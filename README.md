# 임베디드 OS 개발 프로젝트
> ARM 기반 펌웨어 / RTOS의 원리와 구조

## 0. 시작하기 전에

임베디드 컴퓨팅 장치는 자기 자신의 고유하고 한정된 기능을 지속적으로 수행하는 독립된 장비로 정의할 수 있다.

우리 주변에는 어디든 임베디드 시스템이 있다. 키보드, 마우스, 모니터, TV, 스피커, 냉장고 모두 임베디드 시스템이다.

임베디드 시스템은 컴퓨터의 일종이다. 따라서 하드웨어와 소프트웨어로 이루어져 있다. 임베디드 시스템의 소프트웨어를 펌웨어라고 따로 부르기도 한다.

이 책에서는 아무것도 없는 상태에서 어떻게 펌웨어를 만드는지 설명하는 책이다.

보통 애플리케이션 개발시에는 OS가 하드웨어를 모두 제어한다. 

이 책에서는 소프트웨어와 하드웨어의 경계에서 펌웨어가 어떻게 하드웨어를 제어하고 이용하는지에 대한 지식을 얻을 수 있다.


## 1. 임베디드 운영체제

운영체제란 하드웨어를 관리하고, 응용프로그램과 하드웨어 사이에서 인터페이스 역할을 하며 시스템의 동작을 제어하는 시스템 소프트웨어이다.

임베디드 운영체제는, 운영체제의 하위 범부로 운영체제가 가져야 하는 기능 중 필요한 것만 구현하고 포함시켜 임베디드 시스템에 최적화된 효율적인 운영체제이다.

운영체제는 다음과 같이 크게 5가지로 구분할 수 있다.

1. 프로세스 관리

   운영체제에서 작동하는 응용프로그램을 관리하는 기능이다. 현재 CPU를 점유해야 할 프로세스를 결정하고 CPU 자원을 프로세스에게 할당한다. CPU와 프로세스가 여러 개일 때는 공유 자원 접근과 통신 등을 관리한다.

2. 저장장치 관리

   1차 저장장치인 시스템 메인 메모리와 2차 저장장치인 스토리지 디바이스 등을 관리하는 기능이다. 
   
   메인 메모리 관리로는 프로세스에 할당하는 메모리 영역을 지정하고 해제하는 기본적인 기능과, 각 메모리 영역 간의 침범 방지 기능을 한다. 별도의 가상 메모리 관리 하드웨어를 이용해서 가상 메모리 기능을 제공하기도 한다.

   SSD나 HDD같은 2차 저장장치에는 파일 형태로 데이터를 저장한다. 이 파일 데이터를 관리하는 소프트웨어가 파일 시스템이다. 운영체제는 서로 다른 파일 시스템 간에 파일 교환 등을 지원하는 식으로 파일 시스템을 관리한다.

3. 네트워킹 관리

   TCP/IP 기반 인터넷에 연결하거나 다른 특별한 프로토콜 기반 네트워크에 연결할 때 응용프로그램이 네트워크를 사용하려면 운영체제에서 네트워크 프로토콜을 지원해야 한다.

   운영체제는 네트워크 프로토콜에 따라 데이터를 처리해서 응용프로그램이 처리할 수 있는 형태로 전달한다. 마찬가지로 응용프로그램이 보내는 데이터를 네트워크 프로토콜에 맞춰 처리하여 물리적 네트워크에 데이터를 실어 보낸다.

4. 사용자 관리

   운영체제는 한 컴퓨터를 여러 사람이 사용하는 환경을 지원한다. 이를 위해 사용자별로 서로 다른 사용자의 개인적 데이터를 접근할 수 없도록 해야 한다. 
   
   사용자별로 비밀번호, ID, 이름 등을 관리한다.

5. 디바이스 드라이버

   시스템에는 여러 하드웨어가 붙어 있다. 이들을 운영체제에서 인식하고 관리해서 사용할 수 있게 해야한다.

   이를 위해 운영체제 안에서 하드웨어를 추상화하는 계층이 필요한데, 이를 디바이스 드라이버라고 한다.

   운영체제는 다양한 디바이스 드라이버를 효율적으로 관리하는 기능을 갖추고 있다.

<br>
운영체제는 많은 복잡한 일을 하면서도 신뢰성을 보장해야 한다. 그리고 성능도 좋아야 한다.

## 2. 개발 환경 구성하기

임베디드 시스템에서 동작하는 펌웨어를 만들려면 해당 임베디드 시스템에 맞는 컴파일러를 써야 한다.
이 책에서는 ARM에서 동작하는 펌웨어를 만드므로 ARM용 컴파일러를 설치해야 한다.

컴파일을 실행하는 환경과 컴파일의 결과물이 실행될 환경이 다른 경우에 사용하는 컴파일러는 **크로스 컴파일러** 라고 한다.

이 책에서 사용하는 컴파일러는 gcc-arm-none-eabi 이다.

none은 플랫폼이 없다는 뜻으로, 날것 그대로의 ARM 바이너리를 생성해 준다는 뜻이다.

뒤에있는 ABI(Application Binary Interface)는 C언어에서 함수 호출을 어떻게 하느냐를 정해놓은 규약이다.

어떤 레지스터를 몇 번째 파라미터에 배정하고 스택과 힙은 어떻게 쓰고 하는 것 등을 정해놓은 규약이다.

QEMU는 x86, ARM 등 여러 환경을 가상 머신으로 사용할 수 있는 에뮬레이터이다.

이 책에서 사용하는 qemu 패키지는 qemu-system-arm 이다.

QEMU는 지원하는 시스템을 머신(machine) 이라고 부른다. 이 책에서는 대상 머신으로 realview-pb-a8 을 사용한다.

ARM에서 판매하는 ARM RealView Platform Baseboard를 에뮬레이팅한 머신이라고 한다.

## 3. 일단 시작하기

### 3.1 리셋 벡터

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

## 4. 부팅하기

보통 부팅이라고 하면 시스템에 전원이 들어가서 모든 초기화 작업을 마치고 펌웨어가 대기 상태가 될 때까지를 말하거나, 시스템에 전원이 들어가고 ARM 코어가 리셋 익셉션 핸들러를 모두 처리한 다음에 본격적으로 C언어 코드로 넘어가기 직전까지를 말한다.

보통은 전자가 일반적이지만 이 책에서는 후자를 부팅으로 정의한다.

### 4.1 메모리 설계

QEMU는 메모리를 용량 제한 없이 사용할 수 있다.

실제 펌웨어 개발 시에는 성능과 비용 사이에서 최적의 결과를 내기 위해 메모리 구조가 꽤 복잡하지만, 이 책에서는 메모리를 넉넉하게 사용한다.

실행 파일은 메모리를 크게 세 가지로 나누어 사용한다.

- text 영역: 코드가 있는 공간
- data 영역: 초기화한 전역 변수가 있는 공간
- BSS 영역: 초기화하지 않은 전역 변수가 있는 공간

text영역에는 1MB를 할당한다. 익셉션 벡터 테이블을 text 영역에 포함시킬 것이므로 시작 주소는 0x00000000 이다.

크기를 1MB로 설정하면 끝나는 주소는 0x000FFFFF 이다.

개별 동작 모드마다 태스크 스택 영역을 1MB씩 할당한다.

USR, SYS(2MB): 0x00100000 ~ 0x002FFFFF
SVC(1MB): 0x00300000~0x003FFFFF
IRQ(1MB): 0x00400000~0x004FFFFF
FIQ(1MB): 0x00500000~0x005FFFFF
ABT(1MB): 0x00600000~0x006FFFFF
UND(1MB): 0x00700000~0x007FFFFF 

이후 태스크마다 각 1MB씩 스택 영역을 할당하여 총 64MB를 배정한다.

![alt text](./images/image_1.jpg)

### 4.2 익셉션 벡터 테이블 만들기

```asm
.text       @ .end가 나올 때까지의 모든 코드가 text 섹션이라는 의미
  .code 32  @ 명령어의 크기가 32비트라는 뜻 

  .global vector_start @ 다른 파일에서도 사용 가능한 전역 심볼로 정의.
  .global vector_end

  vector_start: @ 레이블 선언
    LDR PC, reset_handler_addr
    LDR PC, undef_handler_addr
    LDR PC, svc_handler_addr
    LDR PC, pfch_abt_handler_addr
    LDR PC, data_abt_handler_addr
    B .
    LDR PC, irq_handler_addr
    LDR PC, fiq_handler_addr

    reset_handler_addr:    .word reset_handler
    undef_handler_addr:    .word dummy_handler
    svc_handler_addr:      .word dummy_handler
    pfch_abt_handler_addr: .word dummy_handler
    data_abt_handler_addr: .word dummy_handler
    irq_handler_addr:      .word dummy_handler
    fiq_handler_addr:      .word dummy_handler
  vector_end:

  reset_handler:
    LDR R0, =0x10000000
    LDR R1, [R0]

  dummy_handler:
    B .
.end
```

> 익셉션 벡터 테이블에 각 핸들러로 점프하는 코드 작성.
> 각 핸들러는 아직 작성되지 않은 상태.

LDR Reg, Label : 레이블 주소에 저장된 값을 Reg에 저장

LDR Reg, =Label : 레이블의 주소값을 Reg에 저장.

- 이 때 레이블의 주소는 코드 섹션 바로 뒤에 리터럴 풀 형태로 저장. 그 후 LDR Reg, [PC, #offset] 형태로 변환됨.

.word value : 워드 크기의 값을 메모리에 저장하라는 지시어

LDR 명령어에서의 =

- =는 주소를 로드하는데 사용됨
- LDR R0, =0x1234 에서 0x1234는 메모리에 저장되어 있다.
- 즉 =0x1234는 0x1234를 저장하는 주소를 의미하는 것이고, LDR R0, =0x1234 명령어는 해당 주소에 저장되어 있는 0x1234값을 R0에 저장한다.
- LDR R0, =0x1234는 결국 LDR R0, [PC, #offset] 같은 형태로 바뀐다고 보면 된다.
- 만약 #offset이 너무 커서 표현 불가능하면 상수 저장-로드 하는 식으로 코드가 늘어날 수 있다.

MOV 명령에서의 #

- #은 즉시 값을 나타내는데 사용됨.
- MOV R0, #0x12 는 0x12라는 상수 값을 직접 R0 레지스터에 넣는 것
- 즉시 값은 8비트 상수와 회전 값을 결합하여 표현
- 즉시 값은 기계어에 직접 삽입
- #로 표현 불가능하면 = 사용

### 4.3 익셉션 핸들러 만들기

가장 먼저 만들어야 할 익셉션 핸들러는 리셋 익셉션 핸들러이다.

리셋 익셉션 핸들러에서 가장 먼저 해야 할 일은 메모리 맵을 설정해 주는 작업이다.

4.1절에서 설계한 동작 모드별 스택 주소를 각 동작 모드의 뱅크드 레지스터 SP에 설정하는 작업을 하는 것이다.

동작 모드별 스택이 모두 설정되고 나면 C언어 main() 함수로 진입할 것이다.

그 후부터는 어셈블리어가 아닌 C언어로 임베디드 시스템을 제어할 수 있습니다.

ARM은 동작 모드가 7개 있다. 이중 USR모드와 SYS모드는 레지스터를 공유하므로 SP 레지스터는 총 6개가 뱅크드 레지스터로 제공된다.

리셋 익셉션 핸들러에서는 동작 모드를 순서대로 변경해 가면서 SP 레지스터에 정해진 값을 넣는 작업을 수행한다. 이러면 각 동작 모드의 스택이 초기화되는 것이다.

먼저 4.1절에서 설계한 메모리 맵을 C언어 코드로 표현하여 include 디렉터리 안의 MemoryMap.h 파일로 저장한다.

```c
#define INST_ADDR_START       0
#define USRSYS_STACK_START    0x00100000
#define SVC_STACK_START       0x00300000 
#define IRQ_STACK_START       0x00400000
#define FIQ_STACK_START       0x00500000
#define ABT_STACK_START       0x00600000
#define UND_STACK_START       0x00700000
#define TASK_STACK_START      0x00800000
#define GLOBAL_ADDR_START     0x04800000
#define DALLOCK_ADDR_START    0x04900000

#define INST_MEM_SIZE       (USRSYS_STACK_START - INST_ADDR_START)
#define USRSYS_STACK_SIZE   (SVC_STACK_START - USRSYS_STACK_START)
#define SVC_STACK_SIZE      (IRQ_STACK_START - SVC_STACK_START)
#define IRQ_STACK_SIZE      (FIQ_STACK_START - IRQ_STACK_START)
#define FIQ_STACK_SIZE      (ABT_STACK_START - FIQ_STACK_START)
#define ABT_STACK_SIZE      (UND_STACK_START - ABT_STACK_START)
#define UND_STACK_SIZE      (TASK_STACK_START - UND_STACK_START)
#define TASK_STACK_SIZE     (GLOBAL_ADDR_START - TASK_STACK_START)
#define DALLOC_MEM_SIZE     (55 * 1024 * 1024)

#define USRSYS_STACK_TOP    (USRSYS_STACK_START + USRSYS_STACK_SIZE - 4)
#define SVC_STACK_TOP       (SVC_STACK_START + SVC_STACK_SIZE - 4)
#define IRQ_STACK_TOP       (IRQ_STACK_START + IRQ_STACK_SIZE - 4)
#define FIQ_STACK_TOP       (FIQ_STACK_START + FIQ_STACK_SIZE - 4)
#define ABT_STACK_TOP       (ABT_STACK_START + ABT_STACK_SIZE - 4)
#define UND_STACK_TOP       (UND_STACK_START + UND_STACK_SIZE - 4)
```

이후 cpsr에 값을 설정하여 동작 모드를 바꿀 수 있는 값을 아래에 정의하였다.

```c
#define ARM_MODE_BIT_USR 0x10
#define ARM_MODE_BIT_FIQ 0x11
#define ARM_MODE_BIT_IRQ 0x12
#define ARM_MODE_BIT_SVC 0x13
#define ARM_MODE_BIT_ABT 0x17
#define ARM_MODE_BIT_UND 0x1B
#define ARM_MODE_BIT_SYS 0x1F
#define ARM_MODE_BIT_MON 0x16
```

다음은 동작 모드 스택을 초기화하는 리셋 익셉션 핸들러이다.

어셈블리어 코드도 헤더 파일을 포함하는 문법은 C언어와 같다.

```asm
#include "ARMv7AR.h"
#include "MemoryMap.h"

.text       @ .end가 나올 때까지의 모든 코드가 text 섹션이라는 의미
  .code 32  @ 명령어의 크기가 32비트라는 뜻 

  .global vector_start @ 다른 파일에서도 사용 가능한 전역 심볼로 정의.
  .global vector_end

  vector_start: @ 레이블 선언
    LDR PC, reset_handler_addr
    LDR PC, undef_handler_addr
    LDR PC, svc_handler_addr
    LDR PC, pfch_abt_handler_addr
    LDR PC, data_abt_handler_addr
    B .
    LDR PC, irq_handler_addr
    LDR PC, fiq_handler_addr

    reset_handler_addr:    .word reset_handler
    undef_handler_addr:    .word dummy_handler
    svc_handler_addr:      .word dummy_handler
    pfch_abt_handler_addr: .word dummy_handler
    data_abt_handler_addr: .word dummy_handler
    irq_handler_addr:      .word dummy_handler
    fiq_handler_addr:      .word dummy_handler
  vector_end:

  reset_handler:
    MRS r0, cpsr @ move PSR to Register
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
    MSR cpsr, r1 @ 동작 모드 변경
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화

    MRS r0, cpsr
    BIC r1, r0, #0x1F
    ORR r1, r1, #ARM_MODE_BIT_IRQ
    MSR cpsr, r1
    LDR sp, =IRQ_STACK_TOP

    MRS r0, cpsr
    BIC r1, r0, #0x1F
    ORR r1, r1, #ARM_MODE_BIT_FIQ
    MSR cpsr, r1
    LDR sp, =FIQ_STACK_TOP

    MRS r0, cpsr
    BIC r1, r0, #0x1F
    ORR r1, r1, #ARM_MODE_BIT_ABT
    MSR cpsr, r1
    LDR sp, =ABT_STACK_TOP

    MRS r0, cpsr
    BIC r1, r0, #0x1F
    ORR r1, r1, #ARM_MODE_BIT_UND
    MSR cpsr, r1
    LDR sp, =UND_STACK_TOP

    MRS r0, cpsr
    BIC r1, r0, #0x1F
    ORR r1, r1, #ARM_MODE_BIT_SYS
    MSR cpsr, r1
    LDR sp, =USRSYS_STACK_TOP

  dummy_handler:
    B .
.end
```

> 스택은 높은 주소에서 낮은 주소로 자라고, 메모리는 증가하는 방향으로 사용하기 때문에 SP 에는 스택의 꼭대기 주소를 넣어주어야 한다.

스택은 메모리를 반대방향으로 사용한다. 0x00009088 주소에 데이터를 쓰면 그다음에는 0x00009084 주소에 데이터를 쓴다.

따라서 스택을 초기화 할 때는 아래의 공식으로 스택 꼭대기 주소를 구하여 그 값을 사용한다.

스택의 꼭대기 주소 = 스택의 시작 주소 + 스택의 크기 - 4

스택에 값을 push 할 때 SP가 먼저 감소한 후, 해당 주소에 값을 쓰므로 4바이트는 빼지 않아도 되지만, 이 책에서는 일종의 패딩으로 4바이트를 빼주었다.

헤더파일이 추가되었으므로 Makefile에 헤더파일이 있는 디렉터리 경로 정보를 추가해야 한다.

RTOS와 펌웨어의 기본 동작 모드가 SYS이므로, SYS모드의 스택을 마지막으로 설정한다.

```makefile
build/%.o: boot/%.S
	mkdir -p $(shell dirname $@)
	$(AS) -march=$(ARCH) -mcpu=$(MCPU) -I $(INC_DIRS) -g -o $@ $<
```

-I 옵션은 헤더 파일 디렉터리 경로를 지시하는 옵션이다.

또한 #define 구문은 전처리기에 의해 처리된다. arm-none-eabi-as는 어셈블러일 뿐이고 전처리는 해 주지 않는다. 그래서 전처리기까지 하려면 arm-none-eabi-gcc를 사용해야 한다.

```makefile
$(AS) -march=$(ARCH) -mcpu=$(MCPU) -I $(INC_DIRS) -g -o $@ $<

$(CC) -march=$(ARCH) -mcpu=$(MCPU) -I $(INC_DIRS) -c -g -o $@ $<
```

또한 gcc는 기본적으로 실행 파일을 만드므로 오브젝트 파일을 만들라고 지시하는 -c 옵션도 추가해야 한다.

```makefile
$(CC) -mcpu=$(MCPU) -marm -I $(INC_DIRS) -c -g -o $@ $<
```
> -march 와 -mcpu가 충돌할 수 있다는 warning 때문에 위와 같이 바꾸었다.

### 4.4 메인으로 진입하기

Entry.S의 리셋 익셉션 핸들러 마지막 부분에 아래와 같은 코드를 추가한다.

```asm
BL main
```

BL main : 지정한 주소로 분기하고, 현재 명령어의 다음 주소를 링크 레지스터(LR)에 저장한다.

이 줄로 어셈블리어 코드에서 C언어 코드로 진입할 수 있다.

어셈블리어 코드에서 브랜치 명령(BL)으로 점프를 하려면 점프 대상 레이블이 같은 파일 안에 있어야 한다. 다른 파일에 있다면 링커가 링킹할 수 있도록 레이블을 .global로 선언해야 한다. 컴파일러는 C언어 함수 이름을 링커가 자동으로 접근할 수 있는 전역 심벌로 만든다.

```c
#include "stdint.h"

void main(void) {
  uint32_t* dummyAddr = (uint32_t*)(1024*1024*100);
  *dummyAddr = sizeof(long);
}
```
위 코드는 100MB 주소 영역(0x6400000) 에 의미 없는 값을 쓰는 코드이다.

이후 Makefile 내용을 수정해서 C언어 소스 파일을 컴파일할 수 있게 한다.

```makefile
LINKER_SCRIPT = ./navilos.ld
MAP_FILE = build/navilos.map
@ 링커가 생성하는 파일.
@ 링커는 링킹 작업을 할 때 심벌에 할당된 메모리 주소를 map 파일에 기록함.

C_SRCS = $(wildcard boot/*.c)
C_OBJS = $(patsubst boot/%.c, build/%.o, $(C_SRCS))
@ C언어 소스 파일이 컴파일되어 만들어진 오브젝트 파일 이름 저장 변수

$(navilos): $(ASM_OBJS) $(C_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -nostdlib -o $(navilos) $(ASM_OBJS) \
	$(C_OBJS) -Map=$(MAP_FILE) @ map 파일 생성
	$(OC) -O binary $(navilos) $(navilos_bin)
	$(OD) -D -mcpu=$(MCPU) -marm -D -S $(navilos) > $(navilos_asm)
	@ 만들어진 실행 파일을 디스어셈블하여 navilos.S 에 저장

build/%.os: $(ASM_SRCS)
	mkdir -p $(shell dirname $@)
	$(CC) -marm -mcpu=$(MCPU) -I $(INC_DIRS) -c -g -o $@ $<

build/%.o: $(C_SRCS)
	mkdir -p $(shell dirname $@)
	$(CC) -marm -mcpu=$(MCPU) -I $(INC_DIRS) -c -g -o $@ $<
```

x/8wx 메모리주소 : 메모리 주소로부터 8개를 4바이트씩 16진수로 출력하라는 명령

![alt text](./images/image_2.png)

0x6400000 메모리 주소에 sizeof(long) 인 4가 저장되어 있다.

어셈블리 코드에서 C언어의 main 함수로의 진입에 성공했음을 알 수 있다.

### 4.5 요약

이 장에서는 펌웨어의 초기화 코드를 작성하였다. 

ARM 프로세서의 최초 진입 코드를 만들었고, 앞으로 만들 rtos의 메모리 맵을 구성하였다.

## 5. UART

QEMU를 사용하는 환경에서 쓸 수 있는 하드웨어는 제한되어 있다. 이 장에서 작업할 첫 번째 하드웨어는 UART 이다.

### 5.1 UART 출력하기

UART는 Universal Asynchronous Receiver/Transmitter의 약자로, 범용 비동기화 송수신기라는 뜻이다. 실무에서는 주로 UART라고 쓰고, 유아트라고 읽는다.

RealViewPB에는 PL011 이라는 UART 하드웨어 모듈이 붙어있다. ARM 홈페이지에서 이 하드웨어의 데이터시트를 확인할 수 있다.

UART는 보통 콘솔 입출력용으로 사용한다. UART는 어떤 데이터 값이든 주고 받을 수 있어서, 아스키 데이터도 주고 받을 수 있다.

터미널 프로그램을 UART 포트와 연결하면 UART를 통해서 받은 아스키 코드를 그 코드에 해당하는 문자로 화면에 출력한다. 그러면 터미널 프로그램을 사용해서 임베디드 시스템을 제어할 수 있다.

UART를 사용하기 위해 가장 먼저 해야 할 일은 UART 하드웨어의 레지스터를 코드로 만드는 것이다.

데이터시트를 보면, PL011 에는 꽤 많은 레지스터를 가지고 있는데, 하드웨어를 사용하는 목적은 매우 다양하므로 제조사 입장에서 그 다양한 요구사항을 최대한 만족하도록 많은 기능을 추가해 넣었기 때문이다.

실제 레지스터가 각 비트별로 어떤 의미를 가졌고 어떻게 설정하는지는 데이터시트에 다 설명되어 있다.

UARTDR은 데이터 레지스터로, 한 번에 8비트, 즉 1바이트씩 통신할 수 있는 하드웨어이다.

![alt text](./images/image_3.jpg)

그림 5.2를 어떻게 코드로 옮길 수 있을까?

두 가지 방법이 있는데, 첫 번째는 C언어 매크로를 이용하는 방법이고, 두 번째는 구조체를 이용하는 방법이다. 이 책에서는 두 번째 방법을 이용한다.

```c
typedef union UARTDR_t {
  uint32_t all;
  struct {
    uint32_t DATA:8; // 7:0 (8 비트의 unsigned int)
    uint32_t FE:1;   // 8   (1 비트의 unsigned int)
    uint32_t PE:1;   // 이러한 방식은 구조체 비트 필드라고 부른다.
    uint32_t BE:1;   // 구조체 비트 필드를 사용하면 구조체 멤버를 비트 단위로 저장할 수 있다.
    uint32_t OE:1;
    uint32_t reserved:20;
  } bits; // 익명 구조체. 구조체 정의, 인스턴스 선언 합친 형태
}

typedef union UARTCR_t {
  ...
}

typedef struct PL011_t {
  UARTDR_t uartdr;
  ...
  UARTCR_t uartcr;
} PL011_t;
```

각 레지스터별로 비트 오프셋은 구조체의 비트 멤버 변수 선언을 사용하여 정의한다.

컴파일러는 자동으로 비트 시프트와 마스킹 연산을 수행하여 비트필드의 크기와 위치에 맞게 값을 저장한다.

이렇게 레지스터를 코드로 옮기면, 아래와 같이 작업할 수 있다.

```c
PL011_t* Uart = (PL011_t*)UART_BASE_ADDR; // 데이터시트를 보면 RealViewPB에서 UART의 기본 주소는 0x10009000이다.

Uart->uartdr.DATA = data & 0xFF;
if (Uart->uartdr.FE || Uart->uartdr.PE || Uart->uartdr.BE || Uart->uartdr.OE) {
  // 에러 처리 코드
}
```

hal 이라는 이름으로 디렉터리를 새로 만들고, 그 밑에 rvpb 디렉터리를 만든다. 그 안에 Uart.h 파일을 만들고 그 파일에 PL011의 레지스터를 코딩해 넣는다.

구조를 이렇게 한 것은 여러 플랫폼을 지원하는 것을 염두에 두었기 때문이다.

예를 들어 라즈베리파이로 확장한다고 하면 라즈베리파이 보드가 종속된 하드웨어 코드는 hal/rasppi 라는 디렉터리를 만들고 그 안에 넣을 것이다.

다음으로 Reg.c 파일을 만들고, UART 하드웨어를 제어할 수 있는 변수를 선언할 것이다.

```c
volatile PL011_t* Uart = (PL011_t*)UART_BASE_ADDRESS0;
```

> 컴파일러는 보통 메모리 주소를 여러 번 읽으면 첫 번째 값만 읽고 캐싱하여 최적화하려고 한다.
> 하지만 하드웨어 레지스터는 그렇게 하면 안되고, 매번 메모리를 직접 읽고 써야 하므로 volatile을 붙여서 이 변수 대상으로는 최적화 하지 말고 직접 접근해야 한다는 것을 컴파일러에게 알려주는 것이다.

앞으로 초기화하는 하드웨어가 추가될 때마다 해당 하드웨어의 레지스터 구조와 베이스 주소를 연결해서 추가할 것이다.

#### 5.1.1 UART 공용 인터페이스

PL011 은 RealViewPB의 UART 이다. 다른 플랫폼은 다른 종류의 UART 하드웨어를 가지고 있을 것이다.

이들 각자의 레지스터와 접근 변수는 지금까지 설명한 방식으로 만들 수 있다.

개별 하드웨어는 각자의 방식으로 동작하더라도 이를 사용하는 코드는 공용 인터페이스를 통해서 같은 방식으로 사용할 수 있어야 한다.

일종의 디바이스 드라이버 같은 것이 필요한 것이다.

실제로 윈도우나 리눅스는 PC에서 쓰는 수많은 하드웨어를 제어할 수 있어야 하므로, 디바이스 드라이버 레이어가 매우 복잡하다.

보통 펌웨어에서는 그렇게 극단적으로 범용성을 생각할 필요는 없고, 적당한 수준의 범용성만 만족하면 된다.

그래서 공용 인터페이스 API만 정의해 놓고, 해당 API를 갖자의 하드웨어가 구현하는 식으로 범용성을 추구한다.

이러한 공용 인터페이스 혹은 API 설계를 HAL(Hardware Abstraction Layer) 이라고 한다. 서로 다른 하드웨어를 추상화 계층이 중계해 주는 것이다.

![alt text](./images/image_4.jpg)

위 그림처럼 설계하면, 기능 코드를 변경하지 않아도 펌웨어를 다른 하드웨어에 이식할 수 있다.

첫 작업으로 UART 공용 HAL 인터페이스를 정의한다. 이름은 HalUart.h 이다.

위 그림의 HW A가 hal/rvpb 가 되고 HW B는 hal/rasppi 가 된다.

HalUart.h 는 RealViewPB와 라즈베리파이 보드가 공통으로 접근하는 인터페이스 이므로 hal 바로 밑에 위치하게 된다.

```c
// UART 공용 인터페이스
#ifndef HAL_HALUART_H_
#define HAL_HALUART_H_

void Hal_uart_init(void);
void Hal_uart_put_char(uint8_t ch);

#endif /* HAL_HALUART_H_ */
```

먼저 출력부터 테스트할 것이기 때문에 UART 하드웨어를 초기화하는 Hal_uart_init() 함수와 UART로 알파벳 한 글자를 보내서 최종적으로 터미널에 알파벳 한 글자를 출력하는 Hal_uart_put_char() 함수를 정의하였다.

이렇게 HalUart.h 파일을 만들어 놓고 각 하드웨어 HAL 구현체에서는 HalUart.h 파일을 #include로 추가하고 각자 하드웨어에 맞춰서 구현하는 것이다.

즉 한 헤더 파일에 대해서 여러 소스 파일이 존재하는 것이다. 그리고 펌웨어 바이너리를 만들 때, 여러 C 소스 파일 중에서 현재 타깃에 맞는 하드웨어의 C 소스 파일만 컴파일해서 사용하는 것이다.

```
HalUart.h 
- hal/rvpb/Uart.c (RealViewPB가 타깃일 때 선택하여 컴파일)
- hal/rasppi/Uart.c
- hal/.../Uart.c
```

이렇게 여러 플랫폼을 지원 가능하게끔 디자인한다.

#### 5.1.2 UART 공용 인터페이스 구현