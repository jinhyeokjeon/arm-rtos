# 3. 일단 시작하기

## 3.1 리셋 벡터

ARM 코어에 전원이 들어가면 ARM 코어는 리셋 벡터(메모리 주소 0x00000000)에서 32비트를 읽어서 그 명령을 바로 실행한다.

따라서 가장 먼저 할 일은 리셋 벡터에 명령어를 넣어주는 것이다.

```asm
@ Entry.S

.text       @ .end가 나올 때까지의 모든 코드가 text 섹션이라는 의미
  .code 32  @ 명령어의 크기가 32비트라는 뜻 

  .global vector_start @ 다른 파일에서도 사용 가능한 전역 심볼로 정의.
  .global vector_end

  vector_start: @ 레이블 선언
    MOV R0, R1
  vector_end:
    .space 1024, 0 @ 해당 위치부터 1024바이트를 0으로 채우라는 명령
.end
```

실행 파일이란 소프트웨어를 구성하는 요소를 파일 시스템에 바이너리로 만든 것이다.

소프트웨어는 데이터와 그 데이터를 변경하는 코드로 구성되어 있다고 볼 수 있다.

프로그램을 만들 때 선언하는 변수가 데이터이고, 그 변수의 값을 변경하는 로직이 코드인 것이다.

이 코드를 바이너리로 변경해서 모아 놓은 것을 실행 파일에서는 text 섹션이라고 한다.

```
// 크로스 컴파일러로 오브젝트 파일 생성
arm-none-eabi-as -march=armv7-a -mcpu=cortex-a8 -o Entry.o ./Entry.S

// 오브젝트 파일에는 심벌 정보 등이 포함되어 있어, 바이너리만 뽑아냄
arm-none-eabi-objcopy -O binary Entry.o Entry.bin

// 뽑아낸 바이너리 파일을 16진수 형식으로 출력
hexdump Entry.bin
```

## 3.2 실행 파일 만들기

QEMU가 펌웨어 파일을 읽어서 부팅하려면 입력으로 지정한 펌웨어 바이너리 파일이 ELF 파일 형식이어야 한다.

ELF 파일 형식은 여러 실행 파일 형식 중에 대표적인 형식으로 리눅스의 표준 실행 파일 형식이다.

Entry.o 파일도 ELF 파일이다.

ELF 파일을 만들기 위해서는 링커의 도움이 필요하다. 링커는 여러 오브젝트 파일을 묶어서 하나의 실행 파일로 만드는 프로그램이다. 링커가 동작하려면 링커에 정보를 던져 주는 파일이 필요한데, 이를 **링커 스크립트**라고 한다.

보통 윈도우나 리눅스용 애플리케이션을 만들 때에는 사용하는 운영체제에 맞는 링커 스크립트가 해당 운영체제의 라이브러리에 기본으로 포함되어 있다. 하지만 펌웨어를 개발할 때에는 해당 펌웨어가 동작하는 하드웨어 환경에 맞춰서 펌웨어의 섹션 배치를 세세하게 조정해야 할 일이 많이 있다.

링커 스크립트로 링커의 동작을 제어하면 원하는 형태의 ELF 파일을 생성할 수 있다.

```ld
/* navilos.ld */

ENTRY(vector_start) /* vector_start 주소에서 실행 시작 */
SECTIONS            /* 코드, 데이터, BSS 등이 어떻게 배치될 지 정함 */
{
  . = 0x0; /* '.': 현재 메모리 주소. 즉 이 섹션이 0x00000000 에 위치한다 */

  .text : /* text 섹션의 배치 순서 지정 */
  {
    *(vector_start)
    *(.text .rodata)
  }
  .data :
  {
    *(.data)
  }
  .bss :
  {
    *(.bss)
  }
}
```

```
// 실행 파일 만들기.
// -n: 링커에 섹션의 정렬 자동으로 맞추지 말라고 지시
// -T: 링커 스크립트 파일 명 알려줌
// -nostdlib: 링커가 자동으로 표준 라이브러리 링킹 못하도록 지시
arm-none-eabi-ld -n -T ./navilos.ld -nostdlib -o navilos.axf boot/Entry.o

// 디스어셈블
arm-none-eabi-objdump -D navilos.axf
```

## 3.3 QEMU에서 실행해 보기

만들어 낸 실행 파일은 QEMU로 실행해 볼 수 있다. 아직은 QEMU로 실행해 봤자 화면에 아무것도 나오지 않기 때문에 실제로 뭐가 실행되는지 알 수 없으므로, gdb를 통해서 메모리를 확인한다.

```
// -M: 머신 지정, -kernel: ELF 파일 이름 지정, -S: QEMU 동작하자마자 일시정지 되도록 지정, -gdb tcp::1234,ipv4: gdb와 연결하는 소켓 포트 지정
qemu-system-arm -M realview-pb-a8 -kernel navilos.axf -S -gdb tcp::1234,ipv4

// gdb로 연결
gdb-multiarch navilos.axf
.
.
(gdb) target remote:1234
.
.
(gdb) x/4xb 0 // 0x00000000 메모리 주소에서 4바이트 16진수로 출력
```

## 3.4 빌드 자동화하기
위와 같이 복잡한 과정은 아래와 같이 Makefile을 만들어서 자동화를 할 수 있다.

```
ARCH = armv7-a
MCPU = cortex-a8

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy

LINKER_SCRIPT = ./navilos.ld

ASM_SRCS = $(wildcard boot/*.S)
ASM_OBJS = $(patsubst boot/%.S, build/%.o, $(ASM_SRCS))

navilos = build/navilos.axf
navilos_bin = build/navilos.bin

.PHONY: all clean run debug gdb

all: $(navilos)

clean:
	@rm -rf build

run: $(navilos)
	qemu-system-arm -M realview-pb-a8 -kernel $(navilos)

debug: $(navilos)
	qemu-system-arm -M realview-pb-a8 -kernel $(navilos) -S -gdb tcp::1234,ipv4

gdb:
	gdb-multiarch $(navilos)

$(navilos): $(ASM_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -nostdlib -o $(navilos) $(ASM_OBJS)
	$(OC) -O binary $(navilos) $(navilos_bin)

build/%.o: boot/%.S
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mcpu=$(MCPU) -g -o $@ $<
```

## 3.5 하드웨어 정보 읽어오기 - 데이터 시트를 읽는 방법

하드웨어와 상호작용한다는 것은 쉽게 말해서 하드웨어에서 정보를 읽어오고 하드웨어에 정보를 쓰는 작업을 한다는 말이다.

하드웨어에 정보를 읽고 쓰기 위해서는 **레지스터**를 이용한다. 레지스터는 하드웨어가 소프트웨어와 상호작용하는 인터페이스이다.

펌웨어 개발자가 어떤 하드웨어를 제어하는 펌웨어를 작성할 때는 그 하드웨어의 레지스터 사용법을 알아야 하는데, 그 사용법은 데이터시트에 나와 있다.

데이터시트는 해당 하드웨어가 가지고 있는 레지스터의 목록과 설명 그리고 레지스터에 어떤 값을 썼을 때 하드웨어가 어떻게 동작하는지를 적어 놓은 문서이다.

```asm
  vector_start:
    LDR R0, =0x10000000 @ R0에 0x10000000이라는 숫자를 넣으라는 것
    LDR R1, [R0] @ R0에 저장된 메모리 주소에서 값을 읽어서 R1에 넣으라는 것
.end
```

메모리 주소 0x10000000 에 어떤 값이 있는지 알려면, RealViewPB의 데이터 시트를 보면 된다.

데이터시트에서 레지스터 주소 0x10000000를 찾으면 ID Register 라고 나온다.

이 레지스터는 하드웨어를 식별할 수 있는 정보를 가진 레지스터이다.

여러 하드웨어에 같은 펌웨어를 사용할 때 펌웨어는 지금 동작하고 있는 하드웨어가 무엇인지 알아야 하는데, 이럴 때 ID Register와 같은 역할을 하는 레지스터에서 고윳값을 읽고 하드웨어를 구분한다.

위 코드를 빌드하고 QEMU를 gdb와 연결한다.

info register(i r) 은 레지스터의 값을 확인하는 명령어이다.

step(s) 은 소스코드를 한 줄 실행하는 명령어이다.

s를 두 번 입력하고, i r 명령어를 실행하면 R1에 데이터시트에 읽은 내용 그대로 값이 들어가 있는 것을 확인할 수 있다.