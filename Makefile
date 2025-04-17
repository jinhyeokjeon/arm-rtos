ARCH = armv7-a
MCPU = cortex-a8

TARGET = rvpb

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump

LINKER_SCRIPT = ./navilos.ld
MAP_FILE = build/navilos.map

ASM_SRCS = $(wildcard boot/*.S)
ASM_OBJS = $(patsubst boot/%.S, build/%.os, $(ASM_SRCS))

VPATH = boot \
        hal/$(TARGET)

C_SRCS = $(notdir $(wildcard boot/*.c))
C_SRCS += $(notdir $(wildcard hal/$(TARGET)/*.c))
C_OBJS = $(patsubst %.c, build/%.o, $(C_SRCS))

INC_DIRS = -I include \
           -I hal     \
					 -I hal/$(TARGET)

CFLAGS = -c -g -std=c11

navilos = build/navilos.axf
navilos_bin = build/navilos.bin
navilos_asm = build/navilos.S

.PHONY: all clean run debug gdb

all: $(navilos)

clean:
	@rm -rf build

run: $(navilos)
	qemu-system-arm -M realview-pb-a8 -kernel $(navilos) -nographic

debug: $(navilos)
	qemu-system-arm -M realview-pb-a8 -kernel $(navilos) -S -gdb tcp::1234,ipv4

gdb:
	gdb-multiarch $(navilos)

$(navilos): $(ASM_OBJS) $(C_OBJS) $(LINKER_SCRIPT)
	$(LD) -n -T $(LINKER_SCRIPT) -nostdlib -o $(navilos) $(ASM_OBJS) $(C_OBJS) -Map=$(MAP_FILE)
	$(OC) -O binary $(navilos) $(navilos_bin)
	$(OD) -D -mcpu=$(MCPU) -marm -D -S $(navilos) > $(navilos_asm)

build/%.os: %.S
	mkdir -p $(shell dirname $@)
	$(CC) -marm -mcpu=$(MCPU) $(INC_DIRS) -c -g -o $@ $<

build/%.o: %.c
	mkdir -p $(shell dirname $@)
	$(CC) -marm -mcpu=$(MCPU) $(INC_DIRS) -c -g -o $@ $<