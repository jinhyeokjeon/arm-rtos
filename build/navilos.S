
build/navilos.axf:     file format elf32-littlearm


Disassembly of section .text:

00000000 <vector_start>:

  .global vector_start @ 다른 파일에서도 사용 가능한 전역 심볼로 정의.
  .global vector_end

  vector_start: @ 레이블 선언
    LDR PC, reset_handler_addr
       0:	e59ff018 	ldr	pc, [pc, #24]	@ 20 <reset_handler_addr>
    LDR PC, undef_handler_addr
       4:	e59ff018 	ldr	pc, [pc, #24]	@ 24 <undef_handler_addr>
    LDR PC, svc_handler_addr
       8:	e59ff018 	ldr	pc, [pc, #24]	@ 28 <svc_handler_addr>
    LDR PC, pfch_abt_handler_addr
       c:	e59ff018 	ldr	pc, [pc, #24]	@ 2c <pfch_abt_handler_addr>
    LDR PC, data_abt_handler_addr
      10:	e59ff018 	ldr	pc, [pc, #24]	@ 30 <data_abt_handler_addr>
    B .
      14:	eafffffe 	b	14 <vector_start+0x14>
    LDR PC, irq_handler_addr
      18:	e59ff014 	ldr	pc, [pc, #20]	@ 34 <irq_handler_addr>
    LDR PC, fiq_handler_addr
      1c:	e59ff014 	ldr	pc, [pc, #20]	@ 38 <fiq_handler_addr>

00000020 <reset_handler_addr>:
      20:	0000003c 	andeq	r0, r0, ip, lsr r0

00000024 <undef_handler_addr>:
      24:	000000b8 	strheq	r0, [r0], -r8

00000028 <svc_handler_addr>:
      28:	000000b8 	strheq	r0, [r0], -r8

0000002c <pfch_abt_handler_addr>:
      2c:	000000b8 	strheq	r0, [r0], -r8

00000030 <data_abt_handler_addr>:
      30:	000000b8 	strheq	r0, [r0], -r8

00000034 <irq_handler_addr>:
      34:	000000d4 	ldrdeq	r0, [r0], -r4

00000038 <fiq_handler_addr>:
      38:	000000f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>

0000003c <vector_end>:
    irq_handler_addr:      .word Irq_Handler
    fiq_handler_addr:      .word Fiq_Handler
  vector_end:

  reset_handler:
    MRS r0, cpsr @ move PSR to Register
      3c:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
      40:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
      44:	e3811013 	orr	r1, r1, #19
    MSR cpsr, r1 @ 동작 모드 변경
      48:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      4c:	e59fd068 	ldr	sp, [pc, #104]	@ bc <dummy_handler+0x4>

    MRS r0, cpsr
      50:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F
      54:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_IRQ
      58:	e3811012 	orr	r1, r1, #18
    MSR cpsr, r1
      5c:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =IRQ_STACK_TOP
      60:	e59fd058 	ldr	sp, [pc, #88]	@ c0 <dummy_handler+0x8>

    MRS r0, cpsr
      64:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F
      68:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_FIQ
      6c:	e3811011 	orr	r1, r1, #17
    MSR cpsr, r1
      70:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =FIQ_STACK_TOP
      74:	e59fd048 	ldr	sp, [pc, #72]	@ c4 <dummy_handler+0xc>

    MRS r0, cpsr
      78:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F
      7c:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_ABT
      80:	e3811017 	orr	r1, r1, #23
    MSR cpsr, r1
      84:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =ABT_STACK_TOP
      88:	e59fd038 	ldr	sp, [pc, #56]	@ c8 <dummy_handler+0x10>

    MRS r0, cpsr
      8c:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F
      90:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_UND
      94:	e381101b 	orr	r1, r1, #27
    MSR cpsr, r1
      98:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =UND_STACK_TOP
      9c:	e59fd028 	ldr	sp, [pc, #40]	@ cc <dummy_handler+0x14>

    MRS r0, cpsr
      a0:	e10f0000 	mrs	r0, CPSR
    BIC r1, r0, #0x1F
      a4:	e3c0101f 	bic	r1, r0, #31
    ORR r1, r1, #ARM_MODE_BIT_SYS
      a8:	e381101f 	orr	r1, r1, #31
    MSR cpsr, r1
      ac:	e129f001 	msr	CPSR_fc, r1
    LDR sp, =USRSYS_STACK_TOP
      b0:	e59fd018 	ldr	sp, [pc, #24]	@ d0 <dummy_handler+0x18>

    BL main
      b4:	eb00000f 	bl	f8 <main>

000000b8 <dummy_handler>:

  dummy_handler:
    B .
      b8:	eafffffe 	b	b8 <dummy_handler>
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      bc:	003ffffc 	ldrshteq	pc, [pc], -ip	@ <UNPREDICTABLE>
    LDR sp, =IRQ_STACK_TOP
      c0:	004ffffc 	strdeq	pc, [pc], #-252	@ <UNPREDICTABLE>
    LDR sp, =FIQ_STACK_TOP
      c4:	005ffffc 	ldrsheq	pc, [pc], #-252	@ <UNPREDICTABLE>
    LDR sp, =ABT_STACK_TOP
      c8:	006ffffc 	strdeq	pc, [pc], #-252	@ <UNPREDICTABLE>
    LDR sp, =UND_STACK_TOP
      cc:	007ffffc 	ldrshteq	pc, [pc], #-252	@ <UNPREDICTABLE>
    LDR sp, =USRSYS_STACK_TOP
      d0:	002ffffc 	strdeq	pc, [pc], -ip	@ <UNPREDICTABLE>

000000d4 <Irq_Handler>:
#include "stdbool.h"
#include "stdint.h"
#include "HalGic.h"

__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
      d4:	e24ee004 	sub	lr, lr, #4
      d8:	e92d581f 	push	{r0, r1, r2, r3, r4, fp, ip, lr}
      dc:	e28db01c 	add	fp, sp, #28
  Hal_interrupt_run_handler();
      e0:	eb000230 	bl	9a8 <Hal_interrupt_run_handler>
}
      e4:	e320f000 	nop	{0}
      e8:	e24bd01c 	sub	sp, fp, #28
      ec:	e8fd981f 	ldm	sp!, {r0, r1, r2, r3, r4, fp, ip, pc}^

000000f0 <Fiq_Handler>:

__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
      f0:	e24db004 	sub	fp, sp, #4
  while (true);
      f4:	eafffffe 	b	f4 <Fiq_Handler+0x4>

000000f8 <main>:
static void Hw_init(void);
static void Kernel_init(void);
static void Printf_test(void);
static void Timer_test(void);

void main(void) {
      f8:	e92d4800 	push	{fp, lr}
      fc:	e28db004 	add	fp, sp, #4
     100:	e24dd008 	sub	sp, sp, #8
  Hw_init();
     104:	eb000016 	bl	164 <Hw_init>
  Kernel_init();
     108:	eb00001c 	bl	180 <Kernel_init>

  uint32_t i = 100;
     10c:	e3a03064 	mov	r3, #100	@ 0x64
     110:	e50b3008 	str	r3, [fp, #-8]
  while(i--) {
     114:	ea000001 	b	120 <main+0x28>
    Hal_uart_put_char('N');
     118:	e3a0004e 	mov	r0, #78	@ 0x4e
     11c:	eb0002ec 	bl	cd4 <Hal_uart_put_char>
  while(i--) {
     120:	e51b3008 	ldr	r3, [fp, #-8]
     124:	e2432001 	sub	r2, r3, #1
     128:	e50b2008 	str	r2, [fp, #-8]
     12c:	e3530000 	cmp	r3, #0
     130:	1afffff8 	bne	118 <main+0x20>
  }
  Hal_uart_put_char('\n');
     134:	e3a0000a 	mov	r0, #10
     138:	eb0002e5 	bl	cd4 <Hal_uart_put_char>

  putstr("Hello World!\n");
     13c:	e3000294 	movw	r0, #660	@ 0x294
     140:	e3400000 	movt	r0, #0
     144:	eb000366 	bl	ee4 <putstr>

  Printf_test();
     148:	eb000022 	bl	1d8 <Printf_test>

  Hal_interrupt_enable(UART_INTERRUPT0);
     14c:	e3a0002c 	mov	r0, #44	@ 0x2c
     150:	eb00019e 	bl	7d0 <Hal_interrupt_enable>
  Kernel_start();
     154:	eb0004c3 	bl	1468 <Kernel_start>
}
     158:	e320f000 	nop	{0}
     15c:	e24bd004 	sub	sp, fp, #4
     160:	e8bd8800 	pop	{fp, pc}

00000164 <Hw_init>:

static void Hw_init(void){
     164:	e92d4800 	push	{fp, lr}
     168:	e28db004 	add	fp, sp, #4
  Hal_interrupt_init();
     16c:	eb000170 	bl	734 <Hal_interrupt_init>
  Hal_uart_init();
     170:	eb0002b1 	bl	c3c <Hal_uart_init>
  Hal_timer_init();
     174:	eb00022c 	bl	a2c <Hal_timer_init>
}
     178:	e320f000 	nop	{0}
     17c:	e8bd8800 	pop	{fp, pc}

00000180 <Kernel_init>:

static void Kernel_init(void) {
     180:	e92d4800 	push	{fp, lr}
     184:	e28db004 	add	fp, sp, #4
  Kernel_task_init();
     188:	eb000714 	bl	1de0 <Kernel_task_init>
  Kernel_event_flag_init();
     18c:	eb000477 	bl	1370 <Kernel_event_flag_init>
  Kernel_msgQ_init();
     190:	eb000596 	bl	17f0 <Kernel_msgQ_init>
  Kernel_sem_init(1);
     194:	e3a00001 	mov	r0, #1
     198:	eb000690 	bl	1be0 <Kernel_sem_init>
  Kernel_mutex_init();
     19c:	eb0006d4 	bl	1cf4 <Kernel_mutex_init>
  add_task(User_task0, 0);
     1a0:	e3a01000 	mov	r1, #0
     1a4:	e3000400 	movw	r0, #1024	@ 0x400
     1a8:	e3400000 	movt	r0, #0
     1ac:	eb000063 	bl	340 <add_task>
  add_task(User_task1, 1);
     1b0:	e3a01001 	mov	r1, #1
     1b4:	e3000574 	movw	r0, #1396	@ 0x574
     1b8:	e3400000 	movt	r0, #0
     1bc:	eb00005f 	bl	340 <add_task>
  add_task(User_task2, 2);
     1c0:	e3a01002 	mov	r1, #2
     1c4:	e3000650 	movw	r0, #1616	@ 0x650
     1c8:	e3400000 	movt	r0, #0
     1cc:	eb00005b 	bl	340 <add_task>
}
     1d0:	e320f000 	nop	{0}
     1d4:	e8bd8800 	pop	{fp, pc}

000001d8 <Printf_test>:

static void Printf_test(void) {
     1d8:	e92d4800 	push	{fp, lr}
     1dc:	e28db004 	add	fp, sp, #4
     1e0:	e24dd010 	sub	sp, sp, #16
  char* str = "printf pointer test";
     1e4:	e30032a4 	movw	r3, #676	@ 0x2a4
     1e8:	e3403000 	movt	r3, #0
     1ec:	e50b3008 	str	r3, [fp, #-8]
  char* nullptr = 0;
     1f0:	e3a03000 	mov	r3, #0
     1f4:	e50b300c 	str	r3, [fp, #-12]
  uint32_t i = 5;
     1f8:	e3a03005 	mov	r3, #5
     1fc:	e50b3010 	str	r3, [fp, #-16]

  debug_printf("%s\n", "Hello printf");
     200:	e30012b8 	movw	r1, #696	@ 0x2b8
     204:	e3401000 	movt	r1, #0
     208:	e30002c8 	movw	r0, #712	@ 0x2c8
     20c:	e3400000 	movt	r0, #0
     210:	eb00034b 	bl	f44 <debug_printf>
  debug_printf("output string pointer: %s\n", str);
     214:	e51b1008 	ldr	r1, [fp, #-8]
     218:	e30002cc 	movw	r0, #716	@ 0x2cc
     21c:	e3400000 	movt	r0, #0
     220:	eb000347 	bl	f44 <debug_printf>
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
     224:	e3a0200a 	mov	r2, #10
     228:	e51b100c 	ldr	r1, [fp, #-12]
     22c:	e30002e8 	movw	r0, #744	@ 0x2e8
     230:	e3400000 	movt	r0, #0
     234:	eb000342 	bl	f44 <debug_printf>
  debug_printf("%u = 5\n", i);
     238:	e51b1010 	ldr	r1, [fp, #-16]
     23c:	e3000308 	movw	r0, #776	@ 0x308
     240:	e3400000 	movt	r0, #0
     244:	eb00033e 	bl	f44 <debug_printf>
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
     248:	e3a020ff 	mov	r2, #255	@ 0xff
     24c:	e3a010ff 	mov	r1, #255	@ 0xff
     250:	e3000310 	movw	r0, #784	@ 0x310
     254:	e3400000 	movt	r0, #0
     258:	eb000339 	bl	f44 <debug_printf>
  debug_printf("print zero %u\n", 0);
     25c:	e3a01000 	mov	r1, #0
     260:	e3000320 	movw	r0, #800	@ 0x320
     264:	e3400000 	movt	r0, #0
     268:	eb000335 	bl	f44 <debug_printf>

  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
     26c:	e3a03a01 	mov	r3, #4096	@ 0x1000
     270:	e3413000 	movt	r3, #4096	@ 0x1000
     274:	e5933000 	ldr	r3, [r3]
     278:	e1a01003 	mov	r1, r3
     27c:	e3000330 	movw	r0, #816	@ 0x330
     280:	e3400000 	movt	r0, #0
     284:	eb00032e 	bl	f44 <debug_printf>
     288:	e320f000 	nop	{0}
     28c:	e24bd004 	sub	sp, fp, #4
     290:	e8bd8800 	pop	{fp, pc}
     294:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	@ 0xfffffee0
     298:	6f57206f 	svcvs	0x0057206f
     29c:	21646c72 	smccs	18114	@ 0x46c2
     2a0:	0000000a 	andeq	r0, r0, sl
     2a4:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
     2a8:	70206674 	eorvc	r6, r0, r4, ror r6
     2ac:	746e696f 	strbtvc	r6, [lr], #-2415	@ 0xfffff691
     2b0:	74207265 	strtvc	r7, [r0], #-613	@ 0xfffffd9b
     2b4:	00747365 	rsbseq	r7, r4, r5, ror #6
     2b8:	6c6c6548 	cfstr64vs	mvdx6, [ip], #-288	@ 0xfffffee0
     2bc:	7270206f 	rsbsvc	r2, r0, #111	@ 0x6f
     2c0:	66746e69 	ldrbtvs	r6, [r4], -r9, ror #28
     2c4:	00000000 	andeq	r0, r0, r0
     2c8:	000a7325 	andeq	r7, sl, r5, lsr #6
     2cc:	7074756f 	rsbsvc	r7, r4, pc, ror #10
     2d0:	73207475 			@ <UNDEFINED> instruction: 0x73207475
     2d4:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
     2d8:	6f702067 	svcvs	0x00702067
     2dc:	65746e69 	ldrbvs	r6, [r4, #-3689]!	@ 0xfffff197
     2e0:	25203a72 	strcs	r3, [r0, #-2674]!	@ 0xfffff58e
     2e4:	00000a73 	andeq	r0, r0, r3, ror sl
     2e8:	69207325 	stmdbvs	r0!, {r0, r2, r5, r8, r9, ip, sp, lr}
     2ec:	756e2073 	strbvc	r2, [lr, #-115]!	@ 0xffffff8d
     2f0:	70206c6c 	eorvc	r6, r0, ip, ror #24
     2f4:	746e696f 	strbtvc	r6, [lr], #-2415	@ 0xfffff691
     2f8:	202c7265 	eorcs	r7, ip, r5, ror #4
     2fc:	6e207525 	cfsh64vs	mvdx7, mvdx0, #21
     300:	65626d75 	strbvs	r6, [r2, #-3445]!	@ 0xfffff28b
     304:	00000a72 	andeq	r0, r0, r2, ror sl
     308:	3d207525 	cfstr32cc	mvfx7, [r0, #-148]!	@ 0xffffff6c
     30c:	000a3520 	andeq	r3, sl, r0, lsr #10
     310:	3d636564 	cfstr64cc	mvdx6, [r3, #-400]!	@ 0xfffffe70
     314:	68207525 	stmdavs	r0!, {r0, r2, r5, r8, sl, ip, sp, lr}
     318:	253d7865 	ldrcs	r7, [sp, #-2149]!	@ 0xfffff79b
     31c:	00000a78 	andeq	r0, r0, r8, ror sl
     320:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
     324:	657a2074 	ldrbvs	r2, [sl, #-116]!	@ 0xffffff8c
     328:	25206f72 	strcs	r6, [r0, #-3954]!	@ 0xfffff08e
     32c:	00000a75 	andeq	r0, r0, r5, ror sl
     330:	43535953 	cmpmi	r3, #1359872	@ 0x14c000
     334:	304c5254 	subcc	r5, ip, r4, asr r2
     338:	7525203a 	strvc	r2, [r5, #-58]!	@ 0xffffffc6
     33c:	0000000a 	andeq	r0, r0, sl

00000340 <add_task>:
#include "Tasks.h"
#include "stdio.h"
#include "stdlib.h"
#include "Kernel.h"

void add_task(KernelTaskFunc_t f, uint32_t t_id) {
     340:	e92d4800 	push	{fp, lr}
     344:	e28db004 	add	fp, sp, #4
     348:	e24dd010 	sub	sp, sp, #16
     34c:	e50b0010 	str	r0, [fp, #-16]
     350:	e50b1014 	str	r1, [fp, #-20]	@ 0xffffffec
  uint32_t taskId;

  taskId = Kernel_task_create(f);
     354:	e51b0010 	ldr	r0, [fp, #-16]
     358:	eb0006e5 	bl	1ef4 <Kernel_task_create>
     35c:	e50b0008 	str	r0, [fp, #-8]
  if (taskId == NOT_ENOUGH_TASK_NUM) {
     360:	e51b3008 	ldr	r3, [fp, #-8]
     364:	e3730001 	cmn	r3, #1
     368:	1a000003 	bne	37c <add_task+0x3c>
    debug_printf("Task%u creation fail\n", t_id);
     36c:	e51b1014 	ldr	r1, [fp, #-20]	@ 0xffffffec
     370:	e300068c 	movw	r0, #1676	@ 0x68c
     374:	e3400000 	movt	r0, #0
     378:	eb0002f1 	bl	f44 <debug_printf>
  }
}
     37c:	e320f000 	nop	{0}
     380:	e24bd004 	sub	sp, fp, #4
     384:	e8bd8800 	pop	{fp, pc}

00000388 <Test_critical_section>:

static uint32_t shared_value;
static void Test_critical_section(uint32_t p, uint32_t taskId) {
     388:	e92d4800 	push	{fp, lr}
     38c:	e28db004 	add	fp, sp, #4
     390:	e24dd008 	sub	sp, sp, #8
     394:	e50b0008 	str	r0, [fp, #-8]
     398:	e50b100c 	str	r1, [fp, #-12]
  //Kernel_lock_sem();
  Kernel_lock_mutex();
     39c:	eb0004f1 	bl	1768 <Kernel_lock_mutex>
  debug_printf("User Task #%u Send=%u\n", taskId, p);
     3a0:	e51b2008 	ldr	r2, [fp, #-8]
     3a4:	e51b100c 	ldr	r1, [fp, #-12]
     3a8:	e30006a4 	movw	r0, #1700	@ 0x6a4
     3ac:	e3400000 	movt	r0, #0
     3b0:	eb0002e3 	bl	f44 <debug_printf>
  shared_value = p;
     3b4:	e3023248 	movw	r3, #8776	@ 0x2248
     3b8:	e3403000 	movt	r3, #0
     3bc:	e51b2008 	ldr	r2, [fp, #-8]
     3c0:	e5832000 	str	r2, [r3]
  Kernel_yield();
     3c4:	eb00042c 	bl	147c <Kernel_yield>
  delay(1000);
     3c8:	e3a00ffa 	mov	r0, #1000	@ 0x3e8
     3cc:	eb0003d4 	bl	1324 <delay>
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
     3d0:	e3023248 	movw	r3, #8776	@ 0x2248
     3d4:	e3403000 	movt	r3, #0
     3d8:	e5933000 	ldr	r3, [r3]
     3dc:	e1a02003 	mov	r2, r3
     3e0:	e51b100c 	ldr	r1, [fp, #-12]
     3e4:	e30006bc 	movw	r0, #1724	@ 0x6bc
     3e8:	e3400000 	movt	r0, #0
     3ec:	eb0002d4 	bl	f44 <debug_printf>
  // Kernel_unlock_sem();
  Kernel_unlock_mutex();
     3f0:	eb0004ee 	bl	17b0 <Kernel_unlock_mutex>
}
     3f4:	e320f000 	nop	{0}
     3f8:	e24bd004 	sub	sp, fp, #4
     3fc:	e8bd8800 	pop	{fp, pc}

00000400 <User_task0>:

void User_task0(void) {
     400:	e92d4800 	push	{fp, lr}
     404:	e28db004 	add	fp, sp, #4
     408:	e24dd020 	sub	sp, sp, #32
  uint32_t local = 0;
     40c:	e3a03000 	mov	r3, #0
     410:	e50b300c 	str	r3, [fp, #-12]
  debug_printf("User Task #0 SP=0x%x\n", &local);
     414:	e24b300c 	sub	r3, fp, #12
     418:	e1a01003 	mov	r1, r3
     41c:	e30006dc 	movw	r0, #1756	@ 0x6dc
     420:	e3400000 	movt	r0, #0
     424:	eb0002c6 	bl	f44 <debug_printf>

  uint8_t cmdBuf[16];
  uint8_t cmdBufIdx = 0;
     428:	e3a03000 	mov	r3, #0
     42c:	e54b301d 	strb	r3, [fp, #-29]	@ 0xffffffe3
  uint8_t uartch = 0;
     430:	e3a03000 	mov	r3, #0
     434:	e54b301e 	strb	r3, [fp, #-30]	@ 0xffffffe2

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
     438:	e3a00005 	mov	r0, #5
     43c:	eb000435 	bl	1518 <Kernel_wait_events>
     440:	e50b0008 	str	r0, [fp, #-8]
    switch(handle_event) {
     444:	e51b3008 	ldr	r3, [fp, #-8]
     448:	e3530001 	cmp	r3, #1
     44c:	0a000003 	beq	460 <User_task0+0x60>
     450:	e51b3008 	ldr	r3, [fp, #-8]
     454:	e3530004 	cmp	r3, #4
     458:	0a00003f 	beq	55c <User_task0+0x15c>
     45c:	ea000042 	b	56c <User_task0+0x16c>
    case KernelEventFlag_UartIn:
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
     460:	e24b301e 	sub	r3, fp, #30
     464:	e3a02001 	mov	r2, #1
     468:	e1a01003 	mov	r1, r3
     46c:	e3a00000 	mov	r0, #0
     470:	eb000485 	bl	168c <Kernel_recv_msg>

      if (uartch == '\r') {
     474:	e55b301e 	ldrb	r3, [fp, #-30]	@ 0xffffffe2
     478:	e353000d 	cmp	r3, #13
     47c:	1a000028 	bne	524 <User_task0+0x124>
        cmdBuf[cmdBufIdx] = '\0';
     480:	e55b301d 	ldrb	r3, [fp, #-29]	@ 0xffffffe3
     484:	e2433004 	sub	r3, r3, #4
     488:	e083300b 	add	r3, r3, fp
     48c:	e3a02000 	mov	r2, #0
     490:	e5432018 	strb	r2, [r3, #-24]	@ 0xffffffe8
        
        while(true) {
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     494:	e24b301d 	sub	r3, fp, #29
     498:	e3a02001 	mov	r2, #1
     49c:	e1a01003 	mov	r1, r3
     4a0:	e3a00001 	mov	r0, #1
     4a4:	eb000442 	bl	15b4 <Kernel_send_msg>
     4a8:	e1a03000 	mov	r3, r0
     4ac:	e2233001 	eor	r3, r3, #1
     4b0:	e6ef3073 	uxtb	r3, r3
     4b4:	e3530000 	cmp	r3, #0
     4b8:	0a000001 	beq	4c4 <User_task0+0xc4>
            Kernel_yield();
     4bc:	eb0003ee 	bl	147c <Kernel_yield>
     4c0:	eafffff3 	b	494 <User_task0+0x94>
          }
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
     4c4:	e55b301d 	ldrb	r3, [fp, #-29]	@ 0xffffffe3
     4c8:	e1a02003 	mov	r2, r3
     4cc:	e24b301c 	sub	r3, fp, #28
     4d0:	e1a01003 	mov	r1, r3
     4d4:	e3a00001 	mov	r0, #1
     4d8:	eb000435 	bl	15b4 <Kernel_send_msg>
     4dc:	e1a03000 	mov	r3, r0
     4e0:	e2233001 	eor	r3, r3, #1
     4e4:	e6ef3073 	uxtb	r3, r3
     4e8:	e3530000 	cmp	r3, #0
     4ec:	0a000006 	beq	50c <User_task0+0x10c>
            uint8_t rollback;
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
     4f0:	e24b301f 	sub	r3, fp, #31
     4f4:	e3a02001 	mov	r2, #1
     4f8:	e1a01003 	mov	r1, r3
     4fc:	e3a00001 	mov	r0, #1
     500:	eb000461 	bl	168c <Kernel_recv_msg>
            Kernel_yield();
     504:	eb0003dc 	bl	147c <Kernel_yield>
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     508:	eaffffe1 	b	494 <User_task0+0x94>
          }
          else {
            break;
     50c:	e320f000 	nop	{0}
          }
        }

        Kernel_send_events(KernelEventFlag_CmdIn);
     510:	e3a00002 	mov	r0, #2
     514:	eb0003dd 	bl	1490 <Kernel_send_events>
        cmdBufIdx = 0;
     518:	e3a03000 	mov	r3, #0
     51c:	e54b301d 	strb	r3, [fp, #-29]	@ 0xffffffe3
      }
      else {
        cmdBuf[cmdBufIdx] = uartch;
        cmdBufIdx = (cmdBufIdx + 1) % 16;
      }
      break;
     520:	ea000011 	b	56c <User_task0+0x16c>
        cmdBuf[cmdBufIdx] = uartch;
     524:	e55b301d 	ldrb	r3, [fp, #-29]	@ 0xffffffe3
     528:	e55b201e 	ldrb	r2, [fp, #-30]	@ 0xffffffe2
     52c:	e2433004 	sub	r3, r3, #4
     530:	e083300b 	add	r3, r3, fp
     534:	e5432018 	strb	r2, [r3, #-24]	@ 0xffffffe8
        cmdBufIdx = (cmdBufIdx + 1) % 16;
     538:	e55b301d 	ldrb	r3, [fp, #-29]	@ 0xffffffe3
     53c:	e2833001 	add	r3, r3, #1
     540:	e2732000 	rsbs	r2, r3, #0
     544:	e203300f 	and	r3, r3, #15
     548:	e202200f 	and	r2, r2, #15
     54c:	52623000 	rsbpl	r3, r2, #0
     550:	e6ef3073 	uxtb	r3, r3
     554:	e54b301d 	strb	r3, [fp, #-29]	@ 0xffffffe3
      break;
     558:	ea000003 	b	56c <User_task0+0x16c>
    case KernelEventFlag_CmdOut:
      Test_critical_section(5, 0);
     55c:	e3a01000 	mov	r1, #0
     560:	e3a00005 	mov	r0, #5
     564:	ebffff87 	bl	388 <Test_critical_section>
      break;
     568:	e320f000 	nop	{0}
    }
    Kernel_yield();
     56c:	eb0003c2 	bl	147c <Kernel_yield>
  while(true) {
     570:	eaffffb0 	b	438 <User_task0+0x38>

00000574 <User_task1>:
  }
}
void User_task1(void) {
     574:	e92d4800 	push	{fp, lr}
     578:	e28db004 	add	fp, sp, #4
     57c:	e24dd020 	sub	sp, sp, #32
  uint32_t local = 0;
     580:	e3a03000 	mov	r3, #0
     584:	e50b300c 	str	r3, [fp, #-12]
  debug_printf("User Task #1 SP=0x%x\n", &local);
     588:	e24b300c 	sub	r3, fp, #12
     58c:	e1a01003 	mov	r1, r3
     590:	e30006f4 	movw	r0, #1780	@ 0x6f4
     594:	e3400000 	movt	r0, #0
     598:	eb000269 	bl	f44 <debug_printf>

  uint8_t cmdlen = 0;
     59c:	e3a03000 	mov	r3, #0
     5a0:	e54b300d 	strb	r3, [fp, #-13]
  uint8_t cmd[16] = {0, };
     5a4:	e3a03000 	mov	r3, #0
     5a8:	e50b3020 	str	r3, [fp, #-32]	@ 0xffffffe0
     5ac:	e24b301c 	sub	r3, fp, #28
     5b0:	e3a02000 	mov	r2, #0
     5b4:	e5832000 	str	r2, [r3]
     5b8:	e5832004 	str	r2, [r3, #4]
     5bc:	e5832008 	str	r2, [r3, #8]

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
     5c0:	e3a0000a 	mov	r0, #10
     5c4:	eb0003d3 	bl	1518 <Kernel_wait_events>
     5c8:	e50b0008 	str	r0, [fp, #-8]
    switch(handle_event) {
     5cc:	e51b3008 	ldr	r3, [fp, #-8]
     5d0:	e3530002 	cmp	r3, #2
     5d4:	0a000003 	beq	5e8 <User_task1+0x74>
     5d8:	e51b3008 	ldr	r3, [fp, #-8]
     5dc:	e3530008 	cmp	r3, #8
     5e0:	0a000016 	beq	640 <User_task1+0xcc>
     5e4:	ea000017 	b	648 <User_task1+0xd4>
    case KernelEventFlag_CmdIn:
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
     5e8:	e24b300d 	sub	r3, fp, #13
     5ec:	e3a02001 	mov	r2, #1
     5f0:	e1a01003 	mov	r1, r3
     5f4:	e3a00001 	mov	r0, #1
     5f8:	eb000423 	bl	168c <Kernel_recv_msg>
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
     5fc:	e55b300d 	ldrb	r3, [fp, #-13]
     600:	e1a02003 	mov	r2, r3
     604:	e24b3020 	sub	r3, fp, #32
     608:	e1a01003 	mov	r1, r3
     60c:	e3a00001 	mov	r0, #1
     610:	eb00041d 	bl	168c <Kernel_recv_msg>
      cmd[cmdlen] = 0;
     614:	e55b300d 	ldrb	r3, [fp, #-13]
     618:	e2433004 	sub	r3, r3, #4
     61c:	e083300b 	add	r3, r3, fp
     620:	e3a02000 	mov	r2, #0
     624:	e543201c 	strb	r2, [r3, #-28]	@ 0xffffffe4
      debug_printf("\nRecv Cmd: %s\n", cmd);
     628:	e24b3020 	sub	r3, fp, #32
     62c:	e1a01003 	mov	r1, r3
     630:	e300070c 	movw	r0, #1804	@ 0x70c
     634:	e3400000 	movt	r0, #0
     638:	eb000241 	bl	f44 <debug_printf>
      break;
     63c:	ea000001 	b	648 <User_task1+0xd4>
    case KernelEventFlag_Unlock:
      Kernel_unlock_sem();
     640:	eb000443 	bl	1754 <Kernel_unlock_sem>
      break;
     644:	e320f000 	nop	{0}
    }
    Kernel_yield();
     648:	eb00038b 	bl	147c <Kernel_yield>
  while(true) {
     64c:	eaffffdb 	b	5c0 <User_task1+0x4c>

00000650 <User_task2>:
  }
}
void User_task2(void) {
     650:	e92d4800 	push	{fp, lr}
     654:	e28db004 	add	fp, sp, #4
     658:	e24dd008 	sub	sp, sp, #8
  uint32_t local = 0;
     65c:	e3a03000 	mov	r3, #0
     660:	e50b3008 	str	r3, [fp, #-8]
  debug_printf("User Task #2 SP=0x%x\n", &local);
     664:	e24b3008 	sub	r3, fp, #8
     668:	e1a01003 	mov	r1, r3
     66c:	e300071c 	movw	r0, #1820	@ 0x71c
     670:	e3400000 	movt	r0, #0
     674:	eb000232 	bl	f44 <debug_printf>
  while(true) {
    Test_critical_section(3, 2);
     678:	e3a01002 	mov	r1, #2
     67c:	e3a00003 	mov	r0, #3
     680:	ebffff40 	bl	388 <Test_critical_section>
    Kernel_yield();
     684:	eb00037c 	bl	147c <Kernel_yield>
    Test_critical_section(3, 2);
     688:	eafffffa 	b	678 <User_task2+0x28>
     68c:	6b736154 	blvs	1cd8be4 <cpsr_cp+0x1cd595c>
     690:	63207525 			@ <UNDEFINED> instruction: 0x63207525
     694:	74616572 	strbtvc	r6, [r1], #-1394	@ 0xfffffa8e
     698:	206e6f69 	rsbcs	r6, lr, r9, ror #30
     69c:	6c696166 	stfvse	f6, [r9], #-408	@ 0xfffffe68
     6a0:	0000000a 	andeq	r0, r0, sl
     6a4:	72657355 	rsbvc	r7, r5, #1409286145	@ 0x54000001
     6a8:	73615420 	cmnvc	r1, #32, 8	@ 0x20000000
     6ac:	2523206b 	strcs	r2, [r3, #-107]!	@ 0xffffff95
     6b0:	65532075 	ldrbvs	r2, [r3, #-117]	@ 0xffffff8b
     6b4:	253d646e 	ldrcs	r6, [sp, #-1134]!	@ 0xfffffb92
     6b8:	00000a75 	andeq	r0, r0, r5, ror sl
     6bc:	72657355 	rsbvc	r7, r5, #1409286145	@ 0x54000001
     6c0:	73615420 	cmnvc	r1, #32, 8	@ 0x20000000
     6c4:	2523206b 	strcs	r2, [r3, #-107]!	@ 0xffffff95
     6c8:	68532075 	ldmdavs	r3, {r0, r2, r4, r5, r6, sp}^
     6cc:	64657261 	strbtvs	r7, [r5], #-609	@ 0xfffffd9f
     6d0:	6c615620 	stclvs	6, cr5, [r1], #-128	@ 0xffffff80
     6d4:	253d6575 	ldrcs	r6, [sp, #-1397]!	@ 0xfffffa8b
     6d8:	00000a75 	andeq	r0, r0, r5, ror sl
     6dc:	72657355 	rsbvc	r7, r5, #1409286145	@ 0x54000001
     6e0:	73615420 	cmnvc	r1, #32, 8	@ 0x20000000
     6e4:	3023206b 	eorcc	r2, r3, fp, rrx
     6e8:	3d505320 	ldclcc	3, cr5, [r0, #-128]	@ 0xffffff80
     6ec:	78257830 	stmdavc	r5!, {r4, r5, fp, ip, sp, lr}
     6f0:	0000000a 	andeq	r0, r0, sl
     6f4:	72657355 	rsbvc	r7, r5, #1409286145	@ 0x54000001
     6f8:	73615420 	cmnvc	r1, #32, 8	@ 0x20000000
     6fc:	3123206b 			@ <UNDEFINED> instruction: 0x3123206b
     700:	3d505320 	ldclcc	3, cr5, [r0, #-128]	@ 0xffffff80
     704:	78257830 	stmdavc	r5!, {r4, r5, fp, ip, sp, lr}
     708:	0000000a 	andeq	r0, r0, sl
     70c:	6365520a 	cmnvs	r5, #-1610612736	@ 0xa0000000
     710:	6d432076 	stclvs	0, cr2, [r3, #-472]	@ 0xfffffe28
     714:	25203a64 	strcs	r3, [r0, #-2660]!	@ 0xfffff59c
     718:	00000a73 	andeq	r0, r0, r3, ror sl
     71c:	72657355 	rsbvc	r7, r5, #1409286145	@ 0x54000001
     720:	73615420 	cmnvc	r1, #32, 8	@ 0x20000000
     724:	3223206b 	eorcc	r2, r3, #107	@ 0x6b
     728:	3d505320 	ldclcc	3, cr5, [r0, #-128]	@ 0xffffff80
     72c:	78257830 	stmdavc	r5!, {r4, r5, fp, ip, sp, lr}
     730:	0000000a 	andeq	r0, r0, sl

00000734 <Hal_interrupt_init>:
extern volatile GicCput_t* GicCpu;
extern volatile GicDist_t* GicDist;

static InterHdlr_fptr sHandlers[INTERRUPT_HANDLER_NUM];

void Hal_interrupt_init(void) {
     734:	e92d4800 	push	{fp, lr}
     738:	e28db004 	add	fp, sp, #4
     73c:	e24dd008 	sub	sp, sp, #8
  GicCpu->cpucontrol.bits.Enable = 1;
     740:	e302323c 	movw	r3, #8764	@ 0x223c
     744:	e3403000 	movt	r3, #0
     748:	e5932000 	ldr	r2, [r3]
     74c:	e5923000 	ldr	r3, [r2]
     750:	e3833001 	orr	r3, r3, #1
     754:	e5823000 	str	r3, [r2]
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
     758:	e302323c 	movw	r3, #8764	@ 0x223c
     75c:	e3403000 	movt	r3, #0
     760:	e5932000 	ldr	r2, [r3]
     764:	e5923004 	ldr	r3, [r2, #4]
     768:	e38330f0 	orr	r3, r3, #240	@ 0xf0
     76c:	e5823004 	str	r3, [r2, #4]
  GicDist->distributorctrl.bits.Enable = 1;
     770:	e3023240 	movw	r3, #8768	@ 0x2240
     774:	e3403000 	movt	r3, #0
     778:	e5932000 	ldr	r2, [r3]
     77c:	e5923000 	ldr	r3, [r2]
     780:	e3833001 	orr	r3, r3, #1
     784:	e5823000 	str	r3, [r2]

  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     788:	e3a03000 	mov	r3, #0
     78c:	e50b3008 	str	r3, [fp, #-8]
     790:	ea000007 	b	7b4 <Hal_interrupt_init+0x80>
    sHandlers[i] = NULL;
     794:	e302324c 	movw	r3, #8780	@ 0x224c
     798:	e3403000 	movt	r3, #0
     79c:	e51b2008 	ldr	r2, [fp, #-8]
     7a0:	e3a01000 	mov	r1, #0
     7a4:	e7831102 	str	r1, [r3, r2, lsl #2]
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     7a8:	e51b3008 	ldr	r3, [fp, #-8]
     7ac:	e2833001 	add	r3, r3, #1
     7b0:	e50b3008 	str	r3, [fp, #-8]
     7b4:	e51b3008 	ldr	r3, [fp, #-8]
     7b8:	e35300fe 	cmp	r3, #254	@ 0xfe
     7bc:	9afffff4 	bls	794 <Hal_interrupt_init+0x60>
  }

  enable_irq();
     7c0:	eb00019b 	bl	e34 <enable_irq>
}
     7c4:	e320f000 	nop	{0}
     7c8:	e24bd004 	sub	sp, fp, #4
     7cc:	e8bd8800 	pop	{fp, pc}

000007d0 <Hal_interrupt_enable>:
void Hal_interrupt_enable(uint32_t interrupt_num) {
     7d0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     7d4:	e28db000 	add	fp, sp, #0
     7d8:	e24dd014 	sub	sp, sp, #20
     7dc:	e50b0010 	str	r0, [fp, #-16]
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     7e0:	e51b3010 	ldr	r3, [fp, #-16]
     7e4:	e353001f 	cmp	r3, #31
     7e8:	9a000027 	bls	88c <Hal_interrupt_enable+0xbc>
     7ec:	e51b3010 	ldr	r3, [fp, #-16]
     7f0:	e353005f 	cmp	r3, #95	@ 0x5f
     7f4:	8a000024 	bhi	88c <Hal_interrupt_enable+0xbc>
    return;
  }

  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     7f8:	e51b3010 	ldr	r3, [fp, #-16]
     7fc:	e2433020 	sub	r3, r3, #32
     800:	e50b3008 	str	r3, [fp, #-8]

  if (bit_num < GIC_IRQ_START) {
     804:	e51b3008 	ldr	r3, [fp, #-8]
     808:	e353001f 	cmp	r3, #31
     80c:	8a00000d 	bhi	848 <Hal_interrupt_enable+0x78>
    SET_BIT(GicDist->setenable1, bit_num);
     810:	e3023240 	movw	r3, #8768	@ 0x2240
     814:	e3403000 	movt	r3, #0
     818:	e5933000 	ldr	r3, [r3]
     81c:	e5932104 	ldr	r2, [r3, #260]	@ 0x104
     820:	e3a01001 	mov	r1, #1
     824:	e51b3008 	ldr	r3, [fp, #-8]
     828:	e1a03311 	lsl	r3, r1, r3
     82c:	e1a01003 	mov	r1, r3
     830:	e3023240 	movw	r3, #8768	@ 0x2240
     834:	e3403000 	movt	r3, #0
     838:	e5933000 	ldr	r3, [r3]
     83c:	e1822001 	orr	r2, r2, r1
     840:	e5832104 	str	r2, [r3, #260]	@ 0x104
     844:	ea000011 	b	890 <Hal_interrupt_enable+0xc0>
  }
  else {
    bit_num -= GIC_IRQ_START;
     848:	e51b3008 	ldr	r3, [fp, #-8]
     84c:	e2433020 	sub	r3, r3, #32
     850:	e50b3008 	str	r3, [fp, #-8]
    SET_BIT(GicDist->setenable2, bit_num);
     854:	e3023240 	movw	r3, #8768	@ 0x2240
     858:	e3403000 	movt	r3, #0
     85c:	e5933000 	ldr	r3, [r3]
     860:	e5932108 	ldr	r2, [r3, #264]	@ 0x108
     864:	e3a01001 	mov	r1, #1
     868:	e51b3008 	ldr	r3, [fp, #-8]
     86c:	e1a03311 	lsl	r3, r1, r3
     870:	e1a01003 	mov	r1, r3
     874:	e3023240 	movw	r3, #8768	@ 0x2240
     878:	e3403000 	movt	r3, #0
     87c:	e5933000 	ldr	r3, [r3]
     880:	e1822001 	orr	r2, r2, r1
     884:	e5832108 	str	r2, [r3, #264]	@ 0x108
     888:	ea000000 	b	890 <Hal_interrupt_enable+0xc0>
    return;
     88c:	e320f000 	nop	{0}
  }
}
     890:	e28bd000 	add	sp, fp, #0
     894:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     898:	e12fff1e 	bx	lr

0000089c <Hal_interrupt_disable>:
void Hal_interrupt_disable(uint32_t interrupt_num) {
     89c:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     8a0:	e28db000 	add	fp, sp, #0
     8a4:	e24dd014 	sub	sp, sp, #20
     8a8:	e50b0010 	str	r0, [fp, #-16]
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     8ac:	e51b3010 	ldr	r3, [fp, #-16]
     8b0:	e353001f 	cmp	r3, #31
     8b4:	9a000029 	bls	960 <Hal_interrupt_disable+0xc4>
     8b8:	e51b3010 	ldr	r3, [fp, #-16]
     8bc:	e353005f 	cmp	r3, #95	@ 0x5f
     8c0:	8a000026 	bhi	960 <Hal_interrupt_disable+0xc4>
    return;
  }

  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     8c4:	e51b3010 	ldr	r3, [fp, #-16]
     8c8:	e2433020 	sub	r3, r3, #32
     8cc:	e50b3008 	str	r3, [fp, #-8]

  if (bit_num < GIC_IRQ_START) {
     8d0:	e51b3008 	ldr	r3, [fp, #-8]
     8d4:	e353001f 	cmp	r3, #31
     8d8:	8a00000e 	bhi	918 <Hal_interrupt_disable+0x7c>
    CLR_BIT(GicDist->setenable1, bit_num);
     8dc:	e3023240 	movw	r3, #8768	@ 0x2240
     8e0:	e3403000 	movt	r3, #0
     8e4:	e5933000 	ldr	r3, [r3]
     8e8:	e5932104 	ldr	r2, [r3, #260]	@ 0x104
     8ec:	e3a01001 	mov	r1, #1
     8f0:	e51b3008 	ldr	r3, [fp, #-8]
     8f4:	e1a03311 	lsl	r3, r1, r3
     8f8:	e1e03003 	mvn	r3, r3
     8fc:	e1a01003 	mov	r1, r3
     900:	e3023240 	movw	r3, #8768	@ 0x2240
     904:	e3403000 	movt	r3, #0
     908:	e5933000 	ldr	r3, [r3]
     90c:	e0022001 	and	r2, r2, r1
     910:	e5832104 	str	r2, [r3, #260]	@ 0x104
     914:	ea000012 	b	964 <Hal_interrupt_disable+0xc8>
  }
  else {
    bit_num -= GIC_IRQ_START;
     918:	e51b3008 	ldr	r3, [fp, #-8]
     91c:	e2433020 	sub	r3, r3, #32
     920:	e50b3008 	str	r3, [fp, #-8]
    CLR_BIT(GicDist->setenable2, bit_num);
     924:	e3023240 	movw	r3, #8768	@ 0x2240
     928:	e3403000 	movt	r3, #0
     92c:	e5933000 	ldr	r3, [r3]
     930:	e5932108 	ldr	r2, [r3, #264]	@ 0x108
     934:	e3a01001 	mov	r1, #1
     938:	e51b3008 	ldr	r3, [fp, #-8]
     93c:	e1a03311 	lsl	r3, r1, r3
     940:	e1e03003 	mvn	r3, r3
     944:	e1a01003 	mov	r1, r3
     948:	e3023240 	movw	r3, #8768	@ 0x2240
     94c:	e3403000 	movt	r3, #0
     950:	e5933000 	ldr	r3, [r3]
     954:	e0022001 	and	r2, r2, r1
     958:	e5832108 	str	r2, [r3, #264]	@ 0x108
     95c:	ea000000 	b	964 <Hal_interrupt_disable+0xc8>
    return;
     960:	e320f000 	nop	{0}
  }
}
     964:	e28bd000 	add	sp, fp, #0
     968:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     96c:	e12fff1e 	bx	lr

00000970 <Hal_interrupt_register_handler>:
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num) {
     970:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     974:	e28db000 	add	fp, sp, #0
     978:	e24dd00c 	sub	sp, sp, #12
     97c:	e50b0008 	str	r0, [fp, #-8]
     980:	e50b100c 	str	r1, [fp, #-12]
  sHandlers[interrupt_num] = handler;
     984:	e302324c 	movw	r3, #8780	@ 0x224c
     988:	e3403000 	movt	r3, #0
     98c:	e51b200c 	ldr	r2, [fp, #-12]
     990:	e51b1008 	ldr	r1, [fp, #-8]
     994:	e7831102 	str	r1, [r3, r2, lsl #2]
}
     998:	e320f000 	nop	{0}
     99c:	e28bd000 	add	sp, fp, #0
     9a0:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     9a4:	e12fff1e 	bx	lr

000009a8 <Hal_interrupt_run_handler>:
void Hal_interrupt_run_handler(void) {
     9a8:	e92d4800 	push	{fp, lr}
     9ac:	e28db004 	add	fp, sp, #4
     9b0:	e24dd008 	sub	sp, sp, #8
  uint32_t interrupt_num = GicCpu->interruptack.bits.InterruptID;
     9b4:	e302323c 	movw	r3, #8764	@ 0x223c
     9b8:	e3403000 	movt	r3, #0
     9bc:	e5933000 	ldr	r3, [r3]
     9c0:	e593300c 	ldr	r3, [r3, #12]
     9c4:	e7e93053 	ubfx	r3, r3, #0, #10
     9c8:	e6ff3073 	uxth	r3, r3
     9cc:	e50b3008 	str	r3, [fp, #-8]

  if (sHandlers[interrupt_num] != NULL) {
     9d0:	e302324c 	movw	r3, #8780	@ 0x224c
     9d4:	e3403000 	movt	r3, #0
     9d8:	e51b2008 	ldr	r2, [fp, #-8]
     9dc:	e7933102 	ldr	r3, [r3, r2, lsl #2]
     9e0:	e3530000 	cmp	r3, #0
     9e4:	0a000004 	beq	9fc <Hal_interrupt_run_handler+0x54>
    sHandlers[interrupt_num]();
     9e8:	e302324c 	movw	r3, #8780	@ 0x224c
     9ec:	e3403000 	movt	r3, #0
     9f0:	e51b2008 	ldr	r2, [fp, #-8]
     9f4:	e7933102 	ldr	r3, [r3, r2, lsl #2]
     9f8:	e12fff33 	blx	r3
  }

  GicCpu->endofinterrupt.bits.InterruptID = interrupt_num;
     9fc:	e302323c 	movw	r3, #8764	@ 0x223c
     a00:	e3403000 	movt	r3, #0
     a04:	e5932000 	ldr	r2, [r3]
     a08:	e51b3008 	ldr	r3, [fp, #-8]
     a0c:	e7e93053 	ubfx	r3, r3, #0, #10
     a10:	e6ff1073 	uxth	r1, r3
     a14:	e5923010 	ldr	r3, [r2, #16]
     a18:	e7c93011 	bfi	r3, r1, #0, #10
     a1c:	e5823010 	str	r3, [r2, #16]
     a20:	e320f000 	nop	{0}
     a24:	e24bd004 	sub	sp, fp, #4
     a28:	e8bd8800 	pop	{fp, pc}

00000a2c <Hal_timer_init>:

static void interrupt_handler(void);

static uint32_t internal_1ms_counter;

void Hal_timer_init(void) {
     a2c:	e92d4800 	push	{fp, lr}
     a30:	e28db004 	add	fp, sp, #4
     a34:	e24dd008 	sub	sp, sp, #8
  // interface reset
  Timer->timerxcontrol.bits.TimerEn = 0;
     a38:	e3023244 	movw	r3, #8772	@ 0x2244
     a3c:	e3403000 	movt	r3, #0
     a40:	e5932000 	ldr	r2, [r3]
     a44:	e5923008 	ldr	r3, [r2, #8]
     a48:	e7c7339f 	bfc	r3, #7, #1
     a4c:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.TimerMode = 0;
     a50:	e3023244 	movw	r3, #8772	@ 0x2244
     a54:	e3403000 	movt	r3, #0
     a58:	e5932000 	ldr	r2, [r3]
     a5c:	e5923008 	ldr	r3, [r2, #8]
     a60:	e7c6331f 	bfc	r3, #6, #1
     a64:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.OneShot = 0;
     a68:	e3023244 	movw	r3, #8772	@ 0x2244
     a6c:	e3403000 	movt	r3, #0
     a70:	e5932000 	ldr	r2, [r3]
     a74:	e5923008 	ldr	r3, [r2, #8]
     a78:	e7c0301f 	bfc	r3, #0, #1
     a7c:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.TimerSize = 0;
     a80:	e3023244 	movw	r3, #8772	@ 0x2244
     a84:	e3403000 	movt	r3, #0
     a88:	e5932000 	ldr	r2, [r3]
     a8c:	e5923008 	ldr	r3, [r2, #8]
     a90:	e7c1309f 	bfc	r3, #1, #1
     a94:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.TimerPre = 0;
     a98:	e3023244 	movw	r3, #8772	@ 0x2244
     a9c:	e3403000 	movt	r3, #0
     aa0:	e5932000 	ldr	r2, [r3]
     aa4:	e5923008 	ldr	r3, [r2, #8]
     aa8:	e7c3311f 	bfc	r3, #2, #2
     aac:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.IntEnable = 1;
     ab0:	e3023244 	movw	r3, #8772	@ 0x2244
     ab4:	e3403000 	movt	r3, #0
     ab8:	e5932000 	ldr	r2, [r3]
     abc:	e5923008 	ldr	r3, [r2, #8]
     ac0:	e3833020 	orr	r3, r3, #32
     ac4:	e5823008 	str	r3, [r2, #8]
  Timer->timerxload = 0;
     ac8:	e3023244 	movw	r3, #8772	@ 0x2244
     acc:	e3403000 	movt	r3, #0
     ad0:	e5933000 	ldr	r3, [r3]
     ad4:	e3a02000 	mov	r2, #0
     ad8:	e5832000 	str	r2, [r3]
  Timer->timerxvalue = 0xFFFFFFFF;
     adc:	e3023244 	movw	r3, #8772	@ 0x2244
     ae0:	e3403000 	movt	r3, #0
     ae4:	e5933000 	ldr	r3, [r3]
     ae8:	e3e02000 	mvn	r2, #0
     aec:	e5832004 	str	r2, [r3, #4]

  // set periodic mode
  Timer->timerxcontrol.bits.TimerMode = TIMER_PERIOIC;
     af0:	e3023244 	movw	r3, #8772	@ 0x2244
     af4:	e3403000 	movt	r3, #0
     af8:	e5932000 	ldr	r2, [r3]
     afc:	e5923008 	ldr	r3, [r2, #8]
     b00:	e3833040 	orr	r3, r3, #64	@ 0x40
     b04:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.TimerSize = TIMER_32BIT_COUNTER;
     b08:	e3023244 	movw	r3, #8772	@ 0x2244
     b0c:	e3403000 	movt	r3, #0
     b10:	e5932000 	ldr	r2, [r3]
     b14:	e5923008 	ldr	r3, [r2, #8]
     b18:	e3833002 	orr	r3, r3, #2
     b1c:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.OneShot = 0;
     b20:	e3023244 	movw	r3, #8772	@ 0x2244
     b24:	e3403000 	movt	r3, #0
     b28:	e5932000 	ldr	r2, [r3]
     b2c:	e5923008 	ldr	r3, [r2, #8]
     b30:	e7c0301f 	bfc	r3, #0, #1
     b34:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.TimerPre = 0;
     b38:	e3023244 	movw	r3, #8772	@ 0x2244
     b3c:	e3403000 	movt	r3, #0
     b40:	e5932000 	ldr	r2, [r3]
     b44:	e5923008 	ldr	r3, [r2, #8]
     b48:	e7c3311f 	bfc	r3, #2, #2
     b4c:	e5823008 	str	r3, [r2, #8]
  Timer->timerxcontrol.bits.IntEnable = 1;
     b50:	e3023244 	movw	r3, #8772	@ 0x2244
     b54:	e3403000 	movt	r3, #0
     b58:	e5932000 	ldr	r2, [r3]
     b5c:	e5923008 	ldr	r3, [r2, #8]
     b60:	e3833020 	orr	r3, r3, #32
     b64:	e5823008 	str	r3, [r2, #8]

  uint32_t interval_1ms = TIMER_INTERVAL / 100;
     b68:	e300351e 	movw	r3, #1310	@ 0x51e
     b6c:	e50b3008 	str	r3, [fp, #-8]

  Timer->timerxload = interval_1ms;
     b70:	e3023244 	movw	r3, #8772	@ 0x2244
     b74:	e3403000 	movt	r3, #0
     b78:	e5933000 	ldr	r3, [r3]
     b7c:	e51b2008 	ldr	r2, [fp, #-8]
     b80:	e5832000 	str	r2, [r3]
  Timer->timerxcontrol.bits.TimerEn = 1;
     b84:	e3023244 	movw	r3, #8772	@ 0x2244
     b88:	e3403000 	movt	r3, #0
     b8c:	e5932000 	ldr	r2, [r3]
     b90:	e5923008 	ldr	r3, [r2, #8]
     b94:	e3833080 	orr	r3, r3, #128	@ 0x80
     b98:	e5823008 	str	r3, [r2, #8]

  internal_1ms_counter = 0;
     b9c:	e3023648 	movw	r3, #9800	@ 0x2648
     ba0:	e3403000 	movt	r3, #0
     ba4:	e3a02000 	mov	r2, #0
     ba8:	e5832000 	str	r2, [r3]

  // Register Timer interrupt handler
  Hal_interrupt_enable(TIMER_INTERRUPT);
     bac:	e3a00024 	mov	r0, #36	@ 0x24
     bb0:	ebffff06 	bl	7d0 <Hal_interrupt_enable>
  Hal_interrupt_register_handler(interrupt_handler, TIMER_INTERRUPT);
     bb4:	e3a01024 	mov	r1, #36	@ 0x24
     bb8:	e3000bf4 	movw	r0, #3060	@ 0xbf4
     bbc:	e3400000 	movt	r0, #0
     bc0:	ebffff6a 	bl	970 <Hal_interrupt_register_handler>
}
     bc4:	e320f000 	nop	{0}
     bc8:	e24bd004 	sub	sp, fp, #4
     bcc:	e8bd8800 	pop	{fp, pc}

00000bd0 <Hal_timer_get_1ms_counter>:

uint32_t Hal_timer_get_1ms_counter(void) {
     bd0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     bd4:	e28db000 	add	fp, sp, #0
  return internal_1ms_counter;
     bd8:	e3023648 	movw	r3, #9800	@ 0x2648
     bdc:	e3403000 	movt	r3, #0
     be0:	e5933000 	ldr	r3, [r3]
}
     be4:	e1a00003 	mov	r0, r3
     be8:	e28bd000 	add	sp, fp, #0
     bec:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     bf0:	e12fff1e 	bx	lr

00000bf4 <interrupt_handler>:

static void interrupt_handler(void) {
     bf4:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     bf8:	e28db000 	add	fp, sp, #0
  ++internal_1ms_counter;
     bfc:	e3023648 	movw	r3, #9800	@ 0x2648
     c00:	e3403000 	movt	r3, #0
     c04:	e5933000 	ldr	r3, [r3]
     c08:	e2832001 	add	r2, r3, #1
     c0c:	e3023648 	movw	r3, #9800	@ 0x2648
     c10:	e3403000 	movt	r3, #0
     c14:	e5832000 	str	r2, [r3]
  Timer->timerxintclr = 1;
     c18:	e3023244 	movw	r3, #8772	@ 0x2244
     c1c:	e3403000 	movt	r3, #0
     c20:	e5933000 	ldr	r3, [r3]
     c24:	e3a02001 	mov	r2, #1
     c28:	e583200c 	str	r2, [r3, #12]
     c2c:	e320f000 	nop	{0}
     c30:	e28bd000 	add	sp, fp, #0
     c34:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     c38:	e12fff1e 	bx	lr

00000c3c <Hal_uart_init>:

extern volatile PL011_t* Uart;

static void interrupt_handler(void);

void Hal_uart_init(void) {
     c3c:	e92d4800 	push	{fp, lr}
     c40:	e28db004 	add	fp, sp, #4
  // Enable UART
  Uart->uartcr.bits.UARTEN = 0;
     c44:	e3023238 	movw	r3, #8760	@ 0x2238
     c48:	e3403000 	movt	r3, #0
     c4c:	e5932000 	ldr	r2, [r3]
     c50:	e5923030 	ldr	r3, [r2, #48]	@ 0x30
     c54:	e7c0301f 	bfc	r3, #0, #1
     c58:	e5823030 	str	r3, [r2, #48]	@ 0x30
  Uart->uartcr.bits.TXE = 1;
     c5c:	e3023238 	movw	r3, #8760	@ 0x2238
     c60:	e3403000 	movt	r3, #0
     c64:	e5932000 	ldr	r2, [r3]
     c68:	e5923030 	ldr	r3, [r2, #48]	@ 0x30
     c6c:	e3833c01 	orr	r3, r3, #256	@ 0x100
     c70:	e5823030 	str	r3, [r2, #48]	@ 0x30
  Uart->uartcr.bits.RXE = 1;
     c74:	e3023238 	movw	r3, #8760	@ 0x2238
     c78:	e3403000 	movt	r3, #0
     c7c:	e5932000 	ldr	r2, [r3]
     c80:	e5923030 	ldr	r3, [r2, #48]	@ 0x30
     c84:	e3833c02 	orr	r3, r3, #512	@ 0x200
     c88:	e5823030 	str	r3, [r2, #48]	@ 0x30
  Uart->uartcr.bits.UARTEN = 1;
     c8c:	e3023238 	movw	r3, #8760	@ 0x2238
     c90:	e3403000 	movt	r3, #0
     c94:	e5932000 	ldr	r2, [r3]
     c98:	e5923030 	ldr	r3, [r2, #48]	@ 0x30
     c9c:	e3833001 	orr	r3, r3, #1
     ca0:	e5823030 	str	r3, [r2, #48]	@ 0x30

  // Enable input interrupt
  Uart->uartimsc.bits.RXIM = 1;
     ca4:	e3023238 	movw	r3, #8760	@ 0x2238
     ca8:	e3403000 	movt	r3, #0
     cac:	e5932000 	ldr	r2, [r3]
     cb0:	e5923038 	ldr	r3, [r2, #56]	@ 0x38
     cb4:	e3833010 	orr	r3, r3, #16
     cb8:	e5823038 	str	r3, [r2, #56]	@ 0x38

  // Register UART interrupt handler
  // Hal_interrupt_enable(UART_INTERRUPT0);
  Hal_interrupt_register_handler(interrupt_handler, UART_INTERRUPT0);
     cbc:	e3a0102c 	mov	r1, #44	@ 0x2c
     cc0:	e3000dbc 	movw	r0, #3516	@ 0xdbc
     cc4:	e3400000 	movt	r0, #0
     cc8:	ebffff28 	bl	970 <Hal_interrupt_register_handler>
}
     ccc:	e320f000 	nop	{0}
     cd0:	e8bd8800 	pop	{fp, pc}

00000cd4 <Hal_uart_put_char>:

void Hal_uart_put_char(uint8_t ch) {
     cd4:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     cd8:	e28db000 	add	fp, sp, #0
     cdc:	e24dd00c 	sub	sp, sp, #12
     ce0:	e1a03000 	mov	r3, r0
     ce4:	e54b3005 	strb	r3, [fp, #-5]
  while(Uart->uartfr.bits.TXFF);
     ce8:	e320f000 	nop	{0}
     cec:	e3023238 	movw	r3, #8760	@ 0x2238
     cf0:	e3403000 	movt	r3, #0
     cf4:	e5933000 	ldr	r3, [r3]
     cf8:	e5933018 	ldr	r3, [r3, #24]
     cfc:	e7e032d3 	ubfx	r3, r3, #5, #1
     d00:	e6ef3073 	uxtb	r3, r3
     d04:	e3530000 	cmp	r3, #0
     d08:	1afffff7 	bne	cec <Hal_uart_put_char+0x18>
  Uart->uartdr.bits.DATA = (ch & 0xFF);
     d0c:	e3023238 	movw	r3, #8760	@ 0x2238
     d10:	e3403000 	movt	r3, #0
     d14:	e5932000 	ldr	r2, [r3]
     d18:	e55b1005 	ldrb	r1, [fp, #-5]
     d1c:	e5923000 	ldr	r3, [r2]
     d20:	e7c73011 	bfi	r3, r1, #0, #8
     d24:	e5823000 	str	r3, [r2]
}
     d28:	e320f000 	nop	{0}
     d2c:	e28bd000 	add	sp, fp, #0
     d30:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     d34:	e12fff1e 	bx	lr

00000d38 <Hal_uart_get_char>:

uint8_t Hal_uart_get_char(void) {
     d38:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     d3c:	e28db000 	add	fp, sp, #0
     d40:	e24dd00c 	sub	sp, sp, #12
  uint32_t data;

  while(Uart->uartfr.bits.RXFE);
     d44:	e320f000 	nop	{0}
     d48:	e3023238 	movw	r3, #8760	@ 0x2238
     d4c:	e3403000 	movt	r3, #0
     d50:	e5933000 	ldr	r3, [r3]
     d54:	e5933018 	ldr	r3, [r3, #24]
     d58:	e7e03253 	ubfx	r3, r3, #4, #1
     d5c:	e6ef3073 	uxtb	r3, r3
     d60:	e3530000 	cmp	r3, #0
     d64:	1afffff7 	bne	d48 <Hal_uart_get_char+0x10>

  data = Uart->uartdr.all;
     d68:	e3023238 	movw	r3, #8760	@ 0x2238
     d6c:	e3403000 	movt	r3, #0
     d70:	e5933000 	ldr	r3, [r3]
     d74:	e5933000 	ldr	r3, [r3]
     d78:	e50b3008 	str	r3, [fp, #-8]

  // Check for an error flag
  if(data & 0xFFFFFF00) {
     d7c:	e51b3008 	ldr	r3, [fp, #-8]
     d80:	e35300ff 	cmp	r3, #255	@ 0xff
     d84:	9a000006 	bls	da4 <Hal_uart_get_char+0x6c>
    // Clear the error
    Uart->uartrsr.all = 0xFF;
     d88:	e3023238 	movw	r3, #8760	@ 0x2238
     d8c:	e3403000 	movt	r3, #0
     d90:	e5933000 	ldr	r3, [r3]
     d94:	e3a020ff 	mov	r2, #255	@ 0xff
     d98:	e5832004 	str	r2, [r3, #4]
    return 0;
     d9c:	e3a03000 	mov	r3, #0
     da0:	ea000001 	b	dac <Hal_uart_get_char+0x74>
  }

  return (uint8_t)(data & 0xFF);
     da4:	e51b3008 	ldr	r3, [fp, #-8]
     da8:	e6ef3073 	uxtb	r3, r3
}
     dac:	e1a00003 	mov	r0, r3
     db0:	e28bd000 	add	sp, fp, #0
     db4:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     db8:	e12fff1e 	bx	lr

00000dbc <interrupt_handler>:

static void interrupt_handler(void) {
     dbc:	e92d4800 	push	{fp, lr}
     dc0:	e28db004 	add	fp, sp, #4
     dc4:	e24dd008 	sub	sp, sp, #8
  uint8_t ch = Hal_uart_get_char();
     dc8:	ebffffda 	bl	d38 <Hal_uart_get_char>
     dcc:	e1a03000 	mov	r3, r0
     dd0:	e54b3005 	strb	r3, [fp, #-5]

  if (ch == 'U') {
     dd4:	e55b3005 	ldrb	r3, [fp, #-5]
     dd8:	e3530055 	cmp	r3, #85	@ 0x55
     ddc:	1a000002 	bne	dec <interrupt_handler+0x30>
    Kernel_send_events(KernelEventFlag_Unlock);
     de0:	e3a00008 	mov	r0, #8
     de4:	eb0001a9 	bl	1490 <Kernel_send_events>
    return;
     de8:	ea00000f 	b	e2c <interrupt_handler+0x70>
  }
  if (ch == 'X') {
     dec:	e55b3005 	ldrb	r3, [fp, #-5]
     df0:	e3530058 	cmp	r3, #88	@ 0x58
     df4:	1a000002 	bne	e04 <interrupt_handler+0x48>
    Kernel_send_events(KernelEventFlag_CmdOut);
     df8:	e3a00004 	mov	r0, #4
     dfc:	eb0001a3 	bl	1490 <Kernel_send_events>
    return;
     e00:	ea000009 	b	e2c <interrupt_handler+0x70>
  }

  Hal_uart_put_char(ch);
     e04:	e55b3005 	ldrb	r3, [fp, #-5]
     e08:	e1a00003 	mov	r0, r3
     e0c:	ebffffb0 	bl	cd4 <Hal_uart_put_char>
  Kernel_send_msg(KernelMsgQ_Task0, &ch, 1);
     e10:	e24b3005 	sub	r3, fp, #5
     e14:	e3a02001 	mov	r2, #1
     e18:	e1a01003 	mov	r1, r3
     e1c:	e3a00000 	mov	r0, #0
     e20:	eb0001e3 	bl	15b4 <Kernel_send_msg>
  Kernel_send_events(KernelEventFlag_UartIn);
     e24:	e3a00001 	mov	r0, #1
     e28:	eb000198 	bl	1490 <Kernel_send_events>
     e2c:	e24bd004 	sub	sp, fp, #4
     e30:	e8bd8800 	pop	{fp, pc}

00000e34 <enable_irq>:
#include "armcpu.h"

void enable_irq(void) {
     e34:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     e38:	e28db000 	add	fp, sp, #0
  __asm__ ("PUSH {r0, r1}");
     e3c:	e92d0003 	push	{r0, r1}
  __asm__ ("MRS r0, cpsr");
     e40:	e10f0000 	mrs	r0, CPSR
  __asm__ ("BIC r1, r0, #0x80");
     e44:	e3c01080 	bic	r1, r0, #128	@ 0x80
  __asm__ ("MSR cpsr, r1");
     e48:	e129f001 	msr	CPSR_fc, r1
  __asm__ ("POP {r0, r1}");
     e4c:	e8bd0003 	pop	{r0, r1}
}
     e50:	e320f000 	nop	{0}
     e54:	e28bd000 	add	sp, fp, #0
     e58:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     e5c:	e12fff1e 	bx	lr

00000e60 <enable_fiq>:
void enable_fiq(void) {
     e60:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     e64:	e28db000 	add	fp, sp, #0
  __asm__ ("PUSH {r0, r1}");
     e68:	e92d0003 	push	{r0, r1}
  __asm__ ("MRS r0, cpsr");
     e6c:	e10f0000 	mrs	r0, CPSR
  __asm__ ("BIC r1, r0, #0x40");
     e70:	e3c01040 	bic	r1, r0, #64	@ 0x40
  __asm__ ("MSR cpsr, r1");
     e74:	e129f001 	msr	CPSR_fc, r1
  __asm__ ("POP {r0, r1}");
     e78:	e8bd0003 	pop	{r0, r1}
}
     e7c:	e320f000 	nop	{0}
     e80:	e28bd000 	add	sp, fp, #0
     e84:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     e88:	e12fff1e 	bx	lr

00000e8c <disable_irq>:
void disable_irq(void) {
     e8c:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     e90:	e28db000 	add	fp, sp, #0
  __asm__ ("PUSH {r0, r1}");
     e94:	e92d0003 	push	{r0, r1}
  __asm__ ("MRS r0, cpsr");
     e98:	e10f0000 	mrs	r0, CPSR
  __asm__ ("ORR r1, r0, #0x80");
     e9c:	e3801080 	orr	r1, r0, #128	@ 0x80
  __asm__ ("MSR cpsr, r1");
     ea0:	e129f001 	msr	CPSR_fc, r1
  __asm__ ("POP {r0, r1}");
     ea4:	e8bd0003 	pop	{r0, r1}
}
     ea8:	e320f000 	nop	{0}
     eac:	e28bd000 	add	sp, fp, #0
     eb0:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     eb4:	e12fff1e 	bx	lr

00000eb8 <disable_fiq>:
void disable_fiq(void) {
     eb8:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
     ebc:	e28db000 	add	fp, sp, #0
  __asm__ ("PUSH {r0, r1}");
     ec0:	e92d0003 	push	{r0, r1}
  __asm__ ("MRS r0, cpsr");
     ec4:	e10f0000 	mrs	r0, CPSR
  __asm__ ("ORR r1, r0, #0x40");
     ec8:	e3801040 	orr	r1, r0, #64	@ 0x40
  __asm__ ("MSR cpsr, r1");
     ecc:	e129f001 	msr	CPSR_fc, r1
  __asm__ ("POP {r0, r1}");
     ed0:	e8bd0003 	pop	{r0, r1}
     ed4:	e320f000 	nop	{0}
     ed8:	e28bd000 	add	sp, fp, #0
     edc:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
     ee0:	e12fff1e 	bx	lr

00000ee4 <putstr>:

#define PRINTF_BUF_LEN 1024

static char printf_buf[PRINTF_BUF_LEN];

uint32_t putstr(const char* s) {
     ee4:	e92d4800 	push	{fp, lr}
     ee8:	e28db004 	add	fp, sp, #4
     eec:	e24dd010 	sub	sp, sp, #16
     ef0:	e50b0010 	str	r0, [fp, #-16]
  uint32_t c = 0;
     ef4:	e3a03000 	mov	r3, #0
     ef8:	e50b3008 	str	r3, [fp, #-8]
  while(*s) {
     efc:	ea000008 	b	f24 <putstr+0x40>
    Hal_uart_put_char(*s++);
     f00:	e51b3010 	ldr	r3, [fp, #-16]
     f04:	e2832001 	add	r2, r3, #1
     f08:	e50b2010 	str	r2, [fp, #-16]
     f0c:	e5d33000 	ldrb	r3, [r3]
     f10:	e1a00003 	mov	r0, r3
     f14:	ebffff6e 	bl	cd4 <Hal_uart_put_char>
    ++c;
     f18:	e51b3008 	ldr	r3, [fp, #-8]
     f1c:	e2833001 	add	r3, r3, #1
     f20:	e50b3008 	str	r3, [fp, #-8]
  while(*s) {
     f24:	e51b3010 	ldr	r3, [fp, #-16]
     f28:	e5d33000 	ldrb	r3, [r3]
     f2c:	e3530000 	cmp	r3, #0
     f30:	1afffff2 	bne	f00 <putstr+0x1c>
  }
  return c;
     f34:	e51b3008 	ldr	r3, [fp, #-8]
}
     f38:	e1a00003 	mov	r0, r3
     f3c:	e24bd004 	sub	sp, fp, #4
     f40:	e8bd8800 	pop	{fp, pc}

00000f44 <debug_printf>:

uint32_t debug_printf(const char* format, ...) { 
     f44:	e92d000f 	push	{r0, r1, r2, r3}
     f48:	e92d4800 	push	{fp, lr}
     f4c:	e28db004 	add	fp, sp, #4
     f50:	e24dd008 	sub	sp, sp, #8
  va_list args; // 가변 인자를 가리킬 수 있는 참조자 선언
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
     f54:	e28b3008 	add	r3, fp, #8
     f58:	e50b3008 	str	r3, [fp, #-8]
  vsprintf(printf_buf, format, args);
     f5c:	e51b2008 	ldr	r2, [fp, #-8]
     f60:	e59b1004 	ldr	r1, [fp, #4]
     f64:	e302064c 	movw	r0, #9804	@ 0x264c
     f68:	e3400000 	movt	r0, #0
     f6c:	eb000008 	bl	f94 <vsprintf>
  va_end(args); // 메모리 해제

  return putstr(printf_buf);
     f70:	e302064c 	movw	r0, #9804	@ 0x264c
     f74:	e3400000 	movt	r0, #0
     f78:	ebffffd9 	bl	ee4 <putstr>
     f7c:	e1a03000 	mov	r3, r0
}
     f80:	e1a00003 	mov	r0, r3
     f84:	e24bd004 	sub	sp, fp, #4
     f88:	e8bd4800 	pop	{fp, lr}
     f8c:	e28dd010 	add	sp, sp, #16
     f90:	e12fff1e 	bx	lr

00000f94 <vsprintf>:

uint32_t vsprintf(char* buf, const char* format, va_list arg) {
     f94:	e92d4800 	push	{fp, lr}
     f98:	e28db004 	add	fp, sp, #4
     f9c:	e24dd028 	sub	sp, sp, #40	@ 0x28
     fa0:	e50b0020 	str	r0, [fp, #-32]	@ 0xffffffe0
     fa4:	e50b1024 	str	r1, [fp, #-36]	@ 0xffffffdc
     fa8:	e50b2028 	str	r2, [fp, #-40]	@ 0xffffffd8
  uint32_t c = 0;
     fac:	e3a03000 	mov	r3, #0
     fb0:	e50b3008 	str	r3, [fp, #-8]
  char ch;
  char* str;
  uint32_t uint;
  uint32_t hex;

  for (uint32_t i = 0; format[i]; ++i) {
     fb4:	e3a03000 	mov	r3, #0
     fb8:	e50b3010 	str	r3, [fp, #-16]
     fbc:	ea000085 	b	11d8 <vsprintf+0x244>
    if (format[i] == '%') {
     fc0:	e51b2024 	ldr	r2, [fp, #-36]	@ 0xffffffdc
     fc4:	e51b3010 	ldr	r3, [fp, #-16]
     fc8:	e0823003 	add	r3, r2, r3
     fcc:	e5d33000 	ldrb	r3, [r3]
     fd0:	e3530025 	cmp	r3, #37	@ 0x25
     fd4:	1a00006a 	bne	1184 <vsprintf+0x1f0>
      ++i;
     fd8:	e51b3010 	ldr	r3, [fp, #-16]
     fdc:	e2833001 	add	r3, r3, #1
     fe0:	e50b3010 	str	r3, [fp, #-16]
      switch(format[i]) {
     fe4:	e51b2024 	ldr	r2, [fp, #-36]	@ 0xffffffdc
     fe8:	e51b3010 	ldr	r3, [fp, #-16]
     fec:	e0823003 	add	r3, r2, r3
     ff0:	e5d33000 	ldrb	r3, [r3]
     ff4:	e2433063 	sub	r3, r3, #99	@ 0x63
     ff8:	e3530015 	cmp	r3, #21
     ffc:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
    1000:	ea000069 	b	11ac <vsprintf+0x218>
    1004:	0000105c 	andeq	r1, r0, ip, asr r0
    1008:	000011ac 	andeq	r1, r0, ip, lsr #3
    100c:	000011ac 	andeq	r1, r0, ip, lsr #3
    1010:	000011ac 	andeq	r1, r0, ip, lsr #3
    1014:	000011ac 	andeq	r1, r0, ip, lsr #3
    1018:	000011ac 	andeq	r1, r0, ip, lsr #3
    101c:	000011ac 	andeq	r1, r0, ip, lsr #3
    1020:	000011ac 	andeq	r1, r0, ip, lsr #3
    1024:	000011ac 	andeq	r1, r0, ip, lsr #3
    1028:	000011ac 	andeq	r1, r0, ip, lsr #3
    102c:	000011ac 	andeq	r1, r0, ip, lsr #3
    1030:	000011ac 	andeq	r1, r0, ip, lsr #3
    1034:	000011ac 	andeq	r1, r0, ip, lsr #3
    1038:	000011ac 	andeq	r1, r0, ip, lsr #3
    103c:	000011ac 	andeq	r1, r0, ip, lsr #3
    1040:	000011ac 	andeq	r1, r0, ip, lsr #3
    1044:	00001090 	muleq	r0, r0, r0
    1048:	000011ac 	andeq	r1, r0, ip, lsr #3
    104c:	000010fc 	strdeq	r1, [r0], -ip
    1050:	000011ac 	andeq	r1, r0, ip, lsr #3
    1054:	000011ac 	andeq	r1, r0, ip, lsr #3
    1058:	00001140 	andeq	r1, r0, r0, asr #2
      case 'c':
        ch = (char)va_arg(arg, int32_t);
    105c:	e51b3028 	ldr	r3, [fp, #-40]	@ 0xffffffd8
    1060:	e2832004 	add	r2, r3, #4
    1064:	e50b2028 	str	r2, [fp, #-40]	@ 0xffffffd8
    1068:	e5933000 	ldr	r3, [r3]
    106c:	e54b3019 	strb	r3, [fp, #-25]	@ 0xffffffe7
        buf[c++] = ch;
    1070:	e51b3008 	ldr	r3, [fp, #-8]
    1074:	e2832001 	add	r2, r3, #1
    1078:	e50b2008 	str	r2, [fp, #-8]
    107c:	e51b2020 	ldr	r2, [fp, #-32]	@ 0xffffffe0
    1080:	e0823003 	add	r3, r2, r3
    1084:	e55b2019 	ldrb	r2, [fp, #-25]	@ 0xffffffe7
    1088:	e5c32000 	strb	r2, [r3]
        break;
    108c:	ea000046 	b	11ac <vsprintf+0x218>
      case 's':
        str = (char*)va_arg(arg, char*);
    1090:	e51b3028 	ldr	r3, [fp, #-40]	@ 0xffffffd8
    1094:	e2832004 	add	r2, r3, #4
    1098:	e50b2028 	str	r2, [fp, #-40]	@ 0xffffffd8
    109c:	e5933000 	ldr	r3, [r3]
    10a0:	e50b300c 	str	r3, [fp, #-12]
        if (str == NULL) {
    10a4:	e51b300c 	ldr	r3, [fp, #-12]
    10a8:	e3530000 	cmp	r3, #0
    10ac:	1a00000d 	bne	10e8 <vsprintf+0x154>
          str = "(null)";
    10b0:	e301331c 	movw	r3, #4892	@ 0x131c
    10b4:	e3403000 	movt	r3, #0
    10b8:	e50b300c 	str	r3, [fp, #-12]
        }
        while (*str) {
    10bc:	ea000009 	b	10e8 <vsprintf+0x154>
          buf[c++] = (*str++);
    10c0:	e51b300c 	ldr	r3, [fp, #-12]
    10c4:	e2832001 	add	r2, r3, #1
    10c8:	e50b200c 	str	r2, [fp, #-12]
    10cc:	e51b2008 	ldr	r2, [fp, #-8]
    10d0:	e2821001 	add	r1, r2, #1
    10d4:	e50b1008 	str	r1, [fp, #-8]
    10d8:	e51b1020 	ldr	r1, [fp, #-32]	@ 0xffffffe0
    10dc:	e0812002 	add	r2, r1, r2
    10e0:	e5d33000 	ldrb	r3, [r3]
    10e4:	e5c23000 	strb	r3, [r2]
        while (*str) {
    10e8:	e51b300c 	ldr	r3, [fp, #-12]
    10ec:	e5d33000 	ldrb	r3, [r3]
    10f0:	e3530000 	cmp	r3, #0
    10f4:	1afffff1 	bne	10c0 <vsprintf+0x12c>
        }
        break;
    10f8:	ea00002b 	b	11ac <vsprintf+0x218>
      case 'u':
        uint = (uint32_t)va_arg(arg, uint32_t);
    10fc:	e51b3028 	ldr	r3, [fp, #-40]	@ 0xffffffd8
    1100:	e2832004 	add	r2, r3, #4
    1104:	e50b2028 	str	r2, [fp, #-40]	@ 0xffffffd8
    1108:	e5933000 	ldr	r3, [r3]
    110c:	e50b3018 	str	r3, [fp, #-24]	@ 0xffffffe8
        c += utoa(&buf[c], uint, utoa_dec);
    1110:	e51b2020 	ldr	r2, [fp, #-32]	@ 0xffffffe0
    1114:	e51b3008 	ldr	r3, [fp, #-8]
    1118:	e0823003 	add	r3, r2, r3
    111c:	e3a0200a 	mov	r2, #10
    1120:	e51b1018 	ldr	r1, [fp, #-24]	@ 0xffffffe8
    1124:	e1a00003 	mov	r0, r3
    1128:	eb000039 	bl	1214 <utoa>
    112c:	e1a02000 	mov	r2, r0
    1130:	e51b3008 	ldr	r3, [fp, #-8]
    1134:	e0833002 	add	r3, r3, r2
    1138:	e50b3008 	str	r3, [fp, #-8]
        break;
    113c:	ea00001a 	b	11ac <vsprintf+0x218>
      case 'x':
        hex = (uint32_t)va_arg(arg, uint32_t);
    1140:	e51b3028 	ldr	r3, [fp, #-40]	@ 0xffffffd8
    1144:	e2832004 	add	r2, r3, #4
    1148:	e50b2028 	str	r2, [fp, #-40]	@ 0xffffffd8
    114c:	e5933000 	ldr	r3, [r3]
    1150:	e50b3014 	str	r3, [fp, #-20]	@ 0xffffffec
        c += utoa(&buf[c], hex, utoa_hex);
    1154:	e51b2020 	ldr	r2, [fp, #-32]	@ 0xffffffe0
    1158:	e51b3008 	ldr	r3, [fp, #-8]
    115c:	e0823003 	add	r3, r2, r3
    1160:	e3a02010 	mov	r2, #16
    1164:	e51b1014 	ldr	r1, [fp, #-20]	@ 0xffffffec
    1168:	e1a00003 	mov	r0, r3
    116c:	eb000028 	bl	1214 <utoa>
    1170:	e1a02000 	mov	r2, r0
    1174:	e51b3008 	ldr	r3, [fp, #-8]
    1178:	e0833002 	add	r3, r3, r2
    117c:	e50b3008 	str	r3, [fp, #-8]
        break;
    1180:	ea000009 	b	11ac <vsprintf+0x218>
      }
    }
    else {
      buf[c++] = format[i];
    1184:	e51b2024 	ldr	r2, [fp, #-36]	@ 0xffffffdc
    1188:	e51b3010 	ldr	r3, [fp, #-16]
    118c:	e0822003 	add	r2, r2, r3
    1190:	e51b3008 	ldr	r3, [fp, #-8]
    1194:	e2831001 	add	r1, r3, #1
    1198:	e50b1008 	str	r1, [fp, #-8]
    119c:	e51b1020 	ldr	r1, [fp, #-32]	@ 0xffffffe0
    11a0:	e0813003 	add	r3, r1, r3
    11a4:	e5d22000 	ldrb	r2, [r2]
    11a8:	e5c32000 	strb	r2, [r3]
    }

    if (c >= PRINTF_BUF_LEN) {
    11ac:	e51b3008 	ldr	r3, [fp, #-8]
    11b0:	e3530b01 	cmp	r3, #1024	@ 0x400
    11b4:	3a000004 	bcc	11cc <vsprintf+0x238>
        buf[0] = '\0';
    11b8:	e51b3020 	ldr	r3, [fp, #-32]	@ 0xffffffe0
    11bc:	e3a02000 	mov	r2, #0
    11c0:	e5c32000 	strb	r2, [r3]
        return 0;
    11c4:	e3a03000 	mov	r3, #0
    11c8:	ea00000e 	b	1208 <vsprintf+0x274>
  for (uint32_t i = 0; format[i]; ++i) {
    11cc:	e51b3010 	ldr	r3, [fp, #-16]
    11d0:	e2833001 	add	r3, r3, #1
    11d4:	e50b3010 	str	r3, [fp, #-16]
    11d8:	e51b2024 	ldr	r2, [fp, #-36]	@ 0xffffffdc
    11dc:	e51b3010 	ldr	r3, [fp, #-16]
    11e0:	e0823003 	add	r3, r2, r3
    11e4:	e5d33000 	ldrb	r3, [r3]
    11e8:	e3530000 	cmp	r3, #0
    11ec:	1affff73 	bne	fc0 <vsprintf+0x2c>
      }
  }

  buf[c] = '\0';
    11f0:	e51b2020 	ldr	r2, [fp, #-32]	@ 0xffffffe0
    11f4:	e51b3008 	ldr	r3, [fp, #-8]
    11f8:	e0823003 	add	r3, r2, r3
    11fc:	e3a02000 	mov	r2, #0
    1200:	e5c32000 	strb	r2, [r3]
  return c;
    1204:	e51b3008 	ldr	r3, [fp, #-8]
}
    1208:	e1a00003 	mov	r0, r3
    120c:	e24bd004 	sub	sp, fp, #4
    1210:	e8bd8800 	pop	{fp, pc}

00001214 <utoa>:

uint32_t utoa(char* buf, uint32_t val, utoa_t base) {
    1214:	e92d4800 	push	{fp, lr}
    1218:	e28db004 	add	fp, sp, #4
    121c:	e24dd028 	sub	sp, sp, #40	@ 0x28
    1220:	e50b0020 	str	r0, [fp, #-32]	@ 0xffffffe0
    1224:	e50b1024 	str	r1, [fp, #-36]	@ 0xffffffdc
    1228:	e1a03002 	mov	r3, r2
    122c:	e54b3025 	strb	r3, [fp, #-37]	@ 0xffffffdb
  uint32_t c = 0;
    1230:	e3a03000 	mov	r3, #0
    1234:	e50b3008 	str	r3, [fp, #-8]
  int32_t idx = 0;
    1238:	e3a03000 	mov	r3, #0
    123c:	e50b300c 	str	r3, [fp, #-12]
  char tmp[11];

  do {
    uint32_t t = val % (uint32_t)base;
    1240:	e55b2025 	ldrb	r2, [fp, #-37]	@ 0xffffffdb
    1244:	e51b3024 	ldr	r3, [fp, #-36]	@ 0xffffffdc
    1248:	e1a01002 	mov	r1, r2
    124c:	e1a00003 	mov	r0, r3
    1250:	eb0003ef 	bl	2214 <__aeabi_uidivmod>
    1254:	e1a03001 	mov	r3, r1
    1258:	e50b3010 	str	r3, [fp, #-16]
    if (t >= 10) {
    125c:	e51b3010 	ldr	r3, [fp, #-16]
    1260:	e3530009 	cmp	r3, #9
    1264:	9a000002 	bls	1274 <utoa+0x60>
      t += 'A' - 10 - '0';
    1268:	e51b3010 	ldr	r3, [fp, #-16]
    126c:	e2833007 	add	r3, r3, #7
    1270:	e50b3010 	str	r3, [fp, #-16]
    }
    tmp[idx++] = (t + '0');
    1274:	e51b3010 	ldr	r3, [fp, #-16]
    1278:	e6ef2073 	uxtb	r2, r3
    127c:	e51b300c 	ldr	r3, [fp, #-12]
    1280:	e2831001 	add	r1, r3, #1
    1284:	e50b100c 	str	r1, [fp, #-12]
    1288:	e2822030 	add	r2, r2, #48	@ 0x30
    128c:	e6ef2072 	uxtb	r2, r2
    1290:	e2433004 	sub	r3, r3, #4
    1294:	e083300b 	add	r3, r3, fp
    1298:	e5432018 	strb	r2, [r3, #-24]	@ 0xffffffe8
    val /= base;
    129c:	e55b3025 	ldrb	r3, [fp, #-37]	@ 0xffffffdb
    12a0:	e1a01003 	mov	r1, r3
    12a4:	e51b0024 	ldr	r0, [fp, #-36]	@ 0xffffffdc
    12a8:	eb00039c 	bl	2120 <__udivsi3>
    12ac:	e1a03000 	mov	r3, r0
    12b0:	e50b3024 	str	r3, [fp, #-36]	@ 0xffffffdc
  } while(val);
    12b4:	e51b3024 	ldr	r3, [fp, #-36]	@ 0xffffffdc
    12b8:	e3530000 	cmp	r3, #0
    12bc:	1affffdf 	bne	1240 <utoa+0x2c>

  // reverse
  --idx; // idx를 부호 있는 정수형으로 선언한 이유
    12c0:	e51b300c 	ldr	r3, [fp, #-12]
    12c4:	e2433001 	sub	r3, r3, #1
    12c8:	e50b300c 	str	r3, [fp, #-12]
  while (idx >= 0) {
    12cc:	ea00000b 	b	1300 <utoa+0xec>
    buf[c++] = tmp[idx--];
    12d0:	e51b300c 	ldr	r3, [fp, #-12]
    12d4:	e2432001 	sub	r2, r3, #1
    12d8:	e50b200c 	str	r2, [fp, #-12]
    12dc:	e51b2008 	ldr	r2, [fp, #-8]
    12e0:	e2821001 	add	r1, r2, #1
    12e4:	e50b1008 	str	r1, [fp, #-8]
    12e8:	e51b1020 	ldr	r1, [fp, #-32]	@ 0xffffffe0
    12ec:	e0812002 	add	r2, r1, r2
    12f0:	e2433004 	sub	r3, r3, #4
    12f4:	e083300b 	add	r3, r3, fp
    12f8:	e5533018 	ldrb	r3, [r3, #-24]	@ 0xffffffe8
    12fc:	e5c23000 	strb	r3, [r2]
  while (idx >= 0) {
    1300:	e51b300c 	ldr	r3, [fp, #-12]
    1304:	e3530000 	cmp	r3, #0
    1308:	aafffff0 	bge	12d0 <utoa+0xbc>
  }

  return c;
    130c:	e51b3008 	ldr	r3, [fp, #-8]
    1310:	e1a00003 	mov	r0, r3
    1314:	e24bd004 	sub	sp, fp, #4
    1318:	e8bd8800 	pop	{fp, pc}
    131c:	6c756e28 	ldclvs	14, cr6, [r5], #-160	@ 0xffffff60
    1320:	0000296c 	andeq	r2, r0, ip, ror #18

00001324 <delay>:
#include "stdint.h"
#include "stdbool.h"
#include "HalTimer.h"

void delay(uint32_t ms) {
    1324:	e92d4800 	push	{fp, lr}
    1328:	e28db004 	add	fp, sp, #4
    132c:	e24dd010 	sub	sp, sp, #16
    1330:	e50b0010 	str	r0, [fp, #-16]
  uint32_t goal = Hal_timer_get_1ms_counter() + ms;
    1334:	ebfffe25 	bl	bd0 <Hal_timer_get_1ms_counter>
    1338:	e1a02000 	mov	r2, r0
    133c:	e51b3010 	ldr	r3, [fp, #-16]
    1340:	e0833002 	add	r3, r3, r2
    1344:	e50b3008 	str	r3, [fp, #-8]
  while(goal != Hal_timer_get_1ms_counter());
    1348:	e320f000 	nop	{0}
    134c:	ebfffe1f 	bl	bd0 <Hal_timer_get_1ms_counter>
    1350:	e1a02000 	mov	r2, r0
    1354:	e51b3008 	ldr	r3, [fp, #-8]
    1358:	e1530002 	cmp	r3, r2
    135c:	1afffffa 	bne	134c <delay+0x28>
    1360:	e320f000 	nop	{0}
    1364:	e320f000 	nop	{0}
    1368:	e24bd004 	sub	sp, fp, #4
    136c:	e8bd8800 	pop	{fp, pc}

00001370 <Kernel_event_flag_init>:
#include "stdio.h"
#include "event.h"

static uint32_t sEventFlag;

void Kernel_event_flag_init(void) {
    1370:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1374:	e28db000 	add	fp, sp, #0
  sEventFlag = 0;
    1378:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    137c:	e3403000 	movt	r3, #0
    1380:	e3a02000 	mov	r2, #0
    1384:	e5832000 	str	r2, [r3]
}
    1388:	e320f000 	nop	{0}
    138c:	e28bd000 	add	sp, fp, #0
    1390:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1394:	e12fff1e 	bx	lr

00001398 <Kernel_event_flag_set>:
void Kernel_event_flag_set(KernelEventFlag_t event) {
    1398:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    139c:	e28db000 	add	fp, sp, #0
    13a0:	e24dd00c 	sub	sp, sp, #12
    13a4:	e50b0008 	str	r0, [fp, #-8]
  sEventFlag |= (uint32_t)event;
    13a8:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    13ac:	e3403000 	movt	r3, #0
    13b0:	e5932000 	ldr	r2, [r3]
    13b4:	e51b3008 	ldr	r3, [fp, #-8]
    13b8:	e1822003 	orr	r2, r2, r3
    13bc:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    13c0:	e3403000 	movt	r3, #0
    13c4:	e5832000 	str	r2, [r3]
}
    13c8:	e320f000 	nop	{0}
    13cc:	e28bd000 	add	sp, fp, #0
    13d0:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    13d4:	e12fff1e 	bx	lr

000013d8 <Kernel_event_flag_clear>:
void Kernel_event_flag_clear(KernelEventFlag_t event) {
    13d8:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    13dc:	e28db000 	add	fp, sp, #0
    13e0:	e24dd00c 	sub	sp, sp, #12
    13e4:	e50b0008 	str	r0, [fp, #-8]
  sEventFlag &= ~((uint32_t)event);
    13e8:	e51b3008 	ldr	r3, [fp, #-8]
    13ec:	e1e02003 	mvn	r2, r3
    13f0:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    13f4:	e3403000 	movt	r3, #0
    13f8:	e5933000 	ldr	r3, [r3]
    13fc:	e0022003 	and	r2, r2, r3
    1400:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    1404:	e3403000 	movt	r3, #0
    1408:	e5832000 	str	r2, [r3]
}
    140c:	e320f000 	nop	{0}
    1410:	e28bd000 	add	sp, fp, #0
    1414:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1418:	e12fff1e 	bx	lr

0000141c <Kernel_event_flag_check>:
bool Kernel_event_flag_check(KernelEventFlag_t event) {
    141c:	e92d4800 	push	{fp, lr}
    1420:	e28db004 	add	fp, sp, #4
    1424:	e24dd008 	sub	sp, sp, #8
    1428:	e50b0008 	str	r0, [fp, #-8]
  if(sEventFlag & (uint32_t)event) {
    142c:	e3023a4c 	movw	r3, #10828	@ 0x2a4c
    1430:	e3403000 	movt	r3, #0
    1434:	e5932000 	ldr	r2, [r3]
    1438:	e51b3008 	ldr	r3, [fp, #-8]
    143c:	e0033002 	and	r3, r3, r2
    1440:	e3530000 	cmp	r3, #0
    1444:	0a000003 	beq	1458 <Kernel_event_flag_check+0x3c>
    Kernel_event_flag_clear(event);
    1448:	e51b0008 	ldr	r0, [fp, #-8]
    144c:	ebffffe1 	bl	13d8 <Kernel_event_flag_clear>
    return true;
    1450:	e3a03001 	mov	r3, #1
    1454:	ea000000 	b	145c <Kernel_event_flag_check+0x40>
  }
  return false;
    1458:	e3a03000 	mov	r3, #0
    145c:	e1a00003 	mov	r0, r3
    1460:	e24bd004 	sub	sp, fp, #4
    1464:	e8bd8800 	pop	{fp, pc}

00001468 <Kernel_start>:

#include "Kernel.h"
#include "synch.h"
#include "task.h"

void Kernel_start(void) {
    1468:	e92d4800 	push	{fp, lr}
    146c:	e28db004 	add	fp, sp, #4
  Kernel_task_start();
    1470:	eb0002d8 	bl	1fd8 <Kernel_task_start>
}
    1474:	e320f000 	nop	{0}
    1478:	e8bd8800 	pop	{fp, pc}

0000147c <Kernel_yield>:

void Kernel_yield(void) {
    147c:	e92d4800 	push	{fp, lr}
    1480:	e28db004 	add	fp, sp, #4
  Kernel_task_scheduling();
    1484:	eb0002bf 	bl	1f88 <Kernel_task_scheduling>
}
    1488:	e320f000 	nop	{0}
    148c:	e8bd8800 	pop	{fp, pc}

00001490 <Kernel_send_events>:

void Kernel_send_events(uint32_t event_list) {
    1490:	e92d4800 	push	{fp, lr}
    1494:	e28db004 	add	fp, sp, #4
    1498:	e24dd010 	sub	sp, sp, #16
    149c:	e50b0010 	str	r0, [fp, #-16]
  for(uint32_t i = 0; i < 32; ++i) {
    14a0:	e3a03000 	mov	r3, #0
    14a4:	e50b3008 	str	r3, [fp, #-8]
    14a8:	ea000013 	b	14fc <Kernel_send_events+0x6c>
    if((event_list >> i) & 1) {
    14ac:	e51b2010 	ldr	r2, [fp, #-16]
    14b0:	e51b3008 	ldr	r3, [fp, #-8]
    14b4:	e1a03332 	lsr	r3, r2, r3
    14b8:	e2033001 	and	r3, r3, #1
    14bc:	e3530000 	cmp	r3, #0
    14c0:	0a00000a 	beq	14f0 <Kernel_send_events+0x60>
      KernelEventFlag_t sending_event = KernelEventFlag_Empty;
    14c4:	e3a03000 	mov	r3, #0
    14c8:	e50b300c 	str	r3, [fp, #-12]
      sending_event = (KernelEventFlag_t)SET_BIT(sending_event, i);
    14cc:	e3a02001 	mov	r2, #1
    14d0:	e51b3008 	ldr	r3, [fp, #-8]
    14d4:	e1a03312 	lsl	r3, r2, r3
    14d8:	e1a02003 	mov	r2, r3
    14dc:	e51b300c 	ldr	r3, [fp, #-12]
    14e0:	e1833002 	orr	r3, r3, r2
    14e4:	e50b300c 	str	r3, [fp, #-12]
      Kernel_event_flag_set(sending_event);
    14e8:	e51b000c 	ldr	r0, [fp, #-12]
    14ec:	ebffffa9 	bl	1398 <Kernel_event_flag_set>
  for(uint32_t i = 0; i < 32; ++i) {
    14f0:	e51b3008 	ldr	r3, [fp, #-8]
    14f4:	e2833001 	add	r3, r3, #1
    14f8:	e50b3008 	str	r3, [fp, #-8]
    14fc:	e51b3008 	ldr	r3, [fp, #-8]
    1500:	e353001f 	cmp	r3, #31
    1504:	9affffe8 	bls	14ac <Kernel_send_events+0x1c>
    }
  }
}
    1508:	e320f000 	nop	{0}
    150c:	e320f000 	nop	{0}
    1510:	e24bd004 	sub	sp, fp, #4
    1514:	e8bd8800 	pop	{fp, pc}

00001518 <Kernel_wait_events>:

KernelEventFlag_t Kernel_wait_events(uint32_t waiting_list) {
    1518:	e92d4800 	push	{fp, lr}
    151c:	e28db004 	add	fp, sp, #4
    1520:	e24dd010 	sub	sp, sp, #16
    1524:	e50b0010 	str	r0, [fp, #-16]
  for(uint32_t i = 0; i < 32; ++i) {
    1528:	e3a03000 	mov	r3, #0
    152c:	e50b3008 	str	r3, [fp, #-8]
    1530:	ea000018 	b	1598 <Kernel_wait_events+0x80>
    if((waiting_list >> i) & 1) {
    1534:	e51b2010 	ldr	r2, [fp, #-16]
    1538:	e51b3008 	ldr	r3, [fp, #-8]
    153c:	e1a03332 	lsr	r3, r2, r3
    1540:	e2033001 	and	r3, r3, #1
    1544:	e3530000 	cmp	r3, #0
    1548:	0a00000f 	beq	158c <Kernel_wait_events+0x74>
      KernelEventFlag_t waiting_event = KernelEventFlag_Empty;
    154c:	e3a03000 	mov	r3, #0
    1550:	e50b300c 	str	r3, [fp, #-12]
      waiting_event = (KernelEventFlag_t)SET_BIT(waiting_event, i);
    1554:	e3a02001 	mov	r2, #1
    1558:	e51b3008 	ldr	r3, [fp, #-8]
    155c:	e1a03312 	lsl	r3, r2, r3
    1560:	e1a02003 	mov	r2, r3
    1564:	e51b300c 	ldr	r3, [fp, #-12]
    1568:	e1833002 	orr	r3, r3, r2
    156c:	e50b300c 	str	r3, [fp, #-12]

      if(Kernel_event_flag_check(waiting_event)) {
    1570:	e51b000c 	ldr	r0, [fp, #-12]
    1574:	ebffffa8 	bl	141c <Kernel_event_flag_check>
    1578:	e1a03000 	mov	r3, r0
    157c:	e3530000 	cmp	r3, #0
    1580:	0a000001 	beq	158c <Kernel_wait_events+0x74>
        return waiting_event;
    1584:	e51b300c 	ldr	r3, [fp, #-12]
    1588:	ea000006 	b	15a8 <Kernel_wait_events+0x90>
  for(uint32_t i = 0; i < 32; ++i) {
    158c:	e51b3008 	ldr	r3, [fp, #-8]
    1590:	e2833001 	add	r3, r3, #1
    1594:	e50b3008 	str	r3, [fp, #-8]
    1598:	e51b3008 	ldr	r3, [fp, #-8]
    159c:	e353001f 	cmp	r3, #31
    15a0:	9affffe3 	bls	1534 <Kernel_wait_events+0x1c>
      }
    }
  }

  return KernelEventFlag_Empty;
    15a4:	e3a03000 	mov	r3, #0
}
    15a8:	e1a00003 	mov	r0, r3
    15ac:	e24bd004 	sub	sp, fp, #4
    15b0:	e8bd8800 	pop	{fp, pc}

000015b4 <Kernel_send_msg>:

bool Kernel_send_msg(KernelMsgQ_t Qname, void* data, uint32_t count) {
    15b4:	e92d4800 	push	{fp, lr}
    15b8:	e28db004 	add	fp, sp, #4
    15bc:	e24dd020 	sub	sp, sp, #32
    15c0:	e1a03000 	mov	r3, r0
    15c4:	e50b101c 	str	r1, [fp, #-28]	@ 0xffffffe4
    15c8:	e50b2020 	str	r2, [fp, #-32]	@ 0xffffffe0
    15cc:	e54b3015 	strb	r3, [fp, #-21]	@ 0xffffffeb
  uint8_t* d = (uint8_t*)data;
    15d0:	e51b301c 	ldr	r3, [fp, #-28]	@ 0xffffffe4
    15d4:	e50b3008 	str	r3, [fp, #-8]

  for(uint32_t i = 0; i < count; ++i) {
    15d8:	e3a03000 	mov	r3, #0
    15dc:	e50b300c 	str	r3, [fp, #-12]
    15e0:	ea000021 	b	166c <Kernel_send_msg+0xb8>
    if(!Kernel_msgQ_enqueue(Qname, *d)) {
    15e4:	e51b3008 	ldr	r3, [fp, #-8]
    15e8:	e5d32000 	ldrb	r2, [r3]
    15ec:	e55b3015 	ldrb	r3, [fp, #-21]	@ 0xffffffeb
    15f0:	e1a01002 	mov	r1, r2
    15f4:	e1a00003 	mov	r0, r3
    15f8:	eb0000e4 	bl	1990 <Kernel_msgQ_enqueue>
    15fc:	e1a03000 	mov	r3, r0
    1600:	e2233001 	eor	r3, r3, #1
    1604:	e6ef3073 	uxtb	r3, r3
    1608:	e3530000 	cmp	r3, #0
    160c:	0a000010 	beq	1654 <Kernel_send_msg+0xa0>
      for(uint32_t j = 0; j < i; ++j) {
    1610:	e3a03000 	mov	r3, #0
    1614:	e50b3010 	str	r3, [fp, #-16]
    1618:	ea000007 	b	163c <Kernel_send_msg+0x88>
        uint8_t rollback;
        Kernel_msgQ_dequeue(Qname, &rollback);
    161c:	e24b2011 	sub	r2, fp, #17
    1620:	e55b3015 	ldrb	r3, [fp, #-21]	@ 0xffffffeb
    1624:	e1a01002 	mov	r1, r2
    1628:	e1a00003 	mov	r0, r3
    162c:	eb000124 	bl	1ac4 <Kernel_msgQ_dequeue>
      for(uint32_t j = 0; j < i; ++j) {
    1630:	e51b3010 	ldr	r3, [fp, #-16]
    1634:	e2833001 	add	r3, r3, #1
    1638:	e50b3010 	str	r3, [fp, #-16]
    163c:	e51b2010 	ldr	r2, [fp, #-16]
    1640:	e51b300c 	ldr	r3, [fp, #-12]
    1644:	e1520003 	cmp	r2, r3
    1648:	3afffff3 	bcc	161c <Kernel_send_msg+0x68>
      }
      return false;
    164c:	e3a03000 	mov	r3, #0
    1650:	ea00000a 	b	1680 <Kernel_send_msg+0xcc>
    }
    ++d;
    1654:	e51b3008 	ldr	r3, [fp, #-8]
    1658:	e2833001 	add	r3, r3, #1
    165c:	e50b3008 	str	r3, [fp, #-8]
  for(uint32_t i = 0; i < count; ++i) {
    1660:	e51b300c 	ldr	r3, [fp, #-12]
    1664:	e2833001 	add	r3, r3, #1
    1668:	e50b300c 	str	r3, [fp, #-12]
    166c:	e51b200c 	ldr	r2, [fp, #-12]
    1670:	e51b3020 	ldr	r3, [fp, #-32]	@ 0xffffffe0
    1674:	e1520003 	cmp	r2, r3
    1678:	3affffd9 	bcc	15e4 <Kernel_send_msg+0x30>
  }

  return true;
    167c:	e3a03001 	mov	r3, #1
}
    1680:	e1a00003 	mov	r0, r3
    1684:	e24bd004 	sub	sp, fp, #4
    1688:	e8bd8800 	pop	{fp, pc}

0000168c <Kernel_recv_msg>:

uint32_t Kernel_recv_msg(KernelMsgQ_t Qname, void* out_data, uint32_t count) {
    168c:	e92d4800 	push	{fp, lr}
    1690:	e28db004 	add	fp, sp, #4
    1694:	e24dd018 	sub	sp, sp, #24
    1698:	e1a03000 	mov	r3, r0
    169c:	e50b1014 	str	r1, [fp, #-20]	@ 0xffffffec
    16a0:	e50b2018 	str	r2, [fp, #-24]	@ 0xffffffe8
    16a4:	e54b300d 	strb	r3, [fp, #-13]
  uint8_t* d = (uint8_t*)out_data;
    16a8:	e51b3014 	ldr	r3, [fp, #-20]	@ 0xffffffec
    16ac:	e50b3008 	str	r3, [fp, #-8]

  for(uint32_t i = 0; i < count; ++i) {
    16b0:	e3a03000 	mov	r3, #0
    16b4:	e50b300c 	str	r3, [fp, #-12]
    16b8:	ea000010 	b	1700 <Kernel_recv_msg+0x74>
    if(!Kernel_msgQ_dequeue(Qname, d)) {
    16bc:	e55b300d 	ldrb	r3, [fp, #-13]
    16c0:	e51b1008 	ldr	r1, [fp, #-8]
    16c4:	e1a00003 	mov	r0, r3
    16c8:	eb0000fd 	bl	1ac4 <Kernel_msgQ_dequeue>
    16cc:	e1a03000 	mov	r3, r0
    16d0:	e2233001 	eor	r3, r3, #1
    16d4:	e6ef3073 	uxtb	r3, r3
    16d8:	e3530000 	cmp	r3, #0
    16dc:	0a000001 	beq	16e8 <Kernel_recv_msg+0x5c>
      return i;
    16e0:	e51b300c 	ldr	r3, [fp, #-12]
    16e4:	ea00000a 	b	1714 <Kernel_recv_msg+0x88>
    }
    ++d;
    16e8:	e51b3008 	ldr	r3, [fp, #-8]
    16ec:	e2833001 	add	r3, r3, #1
    16f0:	e50b3008 	str	r3, [fp, #-8]
  for(uint32_t i = 0; i < count; ++i) {
    16f4:	e51b300c 	ldr	r3, [fp, #-12]
    16f8:	e2833001 	add	r3, r3, #1
    16fc:	e50b300c 	str	r3, [fp, #-12]
    1700:	e51b200c 	ldr	r2, [fp, #-12]
    1704:	e51b3018 	ldr	r3, [fp, #-24]	@ 0xffffffe8
    1708:	e1520003 	cmp	r2, r3
    170c:	3affffea 	bcc	16bc <Kernel_recv_msg+0x30>
  }

  return count;
    1710:	e51b3018 	ldr	r3, [fp, #-24]	@ 0xffffffe8
}
    1714:	e1a00003 	mov	r0, r3
    1718:	e24bd004 	sub	sp, fp, #4
    171c:	e8bd8800 	pop	{fp, pc}

00001720 <Kernel_lock_sem>:

void Kernel_lock_sem(void) {
    1720:	e92d4800 	push	{fp, lr}
    1724:	e28db004 	add	fp, sp, #4
  while (!Kernel_sem_test()) {
    1728:	ea000000 	b	1730 <Kernel_lock_sem+0x10>
    Kernel_yield();
    172c:	ebffff52 	bl	147c <Kernel_yield>
  while (!Kernel_sem_test()) {
    1730:	eb00013f 	bl	1c34 <Kernel_sem_test>
    1734:	e1a03000 	mov	r3, r0
    1738:	e2233001 	eor	r3, r3, #1
    173c:	e6ef3073 	uxtb	r3, r3
    1740:	e3530000 	cmp	r3, #0
    1744:	1afffff8 	bne	172c <Kernel_lock_sem+0xc>
  }
}
    1748:	e320f000 	nop	{0}
    174c:	e320f000 	nop	{0}
    1750:	e8bd8800 	pop	{fp, pc}

00001754 <Kernel_unlock_sem>:

void Kernel_unlock_sem(void) {
    1754:	e92d4800 	push	{fp, lr}
    1758:	e28db004 	add	fp, sp, #4
  Kernel_sem_release();
    175c:	eb000149 	bl	1c88 <Kernel_sem_release>
}
    1760:	e320f000 	nop	{0}
    1764:	e8bd8800 	pop	{fp, pc}

00001768 <Kernel_lock_mutex>:

void Kernel_lock_mutex(void) {
    1768:	e92d4800 	push	{fp, lr}
    176c:	e28db004 	add	fp, sp, #4
    1770:	e24dd008 	sub	sp, sp, #8
  while(true) {
    uint32_t current_task_id = Kernel_task_get_current_task_id();
    1774:	eb00022e 	bl	2034 <Kernel_task_get_current_task_id>
    1778:	e50b0008 	str	r0, [fp, #-8]
    if(!Kernel_mutex_lock(current_task_id)) {
    177c:	e51b0008 	ldr	r0, [fp, #-8]
    1780:	eb000169 	bl	1d2c <Kernel_mutex_lock>
    1784:	e1a03000 	mov	r3, r0
    1788:	e2233001 	eor	r3, r3, #1
    178c:	e6ef3073 	uxtb	r3, r3
    1790:	e3530000 	cmp	r3, #0
    1794:	0a000001 	beq	17a0 <Kernel_lock_mutex+0x38>
      Kernel_yield();
    1798:	ebffff37 	bl	147c <Kernel_yield>
  while(true) {
    179c:	eafffff4 	b	1774 <Kernel_lock_mutex+0xc>
    }
    else {
      break;
    17a0:	e320f000 	nop	{0}
    }
  }
}
    17a4:	e320f000 	nop	{0}
    17a8:	e24bd004 	sub	sp, fp, #4
    17ac:	e8bd8800 	pop	{fp, pc}

000017b0 <Kernel_unlock_mutex>:

void Kernel_unlock_mutex(void) {
    17b0:	e92d4800 	push	{fp, lr}
    17b4:	e28db004 	add	fp, sp, #4
    17b8:	e24dd008 	sub	sp, sp, #8
  uint32_t current_task_id = Kernel_task_get_current_task_id();
    17bc:	eb00021c 	bl	2034 <Kernel_task_get_current_task_id>
    17c0:	e50b0008 	str	r0, [fp, #-8]
  if(!Kernel_mutex_unlock(current_task_id)) {
    17c4:	e51b0008 	ldr	r0, [fp, #-8]
    17c8:	eb00016f 	bl	1d8c <Kernel_mutex_unlock>
    17cc:	e1a03000 	mov	r3, r0
    17d0:	e2233001 	eor	r3, r3, #1
    17d4:	e6ef3073 	uxtb	r3, r3
    17d8:	e3530000 	cmp	r3, #0
    17dc:	0a000000 	beq	17e4 <Kernel_unlock_mutex+0x34>
    Kernel_yield();
    17e0:	ebffff25 	bl	147c <Kernel_yield>
  }
    17e4:	e320f000 	nop	{0}
    17e8:	e24bd004 	sub	sp, fp, #4
    17ec:	e8bd8800 	pop	{fp, pc}

000017f0 <Kernel_msgQ_init>:

#include "msg.h"

static KernelCirQ_t sMsgQ[KernelMsgQ_Num];

void Kernel_msgQ_init(void) {
    17f0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    17f4:	e28db000 	add	fp, sp, #0
    17f8:	e24dd00c 	sub	sp, sp, #12
  for (uint32_t i = 0; i < KernelMsgQ_Num; ++i) {
    17fc:	e3a03000 	mov	r3, #0
    1800:	e50b3008 	str	r3, [fp, #-8]
    1804:	ea000013 	b	1858 <Kernel_msgQ_init+0x68>
    sMsgQ[i].front = 0;
    1808:	e3023a50 	movw	r3, #10832	@ 0x2a50
    180c:	e3403000 	movt	r3, #0
    1810:	e51b2008 	ldr	r2, [fp, #-8]
    1814:	e3a01f82 	mov	r1, #520	@ 0x208
    1818:	e0020291 	mul	r2, r1, r2
    181c:	e0833002 	add	r3, r3, r2
    1820:	e3a02000 	mov	r2, #0
    1824:	e5832000 	str	r2, [r3]
    sMsgQ[i].rear = 0;
    1828:	e3023a50 	movw	r3, #10832	@ 0x2a50
    182c:	e3403000 	movt	r3, #0
    1830:	e51b2008 	ldr	r2, [fp, #-8]
    1834:	e3a01f82 	mov	r1, #520	@ 0x208
    1838:	e0020291 	mul	r2, r1, r2
    183c:	e0833002 	add	r3, r3, r2
    1840:	e2833004 	add	r3, r3, #4
    1844:	e3a02000 	mov	r2, #0
    1848:	e5832000 	str	r2, [r3]
  for (uint32_t i = 0; i < KernelMsgQ_Num; ++i) {
    184c:	e51b3008 	ldr	r3, [fp, #-8]
    1850:	e2833001 	add	r3, r3, #1
    1854:	e50b3008 	str	r3, [fp, #-8]
    1858:	e51b3008 	ldr	r3, [fp, #-8]
    185c:	e3530002 	cmp	r3, #2
    1860:	9affffe8 	bls	1808 <Kernel_msgQ_init+0x18>
  }
}
    1864:	e320f000 	nop	{0}
    1868:	e320f000 	nop	{0}
    186c:	e28bd000 	add	sp, fp, #0
    1870:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1874:	e12fff1e 	bx	lr

00001878 <Kernel_msgQ_is_empty>:
bool Kernel_msgQ_is_empty(KernelMsgQ_t Qname) {
    1878:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    187c:	e28db000 	add	fp, sp, #0
    1880:	e24dd00c 	sub	sp, sp, #12
    1884:	e1a03000 	mov	r3, r0
    1888:	e54b3005 	strb	r3, [fp, #-5]
  if (Qname >= KernelMsgQ_Num) {
    188c:	e55b3005 	ldrb	r3, [fp, #-5]
    1890:	e3530002 	cmp	r3, #2
    1894:	9a000001 	bls	18a0 <Kernel_msgQ_is_empty+0x28>
    return false;
    1898:	e3a03000 	mov	r3, #0
    189c:	ea000013 	b	18f0 <Kernel_msgQ_is_empty+0x78>
  }
  if (sMsgQ[Qname].front == sMsgQ[Qname].rear) {
    18a0:	e55b2005 	ldrb	r2, [fp, #-5]
    18a4:	e3023a50 	movw	r3, #10832	@ 0x2a50
    18a8:	e3403000 	movt	r3, #0
    18ac:	e3a01f82 	mov	r1, #520	@ 0x208
    18b0:	e0020291 	mul	r2, r1, r2
    18b4:	e0833002 	add	r3, r3, r2
    18b8:	e5932000 	ldr	r2, [r3]
    18bc:	e55b1005 	ldrb	r1, [fp, #-5]
    18c0:	e3023a50 	movw	r3, #10832	@ 0x2a50
    18c4:	e3403000 	movt	r3, #0
    18c8:	e3a00f82 	mov	r0, #520	@ 0x208
    18cc:	e0010190 	mul	r1, r0, r1
    18d0:	e0833001 	add	r3, r3, r1
    18d4:	e2833004 	add	r3, r3, #4
    18d8:	e5933000 	ldr	r3, [r3]
    18dc:	e1520003 	cmp	r2, r3
    18e0:	1a000001 	bne	18ec <Kernel_msgQ_is_empty+0x74>
    return true;
    18e4:	e3a03001 	mov	r3, #1
    18e8:	ea000000 	b	18f0 <Kernel_msgQ_is_empty+0x78>
  }
  return false;
    18ec:	e3a03000 	mov	r3, #0
}
    18f0:	e1a00003 	mov	r0, r3
    18f4:	e28bd000 	add	sp, fp, #0
    18f8:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    18fc:	e12fff1e 	bx	lr

00001900 <Kernel_msgQ_is_full>:
bool Kernel_msgQ_is_full(KernelMsgQ_t Qname) {
    1900:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1904:	e28db000 	add	fp, sp, #0
    1908:	e24dd00c 	sub	sp, sp, #12
    190c:	e1a03000 	mov	r3, r0
    1910:	e54b3005 	strb	r3, [fp, #-5]
  if (Qname >= KernelMsgQ_Num) {
    1914:	e55b3005 	ldrb	r3, [fp, #-5]
    1918:	e3530002 	cmp	r3, #2
    191c:	9a000001 	bls	1928 <Kernel_msgQ_is_full+0x28>
    return false;
    1920:	e3a03000 	mov	r3, #0
    1924:	ea000015 	b	1980 <Kernel_msgQ_is_full+0x80>
  }
  if (((sMsgQ[Qname].rear) + 1) % MSG_Q_SIZE_BYTE == sMsgQ[Qname].front) {
    1928:	e55b2005 	ldrb	r2, [fp, #-5]
    192c:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1930:	e3403000 	movt	r3, #0
    1934:	e3a01f82 	mov	r1, #520	@ 0x208
    1938:	e0020291 	mul	r2, r1, r2
    193c:	e0833002 	add	r3, r3, r2
    1940:	e2833004 	add	r3, r3, #4
    1944:	e5933000 	ldr	r3, [r3]
    1948:	e2833001 	add	r3, r3, #1
    194c:	e7e82053 	ubfx	r2, r3, #0, #9
    1950:	e55b1005 	ldrb	r1, [fp, #-5]
    1954:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1958:	e3403000 	movt	r3, #0
    195c:	e3a00f82 	mov	r0, #520	@ 0x208
    1960:	e0010190 	mul	r1, r0, r1
    1964:	e0833001 	add	r3, r3, r1
    1968:	e5933000 	ldr	r3, [r3]
    196c:	e1520003 	cmp	r2, r3
    1970:	1a000001 	bne	197c <Kernel_msgQ_is_full+0x7c>
    return true;
    1974:	e3a03001 	mov	r3, #1
    1978:	ea000000 	b	1980 <Kernel_msgQ_is_full+0x80>
  }
  return false;
    197c:	e3a03000 	mov	r3, #0
}
    1980:	e1a00003 	mov	r0, r3
    1984:	e28bd000 	add	sp, fp, #0
    1988:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    198c:	e12fff1e 	bx	lr

00001990 <Kernel_msgQ_enqueue>:
bool Kernel_msgQ_enqueue(KernelMsgQ_t Qname, uint8_t data) {
    1990:	e92d4800 	push	{fp, lr}
    1994:	e28db004 	add	fp, sp, #4
    1998:	e24dd008 	sub	sp, sp, #8
    199c:	e1a03000 	mov	r3, r0
    19a0:	e1a02001 	mov	r2, r1
    19a4:	e54b3005 	strb	r3, [fp, #-5]
    19a8:	e1a03002 	mov	r3, r2
    19ac:	e54b3006 	strb	r3, [fp, #-6]
  if (Qname >= KernelMsgQ_Num) {
    19b0:	e55b3005 	ldrb	r3, [fp, #-5]
    19b4:	e3530002 	cmp	r3, #2
    19b8:	9a000001 	bls	19c4 <Kernel_msgQ_enqueue+0x34>
    return false;
    19bc:	e3a03000 	mov	r3, #0
    19c0:	ea00003c 	b	1ab8 <Kernel_msgQ_enqueue+0x128>
  }
  if (Kernel_msgQ_is_full(Qname)) {
    19c4:	e55b3005 	ldrb	r3, [fp, #-5]
    19c8:	e1a00003 	mov	r0, r3
    19cc:	ebffffcb 	bl	1900 <Kernel_msgQ_is_full>
    19d0:	e1a03000 	mov	r3, r0
    19d4:	e3530000 	cmp	r3, #0
    19d8:	0a000001 	beq	19e4 <Kernel_msgQ_enqueue+0x54>
    return false;
    19dc:	e3a03000 	mov	r3, #0
    19e0:	ea000034 	b	1ab8 <Kernel_msgQ_enqueue+0x128>
  }
  ++sMsgQ[Qname].rear;
    19e4:	e55b2005 	ldrb	r2, [fp, #-5]
    19e8:	e3023a50 	movw	r3, #10832	@ 0x2a50
    19ec:	e3403000 	movt	r3, #0
    19f0:	e3a01f82 	mov	r1, #520	@ 0x208
    19f4:	e0010291 	mul	r1, r1, r2
    19f8:	e0833001 	add	r3, r3, r1
    19fc:	e2833004 	add	r3, r3, #4
    1a00:	e5933000 	ldr	r3, [r3]
    1a04:	e2831001 	add	r1, r3, #1
    1a08:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1a0c:	e3403000 	movt	r3, #0
    1a10:	e3a00f82 	mov	r0, #520	@ 0x208
    1a14:	e0020290 	mul	r2, r0, r2
    1a18:	e0833002 	add	r3, r3, r2
    1a1c:	e2833004 	add	r3, r3, #4
    1a20:	e5831000 	str	r1, [r3]
  sMsgQ[Qname].rear = (sMsgQ[Qname].rear + 1) % MSG_Q_SIZE_BYTE;
    1a24:	e55b2005 	ldrb	r2, [fp, #-5]
    1a28:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1a2c:	e3403000 	movt	r3, #0
    1a30:	e3a01f82 	mov	r1, #520	@ 0x208
    1a34:	e0020291 	mul	r2, r1, r2
    1a38:	e0833002 	add	r3, r3, r2
    1a3c:	e2833004 	add	r3, r3, #4
    1a40:	e5933000 	ldr	r3, [r3]
    1a44:	e2833001 	add	r3, r3, #1
    1a48:	e55b1005 	ldrb	r1, [fp, #-5]
    1a4c:	e7e82053 	ubfx	r2, r3, #0, #9
    1a50:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1a54:	e3403000 	movt	r3, #0
    1a58:	e3a00f82 	mov	r0, #520	@ 0x208
    1a5c:	e0010190 	mul	r1, r0, r1
    1a60:	e0833001 	add	r3, r3, r1
    1a64:	e2833004 	add	r3, r3, #4
    1a68:	e5832000 	str	r2, [r3]

  sMsgQ[Qname].Queue[sMsgQ[Qname].rear] = data;
    1a6c:	e55b1005 	ldrb	r1, [fp, #-5]
    1a70:	e55b2005 	ldrb	r2, [fp, #-5]
    1a74:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1a78:	e3403000 	movt	r3, #0
    1a7c:	e3a00f82 	mov	r0, #520	@ 0x208
    1a80:	e0020290 	mul	r2, r0, r2
    1a84:	e0833002 	add	r3, r3, r2
    1a88:	e2833004 	add	r3, r3, #4
    1a8c:	e5932000 	ldr	r2, [r3]
    1a90:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1a94:	e3403000 	movt	r3, #0
    1a98:	e3a00f82 	mov	r0, #520	@ 0x208
    1a9c:	e0010190 	mul	r1, r0, r1
    1aa0:	e0833001 	add	r3, r3, r1
    1aa4:	e0833002 	add	r3, r3, r2
    1aa8:	e2833008 	add	r3, r3, #8
    1aac:	e55b2006 	ldrb	r2, [fp, #-6]
    1ab0:	e5c32000 	strb	r2, [r3]
  return true;
    1ab4:	e3a03001 	mov	r3, #1
}
    1ab8:	e1a00003 	mov	r0, r3
    1abc:	e24bd004 	sub	sp, fp, #4
    1ac0:	e8bd8800 	pop	{fp, pc}

00001ac4 <Kernel_msgQ_dequeue>:
bool Kernel_msgQ_dequeue(KernelMsgQ_t Qname, uint8_t* out_data) {
    1ac4:	e92d4800 	push	{fp, lr}
    1ac8:	e28db004 	add	fp, sp, #4
    1acc:	e24dd008 	sub	sp, sp, #8
    1ad0:	e1a03000 	mov	r3, r0
    1ad4:	e50b100c 	str	r1, [fp, #-12]
    1ad8:	e54b3005 	strb	r3, [fp, #-5]
  if (Qname >= KernelMsgQ_Num) {
    1adc:	e55b3005 	ldrb	r3, [fp, #-5]
    1ae0:	e3530002 	cmp	r3, #2
    1ae4:	9a000001 	bls	1af0 <Kernel_msgQ_dequeue+0x2c>
    return false;
    1ae8:	e3a03000 	mov	r3, #0
    1aec:	ea000038 	b	1bd4 <Kernel_msgQ_dequeue+0x110>
  }
  if (Kernel_msgQ_is_empty(Qname)) {
    1af0:	e55b3005 	ldrb	r3, [fp, #-5]
    1af4:	e1a00003 	mov	r0, r3
    1af8:	ebffff5e 	bl	1878 <Kernel_msgQ_is_empty>
    1afc:	e1a03000 	mov	r3, r0
    1b00:	e3530000 	cmp	r3, #0
    1b04:	0a000001 	beq	1b10 <Kernel_msgQ_dequeue+0x4c>
    return false;
    1b08:	e3a03000 	mov	r3, #0
    1b0c:	ea000030 	b	1bd4 <Kernel_msgQ_dequeue+0x110>
  }
  ++sMsgQ[Qname].front;
    1b10:	e55b2005 	ldrb	r2, [fp, #-5]
    1b14:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1b18:	e3403000 	movt	r3, #0
    1b1c:	e3a01f82 	mov	r1, #520	@ 0x208
    1b20:	e0010291 	mul	r1, r1, r2
    1b24:	e0833001 	add	r3, r3, r1
    1b28:	e5933000 	ldr	r3, [r3]
    1b2c:	e2831001 	add	r1, r3, #1
    1b30:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1b34:	e3403000 	movt	r3, #0
    1b38:	e3a00f82 	mov	r0, #520	@ 0x208
    1b3c:	e0020290 	mul	r2, r0, r2
    1b40:	e0833002 	add	r3, r3, r2
    1b44:	e5831000 	str	r1, [r3]
  sMsgQ[Qname].front = (sMsgQ[Qname].front + 1) % MSG_Q_SIZE_BYTE;
    1b48:	e55b2005 	ldrb	r2, [fp, #-5]
    1b4c:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1b50:	e3403000 	movt	r3, #0
    1b54:	e3a01f82 	mov	r1, #520	@ 0x208
    1b58:	e0020291 	mul	r2, r1, r2
    1b5c:	e0833002 	add	r3, r3, r2
    1b60:	e5933000 	ldr	r3, [r3]
    1b64:	e2833001 	add	r3, r3, #1
    1b68:	e55b1005 	ldrb	r1, [fp, #-5]
    1b6c:	e7e82053 	ubfx	r2, r3, #0, #9
    1b70:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1b74:	e3403000 	movt	r3, #0
    1b78:	e3a00f82 	mov	r0, #520	@ 0x208
    1b7c:	e0010190 	mul	r1, r0, r1
    1b80:	e0833001 	add	r3, r3, r1
    1b84:	e5832000 	str	r2, [r3]
  
  *out_data = sMsgQ[Qname].Queue[sMsgQ[Qname].front];
    1b88:	e55b1005 	ldrb	r1, [fp, #-5]
    1b8c:	e55b2005 	ldrb	r2, [fp, #-5]
    1b90:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1b94:	e3403000 	movt	r3, #0
    1b98:	e3a00f82 	mov	r0, #520	@ 0x208
    1b9c:	e0020290 	mul	r2, r0, r2
    1ba0:	e0833002 	add	r3, r3, r2
    1ba4:	e5932000 	ldr	r2, [r3]
    1ba8:	e3023a50 	movw	r3, #10832	@ 0x2a50
    1bac:	e3403000 	movt	r3, #0
    1bb0:	e3a00f82 	mov	r0, #520	@ 0x208
    1bb4:	e0010190 	mul	r1, r0, r1
    1bb8:	e0833001 	add	r3, r3, r1
    1bbc:	e0833002 	add	r3, r3, r2
    1bc0:	e2833008 	add	r3, r3, #8
    1bc4:	e5d32000 	ldrb	r2, [r3]
    1bc8:	e51b300c 	ldr	r3, [fp, #-12]
    1bcc:	e5c32000 	strb	r2, [r3]

  return true;
    1bd0:	e3a03001 	mov	r3, #1
    1bd4:	e1a00003 	mov	r0, r3
    1bd8:	e24bd004 	sub	sp, fp, #4
    1bdc:	e8bd8800 	pop	{fp, pc}

00001be0 <Kernel_sem_init>:
#define DEF_SEM_MAX 8

static int32_t sSemMax;
static int32_t sSem;

void Kernel_sem_init(int32_t max) {
    1be0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1be4:	e28db000 	add	fp, sp, #0
    1be8:	e24dd00c 	sub	sp, sp, #12
    1bec:	e50b0008 	str	r0, [fp, #-8]
  sSemMax = (max >= DEF_SEM_MAX) ? DEF_SEM_MAX : max;
    1bf0:	e51b3008 	ldr	r3, [fp, #-8]
    1bf4:	e3530008 	cmp	r3, #8
    1bf8:	b1a02003 	movlt	r2, r3
    1bfc:	a3a02008 	movge	r2, #8
    1c00:	e3033068 	movw	r3, #12392	@ 0x3068
    1c04:	e3403000 	movt	r3, #0
    1c08:	e5832000 	str	r2, [r3]

  sSem = sSemMax;
    1c0c:	e3033068 	movw	r3, #12392	@ 0x3068
    1c10:	e3403000 	movt	r3, #0
    1c14:	e5932000 	ldr	r2, [r3]
    1c18:	e303306c 	movw	r3, #12396	@ 0x306c
    1c1c:	e3403000 	movt	r3, #0
    1c20:	e5832000 	str	r2, [r3]
}
    1c24:	e320f000 	nop	{0}
    1c28:	e28bd000 	add	sp, fp, #0
    1c2c:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1c30:	e12fff1e 	bx	lr

00001c34 <Kernel_sem_test>:
bool Kernel_sem_test(void) {
    1c34:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1c38:	e28db000 	add	fp, sp, #0
  if(sSem <= 0) {
    1c3c:	e303306c 	movw	r3, #12396	@ 0x306c
    1c40:	e3403000 	movt	r3, #0
    1c44:	e5933000 	ldr	r3, [r3]
    1c48:	e3530000 	cmp	r3, #0
    1c4c:	ca000001 	bgt	1c58 <Kernel_sem_test+0x24>
    return false;
    1c50:	e3a03000 	mov	r3, #0
    1c54:	ea000007 	b	1c78 <Kernel_sem_test+0x44>
  }
  --sSem;
    1c58:	e303306c 	movw	r3, #12396	@ 0x306c
    1c5c:	e3403000 	movt	r3, #0
    1c60:	e5933000 	ldr	r3, [r3]
    1c64:	e2432001 	sub	r2, r3, #1
    1c68:	e303306c 	movw	r3, #12396	@ 0x306c
    1c6c:	e3403000 	movt	r3, #0
    1c70:	e5832000 	str	r2, [r3]
  return true;
    1c74:	e3a03001 	mov	r3, #1
}
    1c78:	e1a00003 	mov	r0, r3
    1c7c:	e28bd000 	add	sp, fp, #0
    1c80:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1c84:	e12fff1e 	bx	lr

00001c88 <Kernel_sem_release>:
void Kernel_sem_release(void) {
    1c88:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1c8c:	e28db000 	add	fp, sp, #0
  ++sSem;
    1c90:	e303306c 	movw	r3, #12396	@ 0x306c
    1c94:	e3403000 	movt	r3, #0
    1c98:	e5933000 	ldr	r3, [r3]
    1c9c:	e2832001 	add	r2, r3, #1
    1ca0:	e303306c 	movw	r3, #12396	@ 0x306c
    1ca4:	e3403000 	movt	r3, #0
    1ca8:	e5832000 	str	r2, [r3]
  if(sSem >= sSemMax) {
    1cac:	e303306c 	movw	r3, #12396	@ 0x306c
    1cb0:	e3403000 	movt	r3, #0
    1cb4:	e5932000 	ldr	r2, [r3]
    1cb8:	e3033068 	movw	r3, #12392	@ 0x3068
    1cbc:	e3403000 	movt	r3, #0
    1cc0:	e5933000 	ldr	r3, [r3]
    1cc4:	e1520003 	cmp	r2, r3
    1cc8:	ba000005 	blt	1ce4 <Kernel_sem_release+0x5c>
    sSem = sSemMax;
    1ccc:	e3033068 	movw	r3, #12392	@ 0x3068
    1cd0:	e3403000 	movt	r3, #0
    1cd4:	e5932000 	ldr	r2, [r3]
    1cd8:	e303306c 	movw	r3, #12396	@ 0x306c
    1cdc:	e3403000 	movt	r3, #0
    1ce0:	e5832000 	str	r2, [r3]
  }
}
    1ce4:	e320f000 	nop	{0}
    1ce8:	e28bd000 	add	sp, fp, #0
    1cec:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1cf0:	e12fff1e 	bx	lr

00001cf4 <Kernel_mutex_init>:

static KernelMutext_t sMutex;
void Kernel_mutex_init(void) {
    1cf4:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1cf8:	e28db000 	add	fp, sp, #0
  sMutex.owner = 0;
    1cfc:	e3033070 	movw	r3, #12400	@ 0x3070
    1d00:	e3403000 	movt	r3, #0
    1d04:	e3a02000 	mov	r2, #0
    1d08:	e5832000 	str	r2, [r3]
  sMutex.lock = false;
    1d0c:	e3033070 	movw	r3, #12400	@ 0x3070
    1d10:	e3403000 	movt	r3, #0
    1d14:	e3a02000 	mov	r2, #0
    1d18:	e5c32004 	strb	r2, [r3, #4]
}
    1d1c:	e320f000 	nop	{0}
    1d20:	e28bd000 	add	sp, fp, #0
    1d24:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1d28:	e12fff1e 	bx	lr

00001d2c <Kernel_mutex_lock>:
bool Kernel_mutex_lock(uint32_t owner) {
    1d2c:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1d30:	e28db000 	add	fp, sp, #0
    1d34:	e24dd00c 	sub	sp, sp, #12
    1d38:	e50b0008 	str	r0, [fp, #-8]
  if(sMutex.lock) {
    1d3c:	e3033070 	movw	r3, #12400	@ 0x3070
    1d40:	e3403000 	movt	r3, #0
    1d44:	e5d33004 	ldrb	r3, [r3, #4]
    1d48:	e3530000 	cmp	r3, #0
    1d4c:	0a000001 	beq	1d58 <Kernel_mutex_lock+0x2c>
    return false;
    1d50:	e3a03000 	mov	r3, #0
    1d54:	ea000008 	b	1d7c <Kernel_mutex_lock+0x50>
  }

  sMutex.owner = owner;
    1d58:	e3033070 	movw	r3, #12400	@ 0x3070
    1d5c:	e3403000 	movt	r3, #0
    1d60:	e51b2008 	ldr	r2, [fp, #-8]
    1d64:	e5832000 	str	r2, [r3]
  sMutex.lock = true;
    1d68:	e3033070 	movw	r3, #12400	@ 0x3070
    1d6c:	e3403000 	movt	r3, #0
    1d70:	e3a02001 	mov	r2, #1
    1d74:	e5c32004 	strb	r2, [r3, #4]
  return true;
    1d78:	e3a03001 	mov	r3, #1
}
    1d7c:	e1a00003 	mov	r0, r3
    1d80:	e28bd000 	add	sp, fp, #0
    1d84:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1d88:	e12fff1e 	bx	lr

00001d8c <Kernel_mutex_unlock>:
bool Kernel_mutex_unlock(uint32_t owner) {
    1d8c:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1d90:	e28db000 	add	fp, sp, #0
    1d94:	e24dd00c 	sub	sp, sp, #12
    1d98:	e50b0008 	str	r0, [fp, #-8]
  if (owner == sMutex.owner) {
    1d9c:	e3033070 	movw	r3, #12400	@ 0x3070
    1da0:	e3403000 	movt	r3, #0
    1da4:	e5933000 	ldr	r3, [r3]
    1da8:	e51b2008 	ldr	r2, [fp, #-8]
    1dac:	e1520003 	cmp	r2, r3
    1db0:	1a000005 	bne	1dcc <Kernel_mutex_unlock+0x40>
    sMutex.lock = false;
    1db4:	e3033070 	movw	r3, #12400	@ 0x3070
    1db8:	e3403000 	movt	r3, #0
    1dbc:	e3a02000 	mov	r2, #0
    1dc0:	e5c32004 	strb	r2, [r3, #4]
    return true;
    1dc4:	e3a03001 	mov	r3, #1
    1dc8:	ea000000 	b	1dd0 <Kernel_mutex_unlock+0x44>
  }
  return false;
    1dcc:	e3a03000 	mov	r3, #0
    1dd0:	e1a00003 	mov	r0, r3
    1dd4:	e28bd000 	add	sp, fp, #0
    1dd8:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1ddc:	e12fff1e 	bx	lr

00001de0 <Kernel_task_init>:

static KernelTcb_t* Scheduler_round_robin(void);
static __attribute__ ((naked)) void Kernel_task_context_switching(void);

static uint32_t cpsr_cp;
void Kernel_task_init(void) {
    1de0:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1de4:	e28db000 	add	fp, sp, #0
    1de8:	e24dd00c 	sub	sp, sp, #12
  sAllocated_tcb_index = 0;
    1dec:	e3033278 	movw	r3, #12920	@ 0x3278
    1df0:	e3403000 	movt	r3, #0
    1df4:	e3a02000 	mov	r2, #0
    1df8:	e5832000 	str	r2, [r3]
  sCurrent_tcb_index = 0;
    1dfc:	e303327c 	movw	r3, #12924	@ 0x327c
    1e00:	e3403000 	movt	r3, #0
    1e04:	e3a02000 	mov	r2, #0
    1e08:	e5832000 	str	r2, [r3]

  __asm__ ("MRS r0, cpsr");
    1e0c:	e10f0000 	mrs	r0, CPSR
  __asm__ ("LDR r1, =cpsr_cp");
    1e10:	e59f12fc 	ldr	r1, [pc, #764]	@ 2114 <Kernel_task_context_switching+0x3c>
  __asm__ ("STR r0, [r1]");
    1e14:	e5810000 	str	r0, [r1]

  for (uint32_t i = 0; i < MAX_TASK_NUM; ++i) {
    1e18:	e3a03000 	mov	r3, #0
    1e1c:	e50b3008 	str	r3, [fp, #-8]
    1e20:	ea00002b 	b	1ed4 <Kernel_task_init+0xf4>
    sTask_list[i].stack_base = (uint8_t*)(TASK_STACK_START + (i * USR_TASK_STACK_SIZE));
    1e24:	e51b3008 	ldr	r3, [fp, #-8]
    1e28:	e2833008 	add	r3, r3, #8
    1e2c:	e1a03a03 	lsl	r3, r3, #20
    1e30:	e1a01003 	mov	r1, r3
    1e34:	e3032078 	movw	r2, #12408	@ 0x3078
    1e38:	e3402000 	movt	r2, #0
    1e3c:	e51b3008 	ldr	r3, [fp, #-8]
    1e40:	e1a03183 	lsl	r3, r3, #3
    1e44:	e0823003 	add	r3, r2, r3
    1e48:	e5831004 	str	r1, [r3, #4]
    sTask_list[i].sp = (uint32_t)sTask_list[i].stack_base + USR_TASK_STACK_SIZE - 4;
    1e4c:	e3032078 	movw	r2, #12408	@ 0x3078
    1e50:	e3402000 	movt	r2, #0
    1e54:	e51b3008 	ldr	r3, [fp, #-8]
    1e58:	e1a03183 	lsl	r3, r3, #3
    1e5c:	e0823003 	add	r3, r2, r3
    1e60:	e5933004 	ldr	r3, [r3, #4]
    1e64:	e243324f 	sub	r3, r3, #-268435452	@ 0xf0000004
    1e68:	e24336ff 	sub	r3, r3, #267386880	@ 0xff00000
    1e6c:	e3032078 	movw	r2, #12408	@ 0x3078
    1e70:	e3402000 	movt	r2, #0
    1e74:	e51b1008 	ldr	r1, [fp, #-8]
    1e78:	e7823181 	str	r3, [r2, r1, lsl #3]

    sTask_list[i].sp -= sizeof(KernelTaskContext_t);
    1e7c:	e3033078 	movw	r3, #12408	@ 0x3078
    1e80:	e3403000 	movt	r3, #0
    1e84:	e51b2008 	ldr	r2, [fp, #-8]
    1e88:	e7933182 	ldr	r3, [r3, r2, lsl #3]
    1e8c:	e243103c 	sub	r1, r3, #60	@ 0x3c
    1e90:	e3033078 	movw	r3, #12408	@ 0x3078
    1e94:	e3403000 	movt	r3, #0
    1e98:	e51b2008 	ldr	r2, [fp, #-8]
    1e9c:	e7831182 	str	r1, [r3, r2, lsl #3]
    KernelTaskContext_t* ctx = (KernelTaskContext_t*)sTask_list[i].sp;
    1ea0:	e3033078 	movw	r3, #12408	@ 0x3078
    1ea4:	e3403000 	movt	r3, #0
    1ea8:	e51b2008 	ldr	r2, [fp, #-8]
    1eac:	e7933182 	ldr	r3, [r3, r2, lsl #3]
    1eb0:	e50b300c 	str	r3, [fp, #-12]
    ctx->spsr = cpsr_cp;
    1eb4:	e3033288 	movw	r3, #12936	@ 0x3288
    1eb8:	e3403000 	movt	r3, #0
    1ebc:	e5932000 	ldr	r2, [r3]
    1ec0:	e51b300c 	ldr	r3, [fp, #-12]
    1ec4:	e5832000 	str	r2, [r3]
  for (uint32_t i = 0; i < MAX_TASK_NUM; ++i) {
    1ec8:	e51b3008 	ldr	r3, [fp, #-8]
    1ecc:	e2833001 	add	r3, r3, #1
    1ed0:	e50b3008 	str	r3, [fp, #-8]
    1ed4:	e51b3008 	ldr	r3, [fp, #-8]
    1ed8:	e353003f 	cmp	r3, #63	@ 0x3f
    1edc:	9affffd0 	bls	1e24 <Kernel_task_init+0x44>
  }
}
    1ee0:	e320f000 	nop	{0}
    1ee4:	e320f000 	nop	{0}
    1ee8:	e28bd000 	add	sp, fp, #0
    1eec:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1ef0:	e12fff1e 	bx	lr

00001ef4 <Kernel_task_create>:

uint32_t Kernel_task_create(KernelTaskFunc_t startFunc) {
    1ef4:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1ef8:	e28db000 	add	fp, sp, #0
    1efc:	e24dd014 	sub	sp, sp, #20
    1f00:	e50b0010 	str	r0, [fp, #-16]
  KernelTcb_t* new_tcb = &sTask_list[sAllocated_tcb_index++];
    1f04:	e3033278 	movw	r3, #12920	@ 0x3278
    1f08:	e3403000 	movt	r3, #0
    1f0c:	e5932000 	ldr	r2, [r3]
    1f10:	e2821001 	add	r1, r2, #1
    1f14:	e3033278 	movw	r3, #12920	@ 0x3278
    1f18:	e3403000 	movt	r3, #0
    1f1c:	e5831000 	str	r1, [r3]
    1f20:	e1a02182 	lsl	r2, r2, #3
    1f24:	e3033078 	movw	r3, #12408	@ 0x3078
    1f28:	e3403000 	movt	r3, #0
    1f2c:	e0823003 	add	r3, r2, r3
    1f30:	e50b3008 	str	r3, [fp, #-8]

  if (sAllocated_tcb_index > MAX_TASK_NUM) {
    1f34:	e3033278 	movw	r3, #12920	@ 0x3278
    1f38:	e3403000 	movt	r3, #0
    1f3c:	e5933000 	ldr	r3, [r3]
    1f40:	e3530040 	cmp	r3, #64	@ 0x40
    1f44:	9a000001 	bls	1f50 <Kernel_task_create+0x5c>
    return NOT_ENOUGH_TASK_NUM;
    1f48:	e3e03000 	mvn	r3, #0
    1f4c:	ea000009 	b	1f78 <Kernel_task_create+0x84>
  }

  KernelTaskContext_t* ctx = (KernelTaskContext_t*)new_tcb->sp;
    1f50:	e51b3008 	ldr	r3, [fp, #-8]
    1f54:	e5933000 	ldr	r3, [r3]
    1f58:	e50b300c 	str	r3, [fp, #-12]
  ctx->pc = (uint32_t)startFunc;
    1f5c:	e51b2010 	ldr	r2, [fp, #-16]
    1f60:	e51b300c 	ldr	r3, [fp, #-12]
    1f64:	e5832038 	str	r2, [r3, #56]	@ 0x38

  return (sAllocated_tcb_index - 1);
    1f68:	e3033278 	movw	r3, #12920	@ 0x3278
    1f6c:	e3403000 	movt	r3, #0
    1f70:	e5933000 	ldr	r3, [r3]
    1f74:	e2433001 	sub	r3, r3, #1
}
    1f78:	e1a00003 	mov	r0, r3
    1f7c:	e28bd000 	add	sp, fp, #0
    1f80:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    1f84:	e12fff1e 	bx	lr

00001f88 <Kernel_task_scheduling>:

void Kernel_task_scheduling(void) {
    1f88:	e92d4800 	push	{fp, lr}
    1f8c:	e28db004 	add	fp, sp, #4
  sCurrent_tcb = &sTask_list[sCurrent_tcb_index];
    1f90:	e303327c 	movw	r3, #12924	@ 0x327c
    1f94:	e3403000 	movt	r3, #0
    1f98:	e5933000 	ldr	r3, [r3]
    1f9c:	e1a02183 	lsl	r2, r3, #3
    1fa0:	e3033078 	movw	r3, #12408	@ 0x3078
    1fa4:	e3403000 	movt	r3, #0
    1fa8:	e0822003 	add	r2, r2, r3
    1fac:	e3033280 	movw	r3, #12928	@ 0x3280
    1fb0:	e3403000 	movt	r3, #0
    1fb4:	e5832000 	str	r2, [r3]
  sNext_tcb = Scheduler_round_robin();
    1fb8:	eb000026 	bl	2058 <Scheduler_round_robin>
    1fbc:	e1a02000 	mov	r2, r0
    1fc0:	e3033284 	movw	r3, #12932	@ 0x3284
    1fc4:	e3403000 	movt	r3, #0
    1fc8:	e5832000 	str	r2, [r3]

  Kernel_task_context_switching();
    1fcc:	eb000041 	bl	20d8 <Kernel_task_context_switching>
}
    1fd0:	e320f000 	nop	{0}
    1fd4:	e8bd8800 	pop	{fp, pc}

00001fd8 <Kernel_task_start>:

void Kernel_task_start(void) {
    1fd8:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    1fdc:	e28db000 	add	fp, sp, #0
  sNext_tcb = &sTask_list[sCurrent_tcb_index];
    1fe0:	e303327c 	movw	r3, #12924	@ 0x327c
    1fe4:	e3403000 	movt	r3, #0
    1fe8:	e5933000 	ldr	r3, [r3]
    1fec:	e1a02183 	lsl	r2, r3, #3
    1ff0:	e3033078 	movw	r3, #12408	@ 0x3078
    1ff4:	e3403000 	movt	r3, #0
    1ff8:	e0822003 	add	r2, r2, r3
    1ffc:	e3033284 	movw	r3, #12932	@ 0x3284
    2000:	e3403000 	movt	r3, #0
    2004:	e5832000 	str	r2, [r3]
  __asm__ ("LDR r0, =sNext_tcb");
    2008:	e59f0108 	ldr	r0, [pc, #264]	@ 2118 <Kernel_task_context_switching+0x40>
  __asm__ ("LDR r0, [r0]");
    200c:	e5900000 	ldr	r0, [r0]
  __asm__ ("LDMIA r0!, {sp}");
    2010:	e8b02000 	ldm	r0!, {sp}

  __asm__ ("POP {r0}");
    2014:	e49d0004 	pop	{r0}		@ (ldr r0, [sp], #4)
  __asm__ ("MSR cpsr, r0");
    2018:	e129f000 	msr	CPSR_fc, r0
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}"); // 쓰레기 값들로 채워짐
    201c:	e8bd1fff 	pop	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
  __asm__ ("POP {pc}"); // 태스크 함수의 위치로 점프
    2020:	e49df004 	pop	{pc}		@ (ldr pc, [sp], #4)
}
    2024:	e320f000 	nop	{0}
    2028:	e28bd000 	add	sp, fp, #0
    202c:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    2030:	e12fff1e 	bx	lr

00002034 <Kernel_task_get_current_task_id>:

uint32_t Kernel_task_get_current_task_id(void) {
    2034:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
    2038:	e28db000 	add	fp, sp, #0
  return sCurrent_tcb_index;
    203c:	e303327c 	movw	r3, #12924	@ 0x327c
    2040:	e3403000 	movt	r3, #0
    2044:	e5933000 	ldr	r3, [r3]
}
    2048:	e1a00003 	mov	r0, r3
    204c:	e28bd000 	add	sp, fp, #0
    2050:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
    2054:	e12fff1e 	bx	lr

00002058 <Scheduler_round_robin>:

static KernelTcb_t* Scheduler_round_robin(void) {
    2058:	e92d4800 	push	{fp, lr}
    205c:	e28db004 	add	fp, sp, #4
  ++sCurrent_tcb_index;
    2060:	e303327c 	movw	r3, #12924	@ 0x327c
    2064:	e3403000 	movt	r3, #0
    2068:	e5933000 	ldr	r3, [r3]
    206c:	e2832001 	add	r2, r3, #1
    2070:	e303327c 	movw	r3, #12924	@ 0x327c
    2074:	e3403000 	movt	r3, #0
    2078:	e5832000 	str	r2, [r3]
  sCurrent_tcb_index %= sAllocated_tcb_index;
    207c:	e303327c 	movw	r3, #12924	@ 0x327c
    2080:	e3403000 	movt	r3, #0
    2084:	e5932000 	ldr	r2, [r3]
    2088:	e3033278 	movw	r3, #12920	@ 0x3278
    208c:	e3403000 	movt	r3, #0
    2090:	e5933000 	ldr	r3, [r3]
    2094:	e1a01003 	mov	r1, r3
    2098:	e1a00002 	mov	r0, r2
    209c:	eb00005c 	bl	2214 <__aeabi_uidivmod>
    20a0:	e1a03001 	mov	r3, r1
    20a4:	e1a02003 	mov	r2, r3
    20a8:	e303327c 	movw	r3, #12924	@ 0x327c
    20ac:	e3403000 	movt	r3, #0
    20b0:	e5832000 	str	r2, [r3]

  return &sTask_list[sCurrent_tcb_index];
    20b4:	e303327c 	movw	r3, #12924	@ 0x327c
    20b8:	e3403000 	movt	r3, #0
    20bc:	e5933000 	ldr	r3, [r3]
    20c0:	e1a02183 	lsl	r2, r3, #3
    20c4:	e3033078 	movw	r3, #12408	@ 0x3078
    20c8:	e3403000 	movt	r3, #0
    20cc:	e0823003 	add	r3, r2, r3
}
    20d0:	e1a00003 	mov	r0, r3
    20d4:	e8bd8800 	pop	{fp, pc}

000020d8 <Kernel_task_context_switching>:

static __attribute__ ((naked)) void Kernel_task_context_switching(void) {
  // 1. Save context

  // save current task context into the current task stack
  __asm__ ("PUSH {lr}");
    20d8:	e52de004 	push	{lr}		@ (str lr, [sp, #-4]!)
  __asm__ ("PUSH {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
    20dc:	e92d1fff 	push	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
  __asm__ ("MRS r0, cpsr");
    20e0:	e10f0000 	mrs	r0, CPSR
  __asm__ ("PUSH {r0}");
    20e4:	e52d0004 	push	{r0}		@ (str r0, [sp, #-4]!)
  // save current task stack pointer into the current TCB
  __asm__ ("LDR r0, =sCurrent_tcb");
    20e8:	e59f002c 	ldr	r0, [pc, #44]	@ 211c <Kernel_task_context_switching+0x44>
  __asm__ ("LDR r0, [r0]");
    20ec:	e5900000 	ldr	r0, [r0]
  __asm__ ("STMIA r0!, {sp}");
    20f0:	e8a02000 	stmia	r0!, {sp}

  // 2. Restore context

  // restore next task stack pointer from the next TCB
  __asm__ ("LDR r0, =sNext_tcb");
    20f4:	e59f001c 	ldr	r0, [pc, #28]	@ 2118 <Kernel_task_context_switching+0x40>
  __asm__ ("LDR r0, [r0]");
    20f8:	e5900000 	ldr	r0, [r0]
  __asm__ ("LDMIA r0!, {sp}");
    20fc:	e8b02000 	ldm	r0!, {sp}
  // restore next task context from the next task stack
  __asm__ ("POP {r0}");
    2100:	e49d0004 	pop	{r0}		@ (ldr r0, [sp], #4)
  __asm__ ("MSR cpsr, r0");
    2104:	e129f000 	msr	CPSR_fc, r0
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
    2108:	e8bd1fff 	pop	{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}
  __asm__ ("POP {pc}");
    210c:	e49df004 	pop	{pc}		@ (ldr pc, [sp], #4)
    2110:	e320f000 	nop	{0}
    2114:	00003288 	andeq	r3, r0, r8, lsl #5
    2118:	00003284 	andeq	r3, r0, r4, lsl #5
    211c:	00003280 	andeq	r3, r0, r0, lsl #5

00002120 <__udivsi3>:
    2120:	e2512001 	subs	r2, r1, #1
    2124:	012fff1e 	bxeq	lr
    2128:	3a000036 	bcc	2208 <__udivsi3+0xe8>
    212c:	e1500001 	cmp	r0, r1
    2130:	9a000022 	bls	21c0 <__udivsi3+0xa0>
    2134:	e1110002 	tst	r1, r2
    2138:	0a000023 	beq	21cc <__udivsi3+0xac>
    213c:	e311020e 	tst	r1, #-536870912	@ 0xe0000000
    2140:	01a01181 	lsleq	r1, r1, #3
    2144:	03a03008 	moveq	r3, #8
    2148:	13a03001 	movne	r3, #1
    214c:	e3510201 	cmp	r1, #268435456	@ 0x10000000
    2150:	31510000 	cmpcc	r1, r0
    2154:	31a01201 	lslcc	r1, r1, #4
    2158:	31a03203 	lslcc	r3, r3, #4
    215c:	3afffffa 	bcc	214c <__udivsi3+0x2c>
    2160:	e3510102 	cmp	r1, #-2147483648	@ 0x80000000
    2164:	31510000 	cmpcc	r1, r0
    2168:	31a01081 	lslcc	r1, r1, #1
    216c:	31a03083 	lslcc	r3, r3, #1
    2170:	3afffffa 	bcc	2160 <__udivsi3+0x40>
    2174:	e3a02000 	mov	r2, #0
    2178:	e1500001 	cmp	r0, r1
    217c:	20400001 	subcs	r0, r0, r1
    2180:	21822003 	orrcs	r2, r2, r3
    2184:	e15000a1 	cmp	r0, r1, lsr #1
    2188:	204000a1 	subcs	r0, r0, r1, lsr #1
    218c:	218220a3 	orrcs	r2, r2, r3, lsr #1
    2190:	e1500121 	cmp	r0, r1, lsr #2
    2194:	20400121 	subcs	r0, r0, r1, lsr #2
    2198:	21822123 	orrcs	r2, r2, r3, lsr #2
    219c:	e15001a1 	cmp	r0, r1, lsr #3
    21a0:	204001a1 	subcs	r0, r0, r1, lsr #3
    21a4:	218221a3 	orrcs	r2, r2, r3, lsr #3
    21a8:	e3500000 	cmp	r0, #0
    21ac:	11b03223 	lsrsne	r3, r3, #4
    21b0:	11a01221 	lsrne	r1, r1, #4
    21b4:	1affffef 	bne	2178 <__udivsi3+0x58>
    21b8:	e1a00002 	mov	r0, r2
    21bc:	e12fff1e 	bx	lr
    21c0:	03a00001 	moveq	r0, #1
    21c4:	13a00000 	movne	r0, #0
    21c8:	e12fff1e 	bx	lr
    21cc:	e3510801 	cmp	r1, #65536	@ 0x10000
    21d0:	21a01821 	lsrcs	r1, r1, #16
    21d4:	23a02010 	movcs	r2, #16
    21d8:	33a02000 	movcc	r2, #0
    21dc:	e3510c01 	cmp	r1, #256	@ 0x100
    21e0:	21a01421 	lsrcs	r1, r1, #8
    21e4:	22822008 	addcs	r2, r2, #8
    21e8:	e3510010 	cmp	r1, #16
    21ec:	21a01221 	lsrcs	r1, r1, #4
    21f0:	22822004 	addcs	r2, r2, #4
    21f4:	e3510004 	cmp	r1, #4
    21f8:	82822003 	addhi	r2, r2, #3
    21fc:	908220a1 	addls	r2, r2, r1, lsr #1
    2200:	e1a00230 	lsr	r0, r0, r2
    2204:	e12fff1e 	bx	lr
    2208:	e3500000 	cmp	r0, #0
    220c:	13e00000 	mvnne	r0, #0
    2210:	ea000007 	b	2234 <__aeabi_idiv0>

00002214 <__aeabi_uidivmod>:
    2214:	e3510000 	cmp	r1, #0
    2218:	0afffffa 	beq	2208 <__udivsi3+0xe8>
    221c:	e92d4003 	push	{r0, r1, lr}
    2220:	ebffffbe 	bl	2120 <__udivsi3>
    2224:	e8bd4006 	pop	{r1, r2, lr}
    2228:	e0030092 	mul	r3, r2, r0
    222c:	e0411003 	sub	r1, r1, r3
    2230:	e12fff1e 	bx	lr

00002234 <__aeabi_idiv0>:
    2234:	e12fff1e 	bx	lr

Disassembly of section .data:

00002238 <Uart>:
#include "stdint.h"
#include "Uart.h"
#include "Gic.h"
#include "Timer.h"

volatile PL011_t* Uart = (PL011_t*)UART_BASE_ADDRESS0;
    2238:	10009000 	andne	r9, r0, r0

0000223c <GicCpu>:
volatile GicCput_t* GicCpu = (GicCput_t*)GIC_CPU_BASE;
    223c:	1e000000 	cdpne	0, 0, cr0, cr0, cr0, {0}

00002240 <GicDist>:
volatile GicDist_t* GicDist = (GicDist_t*)GIC_DIST_BASE;
    2240:	1e001000 	cdpne	0, 0, cr1, cr0, cr0, {0}

00002244 <Timer>:
    2244:	10011000 	andne	r1, r1, r0

Disassembly of section .bss:

00002248 <shared_value>:
static uint32_t shared_value;
    2248:	00000000 	andeq	r0, r0, r0

0000224c <sHandlers>:
	...

00002648 <internal_1ms_counter>:
static uint32_t internal_1ms_counter;
    2648:	00000000 	andeq	r0, r0, r0

0000264c <printf_buf>:
	...

00002a4c <sEventFlag>:
static uint32_t sEventFlag;
    2a4c:	00000000 	andeq	r0, r0, r0

00002a50 <sMsgQ>:
	...

00003068 <sSemMax>:
static int32_t sSemMax;
    3068:	00000000 	andeq	r0, r0, r0

0000306c <sSem>:
static int32_t sSem;
    306c:	00000000 	andeq	r0, r0, r0

00003070 <sMutex>:
	...

00003078 <sTask_list>:
	...

00003278 <sAllocated_tcb_index>:
static uint32_t sAllocated_tcb_index;
    3278:	00000000 	andeq	r0, r0, r0

0000327c <sCurrent_tcb_index>:
static uint32_t sCurrent_tcb_index;
    327c:	00000000 	andeq	r0, r0, r0

00003280 <sCurrent_tcb>:
static KernelTcb_t* sCurrent_tcb;
    3280:	00000000 	andeq	r0, r0, r0

00003284 <sNext_tcb>:
static KernelTcb_t* sNext_tcb;
    3284:	00000000 	andeq	r0, r0, r0

00003288 <cpsr_cp>:
static uint32_t cpsr_cp;
    3288:	00000000 	andeq	r0, r0, r0

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
    LDR PC, reset_handler_addr
   0:	00002c41 	andeq	r2, r0, r1, asr #24
    LDR PC, undef_handler_addr
   4:	61656100 	cmnvs	r5, r0, lsl #2
    LDR PC, svc_handler_addr
   8:	01006962 	tsteq	r0, r2, ror #18
    LDR PC, pfch_abt_handler_addr
   c:	00000022 	andeq	r0, r0, r2, lsr #32
    LDR PC, data_abt_handler_addr
  10:	412d3705 			@ <UNDEFINED> instruction: 0x412d3705
    B .
  14:	070a0600 	streq	r0, [sl, -r0, lsl #12]
    LDR PC, irq_handler_addr
  18:	09010841 	stmdbeq	r1, {r0, r6, fp}
    LDR PC, fiq_handler_addr
  1c:	14041202 	strne	r1, [r4], #-514	@ 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <cpsr_cp+0x42db0>
  28:	44012201 	strmi	r2, [r1], #-513	@ 0xfffffdff
  2c:	Address 0x2c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
    LDR PC, reset_handler_addr
   0:	3a434347 	bcc	10d0d24 <cpsr_cp+0x10cda9c>
    LDR PC, undef_handler_addr
   4:	35312820 	ldrcc	r2, [r1, #-2080]!	@ 0xfffff7e0
    LDR PC, svc_handler_addr
   8:	2e32313a 	mrccs	1, 1, r3, cr2, cr10, {1}
    LDR PC, pfch_abt_handler_addr
   c:	65722e32 	ldrbvs	r2, [r2, #-3634]!	@ 0xfffff1ce
    LDR PC, data_abt_handler_addr
  10:	312d316c 			@ <UNDEFINED> instruction: 0x312d316c
    B .
  14:	32312029 	eorscc	r2, r1, #41	@ 0x29
    LDR PC, irq_handler_addr
  18:	312e322e 			@ <UNDEFINED> instruction: 0x312e322e
    LDR PC, fiq_handler_addr
  1c:	32303220 	eorscc	r3, r0, #32, 4
  20:	30323132 	eorscc	r3, r2, r2, lsr r1
  24:	Address 0x24 is out of bounds.


Disassembly of section .debug_line:

00000000 <.debug_line>:
    LDR PC, reset_handler_addr
   0:	00000076 	andeq	r0, r0, r6, ror r0
    LDR PC, undef_handler_addr
   4:	00040005 	andeq	r0, r4, r5
    LDR PC, svc_handler_addr
   8:	0000002e 	andeq	r0, r0, lr, lsr #32
    LDR PC, pfch_abt_handler_addr
   c:	fb010102 	blx	4041e <cpsr_cp+0x3d196>
    LDR PC, data_abt_handler_addr
  10:	01000d0e 	tsteq	r0, lr, lsl #26
    B .
  14:	00010101 	andeq	r0, r1, r1, lsl #2
    LDR PC, irq_handler_addr
  18:	00010000 	andeq	r0, r1, r0
    LDR PC, fiq_handler_addr
  1c:	01010100 	mrseq	r0, (UNDEF: 17)
  20:	0000021f 	andeq	r0, r0, pc, lsl r2
  24:	00140000 	andseq	r0, r4, r0
  28:	01020000 	mrseq	r0, (UNDEF: 2)
  2c:	020f021f 	andeq	r0, pc, #-268435455	@ 0xf0000001
  30:	00000019 	andeq	r0, r0, r9, lsl r0
  34:	00001901 	andeq	r1, r0, r1, lsl #18
  38:	05000100 	streq	r0, [r0, #-256]	@ 0xffffff00
    MRS r0, cpsr @ move PSR to Register
  3c:	00000002 	andeq	r0, r0, r2
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	010a0300 	mrseq	r0, (UNDEF: 58)
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	2f2f2f2f 	svccs	0x002f2f2f
    MSR cpsr, r1 @ 동작 모드 변경
  48:	032f2f2f 			@ <UNDEFINED> instruction: 0x032f2f2f
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	2f2ff20c 	svccs	0x002ff20c
    MRS r0, cpsr
  50:	2f302f2f 	svccs	0x00302f2f
    BIC r1, r0, #0x1F
  54:	302f2f2f 	eorcc	r2, pc, pc, lsr #30
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	2f2f2f2f 	svccs	0x002f2f2f
    MSR cpsr, r1
  5c:	2f2f2f30 	svccs	0x002f2f30
    LDR sp, =IRQ_STACK_TOP
  60:	2f2f302f 	svccs	0x002f302f
    MRS r0, cpsr
  64:	2f302f2f 	svccs	0x00302f2f
    BIC r1, r0, #0x1F
  68:	302f2f2f 	eorcc	r2, pc, pc, lsr #30
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	2e5d0331 	mrccs	3, 2, r0, cr13, cr1, {1}
    MSR cpsr, r1
  70:	34343434 	ldrtcc	r3, [r4], #-1076	@ 0xfffffbcc
    LDR sp, =FIQ_STACK_TOP
  74:	00020234 	andeq	r0, r2, r4, lsr r2
    MRS r0, cpsr
  78:	005a0101 	subseq	r0, sl, r1, lsl #2
    BIC r1, r0, #0x1F
  7c:	00030000 	andeq	r0, r3, r0
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	00000035 	andeq	r0, r0, r5, lsr r0
    MSR cpsr, r1
  84:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
    LDR sp, =ABT_STACK_TOP
  88:	0101000d 	tsteq	r1, sp
    MRS r0, cpsr
  8c:	00000101 	andeq	r0, r0, r1, lsl #2
    BIC r1, r0, #0x1F
  90:	00000100 	andeq	r0, r0, r0, lsl #2
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	6f6f6201 	svcvs	0x006f6201
    MSR cpsr, r1
  98:	61680074 	smcvs	32772	@ 0x8004
    LDR sp, =UND_STACK_TOP
  9c:	4800006c 	stmdami	r0, {r2, r3, r5, r6}
    MRS r0, cpsr
  a0:	6c646e61 	stclvs	14, cr6, [r4], #-388	@ 0xfffffe7c
    BIC r1, r0, #0x1F
  a4:	632e7265 			@ <UNDEFINED> instruction: 0x632e7265
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	00000100 	andeq	r0, r0, r0, lsl #2
    MSR cpsr, r1
  ac:	476c6148 	strbmi	r6, [ip, -r8, asr #2]!
    LDR sp, =USRSYS_STACK_TOP
  b0:	682e6369 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sp, lr}
    BL main
  b4:	00000200 	andeq	r0, r0, r0, lsl #4
    B .
  b8:	003c0500 	eorseq	r0, ip, r0, lsl #10
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  bc:	00d40205 	sbcseq	r0, r4, r5, lsl #4
    LDR sp, =IRQ_STACK_TOP
  c0:	05160000 	ldreq	r0, [r6, #-0]
    LDR sp, =FIQ_STACK_TOP
  c4:	01056703 	tsteq	r5, r3, lsl #14
    LDR sp, =ABT_STACK_TOP
  c8:	683c052f 	ldmdavs	ip!, {r0, r1, r2, r3, r5, r8, sl}
    LDR sp, =UND_STACK_TOP
  cc:	02000905 	andeq	r0, r0, #81920	@ 0x14000
    LDR sp, =USRSYS_STACK_TOP
  d0:	022f0104 	eoreq	r0, pc, #4, 2
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
  d4:	01010002 	tsteq	r1, r2
  d8:	00000125 	andeq	r0, r0, r5, lsr #2
  dc:	00c00003 	sbceq	r0, r0, r3
  Hal_interrupt_run_handler();
  e0:	01020000 	mrseq	r0, (UNDEF: 2)
}
  e4:	000d0efb 	strdeq	r0, [sp], -fp
  e8:	01010101 	tsteq	r1, r1, lsl #2
  ec:	01000000 	mrseq	r0, (UNDEF: 0)
__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
  f0:	62010000 	andvs	r0, r1, #0
  while (true);
  f4:	00746f6f 	rsbseq	r6, r4, pc, ror #30
void main(void) {
  f8:	6c636e69 	stclvs	14, cr6, [r3], #-420	@ 0xfffffe5c
  fc:	00656475 	rsbeq	r6, r5, r5, ror r4
 100:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
  Hw_init();
 104:	68006c65 	stmdavs	r0, {r0, r2, r5, r6, sl, fp, sp, lr}
  Kernel_init();
 108:	6c006c61 	stcvs	12, cr6, [r0], {97}	@ 0x61
  uint32_t i = 100;
 10c:	68006269 	stmdavs	r0, {r0, r3, r5, r6, r9, sp, lr}
 110:	722f6c61 	eorvc	r6, pc, #24832	@ 0x6100
  while(i--) {
 114:	00627076 	rsbeq	r7, r2, r6, ror r0
    Hal_uart_put_char('N');
 118:	69614d00 	stmdbvs	r1!, {r8, sl, fp, lr}^
 11c:	00632e6e 	rsbeq	r2, r3, lr, ror #28
  while(i--) {
 120:	73000001 	movwvc	r0, #1
 124:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 128:	00682e74 	rsbeq	r2, r8, r4, ror lr
 12c:	74000002 	strvc	r0, [r0], #-2
 130:	2e6b7361 	cdpcs	3, 6, cr7, cr11, cr1, {3}
  Hal_uart_put_char('\n');
 134:	00030068 	andeq	r0, r3, r8, rrx
 138:	73615400 	cmnvc	r1, #0, 8
  putstr("Hello World!\n");
 13c:	682e736b 	stmdavs	lr!, {r0, r1, r3, r5, r6, r8, r9, ip, sp, lr}
 140:	00000100 	andeq	r0, r0, r0, lsl #2
 144:	636e7973 	cmnvs	lr, #1884160	@ 0x1cc000
  Printf_test();
 148:	00682e68 	rsbeq	r2, r8, r8, ror #28
  Hal_interrupt_enable(UART_INTERRUPT0);
 14c:	6d000003 	stcvs	0, cr0, [r0, #-12]
 150:	682e6773 	stmdavs	lr!, {r0, r1, r4, r5, r6, r8, r9, sl, sp, lr}
  Kernel_start();
 154:	00000300 	andeq	r0, r0, r0, lsl #6
}
 158:	6e657665 	cdpvs	6, 6, cr7, cr5, cr5, {3}
 15c:	00682e74 	rsbeq	r2, r8, r4, ror lr
 160:	48000003 	stmdami	r0, {r0, r1}
static void Hw_init(void){
 164:	61556c61 	cmpvs	r5, r1, ror #24
 168:	682e7472 	stmdavs	lr!, {r1, r4, r5, r6, sl, ip, sp, lr}
  Hal_interrupt_init();
 16c:	00000400 	andeq	r0, r0, r0, lsl #8
  Hal_uart_init();
 170:	476c6148 	strbmi	r6, [ip, -r8, asr #2]!
  Hal_timer_init();
 174:	682e6369 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sp, lr}
}
 178:	00000400 	andeq	r0, r0, r0, lsl #8
 17c:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
static void Kernel_init(void) {
 180:	682e6c65 	stmdavs	lr!, {r0, r2, r5, r6, sl, fp, sp, lr}
 184:	00000300 	andeq	r0, r0, r0, lsl #6
  Kernel_task_init();
 188:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
  Kernel_event_flag_init();
 18c:	00682e6f 	rsbeq	r2, r8, pc, ror #28
  Kernel_msgQ_init();
 190:	48000005 	stmdami	r0, {r0, r2}
  Kernel_sem_init(1);
 194:	69546c61 	ldmdbvs	r4, {r0, r5, r6, sl, fp, sp, lr}^
 198:	2e72656d 	cdpcs	5, 7, cr6, cr2, cr13, {3}
  Kernel_mutex_init();
 19c:	00060068 	andeq	r0, r6, r8, rrx
  add_task(User_task0, 0);
 1a0:	11050000 	mrsne	r0, (UNDEF: 5)
 1a4:	f8020500 			@ <UNDEFINED> instruction: 0xf8020500
 1a8:	03000000 	movweq	r0, #0
 1ac:	03050113 	movweq	r0, #20755	@ 0x5113
  add_task(User_task1, 1);
 1b0:	0c052f67 	stceq	15, cr2, [r5], {103}	@ 0x67
 1b4:	4b080530 	blmi	20167c <cpsr_cp+0x1fe3f4>
 1b8:	052f0505 	streq	r0, [pc, #-1285]!	@ fffffcbb <cpsr_cp+0xffffca33>
 1bc:	0905490a 	stmdbeq	r5, {r1, r3, r8, fp, lr}
  add_task(User_task2, 2);
 1c0:	4d030566 	cfstr32mi	mvfx0, [r3, #-408]	@ 0xfffffe68
 1c4:	4b30684c 	blmi	c1a2fc <cpsr_cp+0xc17074>
 1c8:	052f0105 	streq	r0, [pc, #-261]!	@ cb <dummy_handler+0x13>
 1cc:	0305681a 	movweq	r6, #22554	@ 0x581a
}
 1d0:	052f2f4b 	streq	r2, [pc, #-3915]!	@ fffff28d <cpsr_cp+0xffffc005>
 1d4:	1f052f01 	svcne	0x00052f01
static void Printf_test(void) {
 1d8:	4b03054c 	blmi	c1710 <cpsr_cp+0xbe488>
 1dc:	4b2f2f2f 	blmi	bcbea0 <cpsr_cp+0xbc8c18>
 1e0:	0583832f 	streq	r8, [r3, #815]	@ 0x32f
  char* str = "printf pointer test";
 1e4:	1f058301 	svcne	0x00058301
 1e8:	6709054c 	strvs	r0, [r9, -ip, asr #10]
 1ec:	4b0c0567 	blmi	301790 <cpsr_cp+0x2fe508>
  char* nullptr = 0;
 1f0:	9f4c0305 	svcls	0x004c0305
 1f4:	9f839f83 	svcls	0x00839f83
  uint32_t i = 5;
 1f8:	d7010584 	strle	r0, [r1, -r4, lsl #11]
 1fc:	01000602 	tsteq	r0, r2, lsl #12
  debug_printf("%s\n", "Hello printf");
 200:	00016401 	andeq	r6, r1, r1, lsl #8
 204:	83000300 	movwhi	r0, #768	@ 0x300
 208:	02000000 	andeq	r0, r0, #0
 20c:	0d0efb01 	vstreq	d15, [lr, #-4]
 210:	01010100 	mrseq	r0, (UNDEF: 17)
  debug_printf("output string pointer: %s\n", str);
 214:	00000001 	andeq	r0, r0, r1
 218:	01000001 	tsteq	r0, r1
 21c:	746f6f62 	strbtvc	r6, [pc], #-3938	@ 224 <Printf_test+0x4c>
 220:	636e6900 	cmnvs	lr, #0, 18
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
 224:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 228:	72656b00 	rsbvc	r6, r5, #0, 22
 22c:	006c656e 	rsbeq	r6, ip, lr, ror #10
 230:	0062696c 	rsbeq	r6, r2, ip, ror #18
 234:	73615400 	cmnvc	r1, #0, 8
  debug_printf("%u = 5\n", i);
 238:	632e736b 			@ <UNDEFINED> instruction: 0x632e736b
 23c:	00000100 	andeq	r0, r0, r0, lsl #2
 240:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 244:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
 248:	00000200 	andeq	r0, r0, r0, lsl #4
 24c:	6b736174 	blvs	1cd8824 <cpsr_cp+0x1cd559c>
 250:	0300682e 	movweq	r6, #2094	@ 0x82e
 254:	76650000 	strbtvc	r0, [r5], -r0
 258:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
  debug_printf("print zero %u\n", 0);
 25c:	00030068 	andeq	r0, r3, r8, rrx
 260:	67736d00 	ldrbvs	r6, [r3, -r0, lsl #26]!
 264:	0300682e 	movweq	r6, #2094	@ 0x82e
 268:	654b0000 	strbvs	r0, [fp, #-0]
  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
 26c:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
 270:	0300682e 	movweq	r6, #2094	@ 0x82e
 274:	74730000 	ldrbtvc	r0, [r3], #-0
 278:	62696c64 	rsbvs	r6, r9, #100, 24	@ 0x6400
 27c:	0400682e 	streq	r6, [r0], #-2094	@ 0xfffff7d2
 280:	74730000 	ldrbtvc	r0, [r3], #-0
 284:	2e6f6964 	vnmulcs.f16	s13, s30, s9	@ <UNPREDICTABLE>
 288:	00040068 	andeq	r0, r4, r8, rrx
 28c:	32050000 	andcc	r0, r5, #0
 290:	40020500 	andmi	r0, r2, r0, lsl #10
 294:	19000003 	stmdbne	r0, {r0, r1}
 298:	05a10c05 	streq	r0, [r1, #3077]!	@ 0xc05
 29c:	05056706 	streq	r6, [r5, #-1798]	@ 0xfffff8fa
 2a0:	84010567 	strhi	r0, [r1], #-1383	@ 0xfffffa99
 2a4:	05694005 	strbeq	r4, [r9, #-5]!
 2a8:	052fa003 	streq	sl, [pc, #-3]!	@ 2ad <Printf_test+0xd5>
 2ac:	03059f10 	movweq	r9, #24336	@ 0x5f10
 2b0:	f44b2f83 			@ <UNDEFINED> instruction: 0xf44b2f83
 2b4:	052f0105 	streq	r0, [pc, #-261]!	@ 1b7 <Kernel_init+0x37>
 2b8:	0c056817 	stceq	8, cr6, [r5], {23}
 2bc:	4b030567 	blmi	c1860 <cpsr_cp+0xbe5d8>
 2c0:	4ba10b05 	blmi	fe842edc <cpsr_cp+0xfe83fc54>
 2c4:	054d2605 	strbeq	r2, [sp, #-1541]	@ 0xfffff9fb
 2c8:	07056705 	streq	r6, [r5, -r5, lsl #14]
 2cc:	a01205d8 			@ <UNDEFINED> instruction: 0xa01205d8
 2d0:	052e0a05 	streq	r0, [lr, #-2565]!	@ 0xfffff5fb
 2d4:	1b054b0f 	blne	152f18 <cpsr_cp+0x14fc90>
 2d8:	850f052e 	strhi	r0, [pc, #-1326]	@ fffffdb2 <cpsr_cp+0xffffcb2a>
 2dc:	05ba0e05 	ldreq	r0, [sl, #3589]!	@ 0xe05
 2e0:	054b4a0d 	strbeq	r4, [fp, #-2573]	@ 0xfffff5f3
 2e4:	13054c14 	movwne	r4, #23572	@ 0x5c14
 2e8:	4a1205d6 	bmi	481a48 <cpsr_cp+0x47e7c0>
 2ec:	9f4c0d05 	svcls	0x004c0d05
 2f0:	032e7a03 			@ <UNDEFINED> instruction: 0x032e7a03
 2f4:	09052e09 	stmdbeq	r5, {r0, r3, r9, sl, fp, sp}
 2f8:	4b130532 	blmi	4c17c8 <cpsr_cp+0x4be540>
 2fc:	05500705 	ldrbeq	r0, [r0, #-1797]	@ 0xfffff8fb
 300:	1b052b0f 	blne	14af44 <cpsr_cp+0x147cbc>
 304:	8320052e 			@ <UNDEFINED> instruction: 0x8320052e
 308:	054a2505 	strbeq	r2, [sl, #-1285]	@ 0xfffffafb
 30c:	07058213 	smladeq	r5, r3, r2, r8
 310:	0567304c 	strbeq	r3, [r7, #-76]!	@ 0xffffffb4
 314:	0f053005 	svceq	0x00053005
 318:	052e5d03 	streq	r5, [lr, #-3331]!	@ 0xfffff2fd
 31c:	2e260317 	mcrcs	3, 1, r0, cr6, cr7, {0}
 320:	05670c05 	strbeq	r0, [r7, #-3077]!	@ 0xfffff3fb
 324:	0b054b03 	bleq	152f38 <cpsr_cp+0x14fcb0>
 328:	26054ba0 	strcs	r4, [r5], -r0, lsr #23
 32c:	670505d9 			@ <UNDEFINED> instruction: 0x670505d9
 330:	9fd80705 	svcls	0x00d80705
 334:	05bb0a05 	ldreq	r0, [fp, #2565]!	@ 0xa05
 338:	07052e13 	smladeq	r5, r3, lr, r2
 33c:	2f309f83 	svccs	0x00309f83
void add_task(KernelTaskFunc_t f, uint32_t t_id) {
 340:	05300505 	ldreq	r0, [r0, #-1285]!	@ 0xfffffafb
 344:	2e73030f 	cdpcs	3, 7, cr0, cr3, cr15, {0}
 348:	10031705 	andne	r1, r3, r5, lsl #14
 34c:	670c052e 	strvs	r0, [ip, -lr, lsr #10]
 350:	054b0305 	strbeq	r0, [fp, #-773]	@ 0xfffffcfb
  taskId = Kernel_task_create(f);
 354:	04020005 	streq	r0, [r2], #-5
 358:	0200a001 	andeq	sl, r0, #1
 35c:	00670104 	rsbeq	r0, r7, r4, lsl #2
  if (taskId == NOT_ENOUGH_TASK_NUM) {
 360:	2d010402 	cfstrscs	mvf0, [r1, #-8]
 364:	01000202 	tsteq	r0, r2, lsl #4
 368:	00012201 	andeq	r2, r1, r1, lsl #4
    debug_printf("Task%u creation fail\n", t_id);
 36c:	62000300 	andvs	r0, r0, #0, 6
 370:	02000000 	andeq	r0, r0, #0
 374:	0d0efb01 	vstreq	d15, [lr, #-4]
 378:	01010100 	mrseq	r0, (UNDEF: 17)
}
 37c:	00000001 	andeq	r0, r0, r1
 380:	01000001 	tsteq	r0, r1
 384:	2f6c6168 	svccs	0x006c6168
static void Test_critical_section(uint32_t p, uint32_t taskId) {
 388:	62707672 	rsbsvs	r7, r0, #119537664	@ 0x7200000
 38c:	636e6900 	cmnvs	lr, #0, 18
 390:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 394:	6c616800 	stclvs	8, cr6, [r1], #-0
 398:	62696c00 	rsbvs	r6, r9, #0, 24
  Kernel_lock_mutex();
 39c:	69470000 	stmdbvs	r7, {}^	@ <UNPREDICTABLE>
  debug_printf("User Task #%u Send=%u\n", taskId, p);
 3a0:	00632e63 	rsbeq	r2, r3, r3, ror #28
 3a4:	47000001 	strmi	r0, [r0, -r1]
 3a8:	682e6369 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sp, lr}
 3ac:	00000100 	andeq	r0, r0, r0, lsl #2
 3b0:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
  shared_value = p;
 3b4:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 3b8:	00000200 	andeq	r0, r0, r0, lsl #4
 3bc:	476c6148 	strbmi	r6, [ip, -r8, asr #2]!
 3c0:	682e6369 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sp, lr}
  Kernel_yield();
 3c4:	00000300 	andeq	r0, r0, r0, lsl #6
  delay(1000);
 3c8:	636d7261 	cmnvs	sp, #268435462	@ 0x10000006
 3cc:	682e7570 	stmdavs	lr!, {r4, r5, r6, r8, sl, ip, sp, lr}
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
 3d0:	00000400 	andeq	r0, r0, r0, lsl #8
 3d4:	001f0500 	andseq	r0, pc, r0, lsl #10
 3d8:	07340205 	ldreq	r0, [r4, -r5, lsl #4]!
 3dc:	0b030000 	bleq	c03e4 <cpsr_cp+0xbd15c>
 3e0:	67090501 	strvs	r0, [r9, -r1, lsl #10]
 3e4:	05662205 	strbeq	r2, [r6, #-517]!	@ 0xfffffdfb
 3e8:	2a056709 	bcs	15a014 <cpsr_cp+0x156d8c>
 3ec:	670a0566 	strvs	r0, [sl, -r6, ror #10]
  Kernel_unlock_mutex();
 3f0:	05662805 	strbeq	r2, [r6, #-2053]!	@ 0xfffff7fb
}
 3f4:	03056811 	movweq	r6, #22545	@ 0x5811
 3f8:	0012054a 	andseq	r0, r2, sl, asr #10
 3fc:	2f030402 	svccs	0x00030402
void User_task0(void) {
 400:	02003305 	andeq	r3, r0, #335544320	@ 0x14000000
 404:	059d0304 	ldreq	r0, [sp, #772]	@ 0x304
 408:	0402001a 	streq	r0, [r2], #-26	@ 0xffffffe6
  uint32_t local = 0;
 40c:	03056601 	movweq	r6, #22017	@ 0x5601
 410:	2f01056a 	svccs	0x0001056a
  debug_printf("User Task #0 SP=0x%x\n", &local);
 414:	05673305 	strbeq	r3, [r7, #-773]!	@ 0xfffffcfb
 418:	27058306 	strcs	r8, [r5, -r6, lsl #6]
 41c:	01040200 	mrseq	r0, R12_usr
 420:	6a0c0566 	bvs	3019c0 <cpsr_cp+0x2fe738>
 424:	05680605 	strbeq	r0, [r8, #-1541]!	@ 0xfffff9fb
  uint8_t cmdBufIdx = 0;
 428:	0d056705 	stceq	7, cr6, [r5, #-20]	@ 0xffffffec
 42c:	0505af08 	streq	sl, [r5, #-3848]	@ 0xfffff0f8
  uint8_t uartch = 0;
 430:	08760367 	ldmdaeq	r6!, {r0, r1, r2, r5, r6, r8, r9}^
 434:	030105ac 	movweq	r0, #5548	@ 0x15ac
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
 438:	34052e0c 	strcc	r2, [r5], #-3596	@ 0xfffff1f4
 43c:	83060567 	movwhi	r0, #25959	@ 0x6567
 440:	02002705 	andeq	r2, r0, #1310720	@ 0x140000
    switch(handle_event) {
 444:	05660104 	strbeq	r0, [r6, #-260]!	@ 0xfffffefc
 448:	06056a0c 	streq	r6, [r5], -ip, lsl #20
 44c:	67050568 	strvs	r0, [r5, -r8, ror #10]
 450:	cb080d05 	blgt	20386c <cpsr_cp+0x2005e4>
 454:	03670505 	cmneq	r7, #20971520	@ 0x1400000
 458:	05c80876 	strbeq	r0, [r8, #2166]	@ 0x876
 45c:	2e0c0301 	cdpcs	3, 0, cr0, cr12, cr1, {0}
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
 460:	05675505 	strbeq	r5, [r7, #-1285]!	@ 0xfffffafb
 464:	01059f1c 	tsteq	r5, ip, lsl pc
 468:	8326059f 			@ <UNDEFINED> instruction: 0x8326059f
 46c:	05672205 	strbeq	r2, [r7, #-517]!	@ 0xfffffdfb
 470:	0c056635 	stceq	6, cr6, [r5], {53}	@ 0x35
      if (uartch == '\r') {
 474:	30100566 	andscc	r0, r0, r6, ror #10
 478:	05820605 	streq	r0, [r2, #1541]	@ 0x605
 47c:	05054b0e 	streq	r4, [r5, #-2830]	@ 0xfffff4f2
        cmdBuf[cmdBufIdx] = '\0';
 480:	31090582 	smlabbcc	r9, r2, r5, r0
 484:	05662b05 	strbeq	r2, [r6, #-2821]!	@ 0xfffff4fb
 488:	0602bb01 	streq	fp, [r2], -r1, lsl #22
 48c:	5e010100 	adfpls	f0, f1, f0
 490:	03000000 	movweq	r0, #0
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
 494:	00005800 	andeq	r5, r0, r0, lsl #16
 498:	fb010200 	blx	40ca2 <cpsr_cp+0x3da1a>
 49c:	01000d0e 	tsteq	r0, lr, lsl #26
 4a0:	00010101 	andeq	r0, r1, r1, lsl #2
 4a4:	00010000 	andeq	r0, r1, r0
 4a8:	61680100 	cmnvs	r8, r0, lsl #2
 4ac:	76722f6c 	ldrbtvc	r2, [r2], -ip, ror #30
 4b0:	69006270 	stmdbvs	r0, {r4, r5, r6, r9, sp, lr}
 4b4:	756c636e 	strbvc	r6, [ip, #-878]!	@ 0xfffffc92
 4b8:	00006564 	andeq	r6, r0, r4, ror #10
            Kernel_yield();
 4bc:	73676552 	cmnvc	r7, #343932928	@ 0x14800000
 4c0:	0100632e 	tsteq	r0, lr, lsr #6
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
 4c4:	61550000 	cmpvs	r5, r0
 4c8:	682e7472 	stmdavs	lr!, {r1, r4, r5, r6, sl, ip, sp, lr}
 4cc:	00000100 	andeq	r0, r0, r0, lsl #2
 4d0:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 4d4:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 4d8:	00000200 	andeq	r0, r0, r0, lsl #4
 4dc:	2e636947 	vnmulcs.f16	s13, s6, s14	@ <UNPREDICTABLE>
 4e0:	00010068 	andeq	r0, r1, r8, rrx
 4e4:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
 4e8:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 4ec:	00000100 	andeq	r0, r0, r0, lsl #2
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
 4f0:	0000ec00 	andeq	lr, r0, r0, lsl #24
 4f4:	56000300 	strpl	r0, [r0], -r0, lsl #6
 4f8:	02000000 	andeq	r0, r0, #0
 4fc:	0d0efb01 	vstreq	d15, [lr, #-4]
 500:	01010100 	mrseq	r0, (UNDEF: 17)
            Kernel_yield();
 504:	00000001 	andeq	r0, r0, r1
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
 508:	01000001 	tsteq	r0, r1
            break;
 50c:	2f6c6168 	svccs	0x006c6168
        Kernel_send_events(KernelEventFlag_CmdIn);
 510:	62707672 	rsbsvs	r7, r0, #119537664	@ 0x7200000
 514:	636e6900 	cmnvs	lr, #0, 18
        cmdBufIdx = 0;
 518:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 51c:	6c616800 	stclvs	8, cr6, [r1], #-0
      break;
 520:	69540000 	ldmdbvs	r4, {}^	@ <UNPREDICTABLE>
        cmdBuf[cmdBufIdx] = uartch;
 524:	2e72656d 	cdpcs	5, 7, cr6, cr2, cr13, {3}
 528:	00010063 	andeq	r0, r1, r3, rrx
 52c:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
 530:	682e7265 	stmdavs	lr!, {r0, r2, r5, r6, r9, ip, sp, lr}
 534:	00000100 	andeq	r0, r0, r0, lsl #2
        cmdBufIdx = (cmdBufIdx + 1) % 16;
 538:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 53c:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 540:	00000200 	andeq	r0, r0, r0, lsl #4
 544:	476c6148 	strbmi	r6, [ip, -r8, asr #2]!
 548:	682e6369 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sp, lr}
 54c:	00000300 	andeq	r0, r0, r0, lsl #6
 550:	001b0500 	andseq	r0, fp, r0, lsl #10
 554:	0a2c0205 	beq	b00d70 <cpsr_cp+0xafdae8>
      break;
 558:	0b030000 	bleq	c0560 <cpsr_cp+0xbd2d8>
      Test_critical_section(5, 0);
 55c:	68080501 	stmdavs	r8, {r0, r8, sl}
 560:	05662505 	strbeq	r2, [r6, #-1285]!	@ 0xfffffafb
 564:	27056708 	strcs	r6, [r5, -r8, lsl #14]
      break;
 568:	67080566 	strvs	r0, [r8, -r6, ror #10]
    Kernel_yield();
 56c:	05662505 	strbeq	r2, [r6, #-1285]!	@ 0xfffffafb
  while(true) {
 570:	27056708 	strcs	r6, [r5, -r8, lsl #14]
void User_task1(void) {
 574:	67080566 	strvs	r0, [r8, -r6, ror #10]
 578:	05662605 	strbeq	r2, [r6, #-1541]!	@ 0xfffff9fb
 57c:	27056708 	strcs	r6, [r5, -r8, lsl #14]
  uint32_t local = 0;
 580:	67080566 	strvs	r0, [r8, -r6, ror #10]
 584:	05661505 	strbeq	r1, [r6, #-1285]!	@ 0xfffffafb
  debug_printf("User Task #1 SP=0x%x\n", &local);
 588:	16054b08 	strne	r4, [r5], -r8, lsl #22
 58c:	4d080566 	cfstr32mi	mvfx0, [r8, #-408]	@ 0xfffffe68
 590:	05662705 	strbeq	r2, [r6, #-1797]!	@ 0xfffff8fb
 594:	27056708 	strcs	r6, [r5, -r8, lsl #14]
 598:	67080566 	strvs	r0, [r8, -r6, ror #10]
  uint8_t cmdlen = 0;
 59c:	05662505 	strbeq	r2, [r6, #-1285]!	@ 0xfffffafb
 5a0:	26056708 	strcs	r6, [r5], -r8, lsl #14
  uint8_t cmd[16] = {0, };
 5a4:	67080566 	strvs	r0, [r8, -r6, ror #10]
 5a8:	05662705 	strbeq	r2, [r6, #-1797]!	@ 0xfffff8fb
 5ac:	0805680c 	stmdaeq	r5, {r2, r3, fp, sp, lr}
 5b0:	6615054c 	ldrvs	r0, [r5], -ip, asr #10
 5b4:	054b0805 	strbeq	r0, [fp, #-2053]	@ 0xfffff7fb
 5b8:	18056625 	stmdane	r5, {r0, r2, r5, r9, sl, sp, lr}
 5bc:	85030568 	strhi	r0, [r3, #-1384]	@ 0xfffffa98
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
 5c0:	8301054b 	movwhi	r0, #5451	@ 0x154b
 5c4:	05682a05 	strbeq	r2, [r8, #-2565]!	@ 0xfffff5fb
 5c8:	01054b0a 	tsteq	r5, sl, lsl #22
    switch(handle_event) {
 5cc:	84250567 	strthi	r0, [r5], #-1383	@ 0xfffffa99
 5d0:	054b0305 	strbeq	r0, [fp, #-773]	@ 0xfffffcfb
 5d4:	1705d708 	strne	sp, [r5, -r8, lsl #14]
 5d8:	4b010566 	blmi	41b78 <cpsr_cp+0x3e8f0>
 5dc:	01000802 	tsteq	r0, r2, lsl #16
 5e0:	00013201 	andeq	r3, r1, r1, lsl #4
 5e4:	7b000300 	blvc	11ec <vsprintf+0x258>
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
 5e8:	02000000 	andeq	r0, r0, #0
 5ec:	0d0efb01 	vstreq	d15, [lr, #-4]
 5f0:	01010100 	mrseq	r0, (UNDEF: 17)
 5f4:	00000001 	andeq	r0, r0, r1
 5f8:	01000001 	tsteq	r0, r1
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
 5fc:	2f6c6168 	svccs	0x006c6168
 600:	62707672 	rsbsvs	r7, r0, #119537664	@ 0x7200000
 604:	636e6900 	cmnvs	lr, #0, 18
 608:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 60c:	6c616800 	stclvs	8, cr6, [r1], #-0
 610:	72656b00 	rsbvc	r6, r5, #0, 22
      cmd[cmdlen] = 0;
 614:	006c656e 	rsbeq	r6, ip, lr, ror #10
 618:	72615500 	rsbvc	r5, r1, #0, 10
 61c:	00632e74 	rsbeq	r2, r3, r4, ror lr
 620:	73000001 	movwvc	r0, #1
 624:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
      debug_printf("\nRecv Cmd: %s\n", cmd);
 628:	00682e74 	rsbeq	r2, r8, r4, ror lr
 62c:	55000002 	strpl	r0, [r0, #-2]
 630:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 634:	00010068 	andeq	r0, r1, r8, rrx
 638:	6c614800 	stclvs	8, cr4, [r1], #-0
      break;
 63c:	2e636947 	vnmulcs.f16	s13, s6, s14	@ <UNPREDICTABLE>
      Kernel_unlock_sem();
 640:	00030068 	andeq	r0, r3, r8, rrx
      break;
 644:	65766500 	ldrbvs	r6, [r6, #-1280]!	@ 0xfffffb00
    Kernel_yield();
 648:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
  while(true) {
 64c:	00000400 	andeq	r0, r0, r0, lsl #8
void User_task2(void) {
 650:	2e67736d 	cdpcs	3, 6, cr7, cr7, cr13, {3}
 654:	00040068 	andeq	r0, r4, r8, rrx
 658:	72654b00 	rsbvc	r4, r5, #0, 22
  uint32_t local = 0;
 65c:	2e6c656e 	cdpcs	5, 6, cr6, cr12, cr14, {3}
 660:	00040068 	andeq	r0, r4, r8, rrx
  debug_printf("User Task #2 SP=0x%x\n", &local);
 664:	1a050000 	bne	14066c <cpsr_cp+0x13d3e4>
 668:	3c020500 	cfstr32cc	mvfx0, [r2], {-0}
 66c:	0300000c 	movweq	r0, #12
 670:	0705010a 	streq	r0, [r5, -sl, lsl #2]
 674:	661c054c 	ldrvs	r0, [ip], -ip, asr #10
    Test_critical_section(3, 2);
 678:	05670705 	strbeq	r0, [r7, #-1797]!	@ 0xfffff8fb
 67c:	07056619 	smladeq	r5, r9, r6, r6
 680:	66190567 	ldrvs	r0, [r9], -r7, ror #10
    Kernel_yield();
 684:	05670705 	strbeq	r0, [r7, #-1797]!	@ 0xfffff8fb
    Test_critical_section(3, 2);
 688:	0705661c 	smladeq	r5, ip, r6, r6
 68c:	661c0569 	ldrvs	r0, [ip], -r9, ror #10
 690:	056a0305 	strbeq	r0, [sl, #-773]!	@ 0xfffffcfb
 694:	24058301 	strcs	r8, [r5], #-769	@ 0xfffffcff
 698:	9f08054c 	svcls	0x0008054c
 69c:	02000d05 	andeq	r0, r0, #320	@ 0x140
 6a0:	052e0104 	streq	r0, [lr, #-260]!	@ 0xfffffefc
 6a4:	0402001a 	streq	r0, [r2], #-26	@ 0xffffffe6
 6a8:	09056601 	stmdbeq	r5, {r0, r9, sl, sp, lr}
 6ac:	01040200 	mrseq	r0, R12_usr
 6b0:	4b070566 	blmi	1c1c50 <cpsr_cp+0x1be9c8>
 6b4:	05661a05 	strbeq	r1, [r6, #-2565]!	@ 0xfffff5fb
 6b8:	21058301 	tstcs	r5, r1, lsl #6
 6bc:	69080584 	stmdbvs	r8, {r2, r7, r8, sl}
 6c0:	02000d05 	andeq	r0, r0, #320	@ 0x140
 6c4:	052e0104 	streq	r0, [lr, #-260]!	@ 0xfffffefc
 6c8:	0402001a 	streq	r0, [r2], #-26	@ 0xffffffe6
 6cc:	09056601 	stmdbeq	r5, {r0, r9, sl, sp, lr}
 6d0:	01040200 	mrseq	r0, R12_usr
 6d4:	4c0e0566 	cfstr32mi	mvfx0, [lr], {102}	@ 0x66
 6d8:	05660805 	strbeq	r0, [r6, #-2053]!	@ 0xfffff7fb
 6dc:	09054d05 	stmdbeq	r5, {r0, r2, r8, sl, fp, lr}
 6e0:	66170568 	ldrvs	r0, [r7], -r8, ror #10
 6e4:	054b0c05 	strbeq	r0, [fp, #-3077]	@ 0xfffff3fb
 6e8:	01054d0a 	tsteq	r5, sl, lsl #26
 6ec:	8425054b 	strthi	r0, [r5], #-1355	@ 0xfffffab5
 6f0:	05671005 	strbeq	r1, [r7, #-5]!
 6f4:	0a054a0b 	beq	152f28 <cpsr_cp+0x14fca0>
 6f8:	2e060530 	cfmv64hrcs	mvdx6, r0
 6fc:	4b4b0505 	blmi	12c1b18 <cpsr_cp+0x12be890>
 700:	05300a05 	ldreq	r0, [r0, #-2565]!	@ 0xfffff5fb
 704:	05052e06 	streq	r2, [r5, #-3590]	@ 0xfffff1fa
 708:	03054b4b 	movweq	r4, #23371	@ 0x5b4b
 70c:	059f6731 	ldreq	r6, [pc, #1841]	@ e45 <enable_irq+0x11>
 710:	04024b01 	streq	r4, [r2], #-2817	@ 0xfffff4ff
 714:	69010100 	stmdbvs	r1, {r8}
 718:	03000000 	movweq	r0, #0
 71c:	00002300 	andeq	r2, r0, r0, lsl #6
 720:	fb010200 	blx	40f2a <cpsr_cp+0x3dca2>
 724:	01000d0e 	tsteq	r0, lr, lsl #26
 728:	00010101 	andeq	r0, r1, r1, lsl #2
 72c:	00010000 	andeq	r0, r1, r0
 730:	696c0100 	stmdbvs	ip!, {r8}^
void Hal_interrupt_init(void) {
 734:	61000062 	tstvs	r0, r2, rrx
 738:	70636d72 	rsbvc	r6, r3, r2, ror sp
 73c:	00632e75 	rsbeq	r2, r3, r5, ror lr
  GicCpu->cpucontrol.bits.Enable = 1;
 740:	00000001 	andeq	r0, r0, r1
 744:	05001705 	streq	r1, [r0, #-1797]	@ 0xfffff8fb
 748:	000e3402 	andeq	r3, lr, r2, lsl #8
 74c:	03051400 	movweq	r1, #21504	@ 0x5400
 750:	2f2f2f4b 	svccs	0x002f2f4b
 754:	2f01052f 	svccs	0x0001052f
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
 758:	05831705 	streq	r1, [r3, #1797]	@ 0x705
 75c:	2f2f4b03 	svccs	0x002f4b03
 760:	01052f2f 	tsteq	r5, pc, lsr #30
 764:	8318052f 	tsthi	r8, #197132288	@ 0xbc00000
 768:	2f4b0305 	svccs	0x004b0305
 76c:	052f2f2f 	streq	r2, [pc, #-3887]!	@ fffff845 <cpsr_cp+0xffffc5bd>
  GicDist->distributorctrl.bits.Enable = 1;
 770:	18052f01 	stmdane	r5, {r0, r8, r9, sl, fp, sp}
 774:	4b030583 	blmi	c1d88 <cpsr_cp+0xbeb00>
 778:	2f2f2f2f 	svccs	0x002f2f2f
 77c:	022f0105 	eoreq	r0, pc, #1073741825	@ 0x40000001
 780:	01010008 	tsteq	r1, r8
 784:	00000186 	andeq	r0, r0, r6, lsl #3
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
 788:	006c0003 	rsbeq	r0, ip, r3
 78c:	01020000 	mrseq	r0, (UNDEF: 2)
 790:	000d0efb 	strdeq	r0, [sp], -fp
    sHandlers[i] = NULL;
 794:	01010101 	tsteq	r1, r1, lsl #2
 798:	01000000 	mrseq	r0, (UNDEF: 0)
 79c:	6c010000 	stcvs	0, cr0, [r1], {-0}
 7a0:	69006269 	stmdbvs	r0, {r0, r3, r5, r6, r9, sp, lr}
 7a4:	756c636e 	strbvc	r6, [ip, #-878]!	@ 0xfffffc92
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
 7a8:	68006564 	stmdavs	r0, {r2, r5, r6, r8, sl, sp, lr}
 7ac:	00006c61 	andeq	r6, r0, r1, ror #24
 7b0:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 7b4:	00632e6f 	rsbeq	r2, r3, pc, ror #28
 7b8:	73000001 	movwvc	r0, #1
 7bc:	72616474 	rsbvc	r6, r1, #116, 8	@ 0x74000000
  enable_irq();
 7c0:	00682e67 	rsbeq	r2, r8, r7, ror #28
}
 7c4:	73000002 	movwvc	r0, #2
 7c8:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 7cc:	00682e74 	rsbeq	r2, r8, r4, ror lr
void Hal_interrupt_enable(uint32_t interrupt_num) {
 7d0:	73000002 	movwvc	r0, #2
 7d4:	6f696474 	svcvs	0x00696474
 7d8:	0100682e 	tsteq	r0, lr, lsr #16
 7dc:	623c0000 	eorsvs	r0, ip, #0
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
 7e0:	746c6975 	strbtvc	r6, [ip], #-2421	@ 0xfffff68b
 7e4:	3e6e692d 	vmulcc.f16	s13, s28, s27	@ <UNPREDICTABLE>
 7e8:	00000000 	andeq	r0, r0, r0
 7ec:	556c6148 	strbpl	r6, [ip, #-328]!	@ 0xfffffeb8
 7f0:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 7f4:	00030068 	andeq	r0, r3, r8, rrx
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
 7f8:	20050000 	andcs	r0, r5, r0
 7fc:	e4020500 	str	r0, [r2], #-1280	@ 0xfffffb00
 800:	0300000e 	movweq	r0, #14
  if (bit_num < GIC_IRQ_START) {
 804:	0c050109 	stfeqs	f0, [r5], {9}
 808:	4b080583 	blmi	201e1c <cpsr_cp+0x1feb94>
 80c:	052f1905 	streq	r1, [pc, #-2309]!	@ ffffff0f <cpsr_cp+0xffffcc87>
    SET_BIT(GicDist->setenable1, bit_num);
 810:	05676605 	strbeq	r6, [r7, #-1541]!	@ 0xfffff9fb
 814:	0a056409 	beq	159840 <cpsr_cp+0x1565b8>
 818:	2f010586 	svccs	0x00010586
 81c:	05683005 	strbeq	r3, [r8, #-5]!
 820:	054b8403 	strbeq	r8, [fp, #-1027]	@ 0xfffffbfd
 824:	0105a10a 	tsteq	r5, sl, lsl #2
 828:	a03f0583 	eorsge	r0, pc, r3, lsl #11
 82c:	05bb0c05 	ldreq	r0, [fp, #3077]!	@ 0xc05
 830:	03055111 	movweq	r5, #20753	@ 0x5111
 834:	2f0f054a 	svccs	0x000f054a
 838:	05820805 	streq	r0, [r2, #2053]	@ 0x805
 83c:	14054b07 	strne	r4, [r5], #-2823	@ 0xfffff4f9
 840:	82070567 	andhi	r0, r7, #432013312	@ 0x19c00000
 844:	34021405 	strcc	r1, [r2], #-1029	@ 0xfffffbfb
    bit_num -= GIC_IRQ_START;
 848:	820c0514 	andhi	r0, ip, #20, 10	@ 0x5000000
 84c:	052f0e05 	streq	r0, [pc, #-3589]!	@ fffffa4f <cpsr_cp+0xffffc7c7>
 850:	1205660c 	andne	r6, r5, #12, 12	@ 0xc00000
    SET_BIT(GicDist->setenable2, bit_num);
 854:	4b09054a 	blmi	241d84 <cpsr_cp+0x23eafc>
 858:	05300d05 	ldreq	r0, [r0, #-3333]!	@ 0xfffff2fb
 85c:	0f059f0c 	svceq	0x00059f0c
 860:	1b056867 	blne	15aa04 <cpsr_cp+0x15777c>
 864:	6610052f 	ldrvs	r0, [r0], -pc, lsr #10
 868:	05660e05 	strbeq	r0, [r6, #-3589]!	@ 0xfffff1fb
 86c:	14054a17 	strne	r4, [r5], #-2583	@ 0xfffff5e9
 870:	2d10052e 	cfldr32cs	mvfx0, [r0, #-184]	@ 0xffffff48
 874:	05850905 	streq	r0, [r5, #2309]	@ 0x905
 878:	059f300e 	ldreq	r3, [pc, #14]	@ 88e <Hal_interrupt_enable+0xbe>
 87c:	0905f20b 	stmdbeq	r5, {r0, r1, r3, r9, ip, sp, lr, pc}
 880:	300d0567 	andcc	r0, sp, r7, ror #10
 884:	059f0e05 	ldreq	r0, [pc, #3589]	@ 1691 <Kernel_recv_msg+0x5>
 888:	0905f20b 	stmdbeq	r5, {r0, r1, r3, r9, ip, sp, lr, pc}
    return;
 88c:	32180567 	andscc	r0, r8, #432013312	@ 0x19c00000
}
 890:	05660c05 	strbeq	r0, [r6, #-3077]!	@ 0xfffff3fb
 894:	1805660a 	stmdane	r5, {r1, r3, r9, sl, sp, lr}
 898:	2e10054a 	cfmac32cs	mvfx0, mvfx0, mvfx10
void Hal_interrupt_disable(uint32_t interrupt_num) {
 89c:	05310805 	ldreq	r0, [r1, #-2053]!	@ 0xfffff7fb
 8a0:	05676710 	strbeq	r6, [r7, #-1808]!	@ 0xfffff8f0
 8a4:	04020023 	streq	r0, [r2], #-35	@ 0xffffffdd
 8a8:	4a5f0302 	bmi	17c14b8 <cpsr_cp+0x17be230>
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
 8ac:	02001e05 	andeq	r1, r0, #5, 28	@ 0x50
 8b0:	05660104 	strbeq	r0, [r6, #-260]!	@ 0xfffffefc
 8b4:	04020018 	streq	r0, [r2], #-24	@ 0xffffffe8
 8b8:	06058201 	streq	r8, [r5], -r1, lsl #4
 8bc:	054a2503 	strbeq	r2, [sl, #-1283]	@ 0xfffffafd
 8c0:	054b660a 	strbeq	r6, [fp, #-1546]	@ 0xfffff9f6
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
 8c4:	35052f01 	strcc	r2, [r5, #-3841]	@ 0xfffff0ff
 8c8:	d70c0568 	strle	r0, [ip, -r8, ror #10]
 8cc:	054b0b05 	strbeq	r0, [fp, #-2821]	@ 0xfffff4fb
  if (bit_num < GIC_IRQ_START) {
 8d0:	0e054e18 	mcreq	14, 0, r4, cr5, cr8, {0}
 8d4:	bb08052e 	bllt	201d94 <cpsr_cp+0x1feb0c>
 8d8:	05670905 	strbeq	r0, [r7, #-2309]!	@ 0xfffff6fb
    CLR_BIT(GicDist->setenable1, bit_num);
 8dc:	0c056815 	stceq	8, cr6, [r5], {21}
 8e0:	6615054a 	ldrvs	r0, [r5], -sl, asr #10
 8e4:	054a1005 	strbeq	r1, [sl, #-5]
 8e8:	0b056709 	bleq	15a514 <cpsr_cp+0x15728c>
 8ec:	690305bb 	stmdbvs	r3, {r0, r1, r3, r4, r5, r7, r8, sl}
 8f0:	05670905 	strbeq	r0, [r7, #-2309]!	@ 0xfffff6fb
 8f4:	0a052f17 	beq	14c558 <cpsr_cp+0x1492d0>
 8f8:	66080566 	strvs	r0, [r8], -r6, ror #10
 8fc:	054a1305 	strbeq	r1, [sl, #-773]	@ 0xfffffcfb
 900:	052d660e 	streq	r6, [sp, #-1550]!	@ 0xfffff9f2
 904:	01056a0a 	tsteq	r5, sl, lsl #20
 908:	0006022f 	andeq	r0, r6, pc, lsr #4
 90c:	007d0101 	rsbseq	r0, sp, r1, lsl #2
 910:	00030000 	andeq	r0, r3, r0
 914:	0000004e 	andeq	r0, r0, lr, asr #32
    bit_num -= GIC_IRQ_START;
 918:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 91c:	0101000d 	tsteq	r1, sp
 920:	00000101 	andeq	r0, r0, r1, lsl #2
    CLR_BIT(GicDist->setenable2, bit_num);
 924:	00000100 	andeq	r0, r0, r0, lsl #2
 928:	62696c01 	rsbvs	r6, r9, #256	@ 0x100
 92c:	636e6900 	cmnvs	lr, #0, 18
 930:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 934:	6c616800 	stclvs	8, cr6, [r1], #-0
 938:	7076722f 	rsbsvc	r7, r6, pc, lsr #4
 93c:	73000062 	movwvc	r0, #98	@ 0x62
 940:	696c6474 	stmdbvs	ip!, {r2, r4, r5, r6, sl, sp, lr}^
 944:	00632e62 	rsbeq	r2, r3, r2, ror #28
 948:	73000001 	movwvc	r0, #1
 94c:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 950:	00682e74 	rsbeq	r2, r8, r4, ror lr
 954:	48000002 	stmdami	r0, {r1}
 958:	69546c61 	ldmdbvs	r4, {r0, r5, r6, sl, fp, sp, lr}^
 95c:	2e72656d 	cdpcs	5, 7, cr6, cr2, cr13, {3}
    return;
 960:	00030068 	andeq	r0, r3, r8, rrx
}
 964:	19050000 	stmdbne	r5, {}	@ <UNPREDICTABLE>
 968:	24020500 	strcs	r0, [r2], #-1280	@ 0xfffffb00
 96c:	16000013 			@ <UNDEFINED> instruction: 0x16000013
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num) {
 970:	05831305 	streq	r1, [r3, #773]	@ 0x305
 974:	08054a0c 	stmdaeq	r5, {r2, r3, r9, fp, lr}
 978:	00110567 	andseq	r0, r1, r7, ror #10
 97c:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 980:	02000e05 	andeq	r0, r0, #5, 28	@ 0x50
  sHandlers[interrupt_num] = handler;
 984:	054a0104 	strbeq	r0, [sl, #-260]	@ 0xfffffefc
 988:	08026701 	stmdaeq	r2, {r0, r8, r9, sl, sp, lr}
 98c:	87010100 	strhi	r0, [r1, -r0, lsl #2]
 990:	03000000 	movweq	r0, #0
 994:	00004400 	andeq	r4, r0, r0, lsl #8
}
 998:	fb010200 	blx	411a2 <cpsr_cp+0x3df1a>
 99c:	01000d0e 	tsteq	r0, lr, lsl #26
 9a0:	00010101 	andeq	r0, r1, r1, lsl #2
 9a4:	00010000 	andeq	r0, r1, r0
void Hal_interrupt_run_handler(void) {
 9a8:	656b0100 	strbvs	r0, [fp, #-256]!	@ 0xffffff00
 9ac:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
 9b0:	636e6900 	cmnvs	lr, #0, 18
  uint32_t interrupt_num = GicCpu->interruptack.bits.InterruptID;
 9b4:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
 9b8:	76650000 	strbtvc	r0, [r5], -r0
 9bc:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
 9c0:	00010063 	andeq	r0, r1, r3, rrx
 9c4:	64747300 	ldrbtvs	r7, [r4], #-768	@ 0xfffffd00
 9c8:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 9cc:	00020068 	andeq	r0, r2, r8, rrx
  if (sHandlers[interrupt_num] != NULL) {
 9d0:	65766500 	ldrbvs	r6, [r6, #-1280]!	@ 0xfffffb00
 9d4:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 9d8:	00000100 	andeq	r0, r0, r0, lsl #2
 9dc:	00230500 	eoreq	r0, r3, r0, lsl #10
 9e0:	13700205 	cmnne	r0, #1342177280	@ 0x50000000
 9e4:	051a0000 	ldreq	r0, [sl, #-0]
    sHandlers[interrupt_num]();
 9e8:	01054b0e 	tsteq	r5, lr, lsl #22
 9ec:	83350583 	teqhi	r5, #549453824	@ 0x20c00000
 9f0:	05830e05 	streq	r0, [r3, #3589]	@ 0xe05
 9f4:	3705f301 	strcc	pc, [r5, -r1, lsl #6]
 9f8:	83110583 	tsthi	r1, #549453824	@ 0x20c00000
  GicCpu->endofinterrupt.bits.InterruptID = interrupt_num;
 9fc:	054a0e05 	strbeq	r0, [sl, #-3589]	@ 0xfffff1fb
 a00:	3705d701 	strcc	sp, [r5, -r1, lsl #14]
 a04:	83110583 	tsthi	r1, #549453824	@ 0x20c00000
 a08:	4b9e0505 	blmi	fe781e24 <cpsr_cp+0xfe77eb9c>
 a0c:	054b0c05 	strbeq	r0, [fp, #-3077]	@ 0xfffff3fb
 a10:	01054c0a 	tsteq	r5, sl, lsl #24
 a14:	0006022f 	andeq	r0, r6, pc, lsr #4
 a18:	01b80101 			@ <UNDEFINED> instruction: 0x01b80101
 a1c:	00030000 	andeq	r0, r3, r0
 a20:	00000063 	andeq	r0, r0, r3, rrx
 a24:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 a28:	0101000d 	tsteq	r1, sp
void Hal_timer_init(void) {
 a2c:	00000101 	andeq	r0, r0, r1, lsl #2
 a30:	00000100 	andeq	r0, r0, r0, lsl #2
 a34:	72656b01 	rsbvc	r6, r5, #1024	@ 0x400
  Timer->timerxcontrol.bits.TimerEn = 0;
 a38:	006c656e 	rsbeq	r6, ip, lr, ror #10
 a3c:	6c636e69 	stclvs	14, cr6, [r3], #-420	@ 0xfffffe5c
 a40:	00656475 	rsbeq	r6, r5, r5, ror r4
 a44:	72654b00 	rsbvc	r4, r5, #0, 22
 a48:	2e6c656e 	cdpcs	5, 6, cr6, cr12, cr14, {3}
 a4c:	00010063 	andeq	r0, r1, r3, rrx
  Timer->timerxcontrol.bits.TimerMode = 0;
 a50:	64747300 	ldrbtvs	r7, [r4], #-768	@ 0xfffffd00
 a54:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 a58:	00020068 	andeq	r0, r2, r8, rrx
 a5c:	65766500 	ldrbvs	r6, [r6, #-1280]!	@ 0xfffffb00
 a60:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
 a64:	00000100 	andeq	r0, r0, r0, lsl #2
  Timer->timerxcontrol.bits.OneShot = 0;
 a68:	2e67736d 	cdpcs	3, 6, cr7, cr7, cr13, {3}
 a6c:	00010068 	andeq	r0, r1, r8, rrx
 a70:	6e797300 	cdpvs	3, 7, cr7, cr9, cr0, {0}
 a74:	682e6863 	stmdavs	lr!, {r0, r1, r5, r6, fp, sp, lr}
 a78:	00000100 	andeq	r0, r0, r0, lsl #2
 a7c:	6b736174 	blvs	1cd9054 <cpsr_cp+0x1cd5dcc>
  Timer->timerxcontrol.bits.TimerSize = 0;
 a80:	0100682e 	tsteq	r0, lr, lsr #16
 a84:	05000000 	streq	r0, [r0, #-0]
 a88:	02050019 	andeq	r0, r5, #25
 a8c:	00001468 	andeq	r1, r0, r8, ror #8
 a90:	4b03051a 	blmi	c1f00 <cpsr_cp+0xbec78>
 a94:	052f0105 	streq	r0, [pc, #-261]!	@ 997 <Hal_interrupt_register_handler+0x27>
  Timer->timerxcontrol.bits.TimerPre = 0;
 a98:	03054c19 	movweq	r4, #23577	@ 0x5c19
 a9c:	2f01054b 	svccs	0x0001054b
 aa0:	054c2e05 	strbeq	r2, [ip, #-3589]	@ 0xfffff1fb
 aa4:	03058310 	movweq	r8, #21264	@ 0x5310
 aa8:	2f14054a 	svccs	0x0014054a
 aac:	05661a05 	strbeq	r1, [r6, #-2565]!	@ 0xfffff5fb
  Timer->timerxcontrol.bits.IntEnable = 1;
 ab0:	19052e07 	stmdbne	r5, {r0, r1, r2, r9, sl, fp, sp}
 ab4:	4b2a054b 	blmi	a81fe8 <cpsr_cp+0xa7ed60>
 ab8:	05d70705 	ldrbeq	r0, [r7, #1797]	@ 0x705
 abc:	0402001f 	streq	r0, [r2], #-31	@ 0xffffffe1
 ac0:	19054602 	stmdbne	r5, {r1, r9, sl, lr}
 ac4:	01040200 	mrseq	r0, R12_usr
  Timer->timerxload = 0;
 ac8:	6d010566 	cfstr32vs	mvfx0, [r1, #-408]	@ 0xfffffe68
 acc:	05843d05 	streq	r3, [r4, #3333]	@ 0xd05
 ad0:	03058310 	movweq	r8, #21264	@ 0x5310
 ad4:	2f16054a 	svccs	0x0016054a
 ad8:	05661c05 	strbeq	r1, [r6, #-3077]!	@ 0xfffff3fb
  Timer->timerxvalue = 0xFFFFFFFF;
 adc:	19052e07 	stmdbne	r5, {r0, r1, r2, r9, sl, fp, sp}
 ae0:	4b2a054b 	blmi	a82014 <cpsr_cp+0xa7ed8c>
 ae4:	05d80a05 	ldrbeq	r0, [r8, #2565]	@ 0xa05
 ae8:	10056609 	andne	r6, r5, r9, lsl #12
 aec:	001f054b 	andseq	r0, pc, fp, asr #10
  Timer->timerxcontrol.bits.TimerMode = TIMER_PERIOIC;
 af0:	03020402 	movweq	r0, #9218	@ 0x2402
 af4:	19054a7a 	stmdbne	r5, {r1, r3, r4, r5, r6, r9, fp, lr}
 af8:	01040200 	mrseq	r0, R12_usr
 afc:	030a0566 	movweq	r0, #42342	@ 0xa566
 b00:	0105660b 	tsteq	r5, fp, lsl #12
 b04:	6846052f 	stmdavs	r6, {r0, r1, r2, r3, r5, r8, sl}^
  Timer->timerxcontrol.bits.TimerSize = TIMER_32BIT_COUNTER;
 b08:	05d70c05 	ldrbeq	r0, [r7, #3077]	@ 0xc05
 b0c:	03054c10 	movweq	r4, #23568	@ 0x5c10
 b10:	2f09054a 	svccs	0x0009054a
 b14:	05d60805 	ldrbeq	r0, [r6, #2053]	@ 0x805
 b18:	14054a07 	strne	r4, [r5], #-2567	@ 0xfffff5f9
 b1c:	4a07054b 	bmi	1c2050 <cpsr_cp+0x1bedc8>
  Timer->timerxcontrol.bits.OneShot = 0;
 b20:	02000905 	andeq	r0, r0, #81920	@ 0x14000
 b24:	05300304 	ldreq	r0, [r0, #-772]!	@ 0xfffffcfc
 b28:	04020022 	streq	r0, [r2], #-34	@ 0xffffffde
 b2c:	1d059c03 	stcne	12, cr9, [r5, #-12]
 b30:	01040200 	mrseq	r0, R12_usr
 b34:	860e0566 	strhi	r0, [lr], -r6, ror #10
  Timer->timerxcontrol.bits.TimerPre = 0;
 b38:	02000505 	andeq	r0, r0, #20971520	@ 0x1400000
 b3c:	054c0204 	strbeq	r0, [ip, #-516]	@ 0xfffffdfc
 b40:	04020022 	streq	r0, [r2], #-34	@ 0xffffffde
 b44:	66780302 	ldrbtvs	r0, [r8], -r2, lsl #6
 b48:	02001905 	andeq	r1, r0, #81920	@ 0x14000
 b4c:	05660104 	strbeq	r0, [r6, #-260]!	@ 0xfffffefc
  Timer->timerxcontrol.bits.IntEnable = 1;
 b50:	820b030a 	andhi	r0, fp, #671088640	@ 0x28000000
 b54:	052f0105 	streq	r0, [pc, #-261]!	@ a57 <Hal_timer_init+0x2b>
 b58:	0c05684e 	stceq	8, cr6, [r5], {78}	@ 0x4e
 b5c:	4c1005d7 	cfldr32mi	mvfx0, [r0], {215}	@ 0xd7
 b60:	054a0305 	strbeq	r0, [sl, #-773]	@ 0xfffffcfb
 b64:	08052f09 	stmdaeq	r5, {r0, r3, r8, r9, sl, fp, sp}
  uint32_t interval_1ms = TIMER_INTERVAL / 100;
 b68:	4a07059e 	bmi	1c21e8 <cpsr_cp+0x1bef60>
 b6c:	054b0e05 	strbeq	r0, [fp, #-3589]	@ 0xfffff1fb
  Timer->timerxload = interval_1ms;
 b70:	04020005 	streq	r0, [r2], #-5
 b74:	22054c02 	andcs	r4, r5, #512	@ 0x200
 b78:	02040200 	andeq	r0, r4, #0, 4
 b7c:	00190562 	andseq	r0, r9, r2, ror #10
 b80:	66010402 	strvs	r0, [r1], -r2, lsl #8
  Timer->timerxcontrol.bits.TimerEn = 1;
 b84:	05890a05 	streq	r0, [r9, #2565]	@ 0xa05
 b88:	1c052f01 	stcne	15, cr2, [r5], {1}
 b8c:	4b090568 	blmi	242134 <cpsr_cp+0x23eeac>
 b90:	052f0505 	streq	r0, [pc, #-1285]!	@ 693 <User_task2+0x43>
 b94:	0a052d0b 	beq	14bfc8 <cpsr_cp+0x148d40>
 b98:	8501054a 	strhi	r0, [r1, #-1354]	@ 0xfffffab6
  internal_1ms_counter = 0;
 b9c:	05681e05 	strbeq	r1, [r8, #-3589]!	@ 0xfffff1fb
 ba0:	01054b03 	tsteq	r5, r3, lsl #22
 ba4:	4c1e052f 	cfldr32mi	mvfx0, [lr], {47}	@ 0x2f
 ba8:	05682005 	strbeq	r2, [r8, #-5]!
  Hal_interrupt_enable(TIMER_INTERRUPT);
 bac:	08054b09 	stmdaeq	r5, {r0, r3, r8, r9, fp, lr}
 bb0:	4a070566 	bmi	1c2150 <cpsr_cp+0x1beec8>
  Hal_interrupt_register_handler(interrupt_handler, TIMER_INTERRUPT);
 bb4:	2b0f054b 	blcs	3c20e8 <cpsr_cp+0x3bee60>
 bb8:	05340705 	ldreq	r0, [r4, #-1797]!	@ 0xfffff8fb
 bbc:	20053101 	andcs	r3, r5, r1, lsl #2
 bc0:	671e0568 	ldrvs	r0, [lr, -r8, ror #10]
}
 bc4:	054b0705 	strbeq	r0, [fp, #-1797]	@ 0xfffff8fb
 bc8:	05056606 	streq	r6, [r5, #-1542]	@ 0xfffff9fa
 bcc:	01054b4a 	tsteq	r5, sl, asr #22
uint32_t Hal_timer_get_1ms_counter(void) {
 bd0:	00060230 	andeq	r0, r6, r0, lsr r2
 bd4:	01250101 			@ <UNDEFINED> instruction: 0x01250101
  return internal_1ms_counter;
 bd8:	00030000 	andeq	r0, r3, r0
 bdc:	00000040 	andeq	r0, r0, r0, asr #32
 be0:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
}
 be4:	0101000d 	tsteq	r1, sp
 be8:	00000101 	andeq	r0, r0, r1, lsl #2
 bec:	00000100 	andeq	r0, r0, r0, lsl #2
 bf0:	72656b01 	rsbvc	r6, r5, #1024	@ 0x400
static void interrupt_handler(void) {
 bf4:	006c656e 	rsbeq	r6, ip, lr, ror #10
 bf8:	6c636e69 	stclvs	14, cr6, [r3], #-420	@ 0xfffffe5c
  ++internal_1ms_counter;
 bfc:	00656475 	rsbeq	r6, r5, r5, ror r4
 c00:	67736d00 	ldrbvs	r6, [r3, -r0, lsl #26]!
 c04:	0100632e 	tsteq	r0, lr, lsr #6
 c08:	74730000 	ldrbtvc	r0, [r3], #-0
 c0c:	746e6964 	strbtvc	r6, [lr], #-2404	@ 0xfffff69c
 c10:	0200682e 	andeq	r6, r0, #3014656	@ 0x2e0000
 c14:	736d0000 	cmnvc	sp, #0
  Timer->timerxintclr = 1;
 c18:	00682e67 	rsbeq	r2, r8, r7, ror #28
 c1c:	00000001 	andeq	r0, r0, r1
 c20:	05001d05 	streq	r1, [r0, #-3333]	@ 0xfffff2fb
 c24:	0017f002 	andseq	pc, r7, r2
 c28:	11051a00 	tstne	r5, r0, lsl #20
 c2c:	4a030567 	bmi	c21d0 <cpsr_cp+0xbef48>
 c30:	02001405 	andeq	r1, r0, #83886080	@ 0x5000000
 c34:	052f0304 	streq	r0, [pc, #-772]!	@ 938 <Hal_interrupt_disable+0x9c>
 c38:	04020013 	streq	r0, [r2], #-19	@ 0xffffffed
void Hal_uart_init(void) {
 c3c:	2c05f303 	stccs	3, cr15, [r5], {3}
 c40:	03040200 	movweq	r0, #16896	@ 0x4200
  Uart->uartcr.bits.UARTEN = 0;
 c44:	1a051e08 	bne	14846c <cpsr_cp+0x1451e4>
 c48:	01040200 	mrseq	r0, R12_usr
 c4c:	6a010566 	bvs	421ec <cpsr_cp+0x3ef64>
 c50:	059f2f05 	ldreq	r2, [pc, #3845]	@ 1b5d <Kernel_msgQ_dequeue+0x99>
 c54:	0c059f06 	stceq	15, cr9, [r5], {6}
 c58:	4c130567 	cfldr32mi	mvfx0, [r3], {103}	@ 0x67
  Uart->uartcr.bits.TXE = 1;
 c5c:	05d62905 	ldrbeq	r2, [r6, #2309]	@ 0x905
 c60:	0c05f206 	sfmeq	f7, 1, [r5], {6}
 c64:	4c0a054b 	cfstr32mi	mvfx0, [sl], {75}	@ 0x4b
 c68:	052f0105 	streq	r0, [pc, #-261]!	@ b6b <Hal_timer_init+0x13f>
 c6c:	0605832e 	streq	r8, [r5], -lr, lsr #6
 c70:	670c059f 			@ <UNDEFINED> instruction: 0x670c059f
  Uart->uartcr.bits.RXE = 1;
 c74:	054c1505 	strbeq	r1, [ip, #-1285]	@ 0xfffffafb
 c78:	2105f21c 	tstcs	r5, ip, lsl r2	@ <UNPREDICTABLE>
 c7c:	2e42052e 	cdpcs	5, 4, cr0, cr2, cr14, {1}
 c80:	05d60605 	ldrbeq	r0, [r6, #1541]	@ 0x605
 c84:	0a054b0c 	beq	1538bc <cpsr_cp+0x150634>
 c88:	2f01054c 	svccs	0x0001054c
  Uart->uartcr.bits.UARTEN = 1;
 c8c:	05833c05 	streq	r3, [r3, #3077]	@ 0xc05
 c90:	0c05f306 	stceq	3, cr15, [r5], {6}
 c94:	4c070567 	cfstr32mi	mvfx0, [r7], {103}	@ 0x67
 c98:	05820605 	streq	r0, [r2, #1541]	@ 0x605
 c9c:	11054b0c 	tstne	r5, ip, lsl #22
 ca0:	f203054c 	vrshl.s8	q0, q6, <illegal reg q1.5>
  Uart->uartimsc.bits.RXIM = 1;
 ca4:	05f32405 	ldrbeq	r2, [r3, #1029]!	@ 0x405
 ca8:	0f05f22a 	svceq	0x0005f22a
 cac:	2e2f052e 	cfsh64cs	mvdx0, mvdx15, #30
 cb0:	d82e1505 	stmdale	lr!, {r0, r2, r8, sl, ip}
 cb4:	052e2205 	streq	r2, [lr, #-517]!	@ 0xfffffdfb
 cb8:	0a05f229 	beq	17d564 <cpsr_cp+0x17a2dc>
  Hal_interrupt_register_handler(interrupt_handler, UART_INTERRUPT0);
 cbc:	01052108 	tsteq	r5, r8, lsl #2
 cc0:	6741052f 	strbvs	r0, [r1, -pc, lsr #10]
 cc4:	05bb0605 	ldreq	r0, [fp, #1541]!	@ 0x605
 cc8:	0705670c 	streq	r6, [r5, -ip, lsl #14]
}
 ccc:	8206054c 	andhi	r0, r6, #76, 10	@ 0x13000000
 cd0:	054b0c05 	strbeq	r0, [fp, #-3077]	@ 0xfffff3fb
void Hal_uart_put_char(uint8_t ch) {
 cd4:	03054c11 	movweq	r4, #23569	@ 0x5c11
 cd8:	d72505d6 			@ <UNDEFINED> instruction: 0xd72505d6
 cdc:	05d62c05 	ldrbeq	r2, [r6, #3077]	@ 0xc05
 ce0:	31052e0f 	tstcc	r5, pc, lsl #28
 ce4:	2e16052e 	cfmul64cs	mvdx0, mvdx6, mvdx14
  while(Uart->uartfr.bits.TXFF);
 ce8:	05bc2105 	ldreq	r2, [ip, #261]!	@ 0x105
 cec:	21052e2e 	tstcs	r5, lr, lsr #28
 cf0:	f20d05d6 	vqrshl.s8	q0, q3, <illegal reg q14.5>
 cf4:	054c0a05 	strbeq	r0, [ip, #-2565]	@ 0xfffff5fb
 cf8:	06022f01 	streq	r2, [r2], -r1, lsl #30
 cfc:	c5010100 	strgt	r0, [r1, #-256]	@ 0xffffff00
 d00:	03000000 	movweq	r0, #0
 d04:	00004400 	andeq	r4, r0, r0, lsl #8
 d08:	fb010200 	blx	41512 <cpsr_cp+0x3e28a>
  Uart->uartdr.bits.DATA = (ch & 0xFF);
 d0c:	01000d0e 	tsteq	r0, lr, lsl #26
 d10:	00010101 	andeq	r0, r1, r1, lsl #2
 d14:	00010000 	andeq	r0, r1, r0
 d18:	656b0100 	strbvs	r0, [fp, #-256]!	@ 0xffffff00
 d1c:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
 d20:	636e6900 	cmnvs	lr, #0, 18
 d24:	6564756c 	strbvs	r7, [r4, #-1388]!	@ 0xfffffa94
}
 d28:	79730000 	ldmdbvc	r3!, {}^	@ <UNPREDICTABLE>
 d2c:	2e68636e 	cdpcs	3, 6, cr6, cr8, cr14, {3}
 d30:	00010063 	andeq	r0, r1, r3, rrx
 d34:	64747300 	ldrbtvs	r7, [r4], #-768	@ 0xfffffd00
uint8_t Hal_uart_get_char(void) {
 d38:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 d3c:	00020068 	andeq	r0, r2, r8, rrx
 d40:	6e797300 	cdpvs	3, 7, cr7, cr9, cr0, {0}
  while(Uart->uartfr.bits.RXFE);
 d44:	682e6863 	stmdavs	lr!, {r0, r1, r5, r6, fp, sp, lr}
 d48:	00000100 	andeq	r0, r0, r0, lsl #2
 d4c:	00230500 	eoreq	r0, r3, r0, lsl #10
 d50:	1be00205 	blne	ff80156c <cpsr_cp+0xff7fe2e4>
 d54:	05190000 	ldreq	r0, [r9, #-0]
 d58:	0b058330 	bleq	161a20 <cpsr_cp+0x15e798>
 d5c:	68080582 	stmdavs	r8, {r1, r7, r8, sl}
 d60:	05bb0105 	ldreq	r0, [fp, #261]!	@ 0x105
 d64:	0b05831c 	bleq	1619dc <cpsr_cp+0x15e754>
  data = Uart->uartdr.all;
 d68:	6605054b 	strvs	r0, [r5], -fp, asr #10
 d6c:	054b0c05 	strbeq	r0, [fp, #-3077]	@ 0xfffff3fb
 d70:	0a054c03 	beq	153d84 <cpsr_cp+0x150afc>
 d74:	2f0105d7 	svccs	0x000105d7
 d78:	05831f05 	streq	r1, [r3, #3845]	@ 0xf05
  if(data & 0xFFFFFF00) {
 d7c:	0b054b03 	bleq	153990 <cpsr_cp+0x150708>
 d80:	ba0505d7 	blt	1424e4 <cpsr_cp+0x13f25c>
 d84:	054b0a05 	strbeq	r0, [fp, #-2565]	@ 0xfffff5fb
    Uart->uartrsr.all = 0xFF;
 d88:	1e05bc01 	cdpne	12, 0, cr11, cr5, cr1, {0}
 d8c:	4b100585 	blmi	4023a8 <cpsr_cp+0x3ff120>
 d90:	05830f05 	streq	r0, [r3, #3845]	@ 0xf05
 d94:	28058301 	stmdacs	r5, {r0, r8, r9, pc}
 d98:	830c0583 	movwhi	r0, #50563	@ 0xc583
    return 0;
 d9c:	05660505 	strbeq	r0, [r6, #-1285]!	@ 0xfffffafb
 da0:	10054b0c 	andne	r4, r5, ip, lsl #22
  return (uint8_t)(data & 0xFF);
 da4:	830f054d 	movwhi	r0, #62797	@ 0xf54d
 da8:	05830a05 	streq	r0, [r3, #2565]	@ 0xa05
}
 dac:	2a052f01 	bcs	14c9b8 <cpsr_cp+0x149730>
 db0:	83160583 	tsthi	r6, #549453824	@ 0x20c00000
 db4:	05660605 	strbeq	r0, [r6, #-1541]!	@ 0xfffff9fb
 db8:	0c056711 	stceq	7, cr6, [r5], {17}
static void interrupt_handler(void) {
 dbc:	4c0a0583 	cfstr32mi	mvfx0, [sl], {131}	@ 0x83
 dc0:	022f0105 	eoreq	r0, pc, #1073741825	@ 0x40000001
 dc4:	01010008 	tsteq	r1, r8
  uint8_t ch = Hal_uart_get_char();
 dc8:	00000150 	andeq	r0, r0, r0, asr r1
 dcc:	00420003 	subeq	r0, r2, r3
 dd0:	01020000 	mrseq	r0, (UNDEF: 2)
  if (ch == 'U') {
 dd4:	000d0efb 	strdeq	r0, [sp], -fp
 dd8:	01010101 	tsteq	r1, r1, lsl #2
 ddc:	01000000 	mrseq	r0, (UNDEF: 0)
    Kernel_send_events(KernelEventFlag_Unlock);
 de0:	6b010000 	blvs	40de8 <cpsr_cp+0x3db60>
 de4:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
    return;
 de8:	6e69006c 	cdpvs	0, 6, cr0, cr9, cr12, {3}
  if (ch == 'X') {
 dec:	64756c63 	ldrbtvs	r6, [r5], #-3171	@ 0xfffff39d
 df0:	74000065 	strvc	r0, [r0], #-101	@ 0xffffff9b
 df4:	2e6b7361 	cdpcs	3, 6, cr7, cr11, cr1, {3}
    Kernel_send_events(KernelEventFlag_CmdOut);
 df8:	00010063 	andeq	r0, r1, r3, rrx
 dfc:	64747300 	ldrbtvs	r7, [r4], #-768	@ 0xfffffd00
    return;
 e00:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
  Hal_uart_put_char(ch);
 e04:	00020068 	andeq	r0, r2, r8, rrx
 e08:	73617400 	cmnvc	r1, #0, 8
 e0c:	00682e6b 	rsbeq	r2, r8, fp, ror #28
  Kernel_send_msg(KernelMsgQ_Task0, &ch, 1);
 e10:	00000001 	andeq	r0, r0, r1
 e14:	05001d05 	streq	r1, [r0, #-3333]	@ 0xfffff2fb
 e18:	001de002 	andseq	lr, sp, r2
 e1c:	01110300 	tsteq	r1, r0, lsl #6
 e20:	05671805 	strbeq	r1, [r7, #-2053]!	@ 0xfffff7fb
  Kernel_send_events(KernelEventFlag_UartIn);
 e24:	03058316 	movweq	r8, #21270	@ 0x5316
 e28:	052f2f84 	streq	r2, [pc, #-3972]!	@ fffffeac <cpsr_cp+0xffffcc24>
 e2c:	03053011 	movweq	r3, #20497	@ 0x5011
 e30:	003c054a 	eorseq	r0, ip, sl, asr #10
void enable_irq(void) {
 e34:	2f030402 	svccs	0x00030402
 e38:	02002005 	andeq	r2, r0, #5
  __asm__ ("PUSH {r0, r1}");
 e3c:	05660304 	strbeq	r0, [r6, #-772]!	@ 0xfffffcfc
  __asm__ ("MRS r0, cpsr");
 e40:	0402001e 	streq	r0, [r2], #-30	@ 0xffffffe2
  __asm__ ("BIC r1, r0, #0x80");
 e44:	2f052e03 	svccs	0x00052e03
  __asm__ ("MSR cpsr, r1");
 e48:	03040200 	movweq	r0, #16896	@ 0x4200
  __asm__ ("POP {r0, r1}");
 e4c:	005105bb 	ldrheq	r0, [r1], #-91	@ 0xffffffa5
}
 e50:	ba030402 	blt	c1e60 <cpsr_cp+0xbebd8>
 e54:	02001605 	andeq	r1, r0, #5242880	@ 0x500000
 e58:	054a0304 	strbeq	r0, [sl, #-772]	@ 0xfffffcfc
 e5c:	04020012 	streq	r0, [r2], #-18	@ 0xffffffee
void enable_fiq(void) {
 e60:	16058403 	strne	r8, [r5], -r3, lsl #8
 e64:	03040200 	movweq	r0, #16896	@ 0x4200
  __asm__ ("PUSH {r0, r1}");
 e68:	00430582 	subeq	r0, r3, r2, lsl #11
  __asm__ ("MRS r0, cpsr");
 e6c:	9f030402 	svcls	0x00030402
  __asm__ ("BIC r1, r0, #0x40");
 e70:	02001a05 	andeq	r1, r0, #20480	@ 0x5000
  __asm__ ("MSR cpsr, r1");
 e74:	05820304 	streq	r0, [r2, #772]	@ 0x304
  __asm__ ("POP {r0, r1}");
 e78:	0402000f 	streq	r0, [r2], #-15
}
 e7c:	2a052f03 	bcs	14ca90 <cpsr_cp+0x149808>
 e80:	03040200 	movweq	r0, #16896	@ 0x4200
 e84:	059e7a03 	ldreq	r7, [lr, #2563]	@ 0xa03
 e88:	0402001a 	streq	r0, [r2], #-26	@ 0xffffffe6
void disable_irq(void) {
 e8c:	01056601 	tsteq	r5, r1, lsl #12
 e90:	a039056e 	eorsge	r0, r9, lr, ror #10
  __asm__ ("PUSH {r0, r1}");
 e94:	05833a05 	streq	r3, [r3, #2565]	@ 0xa05
  __asm__ ("MRS r0, cpsr");
 e98:	1c05d610 	stcne	6, cr13, [r5], {16}
  __asm__ ("ORR r1, r0, #0x80");
 e9c:	660605a0 	strvs	r0, [r6], -r0, lsr #11
  __asm__ ("MSR cpsr, r1");
 ea0:	054b0c05 	strbeq	r0, [fp, #-3077]	@ 0xfffff3fb
  __asm__ ("POP {r0, r1}");
 ea4:	18054d3b 	stmdane	r5, {r0, r1, r3, r4, r5, r8, sl, fp, lr}
}
 ea8:	2f0d054a 	svccs	0x000d054a
 eac:	052e0b05 	streq	r0, [lr, #-2821]!	@ 0xfffff4fb
 eb0:	01054c20 	tsteq	r5, r0, lsr #24
 eb4:	84230583 	strthi	r0, [r3], #-1411	@ 0xfffffa7d
void disable_fiq(void) {
 eb8:	054b1d05 	strbeq	r1, [fp, #-3333]	@ 0xfffff2fb
 ebc:	10056612 	andne	r6, r5, r2, lsl r6
  __asm__ ("PUSH {r0, r1}");
 ec0:	670f0582 	strvs	r0, [pc, -r2, lsl #11]
  __asm__ ("MRS r0, cpsr");
 ec4:	054a0d05 	strbeq	r0, [sl, #-3333]	@ 0xfffff2fb
  __asm__ ("ORR r1, r0, #0x40");
 ec8:	01056803 	tsteq	r5, r3, lsl #16
  __asm__ ("MSR cpsr, r1");
 ecc:	4c1e052f 	cfldr32mi	mvfx0, [lr], {47}	@ 0x2f
  __asm__ ("POP {r0, r1}");
 ed0:	054b1a05 	strbeq	r1, [fp, #-2565]	@ 0xfffff5fb
 ed4:	0d05660f 	stceq	6, cr6, [r5, #-60]	@ 0xffffffc4
 ed8:	67030582 	strvs	r0, [r3, -r2, lsl #11]
 edc:	2f302f2f 	svccs	0x00302f2f
 ee0:	01052f2f 	tsteq	r5, pc, lsr #30
uint32_t putstr(const char* s) {
 ee4:	8430052f 	ldrthi	r0, [r0], #-1327	@ 0xfffffad1
 ee8:	054b0a05 	strbeq	r0, [fp, #-2565]	@ 0xfffff5fb
 eec:	31056701 	tstcc	r5, r1, lsl #14
 ef0:	4b030584 	blmi	c2508 <cpsr_cp+0xbf280>
  uint32_t c = 0;
 ef4:	05d71605 	ldrbeq	r1, [r7, #1541]	@ 0x605
 ef8:	05ae0815 	streq	r0, [lr, #2069]!	@ 0x815
  while(*s) {
 efc:	0105660a 	tsteq	r5, sl, lsl #12
    Hal_uart_put_char(*s++);
 f00:	4c490583 	cfstr64mi	mvdx0, [r9], {131}	@ 0x83
 f04:	2f160305 	svccs	0x00160305
 f08:	2f302f2f 	svccs	0x00302f2f
 f0c:	2f2f332f 	svccs	0x002f332f
 f10:	2f2f2f30 	svccs	0x002f2f30
 f14:	022f0105 	eoreq	r0, pc, #1073741825	@ 0x40000001
    ++c;
 f18:	01010008 	tsteq	r1, r8
 f1c:	00000063 	andeq	r0, r0, r3, rrx
 f20:	00040005 	andeq	r0, r4, r5
  while(*s) {
 f24:	0000002e 	andeq	r0, r0, lr, lsr #32
 f28:	fb010102 	blx	4133a <cpsr_cp+0x3e0b2>
 f2c:	01000d0e 	tsteq	r0, lr, lsl #26
 f30:	00010101 	andeq	r0, r1, r1, lsl #2
  return c;
 f34:	00010000 	andeq	r0, r1, r0
}
 f38:	01010100 	mrseq	r0, (UNDEF: 17)
 f3c:	0021021f 	eoreq	r0, r1, pc, lsl r2
 f40:	00780000 	rsbseq	r0, r8, r0
uint32_t debug_printf(const char* format, ...) { 
 f44:	01020000 	mrseq	r0, (UNDEF: 2)
 f48:	020f021f 	andeq	r0, pc, #-268435455	@ 0xf0000001
 f4c:	00000093 	muleq	r0, r3, r0
 f50:	00009301 	andeq	r9, r0, r1, lsl #6
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
 f54:	05000100 	streq	r0, [r0, #-256]	@ 0xffffff00
 f58:	00212002 	eoreq	r2, r1, r2
  vsprintf(printf_buf, format, args);
 f5c:	08cf0300 	stmiaeq	pc, {r8, r9}^	@ <UNPREDICTABLE>
 f60:	2f2f3001 	svccs	0x002f3001
 f64:	302f2f2f 	eorcc	r2, pc, pc, lsr #30
 f68:	2f143e02 	svccs	0x00143e02
 f6c:	302f2f31 	eorcc	r2, pc, r1, lsr pc	@ <UNPREDICTABLE>
  return putstr(printf_buf);
 f70:	322f9208 	eorcc	r9, pc, #8, 4	@ 0x80000000
 f74:	2f661f03 	svccs	0x00661f03
 f78:	2f2f2f2f 	svccs	0x002f2f2f
 f7c:	02022f2f 	andeq	r2, r2, #47, 30	@ 0xbc
}
 f80:	46010100 	strmi	r0, [r1], -r0, lsl #2
 f84:	05000000 	streq	r0, [r0, #-0]
 f88:	2e000400 	cfcpyscs	mvf0, mvf0
 f8c:	02000000 	andeq	r0, r0, #0
 f90:	0efb0101 	cdpeq	1, 15, cr0, cr11, cr1, {0}
uint32_t vsprintf(char* buf, const char* format, va_list arg) {
 f94:	0101000d 	tsteq	r1, sp
 f98:	00000101 	andeq	r0, r0, r1, lsl #2
 f9c:	00000100 	andeq	r0, r0, r0, lsl #2
 fa0:	1f010101 	svcne	0x00010101
 fa4:	00002102 	andeq	r2, r0, r2, lsl #2
 fa8:	00007800 	andeq	r7, r0, r0, lsl #16
  uint32_t c = 0;
 fac:	1f010200 	svcne	0x00010200
 fb0:	93020f02 	movwls	r0, #12034	@ 0x2f02
  for (uint32_t i = 0; format[i]; ++i) {
 fb4:	01000000 	mrseq	r0, (UNDEF: 0)
 fb8:	00000093 	muleq	r0, r3, r0
 fbc:	02050001 	andeq	r0, r5, #1
    if (format[i] == '%') {
 fc0:	00002234 	andeq	r2, r0, r4, lsr r2
 fc4:	010bb903 	tsteq	fp, r3, lsl #18
 fc8:	01000202 	tsteq	r0, r2, lsl #4
 fcc:	Address 0xfcc is out of bounds.


Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
    LDR PC, reset_handler_addr
   0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	@ ffffff4c <cpsr_cp+0xffffccc4>
    LDR PC, undef_handler_addr
   4:	696a2f65 	stmdbvs	sl!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
    LDR PC, svc_handler_addr
   8:	6579686e 	ldrbvs	r6, [r9, #-2158]!	@ 0xfffff792
    LDR PC, pfch_abt_handler_addr
   c:	722f6b6f 	eorvc	r6, pc, #113664	@ 0x1bc00
    LDR PC, data_abt_handler_addr
  10:	00736f74 	rsbseq	r6, r3, r4, ror pc
    B .
  14:	746f6f62 	strbtvc	r6, [pc], #-3938	@ 1c <vector_start+0x1c>
    LDR PC, irq_handler_addr
  18:	746e4500 	strbtvc	r4, [lr], #-1280	@ 0xfffffb00
    LDR PC, fiq_handler_addr
  1c:	532e7972 			@ <UNDEFINED> instruction: 0x532e7972
  20:	75622f00 	strbvc	r2, [r2, #-3840]!	@ 0xfffff100
  24:	2f646c69 	svccs	0x00646c69
  28:	2d636367 	stclcs	3, cr6, [r3, #-412]!	@ 0xfffffe64
  2c:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	@ 0xfffffe7c
  30:	656e6f6e 	strbvs	r6, [lr, #-3950]!	@ 0xfffff092
  34:	6261652d 	rsbvs	r6, r1, #188743680	@ 0xb400000
  38:	79782d69 	ldmdbvc	r8!, {r0, r3, r5, r6, r8, sl, fp, sp}^
    MRS r0, cpsr @ move PSR to Register
  3c:	58747056 	ldmdapl	r4!, {r1, r2, r4, r6, ip, sp, lr}^
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	6363672f 	cmnvs	r3, #12320768	@ 0xbc0000
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	6d72612d 	ldfvse	f6, [r2, #-180]!	@ 0xffffff4c
    MSR cpsr, r1 @ 동작 모드 변경
  48:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	61652d65 	cmnvs	r5, r5, ror #26
    MRS r0, cpsr
  50:	312d6962 			@ <UNDEFINED> instruction: 0x312d6962
    BIC r1, r0, #0x1F
  54:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	316c6572 	smccc	50770	@ 0xc652
    MSR cpsr, r1
  5c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
    LDR sp, =IRQ_STACK_TOP
  60:	612f646c 			@ <UNDEFINED> instruction: 0x612f646c
    MRS r0, cpsr
  64:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
    BIC r1, r0, #0x1F
  68:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	@ 0xfffffe44
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
    MSR cpsr, r1
  70:	62696c2f 	rsbvs	r6, r9, #12032	@ 0x2f00
    LDR sp, =FIQ_STACK_TOP
  74:	00636367 	rsbeq	r6, r3, r7, ror #6
    MRS r0, cpsr
  78:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
    BIC r1, r0, #0x1F
  7c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	62696c2f 	rsbvs	r6, r9, #12032	@ 0x2f00
    MSR cpsr, r1
  84:	2f636367 	svccs	0x00636367
    LDR sp, =ABT_STACK_TOP
  88:	666e6f63 	strbtvs	r6, [lr], -r3, ror #30
    MRS r0, cpsr
  8c:	612f6769 			@ <UNDEFINED> instruction: 0x612f6769
    BIC r1, r0, #0x1F
  90:	6c006d72 	stcvs	13, cr6, [r0], {114}	@ 0x72
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	66316269 	ldrtvs	r6, [r1], -r9, ror #4
    MSR cpsr, r1
  98:	73636e75 	cmnvc	r3, #1872	@ 0x750
    LDR sp, =UND_STACK_TOP
  9c:	Address 0x9c is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
    LDR PC, reset_handler_addr
       0:	00000021 	andeq	r0, r0, r1, lsr #32
    LDR PC, undef_handler_addr
       4:	04010005 	streq	r0, [r1], #-5
    LDR PC, svc_handler_addr
       8:	00000000 	andeq	r0, r0, r0
    LDR PC, pfch_abt_handler_addr
       c:	00000001 	andeq	r0, r0, r1
    LDR PC, data_abt_handler_addr
      10:	00000000 	andeq	r0, r0, r0
    B .
      14:	0001d400 	andeq	sp, r1, r0, lsl #8
    LDR PC, irq_handler_addr
      18:	0d000000 	stceq	0, cr0, [r0, #-0]
    LDR PC, fiq_handler_addr
      1c:	21000000 	mrscs	r0, (UNDEF: 0)
      20:	01000000 	mrseq	r0, (UNDEF: 0)
      24:	00008780 	andeq	r8, r0, r0, lsl #15
      28:	01000500 	tsteq	r0, r0, lsl #10
      2c:	00001404 	andeq	r1, r0, r4, lsl #8
      30:	00be0200 	adcseq	r0, lr, r0, lsl #4
      34:	6a1d0000 	bvs	74003c <cpsr_cp+0x73cdb4>
      38:	0d000000 	stceq	0, cr0, [r0, #-0]
    MRS r0, cpsr @ move PSR to Register
      3c:	d4000000 	strle	r0, [r0], #-0
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
      40:	24000000 	strcs	r0, [r0], #-0
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
      44:	7a000000 	bvc	4c <vector_end+0x10>
    MSR cpsr, r1 @ 동작 모드 변경
      48:	01000000 	mrseq	r0, (UNDEF: 0)
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      4c:	005e0601 	subseq	r0, lr, r1, lsl #12
    MRS r0, cpsr
      50:	02010000 	andeq	r0, r1, #0
    BIC r1, r0, #0x1F
      54:	0000b405 	andeq	fp, r0, r5, lsl #8
    ORR r1, r1, #ARM_MODE_BIT_IRQ
      58:	05040300 	streq	r0, [r4, #-768]	@ 0xfffffd00
    MSR cpsr, r1
      5c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    LDR sp, =IRQ_STACK_TOP
      60:	79050801 	stmdbvc	r5, {r0, fp}
    MRS r0, cpsr
      64:	01000000 	mrseq	r0, (UNDEF: 0)
    BIC r1, r0, #0x1F
      68:	005c0801 	subseq	r0, ip, r1, lsl #16
    ORR r1, r1, #ARM_MODE_BIT_FIQ
      6c:	02010000 	andeq	r0, r1, #0
    MSR cpsr, r1
      70:	00008707 	andeq	r8, r0, r7, lsl #14
    LDR sp, =FIQ_STACK_TOP
      74:	07040100 	streq	r0, [r4, -r0, lsl #2]
    MRS r0, cpsr
      78:	00000043 	andeq	r0, r0, r3, asr #32
    BIC r1, r0, #0x1F
      7c:	39070801 	stmdbcc	r7, {r0, fp}
    ORR r1, r1, #ARM_MODE_BIT_ABT
      80:	04000000 	streq	r0, [r0], #-0
    MSR cpsr, r1
      84:	0000009a 	muleq	r0, sl, r0
    LDR sp, =ABT_STACK_TOP
      88:	05060e02 	streq	r0, [r6, #-3586]	@ 0xfffff1fe
    MRS r0, cpsr
      8c:	00000050 	andeq	r0, r0, r0, asr r0
    BIC r1, r0, #0x1F
      90:	f02a0901 			@ <UNDEFINED> instruction: 0xf02a0901
    ORR r1, r1, #ARM_MODE_BIT_UND
      94:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    MSR cpsr, r1
      98:	01000000 	mrseq	r0, (UNDEF: 0)
    LDR sp, =UND_STACK_TOP
      9c:	002d069c 	mlaeq	sp, ip, r6, r0
    MRS r0, cpsr
      a0:	05010000 	streq	r0, [r1, #-0]
    BIC r1, r0, #0x1F
      a4:	0000d42a 	andeq	sp, r0, sl, lsr #8
    ORR r1, r1, #ARM_MODE_BIT_SYS
      a8:	00001c00 	andeq	r1, r0, r0, lsl #24
    MSR cpsr, r1
      ac:	009c0100 	addseq	r0, ip, r0, lsl #2
    LDR sp, =USRSYS_STACK_TOP
      b0:	000001f3 	strdeq	r0, [r0], -r3
    BL main
      b4:	04010005 	streq	r0, [r1], #-5
    B .
      b8:	00000083 	andeq	r0, r0, r3, lsl #1
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      bc:	0000be0b 	andeq	fp, r0, fp, lsl #28
    LDR sp, =IRQ_STACK_TOP
      c0:	01d61d00 	bicseq	r1, r6, r0, lsl #26
    LDR sp, =FIQ_STACK_TOP
      c4:	000d0000 	andeq	r0, sp, r0
    LDR sp, =ABT_STACK_TOP
      c8:	00f80000 	rscseq	r0, r8, r0
    LDR sp, =UND_STACK_TOP
      cc:	019c0000 	orrseq	r0, ip, r0
    LDR sp, =USRSYS_STACK_TOP
      d0:	00d80000 	sbcseq	r0, r8, r0
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
      d4:	01020000 	mrseq	r0, (UNDEF: 2)
      d8:	00005e06 	andeq	r5, r0, r6, lsl #28
      dc:	05020200 	streq	r0, [r2, #-512]	@ 0xfffffe00
  Hal_interrupt_run_handler();
      e0:	000000b4 	strheq	r0, [r0], -r4
}
      e4:	00024904 	andeq	r4, r2, r4, lsl #18
      e8:	0f0d0200 	svceq	0x000d0200
      ec:	00000040 	andeq	r0, r0, r0, asr #32
__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
      f0:	6905040c 	stmdbvs	r5, {r2, r3, sl}
  while (true);
      f4:	0200746e 	andeq	r7, r0, #1845493760	@ 0x6e000000
void main(void) {
      f8:	00790508 	rsbseq	r0, r9, r8, lsl #10
      fc:	fc040000 	stc2	0, cr0, [r4], {-0}
     100:	02000001 	andeq	r0, r0, #1
  Hw_init();
     104:	005a1817 	subseq	r1, sl, r7, lsl r8
  Kernel_init();
     108:	01020000 	mrseq	r0, (UNDEF: 2)
  uint32_t i = 100;
     10c:	00005c08 	andeq	r5, r0, r8, lsl #24
     110:	07020200 	streq	r0, [r2, -r0, lsl #4]
  while(i--) {
     114:	00000087 	andeq	r0, r0, r7, lsl #1
    Hal_uart_put_char('N');
     118:	00024804 	andeq	r4, r2, r4, lsl #16
     11c:	171a0200 	ldrne	r0, [sl, -r0, lsl #4]
  while(i--) {
     120:	00000074 	andeq	r0, r0, r4, ror r0
     124:	43070402 	movwmi	r0, #29698	@ 0x7402
     128:	02000000 	andeq	r0, r0, #0
     12c:	00390708 	eorseq	r0, r9, r8, lsl #14
     130:	87060000 	strhi	r0, [r6, -r0]
  Hal_uart_put_char('\n');
     134:	0d000000 	stceq	0, cr0, [r0, #-0]
     138:	00017d04 	andeq	r7, r1, r4, lsl #26
  putstr("Hello World!\n");
     13c:	10160300 	andsne	r0, r6, r0, lsl #6
     140:	00000082 	andeq	r0, r0, r2, lsl #1
     144:	51020102 	tstpl	r2, r2, lsl #2
  Printf_test();
     148:	08000002 	stmdaeq	r0, {r1}
  Hal_interrupt_enable(UART_INTERRUPT0);
     14c:	00000204 	andeq	r0, r0, r4, lsl #4
     150:	0000680d 	andeq	r6, r0, sp, lsl #16
  Kernel_start();
     154:	0000b000 	andeq	fp, r0, r0
}
     158:	00b00300 	adcseq	r0, r0, r0, lsl #6
     15c:	00090000 	andeq	r0, r9, r0
     160:	0000bc06 	andeq	fp, r0, r6, lsl #24
static void Hw_init(void){
     164:	08010200 	stmdaeq	r1, {r9}
     168:	00000065 	andeq	r0, r0, r5, rrx
  Hal_interrupt_init();
     16c:	0000b50e 	andeq	fp, r0, lr, lsl #10
  Hal_uart_init();
     170:	023d0100 	eorseq	r0, sp, #0, 2
  Hal_timer_init();
     174:	07040000 	streq	r0, [r4, -r0]
}
     178:	00021101 	andeq	r1, r2, r1, lsl #2
     17c:	01060400 	tsteq	r6, r0, lsl #8
static void Kernel_init(void) {
     180:	00000232 	andeq	r0, r0, r2, lsr r2
     184:	e7050504 	str	r0, [r5, -r4, lsl #10]
  Kernel_task_init();
     188:	04000001 	streq	r0, [r0], #-1
  Kernel_event_flag_init();
     18c:	0000ec03 	andeq	lr, r0, r3, lsl #24
  Kernel_msgQ_init();
     190:	00880300 	addeq	r0, r8, r0, lsl #6
  Kernel_sem_init(1);
     194:	68030000 	stmdavs	r3, {}	@ <UNPREDICTABLE>
     198:	00000000 	andeq	r0, r0, r0
  Kernel_mutex_init();
     19c:	00025f01 	andeq	r5, r2, r1, lsl #30
  add_task(User_task0, 0);
     1a0:	05100500 	ldreq	r0, [r0, #-1280]	@ 0xfffffb00
     1a4:	0000018e 	andeq	r0, r0, lr, lsl #3
     1a8:	01040705 	tsteq	r4, r5, lsl #14
     1ac:	34030000 	strcc	r0, [r3], #-0
  add_task(User_task1, 1);
     1b0:	00000000 	andeq	r0, r0, r0
     1b4:	00015901 	andeq	r5, r1, r1, lsl #18
     1b8:	01170600 	tsteq	r7, r0, lsl #12
     1bc:	00000142 	andeq	r0, r0, r2, asr #2
  add_task(User_task2, 2);
     1c0:	c5012b07 	strgt	r2, [r1, #-2823]	@ 0xfffff4f9
     1c4:	03000001 	movweq	r0, #1
     1c8:	02230f18 	eoreq	r0, r3, #24, 30	@ 0x60
     1cc:	040c0000 	streq	r0, [ip], #-0
}
     1d0:	00012706 	andeq	r2, r1, r6, lsl #14
     1d4:	01000900 	tsteq	r0, r0, lsl #18
static void Printf_test(void) {
     1d8:	000001b7 			@ <UNDEFINED> instruction: 0x000001b7
     1dc:	6a010408 	bvs	41204 <cpsr_cp+0x3df7c>
     1e0:	09000001 	stmdbeq	r0, {r0}
  char* str = "printf pointer test";
     1e4:	019e010a 	orrseq	r0, lr, sl, lsl #2
     1e8:	0a0a0000 	beq	2801f0 <cpsr_cp+0x27cf68>
     1ec:	00012d05 	andeq	r2, r1, r5, lsl #26
  char* nullptr = 0;
     1f0:	4d0b0900 	vstrmi.16	s0, [fp, #-0]	@ <UNPREDICTABLE>
     1f4:	03000001 	movweq	r0, #1
  uint32_t i = 5;
     1f8:	00000068 	andeq	r0, r0, r8, rrx
     1fc:	021c0800 	andseq	r0, ip, #0, 16
  debug_printf("%s\n", "Hello printf");
     200:	680c0000 	stmdavs	ip, {}	@ <UNPREDICTABLE>
     204:	61000000 	mrsvs	r0, (UNDEF: 0)
     208:	03000001 	movweq	r0, #1
     20c:	000000b0 	strheq	r0, [r0], -r0	@ <UNPREDICTABLE>
     210:	01130500 	tsteq	r3, r0, lsl #10
  debug_printf("output string pointer: %s\n", str);
     214:	05080000 	streq	r0, [r8, #-0]
     218:	00000172 	andeq	r0, r0, r2, ror r1
     21c:	00004e03 	andeq	r4, r0, r3, lsl #28
     220:	f0100000 			@ <UNDEFINED> instruction: 0xf0100000
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
     224:	01000001 	tsteq	r0, r1
     228:	01d80d37 	bicseq	r0, r8, r7, lsr sp
     22c:	00bc0000 	adcseq	r0, ip, r0
     230:	9c010000 	stcls	0, cr0, [r1], {-0}
     234:	000001b2 			@ <UNDEFINED> instruction: 0x000001b2
  debug_printf("%u = 5\n", i);
     238:	72747307 	rsbsvc	r7, r4, #469762048	@ 0x1c000000
     23c:	b2093800 	andlt	r3, r9, #0, 16
     240:	02000001 	andeq	r0, r0, #1
     244:	57117491 			@ <UNDEFINED> instruction: 0x57117491
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
     248:	01000002 	tsteq	r0, r2
     24c:	01b20939 			@ <UNDEFINED> instruction: 0x01b20939
     250:	91020000 	mrsls	r0, (UNDEF: 2)
     254:	00690770 	rsbeq	r0, r9, r0, ror r7
     258:	00680c3a 	rsbeq	r0, r8, sl, lsr ip
  debug_printf("print zero %u\n", 0);
     25c:	91020000 	mrsls	r0, (UNDEF: 2)
     260:	b506006c 	strlt	r0, [r6, #-108]	@ 0xffffff94
     264:	0a000000 	beq	26c <Printf_test+0x94>
     268:	000001ab 	andeq	r0, r0, fp, lsr #3
  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
     26c:	0001802c 	andeq	r8, r1, ip, lsr #32
     270:	00005800 	andeq	r5, r0, r0, lsl #16
     274:	0a9c0100 	beq	fe70067c <cpsr_cp+0xfe6fd3f4>
     278:	00000125 	andeq	r0, r0, r5, lsr #2
     27c:	00016426 	andeq	r6, r1, r6, lsr #8
     280:	00001c00 	andeq	r1, r0, r0, lsl #24
     284:	129c0100 	addsne	r0, ip, #0, 2
     288:	000001e2 	andeq	r0, r0, r2, ror #3
     28c:	f8061401 			@ <UNDEFINED> instruction: 0xf8061401
     290:	6c000000 	stcvs	0, cr0, [r0], {-0}
     294:	01000000 	mrseq	r0, (UNDEF: 0)
     298:	0069079c 	mlseq	r9, ip, r7, r0
     29c:	00680c18 	rsbeq	r0, r8, r8, lsl ip
     2a0:	91020000 	mrsls	r0, (UNDEF: 2)
     2a4:	31000074 	tstcc	r0, r4, ror r0
     2a8:	05000004 	streq	r0, [r0, #-4]
     2ac:	a4040100 	strge	r0, [r4], #-256	@ 0xffffff00
     2b0:	11000001 	tstne	r0, r1
     2b4:	000000be 	strheq	r0, [r0], -lr
     2b8:	0002f81d 	andeq	pc, r2, sp, lsl r8	@ <UNPREDICTABLE>
     2bc:	00000d00 	andeq	r0, r0, r0, lsl #26
     2c0:	00034000 	andeq	r4, r3, r0
     2c4:	00034c00 	andeq	r4, r3, r0, lsl #24
     2c8:	00020100 	andeq	r0, r2, r0, lsl #2
     2cc:	06010500 	streq	r0, [r1], -r0, lsl #10
     2d0:	0000005e 	andeq	r0, r0, lr, asr r0
     2d4:	b4050205 	strlt	r0, [r5], #-517	@ 0xfffffdfb
     2d8:	12000000 	andne	r0, r0, #0
     2dc:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     2e0:	08050074 	stmdaeq	r5, {r2, r4, r5, r6}
     2e4:	00007905 	andeq	r7, r0, r5, lsl #18
     2e8:	01fc0700 	mvnseq	r0, r0, lsl #14
     2ec:	17020000 	strne	r0, [r2, -r0]
     2f0:	00004e18 	andeq	r4, r0, r8, lsl lr
     2f4:	08010500 	stmdaeq	r1, {r8, sl}
     2f8:	0000005c 	andeq	r0, r0, ip, asr r0
     2fc:	87070205 	strhi	r0, [r7, -r5, lsl #4]
     300:	07000000 	streq	r0, [r0, -r0]
     304:	00000248 	andeq	r0, r0, r8, asr #4
     308:	68171a02 	ldmdavs	r7, {r1, r9, fp, ip}
     30c:	05000000 	streq	r0, [r0, #-0]
     310:	00430704 	subeq	r0, r3, r4, lsl #14
     314:	08050000 	stmdaeq	r5, {}	@ <UNPREDICTABLE>
     318:	00003907 	andeq	r3, r0, r7, lsl #18
     31c:	017d0700 	cmneq	sp, r0, lsl #14
     320:	16030000 	strne	r0, [r3], -r0
     324:	00008210 	andeq	r8, r0, r0, lsl r2
     328:	00870c00 	addeq	r0, r7, r0, lsl #24
     32c:	14130000 	ldrne	r0, [r3], #-0
     330:	041b0d04 	ldreq	r0, [fp], #-3332	@ 0xfffff2fc
     334:	68040000 	stmdavs	r4, {}	@ <UNPREDICTABLE>
     338:	04000000 	streq	r0, [r0], #-0
     33c:	00019906 	andeq	r9, r1, r6, lsl #18
void add_task(KernelTaskFunc_t f, uint32_t t_id) {
     340:	05530200 	ldrbeq	r0, [r3, #-512]	@ 0xfffffe00
     344:	02010000 	andeq	r0, r1, #0
     348:	00000312 	andeq	r0, r0, r2, lsl r3
     34c:	06570202 	ldrbeq	r0, [r7], -r2, lsl #4
     350:	02040000 	andeq	r0, r4, #0
  taskId = Kernel_task_create(f);
     354:	0000073b 	andeq	r0, r0, fp, lsr r7
     358:	06900208 	ldreq	r0, [r0], r8, lsl #4
     35c:	02100000 	andseq	r0, r0, #0
  if (taskId == NOT_ENOUGH_TASK_NUM) {
     360:	000006ab 	andeq	r0, r0, fp, lsr #13
     364:	06c60220 	strbeq	r0, [r6], r0, lsr #4
     368:	02400000 	subeq	r0, r0, #0
    debug_printf("Task%u creation fail\n", t_id);
     36c:	000006e1 	andeq	r0, r0, r1, ror #13
     370:	06fc0680 	ldrbteq	r0, [ip], r0, lsl #13
     374:	01000000 	mrseq	r0, (UNDEF: 0)
     378:	00071706 	andeq	r1, r7, r6, lsl #14
}
     37c:	06020000 	streq	r0, [r2], -r0
     380:	0000057d 	andeq	r0, r0, sp, ror r5
     384:	28060400 	stmdacs	r6, {sl}
static void Test_critical_section(uint32_t p, uint32_t taskId) {
     388:	00000003 	andeq	r0, r0, r3
     38c:	03430608 	movteq	r0, #13832	@ 0x3608
     390:	10000000 	andne	r0, r0, r0
     394:	00035e06 	andeq	r5, r3, r6, lsl #28
     398:	06200000 	strteq	r0, [r0], -r0
  Kernel_lock_mutex();
     39c:	00000379 	andeq	r0, r0, r9, ror r3
  debug_printf("User Task #%u Send=%u\n", taskId, p);
     3a0:	94064000 	strls	r4, [r6], #-0
     3a4:	00000003 	andeq	r0, r0, r3
     3a8:	03af0180 			@ <UNDEFINED> instruction: 0x03af0180
     3ac:	00000000 	andeq	r0, r0, r0
     3b0:	ca010001 	bgt	403bc <cpsr_cp+0x3d134>
  shared_value = p;
     3b4:	00000003 	andeq	r0, r0, r3
     3b8:	01000200 	mrseq	r0, R8_usr
     3bc:	000003e5 	andeq	r0, r0, r5, ror #7
     3c0:	00040000 	andeq	r0, r4, r0
  Kernel_yield();
     3c4:	00040001 	andeq	r0, r4, r1
  delay(1000);
     3c8:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
     3cc:	04600100 	strbteq	r0, [r0], #-256	@ 0xffffff00
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
     3d0:	00000000 	andeq	r0, r0, r0
     3d4:	7b010010 	blvc	4041c <cpsr_cp+0x3d194>
     3d8:	00000004 	andeq	r0, r0, r4
     3dc:	01002000 	mrseq	r2, (UNDEF: 0)
     3e0:	00000496 	muleq	r0, r6, r4
     3e4:	00400000 	subeq	r0, r0, r0
     3e8:	0004b101 	andeq	fp, r4, r1, lsl #2
     3ec:	80000000 	andhi	r0, r0, r0
  Kernel_unlock_mutex();
     3f0:	04cc0100 	strbeq	r0, [ip], #256	@ 0x100
}
     3f4:	00000000 	andeq	r0, r0, r0
     3f8:	e7010100 	str	r0, [r1, -r0, lsl #2]
     3fc:	00000004 	andeq	r0, r0, r4
void User_task0(void) {
     400:	01020000 	mrseq	r0, (UNDEF: 2)
     404:	00000502 	andeq	r0, r0, r2, lsl #10
     408:	04000000 	streq	r0, [r0], #-0
  uint32_t local = 0;
     40c:	00051d01 	andeq	r1, r5, r1, lsl #26
     410:	00000000 	andeq	r0, r0, r0
  debug_printf("User Task #0 SP=0x%x\n", &local);
     414:	05380108 	ldreq	r0, [r8, #-264]!	@ 0xfffffef8
     418:	00000000 	andeq	r0, r0, r0
     41c:	c4011000 	strgt	r1, [r1], #-0
     420:	00000002 	andeq	r0, r0, r2
     424:	01200000 			@ <UNDEFINED> instruction: 0x01200000
  uint8_t cmdBufIdx = 0;
     428:	0000061b 	andeq	r0, r0, fp, lsl r6
     42c:	40000000 	andmi	r0, r0, r0
  uint8_t uartch = 0;
     430:	00063601 	andeq	r3, r6, r1, lsl #12
     434:	00000000 	andeq	r0, r0, r0
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
     438:	02780280 	rsbseq	r0, r8, #128, 4
     43c:	00000000 	andeq	r0, r0, r0
     440:	00041b07 	andeq	r1, r4, r7, lsl #22
    switch(handle_event) {
     444:	03290400 			@ <UNDEFINED> instruction: 0x03290400
     448:	0000008a 	andeq	r0, r0, sl, lsl #1
     44c:	0005ac0d 	andeq	sl, r5, sp, lsl #24
     450:	004e0100 	subeq	r0, lr, r0, lsl #2
     454:	09050000 	stmdbeq	r5, {}	@ <UNPREDICTABLE>
     458:	000001ce 	andeq	r0, r0, lr, asr #3
     45c:	0005ce02 	andeq	ip, r5, r2, lsl #28
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
     460:	df020000 	svcle	0x00020000
     464:	01000005 	tsteq	r0, r5
     468:	0005f002 	andeq	pc, r5, r2
     46c:	e9020200 	stmdb	r2, {r9}
     470:	03000002 	movweq	r0, #2
      if (uartch == '\r') {
     474:	05ac0700 	streq	r0, [ip, #1792]!	@ 0x700
     478:	0f050000 	svceq	0x00050000
     47c:	0001a503 	andeq	sl, r1, r3, lsl #10
        cmdBuf[cmdBufIdx] = '\0';
     480:	06010300 	streq	r0, [r1], -r0, lsl #6
     484:	11110000 	tstne	r1, r0
     488:	0000005c 	andeq	r0, r0, ip, asr r0
     48c:	22480305 	subcs	r0, r8, #335544320	@ 0x14000000
     490:	3b090000 	blcc	240498 <cpsr_cp+0x23d210>
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     494:	11000004 	tstne	r0, r4
     498:	00028e0e 	andeq	r8, r2, lr, lsl #28
     49c:	020c0600 	andeq	r0, ip, #0, 12
     4a0:	04000002 	streq	r0, [r0], #-2
     4a4:	0000005c 	andeq	r0, r0, ip, asr r0
     4a8:	05b90800 	ldreq	r0, [r9, #2048]!	@ 0x800
     4ac:	0e060000 	cdpeq	0, 0, cr0, cr6, cr0, {0}
     4b0:	00022206 	andeq	r2, r2, r6, lsl #4
     4b4:	00022200 	andeq	r2, r2, r0, lsl #4
     4b8:	01ce0400 	biceq	r0, lr, r0, lsl #8
            Kernel_yield();
     4bc:	88040000 	stmdahi	r4, {}	@ <UNPREDICTABLE>
     4c0:	04000000 	streq	r0, [r0], #-0
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
     4c4:	0000005c 	andeq	r0, r0, ip, asr r0
     4c8:	02010500 	andeq	r0, r1, #0, 10
     4cc:	00000251 	andeq	r0, r0, r1, asr r2
     4d0:	00066e08 	andeq	r6, r6, r8, lsl #28
     4d4:	0a0f0600 	beq	3c1cdc <cpsr_cp+0x3bea54>
     4d8:	0000005c 	andeq	r0, r0, ip, asr r0
     4dc:	00000249 	andeq	r0, r0, r9, asr #4
     4e0:	0001ce04 	andeq	ip, r1, r4, lsl #28
     4e4:	00880400 	addeq	r0, r8, r0, lsl #8
     4e8:	5c040000 	stcpl	0, cr0, [r4], {-0}
     4ec:	00000000 	andeq	r0, r0, r0
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
     4f0:	00044d08 	andeq	r4, r4, r8, lsl #26
     4f4:	130d0600 	movwne	r0, #54784	@ 0xd600
     4f8:	00000199 	muleq	r0, r9, r1
     4fc:	0000025f 	andeq	r0, r0, pc, asr r2
     500:	00005c04 	andeq	r5, r0, r4, lsl #24
            Kernel_yield();
     504:	98090000 	stmdals	r9, {}	@ <UNPREDICTABLE>
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     508:	13000005 	movwne	r0, #5
            break;
     50c:	00030c0e 	andeq	r0, r3, lr, lsl #24
        Kernel_send_events(KernelEventFlag_CmdIn);
     510:	76040700 	strvc	r0, [r4], -r0, lsl #14
     514:	04000002 	streq	r0, [r0], #-2
        cmdBufIdx = 0;
     518:	0000005c 	andeq	r0, r0, ip, asr r0
     51c:	060e0900 	streq	r0, [lr], -r0, lsl #18
      break;
     520:	090b0000 	stmdbeq	fp, {}	@ <UNPREDICTABLE>
        cmdBuf[cmdBufIdx] = uartch;
     524:	0000067e 	andeq	r0, r0, lr, ror r6
     528:	02040812 	andeq	r0, r4, #1179648	@ 0x120000
     52c:	0d080000 	stceq	0, cr0, [r8, #-0]
     530:	00005c0a 	andeq	r5, r0, sl, lsl #24
     534:	00029900 	andeq	r9, r2, r0, lsl #18
        cmdBufIdx = (cmdBufIdx + 1) % 16;
     538:	02990400 	addseq	r0, r9, #0, 8
     53c:	00150000 	andseq	r0, r5, r0
     540:	0002a50c 	andeq	sl, r2, ip, lsl #10
     544:	08010500 	stmdaeq	r1, {r8, sl}
     548:	00000065 	andeq	r0, r0, r5, rrx
     54c:	00029e16 	andeq	r9, r2, r6, lsl lr
     550:	056a0800 	strbeq	r0, [sl, #-2048]!	@ 0xfffff800
     554:	19030000 	stmdbne	r3, {}	@ <UNPREDICTABLE>
      break;
     558:	00005c0a 	andeq	r5, r0, sl, lsl #24
      Test_critical_section(5, 0);
     55c:	0002c000 	andeq	ip, r2, r0
     560:	00760400 	rsbseq	r0, r6, r0, lsl #8
     564:	0a000000 	beq	56c <User_task0+0x16c>
      break;
     568:	0000023d 	andeq	r0, r0, sp, lsr r2
    Kernel_yield();
     56c:	00065063 	andeq	r5, r6, r3, rrx
  while(true) {
     570:	00003c00 	andeq	r3, r0, r0, lsl #24
void User_task1(void) {
     574:	e39c0100 	orrs	r0, ip, #0, 2
     578:	03000002 	movweq	r0, #2
     57c:	00000651 	andeq	r0, r0, r1, asr r6
  uint32_t local = 0;
     580:	005c0c64 	subseq	r0, ip, r4, ror #24
     584:	91020000 	mrsls	r0, (UNDEF: 2)
  debug_printf("User Task #1 SP=0x%x\n", &local);
     588:	110a0074 	tstne	sl, r4, ror r0
     58c:	4c000002 	stcmi	0, cr0, [r0], {2}
     590:	00000574 	andeq	r0, r0, r4, ror r5
     594:	000000dc 	ldrdeq	r0, [r0], -ip
     598:	033b9c01 	teqeq	fp, #256	@ 0x100
  uint8_t cmdlen = 0;
     59c:	51030000 	mrspl	r0, (UNDEF: 3)
     5a0:	4d000006 	stcmi	0, cr0, [r0, #-24]	@ 0xffffffe8
  uint8_t cmd[16] = {0, };
     5a4:	00005c0c 	andeq	r5, r0, ip, lsl #24
     5a8:	70910200 	addsvc	r0, r1, r0, lsl #4
     5ac:	00030503 	andeq	r0, r3, r3, lsl #10
     5b0:	420b5000 	andmi	r5, fp, #0
     5b4:	02000000 	andeq	r0, r0, #0
     5b8:	63176f91 	tstvs	r7, #580	@ 0x244
     5bc:	0100646d 	tsteq	r0, sp, ror #8
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
     5c0:	033b0b51 	teqeq	fp, #82944	@ 0x14400
     5c4:	91020000 	mrsls	r0, (UNDEF: 2)
     5c8:	05c00b5c 	strbeq	r0, [r0, #2908]	@ 0xb5c
    switch(handle_event) {
     5cc:	008c0000 	addeq	r0, ip, r0
     5d0:	a1030000 	mrsge	r0, (UNDEF: 3)
     5d4:	54000002 	strpl	r0, [r0], #-2
     5d8:	00019917 	andeq	r9, r1, r7, lsl r9
     5dc:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
     5e0:	42180000 	andsmi	r0, r8, #0
     5e4:	4b000000 	blmi	5ec <User_task1+0x78>
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
     5e8:	19000003 	stmdbne	r0, {r0, r1}
     5ec:	00000068 	andeq	r0, r0, r8, rrx
     5f0:	320a000f 	andcc	r0, sl, #15
     5f4:	1e000002 	cdpne	0, 0, cr0, cr0, cr2, {0}
     5f8:	00000400 	andeq	r0, r0, r0, lsl #8
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
     5fc:	00000174 	andeq	r0, r0, r4, ror r1
     600:	03c89c01 	biceq	r9, r8, #256	@ 0x100
     604:	51030000 	mrspl	r0, (UNDEF: 3)
     608:	1f000006 	svcne	0x00000006
     60c:	00005c0c 	andeq	r5, r0, ip, lsl #24
     610:	70910200 	addsvc	r0, r1, r0, lsl #4
      cmd[cmdlen] = 0;
     614:	00042d03 	andeq	r2, r4, r3, lsl #26
     618:	3b0b2200 	blcc	2c8e20 <cpsr_cp+0x2c5b98>
     61c:	02000003 	andeq	r0, r0, #3
     620:	df036091 	svcle	0x00036091
     624:	23000002 	movwcs	r0, #2
      debug_printf("\nRecv Cmd: %s\n", cmd);
     628:	0000420b 	andeq	r4, r0, fp, lsl #4
     62c:	5f910200 	svcpl	0x00910200
     630:	00027103 	andeq	r7, r2, r3, lsl #2
     634:	420b2400 	andmi	r2, fp, #0, 8
     638:	02000000 	andeq	r0, r0, #0
      break;
     63c:	380b5e91 	stmdacc	fp, {r0, r4, r7, r9, sl, fp, ip, lr}
      Kernel_unlock_sem();
     640:	38000004 	stmdacc	r0, {r2}
      break;
     644:	03000001 	movweq	r0, #1
    Kernel_yield();
     648:	000002a1 	andeq	r0, r0, r1, lsr #5
  while(true) {
     64c:	01991727 	orrseq	r1, r9, r7, lsr #14
void User_task2(void) {
     650:	91020000 	mrsls	r0, (UNDEF: 2)
     654:	04f00b74 	ldrbteq	r0, [r0], #2932	@ 0xb74
     658:	00180000 	andseq	r0, r8, r0
  uint32_t local = 0;
     65c:	32030000 	andcc	r0, r3, #0
     660:	34000007 	strcc	r0, [r0], #-7
  debug_printf("User Task #2 SP=0x%x\n", &local);
     664:	00004215 	andeq	r4, r0, r5, lsl r2
     668:	5d910200 	lfmpl	f0, 4, [r1]
     66c:	1a000000 	bne	674 <User_task2+0x24>
     670:	000002ae 	andeq	r0, r0, lr, lsr #5
     674:	880d1201 	stmdahi	sp, {r0, r9, ip}
    Test_critical_section(3, 2);
     678:	78000003 	stmdavc	r0, {r0, r1}
     67c:	01000000 	mrseq	r0, (UNDEF: 0)
     680:	0003f99c 	muleq	r3, ip, r9
    Kernel_yield();
     684:	00700f00 	rsbseq	r0, r0, r0, lsl #30
    Test_critical_section(3, 2);
     688:	005c2c12 	subseq	r2, ip, r2, lsl ip
     68c:	91020000 	mrsls	r0, (UNDEF: 2)
     690:	04341074 	ldrteq	r1, [r4], #-116	@ 0xffffff8c
     694:	38120000 	ldmdacc	r2, {}	@ <UNPREDICTABLE>
     698:	0000005c 	andeq	r0, r0, ip, asr r0
     69c:	00709102 	rsbseq	r9, r0, r2, lsl #2
     6a0:	0001e71b 	andeq	lr, r1, fp, lsl r7
     6a4:	06080100 	streq	r0, [r8], -r0, lsl #2
     6a8:	00000340 	andeq	r0, r0, r0, asr #6
     6ac:	00000048 	andeq	r0, r0, r8, asr #32
     6b0:	660f9c01 	strvs	r9, [pc], -r1, lsl #24
     6b4:	76200800 	strtvc	r0, [r0], -r0, lsl #16
     6b8:	02000000 	andeq	r0, r0, #0
     6bc:	c9106c91 	ldmdbgt	r0, {r0, r4, r7, sl, fp, sp, lr}
     6c0:	08000005 	stmdaeq	r0, {r0, r2}
     6c4:	00005c2c 	andeq	r5, r0, ip, lsr #24
     6c8:	68910200 	ldmvs	r1, {r9}
     6cc:	00043403 	andeq	r3, r4, r3, lsl #8
     6d0:	5c0c0900 			@ <UNDEFINED> instruction: 0x5c0c0900
     6d4:	02000000 	andeq	r0, r0, #0
     6d8:	00007491 	muleq	r0, r1, r4
     6dc:	000005af 	andeq	r0, r0, pc, lsr #11
     6e0:	04010005 	streq	r0, [r1], #-5
     6e4:	0000032d 	andeq	r0, r0, sp, lsr #6
     6e8:	0000be12 	andeq	fp, r0, r2, lsl lr
     6ec:	07841d00 	streq	r1, [r4, r0, lsl #26]
     6f0:	000d0000 	andeq	r0, sp, r0
     6f4:	07340000 	ldreq	r0, [r4, -r0]!
     6f8:	02f80000 	rscseq	r0, r8, #0
     6fc:	03690000 	cmneq	r9, #0
     700:	01080000 	mrseq	r0, (UNDEF: 8)
     704:	00005e06 	andeq	r5, r0, r6, lsl #28
     708:	05020800 	streq	r0, [r2, #-2048]	@ 0xfffff800
     70c:	000000b4 	strheq	r0, [r0], -r4
     710:	69050413 	stmdbvs	r5, {r0, r1, r4, sl}
     714:	0800746e 	stmdaeq	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     718:	00790508 	rsbseq	r0, r9, r8, lsl #10
     71c:	01080000 	mrseq	r0, (UNDEF: 8)
     720:	00005c08 	andeq	r5, r0, r8, lsl #24
     724:	07020800 	streq	r0, [r2, -r0, lsl #16]
     728:	00000087 	andeq	r0, r0, r7, lsl #1
     72c:	00024802 	andeq	r4, r2, r2, lsl #16
     730:	171a0300 	ldrne	r0, [sl, -r0, lsl #6]
void Hal_interrupt_init(void) {
     734:	0000005c 	andeq	r0, r0, ip, asr r0
     738:	43070408 	movwmi	r0, #29704	@ 0x7408
     73c:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
  GicCpu->cpucontrol.bits.Enable = 1;
     740:	00390708 	eorseq	r0, r9, r8, lsl #14
     744:	06040000 	streq	r0, [r4], -r0
     748:	00000089 	andeq	r0, r0, r9, lsl #1
     74c:	000cc301 	andeq	ip, ip, r1, lsl #6
     750:	00500700 	subseq	r0, r0, r0, lsl #14
     754:	00010000 	andeq	r0, r1, r0
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
     758:	0008c701 	andeq	ip, r8, r1, lsl #14
     75c:	00500800 	subseq	r0, r0, r0, lsl #16
     760:	011f0000 	tsteq	pc, r0
     764:	083b0500 	ldmdaeq	fp!, {r8, sl}
     768:	a8040000 	stmdage	r4, {}	@ <UNPREDICTABLE>
     76c:	06000000 	streq	r0, [r0], -r0
  GicDist->distributorctrl.bits.Enable = 1;
     770:	006c6c61 	rsbeq	r6, ip, r1, ror #24
     774:	00005005 	andeq	r5, r0, r5
     778:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     77c:	6a090000 	bvs	240784 <cpsr_cp+0x23d4fc>
     780:	00000000 	andeq	r0, r0, r0
     784:	00083b02 	andeq	r3, r8, r2, lsl #22
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     788:	030a0200 	movweq	r0, #41472	@ 0xa200
     78c:	00000089 	andeq	r0, r0, r9, lsl #1
     790:	00df0d04 	sbcseq	r0, pc, r4, lsl #26
    sHandlers[i] = NULL;
     794:	71010000 	mrsvc	r0, (UNDEF: 1)
     798:	0e000007 	cdpeq	0, 0, cr0, cr0, cr7, {0}
     79c:	00000050 	andeq	r0, r0, r0, asr r0
     7a0:	93010004 	movwls	r0, #4100	@ 0x1004
     7a4:	0f000007 	svceq	0x00000007
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     7a8:	00000050 	andeq	r0, r0, r0, asr r0
     7ac:	c7010404 	strgt	r0, [r1, -r4, lsl #8]
     7b0:	10000008 	andne	r0, r0, r8
     7b4:	00000050 	andeq	r0, r0, r0, asr r0
     7b8:	05000818 	streq	r0, [r0, #-2072]	@ 0xfffff7e8
     7bc:	000008e1 	andeq	r0, r0, r1, ror #17
  enable_irq();
     7c0:	0000fe0b 	andeq	pc, r0, fp, lsl #28
}
     7c4:	6c610600 	stclvs	6, cr0, [r1], #-0
     7c8:	500c006c 	andpl	r0, ip, ip, rrx
     7cc:	07000000 	streq	r0, [r0, -r0]
void Hal_interrupt_enable(uint32_t interrupt_num) {
     7d0:	0000095c 	andeq	r0, r0, ip, asr r9
     7d4:	0000b411 	andeq	fp, r0, r1, lsl r4
     7d8:	e1020000 	mrs	r0, (UNDEF: 2)
     7dc:	02000008 	andeq	r0, r0, #8
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     7e0:	00df0312 	sbcseq	r0, pc, r2, lsl r3	@ <UNPREDICTABLE>
     7e4:	15040000 	strne	r0, [r4, #-0]
     7e8:	00000129 	andeq	r0, r0, r9, lsr #2
     7ec:	0007a001 	andeq	sl, r7, r1
     7f0:	00501600 	subseq	r1, r0, r0, lsl #12
     7f4:	00030000 	andeq	r0, r3, r0
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     7f8:	0008c701 	andeq	ip, r8, r1, lsl #14
     7fc:	00501700 	subseq	r1, r0, r0, lsl #14
     800:	031d0000 	tsteq	sp, #0
  if (bit_num < GIC_IRQ_START) {
     804:	07b90500 	ldreq	r0, [r9, r0, lsl #10]!
     808:	48130000 	ldmdami	r3, {}	@ <UNPREDICTABLE>
     80c:	06000001 	streq	r0, [r0], -r1
    SET_BIT(GicDist->setenable1, bit_num);
     810:	006c6c61 	rsbeq	r6, ip, r1, ror #24
     814:	00005014 	andeq	r5, r0, r4, lsl r0
     818:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     81c:	0a180000 	beq	600824 <cpsr_cp+0x5fd59c>
     820:	00000001 	andeq	r0, r0, r1
     824:	0007b902 	andeq	fp, r7, r2, lsl #18
     828:	03190200 	tsteq	r9, #0, 4
     82c:	00000129 	andeq	r0, r0, r9, lsr #2
     830:	017f1c04 	cmneq	pc, r4, lsl #24
     834:	a8010000 	stmdage	r1, {}	@ <UNPREDICTABLE>
     838:	1d000009 	stcne	0, cr0, [r0, #-36]	@ 0xffffffdc
     83c:	00000050 	andeq	r0, r0, r0, asr r0
     840:	c701000a 	strgt	r0, [r1, -sl]
     844:	1e000007 	cdpne	0, 0, cr0, cr0, cr7, {0}
    bit_num -= GIC_IRQ_START;
     848:	00000050 	andeq	r0, r0, r0, asr r0
     84c:	c7010a03 	strgt	r0, [r1, -r3, lsl #20]
     850:	1f000008 	svcne	0x00000008
    SET_BIT(GicDist->setenable2, bit_num);
     854:	00000050 	andeq	r0, r0, r0, asr r0
     858:	05000d13 	streq	r0, [r0, #-3347]	@ 0xfffff2ed
     85c:	0000092a 	andeq	r0, r0, sl, lsr #18
     860:	00019e1a 	andeq	r9, r1, sl, lsl lr
     864:	6c610600 	stclvs	6, cr0, [r1], #-0
     868:	501b006c 	andspl	r0, fp, ip, rrx
     86c:	07000000 	streq	r0, [r0, -r0]
     870:	0000095c 	andeq	r0, r0, ip, asr r9
     874:	00015420 	andeq	r5, r1, r0, lsr #8
     878:	2a020000 	bcs	80880 <cpsr_cp+0x7d5f8>
     87c:	02000009 	andeq	r0, r0, #9
     880:	017f0321 	cmneq	pc, r1, lsr #6
     884:	24040000 	strcs	r0, [r4], #-0
     888:	000001d5 	ldrdeq	r0, [r0], -r5
    return;
     88c:	0009a801 	andeq	sl, r9, r1, lsl #16
}
     890:	00502500 	subseq	r2, r0, r0, lsl #10
     894:	000a0000 	andeq	r0, sl, r0
     898:	0007c701 	andeq	ip, r7, r1, lsl #14
void Hal_interrupt_disable(uint32_t interrupt_num) {
     89c:	00502600 	subseq	r2, r0, r0, lsl #12
     8a0:	0a030000 	beq	c08a8 <cpsr_cp+0xbd620>
     8a4:	0008c701 	andeq	ip, r8, r1, lsl #14
     8a8:	00502700 	subseq	r2, r0, r0, lsl #14
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     8ac:	0d130000 	ldceq	0, cr0, [r3, #-0]
     8b0:	08d00500 	ldmeq	r0, {r8, sl}^
     8b4:	f4220000 	vld4.8	{d0-d3}, [r2], r0
     8b8:	06000001 	streq	r0, [r0], -r1
     8bc:	006c6c61 	rsbeq	r6, ip, r1, ror #24
     8c0:	00005023 	andeq	r5, r0, r3, lsr #32
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     8c4:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     8c8:	aa280000 	bge	a008d0 <cpsr_cp+0x9fd648>
     8cc:	00000001 	andeq	r0, r0, r1
  if (bit_num < GIC_IRQ_START) {
     8d0:	0008d002 	andeq	sp, r8, r2
     8d4:	03290200 			@ <UNDEFINED> instruction: 0x03290200
     8d8:	000001d5 	ldrdeq	r0, [r0], -r5
    CLR_BIT(GicDist->setenable1, bit_num);
     8dc:	022b2c04 	eoreq	r2, fp, #4, 24	@ 0x400
     8e0:	71010000 	mrsvc	r0, (UNDEF: 1)
     8e4:	2d000007 	stccs	0, cr0, [r0, #-28]	@ 0xffffffe4
     8e8:	00000050 	andeq	r0, r0, r0, asr r0
     8ec:	7d010004 	stcvc	0, cr0, [r1, #-16]
     8f0:	2e000008 	cdpcs	0, 0, cr0, cr0, cr8, {0}
     8f4:	00000050 	andeq	r0, r0, r0, asr r0
     8f8:	c7010404 	strgt	r0, [r1, -r4, lsl #8]
     8fc:	2f000008 	svccs	0x00000008
     900:	00000050 	andeq	r0, r0, r0, asr r0
     904:	05000818 	streq	r0, [r0, #-2072]	@ 0xfffff7e8
     908:	00000970 	andeq	r0, r0, r0, ror r9
     90c:	00024a2a 	andeq	r4, r2, sl, lsr #20
     910:	6c610600 	stclvs	6, cr0, [r1], #-0
     914:	502b006c 	eorpl	r0, fp, ip, rrx
    bit_num -= GIC_IRQ_START;
     918:	07000000 	streq	r0, [r0, -r0]
     91c:	0000095c 	andeq	r0, r0, ip, asr r9
     920:	00020030 	andeq	r0, r2, r0, lsr r0
    CLR_BIT(GicDist->setenable2, bit_num);
     924:	70020000 	andvc	r0, r2, r0
     928:	02000009 	andeq	r0, r0, #9
     92c:	022b0331 	eoreq	r0, fp, #-1006632960	@ 0xc4000000
     930:	34040000 	strcc	r0, [r4], #-0
     934:	00000281 	andeq	r0, r0, r1, lsl #5
     938:	0009a801 	andeq	sl, r9, r1, lsl #16
     93c:	00503500 	subseq	r3, r0, r0, lsl #10
     940:	000a0000 	andeq	r0, sl, r0
     944:	0007c701 	andeq	ip, r7, r1, lsl #14
     948:	00503600 	subseq	r3, r0, r0, lsl #12
     94c:	0a030000 	beq	c0954 <cpsr_cp+0xbd6cc>
     950:	0008c701 	andeq	ip, r8, r1, lsl #14
     954:	00503700 	subseq	r3, r0, r0, lsl #14
     958:	0d130000 	ldceq	0, cr0, [r3, #-0]
     95c:	08f00500 	ldmeq	r0!, {r8, sl}^
    return;
     960:	a0320000 	eorsge	r0, r2, r0
}
     964:	06000002 	streq	r0, [r0], -r2
     968:	006c6c61 	rsbeq	r6, ip, r1, ror #24
     96c:	00005033 	andeq	r5, r0, r3, lsr r0
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num) {
     970:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     974:	56380000 	ldrtpl	r0, [r8], -r0
     978:	00000002 	andeq	r0, r0, r2
     97c:	0008f002 	andeq	pc, r8, r2
     980:	03390200 	teqeq	r9, #0, 4
  sHandlers[interrupt_num] = handler;
     984:	00000281 	andeq	r0, r0, r1, lsl #5
     988:	02cb3c04 	sbceq	r3, fp, #4, 24	@ 0x400
     98c:	c3010000 	movwgt	r0, #4096	@ 0x1000
     990:	3d00000c 	stccc	0, cr0, [r0, #-48]	@ 0xffffffd0
     994:	00000050 	andeq	r0, r0, r0, asr r0
}
     998:	c7010001 	strgt	r0, [r1, -r1]
     99c:	3e000008 	cdpcc	0, 0, cr0, cr0, cr8, {0}
     9a0:	00000050 	andeq	r0, r0, r0, asr r0
     9a4:	0500011f 	streq	r0, [r0, #-287]	@ 0xfffffee1
void Hal_interrupt_run_handler(void) {
     9a8:	0000075f 	andeq	r0, r0, pc, asr r7
     9ac:	0002ea3a 	andeq	lr, r2, sl, lsr sl
     9b0:	6c610600 	stclvs	6, cr0, [r1], #-0
  uint32_t interrupt_num = GicCpu->interruptack.bits.InterruptID;
     9b4:	503b006c 	eorspl	r0, fp, ip, rrx
     9b8:	07000000 	streq	r0, [r0, -r0]
     9bc:	0000095c 	andeq	r0, r0, ip, asr r9
     9c0:	0002ac3f 	andeq	sl, r2, pc, lsr ip
     9c4:	5f020000 	svcpl	0x00020000
     9c8:	02000007 	andeq	r0, r0, #7
     9cc:	02cb0340 	sbceq	r0, fp, #64, 6
  if (sHandlers[interrupt_num] != NULL) {
     9d0:	43040000 	movwmi	r0, #16384	@ 0x4000
     9d4:	00000321 	andeq	r0, r0, r1, lsr #6
     9d8:	00094401 	andeq	r4, r9, r1, lsl #8
     9dc:	00504400 	subseq	r4, r0, r0, lsl #8
     9e0:	00050000 	andeq	r0, r5, r0
     9e4:	00095201 	andeq	r5, r9, r1, lsl #4
    sHandlers[interrupt_num]();
     9e8:	00504500 	subseq	r4, r0, r0, lsl #10
     9ec:	05030000 	streq	r0, [r3, #-0]
     9f0:	0008c701 	andeq	ip, r8, r1, lsl #14
     9f4:	00504600 	subseq	r4, r0, r0, lsl #12
     9f8:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
  GicCpu->endofinterrupt.bits.InterruptID = interrupt_num;
     9fc:	098d0500 	stmibeq	sp, {r8, sl}
     a00:	40410000 	submi	r0, r1, r0
     a04:	06000003 	streq	r0, [r0], -r3
     a08:	006c6c61 	rsbeq	r6, ip, r1, ror #24
     a0c:	00005042 	andeq	r5, r0, r2, asr #32
     a10:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     a14:	f6470000 			@ <UNDEFINED> instruction: 0xf6470000
     a18:	00000002 	andeq	r0, r0, r2
     a1c:	00098d02 	andeq	r8, r9, r2, lsl #26
     a20:	03480200 	movteq	r0, #33280	@ 0x8200
     a24:	00000321 	andeq	r0, r0, r1, lsr #6
     a28:	00077a14 	andeq	r7, r7, r4, lsl sl
void Hal_timer_init(void) {
     a2c:	4a021c00 	bmi	87a34 <cpsr_cp+0x847ac>
     a30:	0003ae10 	andeq	sl, r3, r0, lsl lr
     a34:	07d30300 	ldrbeq	r0, [r3, r0, lsl #6]
  Timer->timerxcontrol.bits.TimerEn = 0;
     a38:	164b0000 	strbne	r0, [fp], -r0
     a3c:	000000a8 	andeq	r0, r0, r8, lsr #1
     a40:	082e0300 	stmdaeq	lr!, {r8, r9}
     a44:	164c0000 	strbne	r0, [ip], -r0
     a48:	000000fe 	strdeq	r0, [r0], -lr
     a4c:	081a0304 	ldmdaeq	sl, {r2, r8, r9}
  Timer->timerxcontrol.bits.TimerMode = 0;
     a50:	164d0000 	strbne	r0, [sp], -r0
     a54:	00000148 	andeq	r0, r0, r8, asr #2
     a58:	07520308 	ldrbeq	r0, [r2, -r8, lsl #6]
     a5c:	164e0000 	strbne	r0, [lr], -r0
     a60:	0000019e 	muleq	r0, lr, r1
     a64:	07fd030c 	ldrbeq	r0, [sp, ip, lsl #6]!
  Timer->timerxcontrol.bits.OneShot = 0;
     a68:	164f0000 	strbne	r0, [pc], -r0
     a6c:	000001f4 	strdeq	r0, [r0], -r4
     a70:	09190310 	ldmdbeq	r9, {r4, r8, r9}
     a74:	16500000 	ldrbne	r0, [r0], -r0
     a78:	0000024a 	andeq	r0, r0, sl, asr #4
     a7c:	08b60314 	ldmeq	r6!, {r2, r4, r8, r9}
  Timer->timerxcontrol.bits.TimerSize = 0;
     a80:	16510000 	ldrbne	r0, [r1], -r0
     a84:	000002a0 	andeq	r0, r0, r0, lsr #5
     a88:	7a020018 	bvc	80af0 <cpsr_cp+0x7d868>
     a8c:	02000007 	andeq	r0, r0, #7
     a90:	034c0352 	movteq	r0, #50002	@ 0xc352
     a94:	ae100000 	cdpge	0, 1, cr0, cr0, cr0, {0}
  Timer->timerxcontrol.bits.TimerPre = 0;
     a98:	15000003 	strne	r0, [r0, #-3]
     a9c:	000009be 			@ <UNDEFINED> instruction: 0x000009be
     aa0:	5302018c 	movwpl	r0, #8588	@ 0x218c
     aa4:	00044610 	andeq	r4, r4, r0, lsl r6
     aa8:	089f0300 	ldmeq	pc, {r8, r9}	@ <UNPREDICTABLE>
     aac:	17540000 	ldrbne	r0, [r4, -r0]
  Timer->timerxcontrol.bits.IntEnable = 1;
     ab0:	000002ea 	andeq	r0, r0, sl, ror #5
     ab4:	09610300 	stmdbeq	r1!, {r8, r9}^
     ab8:	17550000 	ldrbne	r0, [r5, -r0]
     abc:	00000340 	andeq	r0, r0, r0, asr #6
     ac0:	08860304 	stmeq	r6, {r2, r8, r9}
     ac4:	17560000 	ldrbne	r0, [r6, -r0]
  Timer->timerxload = 0;
     ac8:	00000446 	andeq	r0, r0, r6, asr #8
     acc:	099e0908 	ldmibeq	lr, {r3, r8, fp}
     ad0:	50570000 	subspl	r0, r7, r0
     ad4:	00000000 	andeq	r0, r0, r0
     ad8:	08480901 	stmdaeq	r8, {r0, r8, fp}^
  Timer->timerxvalue = 0xFFFFFFFF;
     adc:	50580000 	subspl	r0, r8, r0
     ae0:	04000000 	streq	r0, [r0], #-0
     ae4:	08530901 	ldmdaeq	r3, {r0, r8, fp}^
     ae8:	50590000 	subspl	r0, r9, r0
     aec:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
  Timer->timerxcontrol.bits.TimerMode = TIMER_PERIOIC;
     af0:	09830901 	stmibeq	r3, {r0, r8, fp}
     af4:	565a0000 	ldrbpl	r0, [sl], -r0
     af8:	0c000004 	stceq	0, cr0, [r0], {4}
     afc:	09b40901 	ldmibeq	r4!, {r0, r8, fp}
     b00:	505b0000 	subspl	r0, fp, r0
     b04:	80000000 	andhi	r0, r0, r0
  Timer->timerxcontrol.bits.TimerSize = TIMER_32BIT_COUNTER;
     b08:	07e60901 	strbeq	r0, [r6, r1, lsl #18]!
     b0c:	505c0000 	subspl	r0, ip, r0
     b10:	84000000 	strhi	r0, [r0], #-0
     b14:	07ac0901 	streq	r0, [ip, r1, lsl #18]!
     b18:	505d0000 	subspl	r0, sp, r0
     b1c:	88000000 	stmdahi	r0, {}	@ <UNPREDICTABLE>
  Timer->timerxcontrol.bits.OneShot = 0;
     b20:	500c0001 	andpl	r0, ip, r1
     b24:	56000000 	strpl	r0, [r0], -r0
     b28:	0d000004 	stceq	0, cr0, [r0, #-16]
     b2c:	0000005c 	andeq	r0, r0, ip, asr r0
     b30:	500c003d 	andpl	r0, ip, sp, lsr r0
     b34:	66000000 	strvs	r0, [r0], -r0
  Timer->timerxcontrol.bits.TimerPre = 0;
     b38:	0d000004 	stceq	0, cr0, [r0, #-16]
     b3c:	0000005c 	andeq	r0, r0, ip, asr r0
     b40:	be02001c 	mcrlt	0, 0, r0, cr2, cr12, {0}
     b44:	02000009 	andeq	r0, r0, #9
     b48:	03bf035e 			@ <UNDEFINED> instruction: 0x03bf035e
     b4c:	66100000 	ldrvs	r0, [r0], -r0
  Timer->timerxcontrol.bits.IntEnable = 1;
     b50:	02000004 	andeq	r0, r0, #4
     b54:	00000890 	muleq	r0, r0, r8
     b58:	83100804 	tsthi	r0, #4, 16	@ 0x40000
     b5c:	0e000004 	cdpeq	0, 0, cr0, cr0, cr4, {0}
     b60:	00000488 	andeq	r0, r0, r8, lsl #9
     b64:	08af1116 	stmiaeq	pc!, {r1, r2, r4, r8, ip}	@ <UNPREDICTABLE>
  uint32_t interval_1ms = TIMER_INTERVAL / 100;
     b68:	93070000 	movwls	r0, #28672	@ 0x7000
     b6c:	0e000004 	cdpeq	0, 0, cr0, cr0, cr4, {0}
  Timer->timerxload = interval_1ms;
     b70:	000003ba 			@ <UNDEFINED> instruction: 0x000003ba
     b74:	00082611 	andeq	r2, r8, r1, lsl r6
     b78:	04a20800 	strteq	r0, [r2], #2048	@ 0x800
     b7c:	720e0000 	andvc	r0, lr, #0
     b80:	0c000004 	stceq	0, cr0, [r0], {4}
  Timer->timerxcontrol.bits.TimerEn = 1;
     b84:	00000477 	andeq	r0, r0, r7, ror r4
     b88:	000004b7 			@ <UNDEFINED> instruction: 0x000004b7
     b8c:	00005c0d 	andeq	r5, r0, sp, lsl #24
     b90:	0a00fe00 	beq	40398 <cpsr_cp+0x3d110>
     b94:	000007f3 	strdeq	r0, [r0], -r3
     b98:	04a7170a 	strteq	r1, [r7], #1802	@ 0x70a
  internal_1ms_counter = 0;
     b9c:	03050000 	movweq	r0, #20480	@ 0x5000
     ba0:	0000224c 	andeq	r2, r0, ip, asr #4
     ba4:	00093917 	andeq	r3, r9, r7, lsl r9
     ba8:	06040500 	streq	r0, [r4], -r0, lsl #10
  Hal_interrupt_enable(TIMER_INTERRUPT);
     bac:	00009a18 	andeq	r9, r0, r8, lsl sl
     bb0:	06380100 	ldrteq	r0, [r8], -r0, lsl #2
  Hal_interrupt_register_handler(interrupt_handler, TIMER_INTERRUPT);
     bb4:	000009a8 	andeq	r0, r0, r8, lsr #19
     bb8:	00000084 	andeq	r0, r0, r4, lsl #1
     bbc:	04f59c01 	ldrbteq	r9, [r5], #3073	@ 0xc01
     bc0:	0c0a0000 	stceq	0, cr0, [sl], {-0}
}
     bc4:	39000008 	stmdbcc	r0, {r3}
     bc8:	0000500c 	andeq	r5, r0, ip
     bcc:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
uint32_t Hal_timer_get_1ms_counter(void) {
     bd0:	085e0f00 	ldmdaeq	lr, {r8, r9, sl, fp}^
     bd4:	70350000 	eorsvc	r0, r5, r0
  return internal_1ms_counter;
     bd8:	38000009 	stmdacc	r0, {r0, r3}
     bdc:	01000000 	mrseq	r0, (UNDEF: 0)
     be0:	0005269c 	muleq	r5, ip, r6
}
     be4:	00ac0b00 	adceq	r0, ip, r0, lsl #22
     be8:	34350000 	ldrtcc	r0, [r5], #-0
     bec:	00000477 	andeq	r0, r0, r7, ror r4
     bf0:	0b749102 	bleq	1d25000 <cpsr_cp+0x1d21d78>
static void interrupt_handler(void) {
     bf4:	0000080c 	andeq	r0, r0, ip, lsl #16
     bf8:	00504635 	subseq	r4, r0, r5, lsr r6
  ++internal_1ms_counter;
     bfc:	91020000 	mrsls	r0, (UNDEF: 2)
     c00:	030f0070 	movweq	r0, #61552	@ 0xf070
     c04:	26000009 	strcs	r0, [r0], -r9
     c08:	0000089c 	muleq	r0, ip, r8
     c0c:	000000d4 	ldrdeq	r0, [r0], -r4
     c10:	05579c01 	ldrbeq	r9, [r7, #-3073]	@ 0xfffff3ff
     c14:	0c0b0000 	stceq	0, cr0, [fp], {-0}
  Timer->timerxintclr = 1;
     c18:	26000008 	strcs	r0, [r0], -r8
     c1c:	00005025 	andeq	r5, r0, r5, lsr #32
     c20:	6c910200 	lfmvs	f0, 4, [r1], {0}
     c24:	0007de0a 	andeq	sp, r7, sl, lsl #28
     c28:	500c2b00 	andpl	r2, ip, r0, lsl #22
     c2c:	02000000 	andeq	r0, r0, #0
     c30:	0f007491 	svceq	0x00007491
     c34:	0000012d 	andeq	r0, r0, sp, lsr #2
     c38:	0007d017 	andeq	sp, r7, r7, lsl r0
void Hal_uart_init(void) {
     c3c:	0000cc00 	andeq	ip, r0, r0, lsl #24
     c40:	889c0100 	ldmhi	ip, {r8}
  Uart->uartcr.bits.UARTEN = 0;
     c44:	0b000005 	bleq	c60 <Hal_uart_init+0x24>
     c48:	0000080c 	andeq	r0, r0, ip, lsl #16
     c4c:	00502417 	subseq	r2, r0, r7, lsl r4
     c50:	91020000 	mrsls	r0, (UNDEF: 2)
     c54:	07de0a6c 	ldrbeq	r0, [lr, ip, ror #20]
     c58:	0c1c0000 	ldceq	0, cr0, [ip], {-0}
  Uart->uartcr.bits.TXE = 1;
     c5c:	00000050 	andeq	r0, r0, r0, asr r0
     c60:	00749102 	rsbseq	r9, r4, r2, lsl #2
     c64:	00016a19 	andeq	r6, r1, r9, lsl sl
     c68:	060c0100 	streq	r0, [ip], -r0, lsl #2
     c6c:	00000734 	andeq	r0, r0, r4, lsr r7
     c70:	0000009c 	muleq	r0, ip, r0
  Uart->uartcr.bits.RXE = 1;
     c74:	881a9c01 	ldmdahi	sl, {r0, sl, fp, ip, pc}
     c78:	38000007 	stmdacc	r0, {r0, r1, r2}
     c7c:	1b000000 	blne	c84 <Hal_uart_init+0x48>
     c80:	11010069 	tstne	r1, r9, rrx
     c84:	00005011 	andeq	r5, r0, r1, lsl r0
     c88:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
  Uart->uartcr.bits.UARTEN = 1;
     c8c:	c5000000 	strgt	r0, [r0, #-0]
     c90:	0500000f 	streq	r0, [r0, #-15]
     c94:	eb040100 	bl	10109c <cpsr_cp+0xfde14>
     c98:	11000004 	tstne	r0, r4
     c9c:	000000be 	strheq	r0, [r0], -lr
     ca0:	000bcb1d 	andeq	ip, fp, sp, lsl fp
  Uart->uartimsc.bits.RXIM = 1;
     ca4:	00000d00 	andeq	r0, r0, r0, lsl #26
     ca8:	00048f00 	andeq	r8, r4, r0, lsl #30
     cac:	06010900 	streq	r0, [r1], -r0, lsl #18
     cb0:	0000005e 	andeq	r0, r0, lr, asr r0
     cb4:	b4050209 	strlt	r0, [r5], #-521	@ 0xfffffdf7
     cb8:	12000000 	andne	r0, r0, #0
  Hal_interrupt_register_handler(interrupt_handler, UART_INTERRUPT0);
     cbc:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     cc0:	08090074 	stmdaeq	r9, {r2, r4, r5, r6}
     cc4:	00007905 	andeq	r7, r0, r5, lsl #18
     cc8:	08010900 	stmdaeq	r1, {r8, fp}
}
     ccc:	0000005c 	andeq	r0, r0, ip, asr r0
     cd0:	87070209 	strhi	r0, [r7, -r9, lsl #4]
void Hal_uart_put_char(uint8_t ch) {
     cd4:	03000000 	movweq	r0, #0
     cd8:	00000248 	andeq	r0, r0, r8, asr #4
     cdc:	54171a03 	ldrpl	r1, [r7], #-2563	@ 0xfffff5fd
     ce0:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
     ce4:	00430704 	subeq	r0, r3, r4, lsl #14
  while(Uart->uartfr.bits.TXFF);
     ce8:	08090000 	stmdaeq	r9, {}	@ <UNPREDICTABLE>
     cec:	00003907 	andeq	r3, r0, r7, lsl #18
     cf0:	06020400 	streq	r0, [r2], -r0, lsl #8
     cf4:	000000ac 	andeq	r0, r0, ip, lsr #1
     cf8:	000b2e01 	andeq	r2, fp, r1, lsl #28
     cfc:	48070200 	stmdami	r7, {r9}
     d00:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
     d04:	45460800 	strbmi	r0, [r6, #-2048]	@ 0xfffff800
     d08:	00480800 	subeq	r0, r8, r0, lsl #16
  Uart->uartdr.bits.DATA = (ch & 0xFF);
     d0c:	08080000 	stmdaeq	r8, {}	@ <UNPREDICTABLE>
     d10:	09004550 	stmdbeq	r0, {r4, r6, r8, sl, lr}
     d14:	00000048 	andeq	r0, r0, r8, asr #32
     d18:	45420809 	strbmi	r0, [r2, #-2057]	@ 0xfffff7f7
     d1c:	00480a00 	subeq	r0, r8, r0, lsl #20
     d20:	080a0000 	stmdaeq	sl, {}	@ <UNPREDICTABLE>
     d24:	0b00454f 	bleq	12268 <cpsr_cp+0xefe0>
}
     d28:	00000048 	andeq	r0, r0, r8, asr #32
     d2c:	08c7010b 	stmiaeq	r7, {r0, r1, r3, r8}^
     d30:	0c020000 	stceq	0, cr0, [r2], {-0}
     d34:	00000048 	andeq	r0, r0, r8, asr #32
uint8_t Hal_uart_get_char(void) {
     d38:	05000c14 	streq	r0, [r0, #-3092]	@ 0xfffff3ec
     d3c:	00000cca 	andeq	r0, r0, sl, asr #25
     d40:	00ce0402 	sbceq	r0, lr, r2, lsl #8
  while(Uart->uartfr.bits.RXFE);
     d44:	61060000 	mrsvs	r0, (UNDEF: 6)
     d48:	02006c6c 	andeq	r6, r0, #108, 24	@ 0x6c00
     d4c:	00004805 	andeq	r4, r0, r5, lsl #16
     d50:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
     d54:	0d020000 	stceq	0, cr0, [r2, #-0]
     d58:	00000062 	andeq	r0, r0, r2, rrx
     d5c:	0cca0300 	stcleq	3, cr0, [sl], {0}
     d60:	0e020000 	cdpeq	0, 0, cr0, cr2, cr0, {0}
     d64:	0000ac03 	andeq	sl, r0, r3, lsl #24
  data = Uart->uartdr.all;
     d68:	11020400 	tstne	r2, r0, lsl #8
     d6c:	00000117 	andeq	r0, r0, r7, lsl r1
     d70:	00454608 	subeq	r4, r5, r8, lsl #12
     d74:	00004812 	andeq	r4, r0, r2, lsl r8
     d78:	50080000 	andpl	r0, r8, r0
  if(data & 0xFFFFFF00) {
     d7c:	48130045 	ldmdami	r3, {r0, r2, r6}
     d80:	01000000 	mrseq	r0, (UNDEF: 0)
     d84:	00454208 	subeq	r4, r5, r8, lsl #4
    Uart->uartrsr.all = 0xFF;
     d88:	00004814 	andeq	r4, r0, r4, lsl r8
     d8c:	4f080200 	svcmi	0x00080200
     d90:	48150045 	ldmdami	r5, {r0, r2, r6}
     d94:	03000000 	movweq	r0, #0
     d98:	0008c701 	andeq	ip, r8, r1, lsl #14
    return 0;
     d9c:	48160200 	ldmdami	r6, {r9}
     da0:	1c000000 	stcne	0, cr0, [r0], {-0}
  return (uint8_t)(data & 0xFF);
     da4:	97050004 	strls	r0, [r5, -r4]
     da8:	0200000c 	andeq	r0, r0, #12
}
     dac:	0001390f 	andeq	r3, r1, pc, lsl #18
     db0:	6c610600 	stclvs	6, cr0, [r1], #-0
     db4:	1002006c 	andne	r0, r2, ip, rrx
     db8:	00000048 	andeq	r0, r0, r8, asr #32
static void interrupt_handler(void) {
     dbc:	00095c07 	andeq	r5, r9, r7, lsl #24
     dc0:	da170200 	ble	5c15c8 <cpsr_cp+0x5be340>
     dc4:	00000000 	andeq	r0, r0, r0
  uint8_t ch = Hal_uart_get_char();
     dc8:	000c9703 	andeq	r9, ip, r3, lsl #14
     dcc:	03180200 	tsteq	r8, #0, 4
     dd0:	00000117 	andeq	r0, r0, r7, lsl r1
  if (ch == 'U') {
     dd4:	c61b0204 	ldrgt	r0, [fp], -r4, lsl #4
     dd8:	08000001 	stmdaeq	r0, {r0}
     ddc:	00535443 	subseq	r5, r3, r3, asr #8
    Kernel_send_events(KernelEventFlag_Unlock);
     de0:	0000481c 	andeq	r4, r0, ip, lsl r8
     de4:	44080000 	strmi	r0, [r8], #-0
    return;
     de8:	1d005253 	sfmne	f5, 4, [r0, #-332]	@ 0xfffffeb4
  if (ch == 'X') {
     dec:	00000048 	andeq	r0, r0, r8, asr #32
     df0:	43440801 	movtmi	r0, #18433	@ 0x4801
     df4:	481e0044 	ldmdami	lr, {r2, r6}
    Kernel_send_events(KernelEventFlag_CmdOut);
     df8:	02000000 	andeq	r0, r0, #0
     dfc:	000d4d01 	andeq	r4, sp, r1, lsl #26
    return;
     e00:	481f0200 	ldmdami	pc, {r9}	@ <UNPREDICTABLE>
  Hal_uart_put_char(ch);
     e04:	01000000 	mrseq	r0, (UNDEF: 0)
     e08:	0d160103 	ldfeqs	f0, [r6, #-12]
     e0c:	20020000 	andcs	r0, r2, r0
  Kernel_send_msg(KernelMsgQ_Task0, &ch, 1);
     e10:	00000048 	andeq	r0, r0, r8, asr #32
     e14:	4d010401 	cfstrsmi	mvf0, [r1, #-4]
     e18:	0200000c 	andeq	r0, r0, #12
     e1c:	00004821 	andeq	r4, r0, r1, lsr #16
     e20:	01050100 	mrseq	r0, (UNDEF: 21)
  Kernel_send_events(KernelEventFlag_UartIn);
     e24:	00000d1b 	andeq	r0, r0, fp, lsl sp
     e28:	00482202 	subeq	r2, r8, r2, lsl #4
     e2c:	06010000 	streq	r0, [r1], -r0
     e30:	000c4801 	andeq	r4, ip, r1, lsl #16
void enable_irq(void) {
     e34:	48230200 	stmdami	r3!, {r9}
     e38:	01000000 	mrseq	r0, (UNDEF: 0)
  __asm__ ("PUSH {r0, r1}");
     e3c:	49520807 	ldmdbmi	r2, {r0, r1, r2, fp}^
  __asm__ ("MRS r0, cpsr");
     e40:	00482400 	subeq	r2, r8, r0, lsl #8
  __asm__ ("BIC r1, r0, #0x80");
     e44:	01080000 	mrseq	r0, (UNDEF: 8)
  __asm__ ("MSR cpsr, r1");
     e48:	000008c7 	andeq	r0, r0, r7, asr #17
  __asm__ ("POP {r0, r1}");
     e4c:	00482502 	subeq	r2, r8, r2, lsl #10
}
     e50:	09170000 	ldmdbeq	r7, {}	@ <UNPREDICTABLE>
     e54:	0be90500 	bleq	ffa4225c <cpsr_cp+0xffa3efd4>
     e58:	19020000 	stmdbne	r2, {}	@ <UNPREDICTABLE>
     e5c:	000001e8 	andeq	r0, r0, r8, ror #3
void enable_fiq(void) {
     e60:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
     e64:	481a0200 	ldmdami	sl, {r9}
  __asm__ ("PUSH {r0, r1}");
     e68:	07000000 	streq	r0, [r0, -r0]
  __asm__ ("MRS r0, cpsr");
     e6c:	0000095c 	andeq	r0, r0, ip, asr r9
  __asm__ ("BIC r1, r0, #0x40");
     e70:	01452602 	cmpeq	r5, r2, lsl #12
  __asm__ ("MSR cpsr, r1");
     e74:	03000000 	movweq	r0, #0
  __asm__ ("POP {r0, r1}");
     e78:	00000be9 	andeq	r0, r0, r9, ror #23
}
     e7c:	c6032702 	strgt	r2, [r3], -r2, lsl #14
     e80:	04000001 	streq	r0, [r0], #-1
     e84:	02162a02 	andseq	r2, r6, #8192	@ 0x2000
     e88:	3f010000 	svccc	0x00010000
void disable_irq(void) {
     e8c:	0200000b 	andeq	r0, r0, #11
     e90:	0000482b 	andeq	r4, r0, fp, lsr #16
  __asm__ ("PUSH {r0, r1}");
     e94:	01000800 	tsteq	r0, r0, lsl #16
  __asm__ ("MRS r0, cpsr");
     e98:	000008c7 	andeq	r0, r0, r7, asr #17
  __asm__ ("ORR r1, r0, #0x80");
     e9c:	00482c02 	subeq	r2, r8, r2, lsl #24
  __asm__ ("MSR cpsr, r1");
     ea0:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
  __asm__ ("POP {r0, r1}");
     ea4:	0a230500 	beq	8c22ac <cpsr_cp+0x8bf024>
}
     ea8:	28020000 	stmdacs	r2, {}	@ <UNPREDICTABLE>
     eac:	00000238 	andeq	r0, r0, r8, lsr r2
     eb0:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
     eb4:	48290200 	stmdami	r9!, {r9}
void disable_fiq(void) {
     eb8:	07000000 	streq	r0, [r0, -r0]
     ebc:	0000095c 	andeq	r0, r0, ip, asr r9
  __asm__ ("PUSH {r0, r1}");
     ec0:	01f42d02 	mvnseq	r2, r2, lsl #26
  __asm__ ("MRS r0, cpsr");
     ec4:	03000000 	movweq	r0, #0
  __asm__ ("ORR r1, r0, #0x40");
     ec8:	00000a23 	andeq	r0, r0, r3, lsr #20
  __asm__ ("MSR cpsr, r1");
     ecc:	16032e02 	strne	r2, [r3], -r2, lsl #28
  __asm__ ("POP {r0, r1}");
     ed0:	04000002 	streq	r0, [r0], #-2
     ed4:	02663102 	rsbeq	r3, r6, #-2147483648	@ 0x80000000
     ed8:	80010000 	andhi	r0, r1, r0
     edc:	0200000c 	andeq	r0, r0, #12
     ee0:	00004832 	andeq	r4, r0, r2, lsr r8
uint32_t putstr(const char* s) {
     ee4:	01001000 	mrseq	r1, (UNDEF: 0)
     ee8:	000008c7 	andeq	r0, r0, r7, asr #17
     eec:	00483302 	subeq	r3, r8, r2, lsl #6
     ef0:	10100000 	andsne	r0, r0, r0
  uint32_t c = 0;
     ef4:	0a400500 	beq	10022fc <cpsr_cp+0xfff074>
     ef8:	2f020000 	svccs	0x00020000
  while(*s) {
     efc:	00000288 	andeq	r0, r0, r8, lsl #5
    Hal_uart_put_char(*s++);
     f00:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
     f04:	48300200 	ldmdami	r0!, {r9}
     f08:	07000000 	streq	r0, [r0, -r0]
     f0c:	0000095c 	andeq	r0, r0, ip, asr r9
     f10:	02443402 	subeq	r3, r4, #33554432	@ 0x2000000
     f14:	03000000 	movweq	r0, #0
    ++c;
     f18:	00000a40 	andeq	r0, r0, r0, asr #20
     f1c:	66033502 	strvs	r3, [r3], -r2, lsl #10
     f20:	04000002 	streq	r0, [r0], #-2
  while(*s) {
     f24:	02b63802 	adcseq	r3, r6, #131072	@ 0x20000
     f28:	33010000 	movwcc	r0, #4096	@ 0x1000
     f2c:	0200000b 	andeq	r0, r0, #11
     f30:	00004839 	andeq	r4, r0, r9, lsr r8
  return c;
     f34:	01000600 	tsteq	r0, r0, lsl #12
}
     f38:	000008c7 	andeq	r0, r0, r7, asr #17
     f3c:	00483a02 	subeq	r3, r8, r2, lsl #20
     f40:	061a0000 	ldreq	r0, [sl], -r0
uint32_t debug_printf(const char* format, ...) { 
     f44:	0c100500 	cfldr32eq	mvfx0, [r0], {-0}
     f48:	36020000 	strcc	r0, [r2], -r0
     f4c:	000002d8 	ldrdeq	r0, [r0], -r8
     f50:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
     f54:	48370200 	ldmdami	r7!, {r9}
     f58:	07000000 	streq	r0, [r0, -r0]
  vsprintf(printf_buf, format, args);
     f5c:	0000095c 	andeq	r0, r0, ip, asr r9
     f60:	02943b02 	addseq	r3, r4, #2048	@ 0x800
     f64:	03000000 	movweq	r0, #0
     f68:	00000c10 	andeq	r0, r0, r0, lsl ip
     f6c:	b6033c02 	strlt	r3, [r3], -r2, lsl #24
  return putstr(printf_buf);
     f70:	04000002 	streq	r0, [r0], #-2
     f74:	034a3f02 	movteq	r3, #44802	@ 0xaf02
     f78:	42080000 	andmi	r0, r8, #0
     f7c:	40004b52 	andmi	r4, r0, r2, asr fp
}
     f80:	00000048 	andeq	r0, r0, r8, asr #32
     f84:	45500800 	ldrbmi	r0, [r0, #-2048]	@ 0xfffff800
     f88:	4841004e 	stmdami	r1, {r1, r2, r3, r6}^
     f8c:	01000000 	mrseq	r0, (UNDEF: 0)
     f90:	53504508 	cmppl	r0, #8, 10	@ 0x2000000
uint32_t vsprintf(char* buf, const char* format, va_list arg) {
     f94:	00484200 	subeq	r4, r8, r0, lsl #4
     f98:	01020000 	mrseq	r0, (UNDEF: 2)
     f9c:	00000ca8 	andeq	r0, r0, r8, lsr #25
     fa0:	00484302 	subeq	r4, r8, r2, lsl #6
     fa4:	03010000 	movweq	r0, #4096	@ 0x1000
     fa8:	4e454608 	cdpmi	6, 4, cr4, cr5, cr8, {0}
  uint32_t c = 0;
     fac:	00484400 	subeq	r4, r8, r0, lsl #8
     fb0:	01040000 	mrseq	r0, (UNDEF: 4)
  for (uint32_t i = 0; format[i]; ++i) {
     fb4:	00000b23 	andeq	r0, r0, r3, lsr #22
     fb8:	00484502 	subeq	r4, r8, r2, lsl #10
     fbc:	05020000 	streq	r0, [r2, #-0]
    if (format[i] == '%') {
     fc0:	53505308 	cmppl	r0, #8, 6	@ 0x20000000
     fc4:	00484600 	subeq	r4, r8, r0, lsl #12
     fc8:	01070000 	mrseq	r0, (UNDEF: 7)
     fcc:	000008c7 	andeq	r0, r0, r7, asr #17
     fd0:	00484702 	subeq	r4, r8, r2, lsl #14
     fd4:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
      ++i;
     fd8:	0c8b0500 	cfstr32eq	mvfx0, [fp], {0}
     fdc:	3d020000 	stccc	0, cr0, [r2, #-0]
     fe0:	0000036c 	andeq	r0, r0, ip, ror #6
      switch(format[i]) {
     fe4:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
     fe8:	483e0200 	ldmdami	lr!, {r9}
     fec:	07000000 	streq	r0, [r0, -r0]
     ff0:	0000095c 	andeq	r0, r0, ip, asr r9
     ff4:	02e44802 	rsceq	r4, r4, #131072	@ 0x20000
     ff8:	03000000 	movweq	r0, #0
     ffc:	00000c8b 	andeq	r0, r0, fp, lsl #25
    1000:	4a034902 	bmi	d3410 <cpsr_cp+0xd0188>
    1004:	04000003 	streq	r0, [r0], #-3
    1008:	042c4c02 	strteq	r4, [ip], #-3074	@ 0xfffff3fe
    100c:	7f010000 	svcvc	0x00010000
    1010:	0200000a 	andeq	r0, r0, #10
    1014:	0000484d 	andeq	r4, r0, sp, asr #16
    1018:	01000100 	mrseq	r0, (UNDEF: 16)
    101c:	00000d61 	andeq	r0, r0, r1, ror #26
    1020:	00484e02 	subeq	r4, r8, r2, lsl #28
    1024:	01010000 	mrseq	r0, (UNDEF: 1)
    1028:	000d2801 	andeq	r2, sp, r1, lsl #16
    102c:	484f0200 	stmdami	pc, {r9}^	@ <UNPREDICTABLE>
    1030:	01000000 	mrseq	r0, (UNDEF: 0)
    1034:	0a670102 	beq	19c1444 <cpsr_cp+0x19be1bc>
    1038:	50020000 	andpl	r0, r2, r0
    103c:	00000048 	andeq	r0, r0, r8, asr #32
    1040:	4c080304 	stcmi	3, cr0, [r8], {4}
    1044:	51004542 	tstpl	r0, r2, asr #10
    1048:	00000048 	andeq	r0, r0, r8, asr #32
    104c:	58540807 	ldmdapl	r4, {r0, r1, r2, fp}^
    1050:	48520045 	ldmdami	r2, {r0, r2, r6}^
    1054:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    1058:	45585208 	ldrbmi	r5, [r8, #-520]	@ 0xfffffdf8
        ch = (char)va_arg(arg, int32_t);
    105c:	00485300 	subeq	r5, r8, r0, lsl #6
    1060:	08090000 	stmdaeq	r9, {}	@ <UNPREDICTABLE>
    1064:	00525444 	subseq	r5, r2, r4, asr #8
    1068:	00004854 	andeq	r4, r0, r4, asr r8
    106c:	52080a00 	andpl	r0, r8, #0, 20
        buf[c++] = ch;
    1070:	55005354 	strpl	r5, [r0, #-852]	@ 0xfffffcac
    1074:	00000048 	andeq	r0, r0, r8, asr #32
    1078:	0d67010b 	stfeqe	f0, [r7, #-44]!	@ 0xffffffd4
    107c:	56020000 	strpl	r0, [r2], -r0
    1080:	00000048 	andeq	r0, r0, r8, asr #32
    1084:	6c010c01 	stcvs	12, cr0, [r1], {1}
    1088:	0200000d 	andeq	r0, r0, #13
        break;
    108c:	00004857 	andeq	r4, r0, r7, asr r8
        str = (char*)va_arg(arg, char*);
    1090:	010d0100 	mrseq	r0, (UNDEF: 29)
    1094:	000009e3 	andeq	r0, r0, r3, ror #19
    1098:	00485802 	subeq	r5, r8, r2, lsl #16
    109c:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
    10a0:	000bfa01 	andeq	pc, fp, r1, lsl #20
        if (str == NULL) {
    10a4:	48590200 	ldmdami	r9, {r9}^
    10a8:	01000000 	mrseq	r0, (UNDEF: 0)
    10ac:	0983010f 	stmibeq	r3, {r0, r1, r2, r3, r8}
          str = "(null)";
    10b0:	5a020000 	bpl	810b8 <cpsr_cp+0x7de30>
    10b4:	00000048 	andeq	r0, r0, r8, asr #32
    10b8:	05001010 	streq	r1, [r0, #-16]
        while (*str) {
    10bc:	00000d2e 	andeq	r0, r0, lr, lsr #26
          buf[c++] = (*str++);
    10c0:	044e4a02 	strbeq	r4, [lr], #-2562	@ 0xfffff5fe
    10c4:	61060000 	mrsvs	r0, (UNDEF: 6)
    10c8:	02006c6c 	andeq	r6, r0, #108, 24	@ 0x6c00
    10cc:	0000484b 	andeq	r4, r0, fp, asr #16
    10d0:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
    10d4:	5b020000 	blpl	810dc <cpsr_cp+0x7de54>
    10d8:	00000378 	andeq	r0, r0, r8, ror r3
    10dc:	0d2e0300 	stceq	3, cr0, [lr, #-0]
    10e0:	5c020000 	stcpl	0, cr0, [r2], {-0}
    10e4:	00042c03 	andeq	r2, r4, r3, lsl #24
        while (*str) {
    10e8:	5f020400 	svcpl	0x00020400
    10ec:	00000489 	andeq	r0, r0, r9, lsl #9
    10f0:	000a8601 	andeq	r8, sl, r1, lsl #12
    10f4:	48600200 	stmdami	r0!, {r9}^
        break;
    10f8:	03000000 	movweq	r0, #0
        uint = (uint32_t)va_arg(arg, uint32_t);
    10fc:	0b640100 	bleq	1901504 <cpsr_cp+0x18fe27c>
    1100:	61020000 	mrsvs	r0, (UNDEF: 2)
    1104:	00000048 	andeq	r0, r0, r8, asr #32
    1108:	c7010303 	strgt	r0, [r1, -r3, lsl #6]
    110c:	02000008 	andeq	r0, r0, #8
        c += utoa(&buf[c], uint, utoa_dec);
    1110:	00004862 	andeq	r4, r0, r2, ror #16
    1114:	00061a00 	andeq	r1, r6, r0, lsl #20
    1118:	000bb705 	andeq	fp, fp, r5, lsl #14
    111c:	ab5d0200 	blge	1741924 <cpsr_cp+0x173e69c>
    1120:	06000004 	streq	r0, [r0], -r4
    1124:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1128:	00485e02 	subeq	r5, r8, r2, lsl #28
    112c:	5c070000 	stcpl	0, cr0, [r7], {-0}
    1130:	02000009 	andeq	r0, r0, #9
    1134:	00045a63 	andeq	r5, r4, r3, ror #20
    1138:	b7030000 	strlt	r0, [r3, -r0]
        break;
    113c:	0200000b 	andeq	r0, r0, #11
        hex = (uint32_t)va_arg(arg, uint32_t);
    1140:	04890364 	streq	r0, [r9], #868	@ 0x364
    1144:	02040000 	andeq	r0, r4, #0
    1148:	00055b67 	andeq	r5, r5, r7, ror #22
    114c:	0cb40100 	ldfeqs	f0, [r4]
    1150:	68020000 	stmdavs	r2, {}	@ <UNPREDICTABLE>
        c += utoa(&buf[c], hex, utoa_hex);
    1154:	00000048 	andeq	r0, r0, r8, asr #32
    1158:	4b010001 	blmi	41164 <cpsr_cp+0x3dedc>
    115c:	0200000a 	andeq	r0, r0, #10
    1160:	00004869 	andeq	r4, r0, r9, ror #16
    1164:	01010100 	mrseq	r0, (UNDEF: 17)
    1168:	00000aa2 	andeq	r0, r0, r2, lsr #21
    116c:	00486a02 	subeq	r6, r8, r2, lsl #20
    1170:	02010000 	andeq	r0, r1, #0
    1174:	000c6f01 	andeq	r6, ip, r1, lsl #30
    1178:	486b0200 	stmdami	fp!, {r9}^
    117c:	01000000 	mrseq	r0, (UNDEF: 0)
        break;
    1180:	0abc0103 	beq	fef01594 <cpsr_cp+0xfeefe30c>
      buf[c++] = format[i];
    1184:	6c020000 	stcvs	0, cr0, [r2], {-0}
    1188:	00000048 	andeq	r0, r0, r8, asr #32
    118c:	ee010401 	cdp	4, 0, cr0, cr1, cr1, {0}
    1190:	0200000c 	andeq	r0, r0, #12
    1194:	0000486d 	andeq	r4, r0, sp, ror #16
    1198:	01050100 	mrseq	r0, (UNDEF: 21)
    119c:	000009de 	ldrdeq	r0, [r0], -lr
    11a0:	00486e02 	subeq	r6, r8, r2, lsl #28
    11a4:	06010000 	streq	r0, [r1], -r0
    11a8:	000a0701 	andeq	r0, sl, r1, lsl #14
    if (c >= PRINTF_BUF_LEN) {
    11ac:	486f0200 	stmdami	pc!, {r9}^	@ <UNPREDICTABLE>
    11b0:	01000000 	mrseq	r0, (UNDEF: 0)
    11b4:	0aae0107 	beq	feb815d8 <cpsr_cp+0xfeb7e350>
        buf[0] = '\0';
    11b8:	70020000 	andvc	r0, r2, r0
    11bc:	00000048 	andeq	r0, r0, r8, asr #32
    11c0:	1e010801 	cdpne	8, 0, cr0, cr1, cr1, {0}
        return 0;
    11c4:	0200000a 	andeq	r0, r0, #10
    11c8:	00004871 	andeq	r4, r0, r1, ror r8
  for (uint32_t i = 0; format[i]; ++i) {
    11cc:	01090100 	mrseq	r0, (UNDEF: 25)
    11d0:	00000a19 	andeq	r0, r0, r9, lsl sl
    11d4:	00487202 	subeq	r7, r8, r2, lsl #4
    11d8:	0a010000 	beq	411e0 <cpsr_cp+0x3df58>
    11dc:	0008c701 	andeq	ip, r8, r1, lsl #14
    11e0:	48730200 	ldmdami	r3!, {r9}^
    11e4:	15000000 	strne	r0, [r0, #-0]
    11e8:	3505000b 	strcc	r0, [r5, #-11]
    11ec:	0200000a 	andeq	r0, r0, #10
  buf[c] = '\0';
    11f0:	00057d65 	andeq	r7, r5, r5, ror #26
    11f4:	6c610600 	stclvs	6, cr0, [r1], #-0
    11f8:	6602006c 	strvs	r0, [r2], -ip, rrx
    11fc:	00000048 	andeq	r0, r0, r8, asr #32
    1200:	00095c07 	andeq	r5, r9, r7, lsl #24
  return c;
    1204:	b7740200 	ldrblt	r0, [r4, -r0, lsl #4]!
}
    1208:	00000004 	andeq	r0, r0, r4
    120c:	000a3503 	andeq	r3, sl, r3, lsl #10
    1210:	03750200 	cmneq	r5, #0, 4
uint32_t utoa(char* buf, uint32_t val, utoa_t base) {
    1214:	0000055b 	andeq	r0, r0, fp, asr r5
    1218:	2d780204 	lfmcs	f0, 2, [r8, #-16]!
    121c:	01000006 	tsteq	r0, r6
    1220:	00000acb 	andeq	r0, r0, fp, asr #21
    1224:	00487902 	subeq	r7, r8, r2, lsl #18
    1228:	00010000 	andeq	r0, r1, r0
    122c:	000bf201 	andeq	pc, fp, r1, lsl #4
  uint32_t c = 0;
    1230:	487a0200 	ldmdami	sl!, {r9}^
    1234:	01000000 	mrseq	r0, (UNDEF: 0)
  int32_t idx = 0;
    1238:	0aec0101 	beq	ffb01644 <cpsr_cp+0xffafe3bc>
    123c:	7b020000 	blvc	81244 <cpsr_cp+0x7dfbc>
    uint32_t t = val % (uint32_t)base;
    1240:	00000048 	andeq	r0, r0, r8, asr #32
    1244:	f4010201 	vst1.8	{d0-d3}, [r1], r1
    1248:	0200000a 	andeq	r0, r0, #10
    124c:	0000487c 	andeq	r4, r0, ip, ror r8
    1250:	01030100 	mrseq	r0, (UNDEF: 19)
    1254:	00000a9c 	muleq	r0, ip, sl
    1258:	00487d02 	subeq	r7, r8, r2, lsl #26
    if (t >= 10) {
    125c:	04010000 	streq	r0, [r1], #-0
    1260:	000b7301 	andeq	r7, fp, r1, lsl #6
    1264:	487e0200 	ldmdami	lr!, {r9}^
      t += 'A' - 10 - '0';
    1268:	01000000 	mrseq	r0, (UNDEF: 0)
    126c:	0c520105 	ldfeqe	f0, [r2], {5}
    1270:	7f020000 	svcvc	0x00020000
    tmp[idx++] = (t + '0');
    1274:	00000048 	andeq	r0, r0, r8, asr #32
    1278:	ba010601 	blt	42a84 <cpsr_cp+0x3f7fc>
    127c:	0200000c 	andeq	r0, r0, #12
    1280:	00004880 	andeq	r4, r0, r0, lsl #17
    1284:	01070100 	mrseq	r0, (UNDEF: 23)
    1288:	00000d71 	andeq	r0, r0, r1, ror sp
    128c:	00488102 	subeq	r8, r8, r2, lsl #2
    1290:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    1294:	000c6901 	andeq	r6, ip, r1, lsl #18
    1298:	48820200 	stmmi	r2, {r9}
    val /= base;
    129c:	01000000 	mrseq	r0, (UNDEF: 0)
    12a0:	0b470109 	bleq	11c16cc <cpsr_cp+0x11be444>
    12a4:	83020000 	movwhi	r0, #8192	@ 0x2000
    12a8:	00000048 	andeq	r0, r0, r8, asr #32
    12ac:	c7010a01 	strgt	r0, [r1, -r1, lsl #20]
    12b0:	02000008 	andeq	r0, r0, #8
  } while(val);
    12b4:	00004884 	andeq	r4, r0, r4, lsl #17
    12b8:	000b1500 	andeq	r1, fp, r0, lsl #10
    12bc:	000c5805 	andeq	r5, ip, r5, lsl #16
  --idx; // idx를 부호 있는 정수형으로 선언한 이유
    12c0:	4f760200 	svcmi	0x00760200
    12c4:	06000006 	streq	r0, [r0], -r6
    12c8:	006c6c61 	rsbeq	r6, ip, r1, ror #24
  while (idx >= 0) {
    12cc:	00487702 	subeq	r7, r8, r2, lsl #14
    buf[c++] = tmp[idx--];
    12d0:	5c070000 	stcpl	0, cr0, [r7], {-0}
    12d4:	02000009 	andeq	r0, r0, #9
    12d8:	00058985 	andeq	r8, r5, r5, lsl #19
    12dc:	58030000 	stmdapl	r3, {}	@ <UNPREDICTABLE>
    12e0:	0200000c 	andeq	r0, r0, #12
    12e4:	062d0386 	strteq	r0, [sp], -r6, lsl #7
    12e8:	02040000 	andeq	r0, r4, #0
    12ec:	0006ff89 	andeq	pc, r6, r9, lsl #31
    12f0:	0a8f0100 	beq	fe3c16f8 <cpsr_cp+0xfe3be470>
    12f4:	8a020000 	bhi	812fc <cpsr_cp+0x7e074>
    12f8:	00000048 	andeq	r0, r0, r8, asr #32
    12fc:	52010001 	andpl	r0, r1, #1
  while (idx >= 0) {
    1300:	0200000a 	andeq	r0, r0, #10
    1304:	0000488b 	andeq	r4, r0, fp, lsl #17
    1308:	01010100 	mrseq	r0, (UNDEF: 17)
  return c;
    130c:	00000c2e 	andeq	r0, r0, lr, lsr #24
    1310:	00488c02 	subeq	r8, r8, r2, lsl #24
    1314:	02010000 	andeq	r0, r1, #0
    1318:	000d2001 	andeq	r2, sp, r1
    131c:	488d0200 	stmmi	sp, {r9}
    1320:	01000000 	mrseq	r0, (UNDEF: 0)
void delay(uint32_t ms) {
    1324:	0a5a0103 	beq	1681738 <cpsr_cp+0x167e4b0>
    1328:	8e020000 	cdphi	0, 0, cr0, cr2, cr0, {0}
    132c:	00000048 	andeq	r0, r0, r8, asr #32
    1330:	28010401 	stmdacs	r1, {r0, sl}
  uint32_t goal = Hal_timer_get_1ms_counter() + ms;
    1334:	0200000b 	andeq	r0, r0, #11
    1338:	0000488f 	andeq	r4, r0, pc, lsl #17
    133c:	01050100 	mrseq	r0, (UNDEF: 21)
    1340:	00000be3 	andeq	r0, r0, r3, ror #23
    1344:	00489002 	subeq	r9, r8, r2
  while(goal != Hal_timer_get_1ms_counter());
    1348:	06010000 	streq	r0, [r1], -r0
    134c:	000ad201 	andeq	sp, sl, r1, lsl #4
    1350:	48910200 	ldmmi	r1, {r9}
    1354:	01000000 	mrseq	r0, (UNDEF: 0)
    1358:	0d5b0107 	ldfeqe	f0, [fp, #-28]	@ 0xffffffe4
    135c:	92020000 	andls	r0, r2, #0
    1360:	00000048 	andeq	r0, r0, r8, asr #32
    1364:	71010801 	tstvc	r1, r1, lsl #16
    1368:	0200000a 	andeq	r0, r0, #10
    136c:	00004893 	muleq	r0, r3, r8
void Kernel_event_flag_init(void) {
    1370:	01090100 	mrseq	r0, (UNDEF: 25)
    1374:	00000a96 	muleq	r0, r6, sl
  sEventFlag = 0;
    1378:	00489402 	subeq	r9, r8, r2, lsl #8
    137c:	0a010000 	beq	41384 <cpsr_cp+0x3e0fc>
    1380:	0008c701 	andeq	ip, r8, r1, lsl #14
    1384:	48950200 	ldmmi	r5, {r9}
}
    1388:	15000000 	strne	r0, [r0, #-0]
    138c:	9505000b 	strls	r0, [r5, #-11]
    1390:	0200000b 	andeq	r0, r0, #11
    1394:	00072187 	andeq	r2, r7, r7, lsl #3
void Kernel_event_flag_set(KernelEventFlag_t event) {
    1398:	6c610600 	stclvs	6, cr0, [r1], #-0
    139c:	8802006c 	stmdahi	r2, {r2, r3, r5, r6}
    13a0:	00000048 	andeq	r0, r0, r8, asr #32
    13a4:	00095c07 	andeq	r5, r9, r7, lsl #24
  sEventFlag |= (uint32_t)event;
    13a8:	5b960200 	blpl	fe581bb0 <cpsr_cp+0xfe57e928>
    13ac:	00000006 	andeq	r0, r0, r6
    13b0:	000b9503 	andeq	r9, fp, r3, lsl #10
    13b4:	03970200 	orrseq	r0, r7, #0, 4
    13b8:	000006ff 	strdeq	r0, [r0], -pc	@ <UNPREDICTABLE>
    13bc:	d19a0204 	orrsle	r0, sl, r4, lsl #4
    13c0:	01000007 	tsteq	r0, r7
    13c4:	00000d06 	andeq	r0, r0, r6, lsl #26
}
    13c8:	00489b02 	subeq	r9, r8, r2, lsl #22
    13cc:	00010000 	andeq	r0, r1, r0
    13d0:	000a2e01 	andeq	r2, sl, r1, lsl #28
    13d4:	489c0200 	ldmmi	ip, {r9}
void Kernel_event_flag_clear(KernelEventFlag_t event) {
    13d8:	01000000 	mrseq	r0, (UNDEF: 0)
    13dc:	0a600101 	beq	18017e8 <cpsr_cp+0x17fe560>
    13e0:	9d020000 	stcls	0, cr0, [r2, #-0]
    13e4:	00000048 	andeq	r0, r0, r8, asr #32
  sEventFlag &= ~((uint32_t)event);
    13e8:	62010201 	andvs	r0, r1, #268435456	@ 0x10000000
    13ec:	0200000c 	andeq	r0, r0, #12
    13f0:	0000489e 	muleq	r0, lr, r8
    13f4:	01030100 	mrseq	r0, (UNDEF: 19)
    13f8:	00000aa9 	andeq	r0, r0, r9, lsr #21
    13fc:	00489f02 	subeq	r9, r8, r2, lsl #30
    1400:	04010000 	streq	r0, [r1], #-0
    1404:	000a1401 	andeq	r1, sl, r1, lsl #8
    1408:	48a00200 	stmiami	r0!, {r9}
}
    140c:	01000000 	mrseq	r0, (UNDEF: 0)
    1410:	0d770105 	ldfeqe	f0, [r7, #-20]!	@ 0xffffffec
    1414:	a1020000 	mrsge	r0, (UNDEF: 2)
    1418:	00000048 	andeq	r0, r0, r8, asr #32
bool Kernel_event_flag_check(KernelEventFlag_t event) {
    141c:	e9010601 	stmdb	r1, {r0, r9, sl}
    1420:	02000009 	andeq	r0, r0, #9
    1424:	000048a2 	andeq	r4, r0, r2, lsr #17
    1428:	01070100 	mrseq	r0, (UNDEF: 23)
  if(sEventFlag & (uint32_t)event) {
    142c:	00000d37 	andeq	r0, r0, r7, lsr sp
    1430:	0048a302 	subeq	sl, r8, r2, lsl #6
    1434:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    1438:	000b5601 	andeq	r5, fp, r1, lsl #12
    143c:	48a40200 	stmiami	r4!, {r9}
    1440:	01000000 	mrseq	r0, (UNDEF: 0)
    1444:	09fa0109 	ldmibeq	sl!, {r0, r3, r8}^
    Kernel_event_flag_clear(event);
    1448:	a5020000 	strge	r0, [r2, #-0]
    144c:	00000048 	andeq	r0, r0, r8, asr #32
    return true;
    1450:	c7010a01 	strgt	r0, [r1, -r1, lsl #20]
    1454:	02000008 	andeq	r0, r0, #8
  return false;
    1458:	000048a6 	andeq	r4, r0, r6, lsr #17
    145c:	000b1500 	andeq	r1, fp, r0, lsl #10
    1460:	000cf305 	andeq	pc, ip, r5, lsl #6
    1464:	f3980200 	vsubl.u16	q0, d8, d0
void Kernel_start(void) {
    1468:	06000007 	streq	r0, [r0], -r7
    146c:	006c6c61 	rsbeq	r6, ip, r1, ror #24
  Kernel_task_start();
    1470:	00489902 	subeq	r9, r8, r2, lsl #18
}
    1474:	5c070000 	stcpl	0, cr0, [r7], {-0}
    1478:	02000009 	andeq	r0, r0, #9
void Kernel_yield(void) {
    147c:	00072da7 	andeq	r2, r7, r7, lsr #27
    1480:	f3030000 	vhadd.u8	d0, d3, d0
  Kernel_task_scheduling();
    1484:	0200000c 	andeq	r0, r0, #12
}
    1488:	07d103a8 	ldrbeq	r0, [r1, r8, lsr #7]
    148c:	02040000 	andeq	r0, r4, #0
void Kernel_send_events(uint32_t event_list) {
    1490:	00083bab 	andeq	r3, r8, fp, lsr #23
    1494:	0b8e0100 	bleq	fe38189c <cpsr_cp+0xfe37e614>
    1498:	ac020000 	stcge	0, cr0, [r2], {-0}
    149c:	00000048 	andeq	r0, r0, r8, asr #32
  for(uint32_t i = 0; i < 32; ++i) {
    14a0:	ad010001 	stcge	0, cr0, [r1, #-4]
    14a4:	0200000c 	andeq	r0, r0, #12
    14a8:	000048ad 	andeq	r4, r0, sp, lsr #17
    if((event_list >> i) & 1) {
    14ac:	01010100 	mrseq	r0, (UNDEF: 17)
    14b0:	00000bc2 	andeq	r0, r0, r2, asr #23
    14b4:	0048ae02 	subeq	sl, r8, r2, lsl #28
    14b8:	02010000 	andeq	r0, r1, #0
    14bc:	0008c701 	andeq	ip, r8, r1, lsl #14
    14c0:	48af0200 	stmiami	pc!, {r9}	@ <UNPREDICTABLE>
      KernelEventFlag_t sending_event = KernelEventFlag_Empty;
    14c4:	1d000000 	stcne	0, cr0, [r0, #-0]
    14c8:	ee050003 	cdp	0, 0, cr0, cr5, cr3, {0}
      sending_event = (KernelEventFlag_t)SET_BIT(sending_event, i);
    14cc:	02000009 	andeq	r0, r0, #9
    14d0:	00085da9 	andeq	r5, r8, r9, lsr #27
    14d4:	6c610600 	stclvs	6, cr0, [r1], #-0
    14d8:	aa02006c 	bge	81690 <cpsr_cp+0x7e408>
    14dc:	00000048 	andeq	r0, r0, r8, asr #32
    14e0:	00095c07 	andeq	r5, r9, r7, lsl #24
    14e4:	ffb00200 			@ <UNDEFINED> instruction: 0xffb00200
      Kernel_event_flag_set(sending_event);
    14e8:	00000007 	andeq	r0, r0, r7
    14ec:	0009ee03 	andeq	lr, r9, r3, lsl #28
  for(uint32_t i = 0; i < 32; ++i) {
    14f0:	03b10200 			@ <UNDEFINED> instruction: 0x03b10200
    14f4:	0000083b 	andeq	r0, r0, fp, lsr r8
    14f8:	000c400e 	andeq	r4, ip, lr
    14fc:	b3024c00 	movwlt	r4, #11264	@ 0x2c00
    1500:	00000946 	andeq	r0, r0, r6, asr #18
    1504:	000b1c02 	andeq	r1, fp, r2, lsl #24
}
    1508:	0fb40200 	svceq	0x00b40200
    150c:	000000ce 	andeq	r0, r0, lr, asr #1
    1510:	0cd80200 	lfmeq	f0, 2, [r8], {0}
    1514:	b5020000 	strlt	r0, [r2, #-0]
KernelEventFlag_t Kernel_wait_events(uint32_t waiting_list) {
    1518:	0001390f 	andeq	r3, r1, pc, lsl #18
    151c:	86020400 	strhi	r0, [r2], -r0, lsl #8
    1520:	02000008 	andeq	r0, r0, #8
    1524:	09460fb6 	stmdbeq	r6, {r1, r2, r4, r5, r7, r8, r9, sl, fp}^
  for(uint32_t i = 0; i < 32; ++i) {
    1528:	02080000 	andeq	r0, r8, #0
    152c:	00000c27 	andeq	r0, r0, r7, lsr #24
    1530:	e80fb702 	stmda	pc, {r1, r8, r9, sl, ip, sp, pc}	@ <UNPREDICTABLE>
    if((waiting_list >> i) & 1) {
    1534:	18000001 	stmdane	r0, {r0}
    1538:	00099e02 	andeq	r9, r9, r2, lsl #28
    153c:	0fb80200 	svceq	0x00b80200
    1540:	00000048 	andeq	r0, r0, r8, asr #32
    1544:	0cfd021c 	lfmeq	f0, 2, [sp], #112	@ 0x70
    1548:	b9020000 	stmdblt	r2, {}	@ <UNPREDICTABLE>
      KernelEventFlag_t waiting_event = KernelEventFlag_Empty;
    154c:	0002380f 	andeq	r3, r2, pc, lsl #16
    1550:	52022000 	andpl	r2, r2, #0
      waiting_event = (KernelEventFlag_t)SET_BIT(waiting_event, i);
    1554:	0200000d 	andeq	r0, r0, #13
    1558:	02880fba 	addeq	r0, r8, #744	@ 0x2e8
    155c:	02240000 	eoreq	r0, r4, #0
    1560:	00000ab3 			@ <UNDEFINED> instruction: 0x00000ab3
    1564:	d80fbb02 	stmdale	pc, {r1, r8, r9, fp, ip, sp, pc}	@ <UNPREDICTABLE>
    1568:	28000002 	stmdacs	r0, {r1}
    156c:	000ae202 	andeq	lr, sl, r2, lsl #4
      if(Kernel_event_flag_check(waiting_event)) {
    1570:	0fbc0200 	svceq	0x00bc0200
    1574:	0000036c 	andeq	r0, r0, ip, ror #6
    1578:	0ca1022c 	sfmeq	f0, 4, [r1], #176	@ 0xb0
    157c:	bd020000 	stclt	0, cr0, [r2, #-0]
    1580:	00044e0f 	andeq	r4, r4, pc, lsl #28
        return waiting_event;
    1584:	5b023000 	blpl	8d58c <cpsr_cp+0x8a304>
    1588:	0200000b 	andeq	r0, r0, #11
  for(uint32_t i = 0; i < 32; ++i) {
    158c:	04ab0fbe 	strteq	r0, [fp], #4030	@ 0xfbe
    1590:	02340000 	eorseq	r0, r4, #0
    1594:	00000b4d 	andeq	r0, r0, sp, asr #22
    1598:	7d0fbf02 	stcvc	15, cr11, [pc, #-8]	@ 1598 <Kernel_wait_events+0x80>
    159c:	38000005 	stmdacc	r0, {r0, r2}
    15a0:	000a7702 	andeq	r7, sl, r2, lsl #14
  return KernelEventFlag_Empty;
    15a4:	0fc00200 	svceq	0x00c00200
}
    15a8:	0000064f 	andeq	r0, r0, pc, asr #12
    15ac:	0bdb023c 	bleq	ff6c1ea4 <cpsr_cp+0xff6bec1c>
    15b0:	c1020000 	mrsgt	r0, (UNDEF: 2)
bool Kernel_send_msg(KernelMsgQ_t Qname, void* data, uint32_t count) {
    15b4:	0007210f 	andeq	r2, r7, pc, lsl #2
    15b8:	79024000 	stmdbvc	r2, {lr}
    15bc:	0200000b 	andeq	r0, r0, #11
    15c0:	07f30fc2 	ldrbeq	r0, [r3, r2, asr #31]!
    15c4:	02440000 	subeq	r0, r4, #0
    15c8:	00000ad8 	ldrdeq	r0, [r0], -r8
    15cc:	5d0fc302 	stcpl	3, cr12, [pc, #-8]	@ 15cc <Kernel_send_msg+0x18>
  uint8_t* d = (uint8_t*)data;
    15d0:	48000008 	stmdami	r0, {r3}
    15d4:	00480f00 	subeq	r0, r8, r0, lsl #30
  for(uint32_t i = 0; i < count; ++i) {
    15d8:	09560000 	ldmdbeq	r6, {}^	@ <UNPREDICTABLE>
    15dc:	54100000 	ldrpl	r0, [r0], #-0
    15e0:	03000000 	movweq	r0, #0
    if(!Kernel_msgQ_enqueue(Qname, *d)) {
    15e4:	0c400300 	mcrreq	3, 0, r0, r0, cr0
    15e8:	c4020000 	strgt	r0, [r2], #-0
    15ec:	00086903 	andeq	r6, r8, r3, lsl #18
    15f0:	09560b00 	ldmdbeq	r6, {r8, r9, fp}^
    15f4:	04040000 	streq	r0, [r4], #-0
    15f8:	00098906 	andeq	r8, r9, r6, lsl #18
    15fc:	0cc30100 	stfeqe	f0, [r3], {0}
    1600:	07040000 	streq	r0, [r4, -r0]
    1604:	00000048 	andeq	r0, r0, r8, asr #32
    1608:	c7010001 	strgt	r0, [r1, -r1]
    160c:	04000008 	streq	r0, [r0], #-8
      for(uint32_t j = 0; j < i; ++j) {
    1610:	00004808 	andeq	r4, r0, r8, lsl #16
    1614:	00011f00 	andeq	r1, r1, r0, lsl #30
    1618:	00083b05 	andeq	r3, r8, r5, lsl #22
        Kernel_msgQ_dequeue(Qname, &rollback);
    161c:	ab040400 	blge	102624 <cpsr_cp+0xff39c>
    1620:	06000009 	streq	r0, [r0], -r9
    1624:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1628:	00480504 	subeq	r0, r8, r4, lsl #10
    162c:	5c070000 	stcpl	0, cr0, [r7], {-0}
      for(uint32_t j = 0; j < i; ++j) {
    1630:	04000009 	streq	r0, [r0], #-9
    1634:	00096709 	andeq	r6, r9, r9, lsl #14
    1638:	3b030000 	blcc	c1640 <cpsr_cp+0xbe3b8>
    163c:	04000008 	streq	r0, [r0], #-8
    1640:	0989030a 	stmibeq	r9, {r1, r3, r8, r9}
    1644:	04040000 	streq	r0, [r4], #-0
    1648:	0009e60d 	andeq	lr, r9, sp, lsl #12
      return false;
    164c:	07710100 	ldrbeq	r0, [r1, -r0, lsl #2]!
    1650:	0e040000 	cdpeq	0, 0, cr0, cr4, cr0, {0}
    ++d;
    1654:	00000048 	andeq	r0, r0, r8, asr #32
    1658:	93010004 	movwls	r0, #4100	@ 0x1004
    165c:	04000007 	streq	r0, [r0], #-7
  for(uint32_t i = 0; i < count; ++i) {
    1660:	0000480f 	andeq	r4, r0, pc, lsl #16
    1664:	01040400 	tsteq	r4, r0, lsl #8
    1668:	000008c7 	andeq	r0, r0, r7, asr #17
    166c:	00481004 	subeq	r1, r8, r4
    1670:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
    1674:	08e10500 	stmiaeq	r1!, {r8, sl}^
    1678:	0b040000 	bleq	101680 <cpsr_cp+0xfe3f8>
  return true;
    167c:	00000a08 	andeq	r0, r0, r8, lsl #20
}
    1680:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
    1684:	480c0400 	stmdami	ip, {sl}
    1688:	07000000 	streq	r0, [r0, -r0]
uint32_t Kernel_recv_msg(KernelMsgQ_t Qname, void* out_data, uint32_t count) {
    168c:	0000095c 	andeq	r0, r0, ip, asr r9
    1690:	09b71104 	ldmibeq	r7!, {r2, r8, ip}
    1694:	03000000 	movweq	r0, #0
    1698:	000008e1 	andeq	r0, r0, r1, ror #17
    169c:	e6031204 	str	r1, [r3], -r4, lsl #4
    16a0:	04000009 	streq	r0, [r0], #-9
    16a4:	0a361504 	beq	d86abc <cpsr_cp+0xd83834>
  uint8_t* d = (uint8_t*)out_data;
    16a8:	a0010000 	andge	r0, r1, r0
    16ac:	04000007 	streq	r0, [r0], #-7
  for(uint32_t i = 0; i < count; ++i) {
    16b0:	00004816 	andeq	r4, r0, r6, lsl r8
    16b4:	01000300 	mrseq	r0, LR_irq
    16b8:	000008c7 	andeq	r0, r0, r7, asr #17
    if(!Kernel_msgQ_dequeue(Qname, d)) {
    16bc:	00481704 	subeq	r1, r8, r4, lsl #14
    16c0:	031d0000 	tsteq	sp, #0
    16c4:	07b90500 	ldreq	r0, [r9, r0, lsl #10]!
    16c8:	13040000 	movwne	r0, #16384	@ 0x4000
    16cc:	00000a58 	andeq	r0, r0, r8, asr sl
    16d0:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
    16d4:	48140400 	ldmdami	r4, {sl}
    16d8:	07000000 	streq	r0, [r0, -r0]
    16dc:	0000095c 	andeq	r0, r0, ip, asr r9
      return i;
    16e0:	0a141804 	beq	5076f8 <cpsr_cp+0x504470>
    16e4:	03000000 	movweq	r0, #0
    ++d;
    16e8:	000007b9 			@ <UNDEFINED> instruction: 0x000007b9
    16ec:	36031904 	strcc	r1, [r3], -r4, lsl #18
    16f0:	0400000a 	streq	r0, [r0], #-10
  for(uint32_t i = 0; i < count; ++i) {
    16f4:	0a931c04 	beq	fe4c870c <cpsr_cp+0xfe4c5484>
    16f8:	a8010000 	stmdage	r1, {}	@ <UNPREDICTABLE>
    16fc:	04000009 	streq	r0, [r0], #-9
    1700:	0000481d 	andeq	r4, r0, sp, lsl r8
    1704:	01000a00 	tsteq	r0, r0, lsl #20
    1708:	000007c7 	andeq	r0, r0, r7, asr #15
    170c:	00481e04 	subeq	r1, r8, r4, lsl #28
  return count;
    1710:	0a030000 	beq	c1718 <cpsr_cp+0xbe490>
}
    1714:	0008c701 	andeq	ip, r8, r1, lsl #14
    1718:	481f0400 	ldmdami	pc, {sl}	@ <UNPREDICTABLE>
    171c:	13000000 	movwne	r0, #0
void Kernel_lock_sem(void) {
    1720:	2a05000d 	bcs	14175c <cpsr_cp+0x13e4d4>
    1724:	04000009 	streq	r0, [r0], #-9
  while (!Kernel_sem_test()) {
    1728:	000ab51a 	andeq	fp, sl, sl, lsl r5
    Kernel_yield();
    172c:	6c610600 	stclvs	6, cr0, [r1], #-0
  while (!Kernel_sem_test()) {
    1730:	1b04006c 	blne	1018e8 <cpsr_cp+0xfe660>
    1734:	00000048 	andeq	r0, r0, r8, asr #32
    1738:	00095c07 	andeq	r5, r9, r7, lsl #24
    173c:	64200400 	strtvs	r0, [r0], #-1024	@ 0xfffffc00
    1740:	0000000a 	andeq	r0, r0, sl
    1744:	00092a03 	andeq	r2, r9, r3, lsl #20
}
    1748:	03210400 			@ <UNDEFINED> instruction: 0x03210400
    174c:	00000a93 	muleq	r0, r3, sl
    1750:	f0240404 			@ <UNDEFINED> instruction: 0xf0240404
void Kernel_unlock_sem(void) {
    1754:	0100000a 	tsteq	r0, sl
    1758:	000009a8 	andeq	r0, r0, r8, lsr #19
  Kernel_sem_release();
    175c:	00482504 	subeq	r2, r8, r4, lsl #10
}
    1760:	000a0000 	andeq	r0, sl, r0
    1764:	0007c701 	andeq	ip, r7, r1, lsl #14
void Kernel_lock_mutex(void) {
    1768:	48260400 	stmdami	r6!, {sl}
    176c:	03000000 	movweq	r0, #0
    1770:	08c7010a 	stmiaeq	r7, {r1, r3, r8}^
    uint32_t current_task_id = Kernel_task_get_current_task_id();
    1774:	27040000 	strcs	r0, [r4, -r0]
    1778:	00000048 	andeq	r0, r0, r8, asr #32
    if(!Kernel_mutex_lock(current_task_id)) {
    177c:	05000d13 	streq	r0, [r0, #-3347]	@ 0xfffff2ed
    1780:	000008d0 	ldrdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
    1784:	0b122204 	bleq	489f9c <cpsr_cp+0x486d14>
    1788:	61060000 	mrsvs	r0, (UNDEF: 6)
    178c:	04006c6c 	streq	r6, [r0], #-3180	@ 0xfffff394
    1790:	00004823 	andeq	r4, r0, r3, lsr #16
    1794:	095c0700 	ldmdbeq	ip, {r8, r9, sl}^
      Kernel_yield();
    1798:	28040000 	stmdacs	r4, {}	@ <UNPREDICTABLE>
  while(true) {
    179c:	00000ac1 	andeq	r0, r0, r1, asr #21
      break;
    17a0:	08d00300 	ldmeq	r0, {r8, r9}^
}
    17a4:	29040000 	stmdbcs	r4, {}	@ <UNPREDICTABLE>
    17a8:	000af003 	andeq	pc, sl, r3
    17ac:	2c040400 	cfstrscs	mvf0, [r4], {-0}
void Kernel_unlock_mutex(void) {
    17b0:	00000b4d 	andeq	r0, r0, sp, asr #22
    17b4:	00077101 	andeq	r7, r7, r1, lsl #2
    17b8:	482d0400 	stmdami	sp!, {sl}
  uint32_t current_task_id = Kernel_task_get_current_task_id();
    17bc:	04000000 	streq	r0, [r0], #-0
    17c0:	087d0100 	ldmdaeq	sp!, {r8}^
  if(!Kernel_mutex_unlock(current_task_id)) {
    17c4:	2e040000 	cdpcs	0, 0, cr0, cr4, cr0, {0}
    17c8:	00000048 	andeq	r0, r0, r8, asr #32
    17cc:	c7010404 	strgt	r0, [r1, -r4, lsl #8]
    17d0:	04000008 	streq	r0, [r0], #-8
    17d4:	0000482f 	andeq	r4, r0, pc, lsr #16
    17d8:	00081800 	andeq	r1, r8, r0, lsl #16
    17dc:	00097005 	andeq	r7, r9, r5
    Kernel_yield();
    17e0:	6f2a0400 	svcvs	0x002a0400
    17e4:	0600000b 	streq	r0, [r0], -fp
    17e8:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    17ec:	00482b04 	subeq	r2, r8, r4, lsl #22
void Kernel_msgQ_init(void) {
    17f0:	5c070000 	stcpl	0, cr0, [r7], {-0}
    17f4:	04000009 	streq	r0, [r0], #-9
    17f8:	000b1e30 	andeq	r1, fp, r0, lsr lr
  for (uint32_t i = 0; i < KernelMsgQ_Num; ++i) {
    17fc:	70030000 	andvc	r0, r3, r0
    1800:	04000009 	streq	r0, [r0], #-9
    1804:	0b4d0331 	bleq	13424d0 <cpsr_cp+0x133f248>
    sMsgQ[i].front = 0;
    1808:	04040000 	streq	r0, [r4], #-0
    180c:	000baa34 	andeq	sl, fp, r4, lsr sl
    1810:	09a80100 	stmibeq	r8!, {r8}
    1814:	35040000 	strcc	r0, [r4, #-0]
    1818:	00000048 	andeq	r0, r0, r8, asr #32
    181c:	c701000a 	strgt	r0, [r1, -sl]
    1820:	04000007 	streq	r0, [r0], #-7
    1824:	00004836 	andeq	r4, r0, r6, lsr r8
    sMsgQ[i].rear = 0;
    1828:	010a0300 	mrseq	r0, (UNDEF: 58)
    182c:	000008c7 	andeq	r0, r0, r7, asr #17
    1830:	00483704 	subeq	r3, r8, r4, lsl #14
    1834:	0d130000 	ldceq	0, cr0, [r3, #-0]
    1838:	08f00500 	ldmeq	r0!, {r8, sl}^
    183c:	32040000 	andcc	r0, r4, #0
    1840:	00000bcc 	andeq	r0, r0, ip, asr #23
    1844:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
    1848:	48330400 	ldmdami	r3!, {sl}
  for (uint32_t i = 0; i < KernelMsgQ_Num; ++i) {
    184c:	07000000 	streq	r0, [r0, -r0]
    1850:	0000095c 	andeq	r0, r0, ip, asr r9
    1854:	0b7b3804 	bleq	1ecf86c <cpsr_cp+0x1ecc5e4>
    1858:	03000000 	movweq	r0, #0
    185c:	000008f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
    1860:	aa033904 	bge	cfc78 <cpsr_cp+0xcc9f0>
}
    1864:	0400000b 	streq	r0, [r0], #-11
    1868:	0bfa3c04 	bleq	ffe90880 <cpsr_cp+0xffe8d5f8>
    186c:	c3010000 	movwgt	r0, #4096	@ 0x1000
    1870:	0400000c 	streq	r0, [r0], #-12
    1874:	0000483d 	andeq	r4, r0, sp, lsr r8
bool Kernel_msgQ_is_empty(KernelMsgQ_t Qname) {
    1878:	01000100 	mrseq	r0, (UNDEF: 16)
    187c:	000008c7 	andeq	r0, r0, r7, asr #17
    1880:	00483e04 	subeq	r3, r8, r4, lsl #28
    1884:	011f0000 	tsteq	pc, r0
    1888:	075f0500 	ldrbeq	r0, [pc, -r0, lsl #10]
  if (Qname >= KernelMsgQ_Num) {
    188c:	3a040000 	bcc	101894 <cpsr_cp+0xfe60c>
    1890:	00000c1c 	andeq	r0, r0, ip, lsl ip
    1894:	6c6c6106 	stfvse	f6, [ip], #-24	@ 0xffffffe8
    return false;
    1898:	483b0400 	ldmdami	fp!, {sl}
    189c:	07000000 	streq	r0, [r0, -r0]
  if (sMsgQ[Qname].front == sMsgQ[Qname].rear) {
    18a0:	0000095c 	andeq	r0, r0, ip, asr r9
    18a4:	0bd83f04 	bleq	ff6114bc <cpsr_cp+0xff60e234>
    18a8:	03000000 	movweq	r0, #0
    18ac:	0000075f 	andeq	r0, r0, pc, asr r7
    18b0:	fa034004 	blx	d18c8 <cpsr_cp+0xce640>
    18b4:	0400000b 	streq	r0, [r0], #-11
    18b8:	0c574304 	mrrceq	3, 0, r4, r7, cr4
    18bc:	44010000 	strmi	r0, [r1], #-0
    18c0:	04000009 	streq	r0, [r0], #-9
    18c4:	00004844 	andeq	r4, r0, r4, asr #16
    18c8:	01000500 	tsteq	r0, r0, lsl #10
    18cc:	00000952 	andeq	r0, r0, r2, asr r9
    18d0:	00484504 	subeq	r4, r8, r4, lsl #10
    18d4:	05030000 	streq	r0, [r3, #-0]
    18d8:	0008c701 	andeq	ip, r8, r1, lsl #14
    18dc:	48460400 	stmdami	r6, {sl}^
    18e0:	18000000 	stmdane	r0, {}	@ <UNPREDICTABLE>
    return true;
    18e4:	8d050008 	stchi	0, cr0, [r5, #-32]	@ 0xffffffe0
    18e8:	04000009 	streq	r0, [r0], #-9
  return false;
    18ec:	000c7941 	andeq	r7, ip, r1, asr #18
}
    18f0:	6c610600 	stclvs	6, cr0, [r1], #-0
    18f4:	4204006c 	andmi	r0, r4, #108	@ 0x6c
    18f8:	00000048 	andeq	r0, r0, r8, asr #32
    18fc:	00095c07 	andeq	r5, r9, r7, lsl #24
bool Kernel_msgQ_is_full(KernelMsgQ_t Qname) {
    1900:	28470400 	stmdacs	r7, {sl}^
    1904:	0000000c 	andeq	r0, r0, ip
    1908:	00098d03 	andeq	r8, r9, r3, lsl #26
    190c:	03480400 	movteq	r0, #33792	@ 0x8400
    1910:	00000c57 	andeq	r0, r0, r7, asr ip
  if (Qname >= KernelMsgQ_Num) {
    1914:	00077a0e 	andeq	r7, r7, lr, lsl #20
    1918:	4a041c00 	bmi	108920 <cpsr_cp+0x105698>
    191c:	00000ced 	andeq	r0, r0, sp, ror #25
    return false;
    1920:	0007d302 	andeq	sp, r7, r2, lsl #6
    1924:	164b0400 	strbne	r0, [fp], -r0, lsl #8
  if (((sMsgQ[Qname].rear) + 1) % MSG_Q_SIZE_BYTE == sMsgQ[Qname].front) {
    1928:	000009ab 	andeq	r0, r0, fp, lsr #19
    192c:	082e0200 	stmdaeq	lr!, {r9}
    1930:	4c040000 	stcmi	0, cr0, [r4], {-0}
    1934:	000a0816 	andeq	r0, sl, r6, lsl r8
    1938:	1a020400 	bne	82940 <cpsr_cp+0x7f6b8>
    193c:	04000008 	streq	r0, [r0], #-8
    1940:	0a58164d 	beq	160727c <cpsr_cp+0x1603ff4>
    1944:	02080000 	andeq	r0, r8, #0
    1948:	00000752 	andeq	r0, r0, r2, asr r7
    194c:	b5164e04 	ldrlt	r4, [r6, #-3588]	@ 0xfffff1fc
    1950:	0c00000a 	stceq	0, cr0, [r0], {10}
    1954:	0007fd02 	andeq	pc, r7, r2, lsl #26
    1958:	164f0400 	strbne	r0, [pc], -r0, lsl #8
    195c:	00000b12 	andeq	r0, r0, r2, lsl fp
    1960:	09190210 	ldmdbeq	r9, {r4, r9}
    1964:	50040000 	andpl	r0, r4, r0
    1968:	000b6f16 	andeq	r6, fp, r6, lsl pc
    196c:	b6021400 	strlt	r1, [r2], -r0, lsl #8
    1970:	04000008 	streq	r0, [r0], #-8
    return true;
    1974:	0bcc1651 	bleq	ff3072c0 <cpsr_cp+0xff304038>
    1978:	00180000 	andseq	r0, r8, r0
  return false;
    197c:	00077a03 	andeq	r7, r7, r3, lsl #20
}
    1980:	03520400 	cmpeq	r2, #0, 8
    1984:	00000c85 	andeq	r0, r0, r5, lsl #25
    1988:	000ced0b 	andeq	lr, ip, fp, lsl #26
    198c:	09be1300 	ldmibeq	lr!, {r8, r9, ip}
bool Kernel_msgQ_enqueue(KernelMsgQ_t Qname, uint8_t data) {
    1990:	018c0000 	orreq	r0, ip, r0
    1994:	88105304 	ldmdahi	r0, {r2, r8, r9, ip, lr}
    1998:	0200000d 	andeq	r0, r0, #13
    199c:	0000089f 	muleq	r0, pc, r8	@ <UNPREDICTABLE>
    19a0:	1c175404 	cfldrsne	mvf5, [r7], {4}
    19a4:	0000000c 	andeq	r0, r0, ip
    19a8:	00096102 	andeq	r6, r9, r2, lsl #2
    19ac:	17550400 	ldrbne	r0, [r5, -r0, lsl #8]
  if (Qname >= KernelMsgQ_Num) {
    19b0:	00000c79 	andeq	r0, r0, r9, ror ip
    19b4:	08860204 	stmeq	r6, {r2, r9}
    19b8:	56040000 	strpl	r0, [r4], -r0
    return false;
    19bc:	000d8817 	andeq	r8, sp, r7, lsl r8
    19c0:	9e0a0800 	cdpls	8, 0, cr0, cr10, cr0, {0}
  if (Kernel_msgQ_is_full(Qname)) {
    19c4:	57000009 	strpl	r0, [r0, -r9]
    19c8:	00000048 	andeq	r0, r0, r8, asr #32
    19cc:	480a0100 	stmdami	sl, {r8}
    19d0:	58000008 	stmdapl	r0, {r3}
    19d4:	00000048 	andeq	r0, r0, r8, asr #32
    19d8:	530a0104 	movwpl	r0, #41220	@ 0xa104
    return false;
    19dc:	59000008 	stmdbpl	r0, {r3}
    19e0:	00000048 	andeq	r0, r0, r8, asr #32
  ++sMsgQ[Qname].rear;
    19e4:	830a0108 	movwhi	r0, #41224	@ 0xa108
    19e8:	5a000009 	bpl	1a14 <Kernel_msgQ_enqueue+0x84>
    19ec:	00000d98 	muleq	r0, r8, sp
    19f0:	b40a010c 	strlt	r0, [sl], #-268	@ 0xfffffef4
    19f4:	5b000009 	blpl	1a20 <Kernel_msgQ_enqueue+0x90>
    19f8:	00000048 	andeq	r0, r0, r8, asr #32
    19fc:	e60a0180 	str	r0, [sl], -r0, lsl #3
    1a00:	5c000007 	stcpl	0, cr0, [r0], {7}
    1a04:	00000048 	andeq	r0, r0, r8, asr #32
    1a08:	ac0a0184 	stfges	f0, [sl], {132}	@ 0x84
    1a0c:	5d000007 	stcpl	0, cr0, [r0, #-28]	@ 0xffffffe4
    1a10:	00000048 	andeq	r0, r0, r8, asr #32
    1a14:	0f000188 	svceq	0x00000188
    1a18:	00000048 	andeq	r0, r0, r8, asr #32
    1a1c:	00000d98 	muleq	r0, r8, sp
    1a20:	00005410 	andeq	r5, r0, r0, lsl r4
  sMsgQ[Qname].rear = (sMsgQ[Qname].rear + 1) % MSG_Q_SIZE_BYTE;
    1a24:	0f003d00 	svceq	0x00003d00
    1a28:	00000048 	andeq	r0, r0, r8, asr #32
    1a2c:	00000da8 	andeq	r0, r0, r8, lsr #27
    1a30:	00005410 	andeq	r5, r0, r0, lsl r4
    1a34:	03001c00 	movweq	r1, #3072	@ 0xc00
    1a38:	000009be 			@ <UNDEFINED> instruction: 0x000009be
    1a3c:	fe035e04 	cdp2	14, 0, cr5, cr3, cr4, {0}
    1a40:	0b00000c 	bleq	1a78 <Kernel_msgQ_enqueue+0xe8>
    1a44:	00000da8 	andeq	r0, r0, r8, lsr #27
    1a48:	29060504 	stmdbcs	r6, {r2, r8, sl}
    1a4c:	0100000e 	tsteq	r0, lr
    1a50:	00000a0c 	andeq	r0, r0, ip, lsl #20
    1a54:	00480705 	subeq	r0, r8, r5, lsl #14
    1a58:	00010000 	andeq	r0, r1, r0
    1a5c:	000ac101 	andeq	ip, sl, r1, lsl #2
    1a60:	48080500 	stmdami	r8, {r8, sl}
    1a64:	01000000 	mrseq	r0, (UNDEF: 0)
    1a68:	0d440101 	stfeqe	f0, [r4, #-4]
  sMsgQ[Qname].Queue[sMsgQ[Qname].rear] = data;
    1a6c:	09050000 	stmdbeq	r5, {}	@ <UNPREDICTABLE>
    1a70:	00000048 	andeq	r0, r0, r8, asr #32
    1a74:	08010202 	stmdaeq	r1, {r1, r9}
    1a78:	0500000b 	streq	r0, [r0, #-11]
    1a7c:	0000480a 	andeq	r4, r0, sl, lsl #16
    1a80:	01040100 	mrseq	r0, (UNDEF: 20)
    1a84:	00000cc0 	andeq	r0, r0, r0, asr #25
    1a88:	00480b05 	subeq	r0, r8, r5, lsl #22
    1a8c:	05010000 	streq	r0, [r1, #-0]
    1a90:	000d0c01 	andeq	r0, sp, r1, lsl #24
    1a94:	480c0500 	stmdami	ip, {r8, sl}
    1a98:	01000000 	mrseq	r0, (UNDEF: 0)
    1a9c:	09ff0106 	ldmibeq	pc!, {r1, r2, r8}^	@ <UNPREDICTABLE>
    1aa0:	0d050000 	stceq	0, cr0, [r5, #-0]
    1aa4:	00000048 	andeq	r0, r0, r8, asr #32
    1aa8:	67010701 	strvs	r0, [r1, -r1, lsl #14]
    1aac:	0500000a 	streq	r0, [r0, #-10]
    1ab0:	0000480e 	andeq	r4, r0, lr, lsl #16
  return true;
    1ab4:	00081800 	andeq	r1, r8, r0, lsl #16
}
    1ab8:	000c0005 	andeq	r0, ip, r5
    1abc:	4b040500 	blmi	102ec4 <cpsr_cp+0xffc3c>
    1ac0:	0600000e 	streq	r0, [r0], -lr
bool Kernel_msgQ_dequeue(KernelMsgQ_t Qname, uint8_t* out_data) {
    1ac4:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1ac8:	00480505 	subeq	r0, r8, r5, lsl #10
    1acc:	5c070000 	stcpl	0, cr0, [r7], {-0}
    1ad0:	05000009 	streq	r0, [r0, #-9]
    1ad4:	000db90f 	andeq	fp, sp, pc, lsl #18
    1ad8:	00030000 	andeq	r0, r3, r0
  if (Qname >= KernelMsgQ_Num) {
    1adc:	0500000c 	streq	r0, [r0, #-12]
    1ae0:	0e290310 	mcreq	3, 1, r0, cr9, cr0, {0}
    1ae4:	05040000 	streq	r0, [r4, #-0]
    return false;
    1ae8:	000e7913 	andeq	r7, lr, r3, lsl r9
    1aec:	0c760100 	ldfeqe	f0, [r6], #-0
  if (Kernel_msgQ_is_empty(Qname)) {
    1af0:	14050000 	strne	r0, [r5], #-0
    1af4:	00000048 	andeq	r0, r0, r8, asr #32
    1af8:	71010001 	tstvc	r1, r1
    1afc:	05000007 	streq	r0, [r0, #-7]
    1b00:	00004815 	andeq	r4, r0, r5, lsl r8
    1b04:	00011f00 	andeq	r1, r1, r0, lsl #30
    return false;
    1b08:	0009c805 	andeq	ip, r9, r5, lsl #16
    1b0c:	9b110500 	blls	442f14 <cpsr_cp+0x43fc8c>
  ++sMsgQ[Qname].front;
    1b10:	0600000e 	streq	r0, [r0], -lr
    1b14:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1b18:	00481205 	subeq	r1, r8, r5, lsl #4
    1b1c:	5c070000 	stcpl	0, cr0, [r7], {-0}
    1b20:	05000009 	streq	r0, [r0, #-9]
    1b24:	000e5716 	andeq	r5, lr, r6, lsl r7
    1b28:	c8030000 	stmdagt	r3, {}	@ <UNPREDICTABLE>
    1b2c:	05000009 	streq	r0, [r0, #-9]
    1b30:	0e790317 	mrceq	3, 3, r0, cr9, cr7, {0}
    1b34:	05040000 	streq	r0, [r4, #-0]
    1b38:	000ec91a 	andeq	ip, lr, sl, lsl r9
    1b3c:	09d40100 	ldmibeq	r4, {r8}^
    1b40:	1b050000 	blne	141b48 <cpsr_cp+0x13e8c0>
    1b44:	00000048 	andeq	r0, r0, r8, asr #32
  sMsgQ[Qname].front = (sMsgQ[Qname].front + 1) % MSG_Q_SIZE_BYTE;
    1b48:	71010001 	tstvc	r1, r1
    1b4c:	05000007 	streq	r0, [r0, #-7]
    1b50:	0000481c 	andeq	r4, r0, ip, lsl r8
    1b54:	00011f00 	andeq	r1, r1, r0, lsl #30
    1b58:	000afc05 	andeq	pc, sl, r5, lsl #24
    1b5c:	eb180500 	bl	602f64 <cpsr_cp+0x5ffcdc>
    1b60:	0600000e 	streq	r0, [r0], -lr
    1b64:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1b68:	00481905 	subeq	r1, r8, r5, lsl #18
    1b6c:	5c070000 	stcpl	0, cr0, [r7], {-0}
    1b70:	05000009 	streq	r0, [r0, #-9]
    1b74:	000ea71d 	andeq	sl, lr, sp, lsl r7
    1b78:	fc030000 	stc2	0, cr0, [r3], {-0}
    1b7c:	0500000a 	streq	r0, [r0, #-10]
    1b80:	0ec9031e 	mcreq	3, 6, r0, cr9, cr14, {0}
    1b84:	3c0e0000 	stccc	0, cr0, [lr], {-0}
  *out_data = sMsgQ[Qname].Queue[sMsgQ[Qname].front];
    1b88:	1c00000d 	stcne	0, cr0, [r0], {13}
    1b8c:	0f5f1f05 	svceq	0x005f1f05
    1b90:	9f020000 	svcls	0x00020000
    1b94:	0500000b 	streq	r0, [r0, #-11]
    1b98:	00481320 	subeq	r1, r8, r0, lsr #6
    1b9c:	02000000 	andeq	r0, r0, #0
    1ba0:	00000c1b 	andeq	r0, r0, fp, lsl ip
    1ba4:	48132105 	ldmdami	r3, {r0, r2, r8, sp}
    1ba8:	04000000 	streq	r0, [r0], #-0
    1bac:	000ce002 	andeq	lr, ip, r2
    1bb0:	13220500 			@ <UNDEFINED> instruction: 0x13220500
    1bb4:	00000e4b 	andeq	r0, r0, fp, asr #28
    1bb8:	0b810208 	bleq	fe0423e0 <cpsr_cp+0xfe03f158>
    1bbc:	23050000 	movwcs	r0, #20480	@ 0x5000
    1bc0:	00004813 	andeq	r4, r0, r3, lsl r8
    1bc4:	36020c00 	strcc	r0, [r2], -r0, lsl #24
    1bc8:	0500000c 	streq	r0, [r0, #-12]
    1bcc:	0e9b1324 	cdpeq	3, 9, cr1, cr11, cr4, {1}
  return true;
    1bd0:	02100000 	andseq	r0, r0, #0
    1bd4:	00000b12 	andeq	r0, r0, r2, lsl fp
    1bd8:	eb132505 	bl	4caff4 <cpsr_cp+0x4c7d6c>
    1bdc:	1400000e 	strne	r0, [r0], #-14
void Kernel_sem_init(int32_t max) {
    1be0:	000baa02 	andeq	sl, fp, r2, lsl #20
    1be4:	13260500 			@ <UNDEFINED> instruction: 0x13260500
    1be8:	00000048 	andeq	r0, r0, r8, asr #32
    1bec:	3c030018 	stccc	0, cr0, [r3], {24}
  sSemMax = (max >= DEF_SEM_MAX) ? DEF_SEM_MAX : max;
    1bf0:	0500000d 	streq	r0, [r0, #-13]
    1bf4:	0ef70327 	cdpeq	3, 15, cr0, cr7, cr7, {1}
    1bf8:	5f0b0000 	svcpl	0x000b0000
    1bfc:	0c00000f 	stceq	0, cr0, [r0], {15}
    1c00:	00000cd3 	ldrdeq	r0, [r0], -r3
    1c04:	0f811306 	svceq	0x00811306
    1c08:	03050000 	movweq	r0, #20480	@ 0x5000
  sSem = sSemMax;
    1c0c:	00002238 	andeq	r2, r0, r8, lsr r2
    1c10:	0009620d 	andeq	r6, r9, sp, lsl #4
    1c14:	08af0c00 	stmiaeq	pc!, {sl, fp}	@ <UNPREDICTABLE>
    1c18:	15070000 	strne	r0, [r7, #-0]
    1c1c:	00000f97 	muleq	r0, r7, pc	@ <UNPREDICTABLE>
    1c20:	223c0305 	eorscs	r0, ip, #335544320	@ 0x14000000
}
    1c24:	f90d0000 			@ <UNDEFINED> instruction: 0xf90d0000
    1c28:	0c00000c 	stceq	0, cr0, [r0], {12}
    1c2c:	00000826 	andeq	r0, r0, r6, lsr #16
    1c30:	0fad1508 	svceq	0x00ad1508
bool Kernel_sem_test(void) {
    1c34:	03050000 	movweq	r0, #20480	@ 0x5000
    1c38:	00002240 	andeq	r2, r0, r0, asr #4
  if(sSem <= 0) {
    1c3c:	000db40d 	andeq	fp, sp, sp, lsl #8
    1c40:	0b6d0c00 	bleq	1b44c48 <cpsr_cp+0x1b419c0>
    1c44:	13090000 	movwne	r0, #36864	@ 0x9000
    1c48:	00000fc3 	andeq	r0, r0, r3, asr #31
    1c4c:	22440305 	subcs	r0, r4, #335544320	@ 0x14000000
    return false;
    1c50:	6b0d0000 	blvs	341c58 <cpsr_cp+0x33e9d0>
    1c54:	0000000f 	andeq	r0, r0, pc
  --sSem;
    1c58:	0000029b 	muleq	r0, fp, r2
    1c5c:	04010005 	streq	r0, [r1], #-5
    1c60:	0000060c 	andeq	r0, r0, ip, lsl #12
    1c64:	0000be0d 	andeq	fp, r0, sp, lsl #28
    1c68:	0d7c1d00 	ldcleq	13, cr1, [ip, #-0]
    1c6c:	000d0000 	andeq	r0, sp, r0
    1c70:	0a2c0000 	beq	b01c78 <cpsr_cp+0xafe9f0>
  return true;
    1c74:	02100000 	andseq	r0, r0, #0
}
    1c78:	04f10000 	ldrbteq	r0, [r1], #0
    1c7c:	01020000 	mrseq	r0, (UNDEF: 2)
    1c80:	00005e06 	andeq	r5, r0, r6, lsl #28
    1c84:	05020200 	streq	r0, [r2, #-512]	@ 0xfffffe00
void Kernel_sem_release(void) {
    1c88:	000000b4 	strheq	r0, [r0], -r4
    1c8c:	6905040e 	stmdbvs	r5, {r1, r2, r3, sl}
  ++sSem;
    1c90:	0200746e 	andeq	r7, r0, #1845493760	@ 0x6e000000
    1c94:	00790508 	rsbseq	r0, r9, r8, lsl #10
    1c98:	01020000 	mrseq	r0, (UNDEF: 2)
    1c9c:	00005c08 	andeq	r5, r0, r8, lsl #24
    1ca0:	07020200 	streq	r0, [r2, -r0, lsl #4]
    1ca4:	00000087 	andeq	r0, r0, r7, lsl #1
    1ca8:	00024804 	andeq	r4, r2, r4, lsl #16
  if(sSem >= sSemMax) {
    1cac:	171a0300 	ldrne	r0, [sl, -r0, lsl #6]
    1cb0:	0000005c 	andeq	r0, r0, ip, asr r0
    1cb4:	43070402 	movwmi	r0, #29698	@ 0x7402
    1cb8:	02000000 	andeq	r0, r0, #0
    1cbc:	00390708 	eorseq	r0, r9, r8, lsl #14
    1cc0:	06050000 	streq	r0, [r5], -r0
    1cc4:	000000d1 	ldrdeq	r0, [r0], -r1
    1cc8:	000a0c01 	andeq	r0, sl, r1, lsl #24
    sSem = sSemMax;
    1ccc:	00500700 	subseq	r0, r0, r0, lsl #14
    1cd0:	00010000 	andeq	r0, r1, r0
    1cd4:	000ac101 	andeq	ip, sl, r1, lsl #2
    1cd8:	00500800 	subseq	r0, r0, r0, lsl #16
    1cdc:	01010000 	mrseq	r0, (UNDEF: 1)
    1ce0:	000d4401 	andeq	r4, sp, r1, lsl #8
}
    1ce4:	00500900 	subseq	r0, r0, r0, lsl #18
    1ce8:	02020000 	andeq	r0, r2, #0
    1cec:	000b0801 	andeq	r0, fp, r1, lsl #16
    1cf0:	00500a00 	subseq	r0, r0, r0, lsl #20
void Kernel_mutex_init(void) {
    1cf4:	04010000 	streq	r0, [r1], #-0
    1cf8:	000cc001 	andeq	ip, ip, r1
  sMutex.owner = 0;
    1cfc:	00500b00 	subseq	r0, r0, r0, lsl #22
    1d00:	05010000 	streq	r0, [r1, #-0]
    1d04:	000d0c01 	andeq	r0, sp, r1, lsl #24
    1d08:	00500c00 	subseq	r0, r0, r0, lsl #24
  sMutex.lock = false;
    1d0c:	06010000 	streq	r0, [r1], -r0
    1d10:	0009ff01 	andeq	pc, r9, r1, lsl #30
    1d14:	00500d00 	subseq	r0, r0, r0, lsl #26
    1d18:	07010000 	streq	r0, [r1, -r0]
}
    1d1c:	000a6701 	andeq	r6, sl, r1, lsl #14
    1d20:	00500e00 	subseq	r0, r0, r0, lsl #28
    1d24:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
    1d28:	0c000600 	stceq	6, cr0, [r0], {-0}
bool Kernel_mutex_lock(uint32_t owner) {
    1d2c:	f0040000 			@ <UNDEFINED> instruction: 0xf0040000
    1d30:	07000000 	streq	r0, [r0, -r0]
    1d34:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    1d38:	00005005 	andeq	r5, r0, r5
  if(sMutex.lock) {
    1d3c:	095c0800 	ldmdbeq	ip, {fp}^
    1d40:	6a0f0000 	bvs	3c1d48 <cpsr_cp+0x3beac0>
    1d44:	00000000 	andeq	r0, r0, r0
    1d48:	000c0004 	andeq	r0, ip, r4
    1d4c:	03100200 	tsteq	r0, #0, 4
    return false;
    1d50:	000000d1 	ldrdeq	r0, [r0], -r1
    1d54:	011b1305 	tsteq	fp, r5, lsl #6
  sMutex.owner = owner;
    1d58:	76010000 	strvc	r0, [r1], -r0
    1d5c:	1400000c 	strne	r0, [r0], #-12
    1d60:	00000050 	andeq	r0, r0, r0, asr r0
    1d64:	71010001 	tstvc	r1, r1
  sMutex.lock = true;
    1d68:	15000007 	strne	r0, [r0, #-7]
    1d6c:	00000050 	andeq	r0, r0, r0, asr r0
    1d70:	0600011f 			@ <UNDEFINED> instruction: 0x0600011f
    1d74:	000009c8 	andeq	r0, r0, r8, asr #19
  return true;
    1d78:	00013a11 	andeq	r3, r1, r1, lsl sl
}
    1d7c:	6c610700 	stclvs	7, cr0, [r1], #-0
    1d80:	5012006c 	andspl	r0, r2, ip, rrx
    1d84:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    1d88:	0000095c 	andeq	r0, r0, ip, asr r9
bool Kernel_mutex_unlock(uint32_t owner) {
    1d8c:	0000fc16 	andeq	pc, r0, r6, lsl ip	@ <UNPREDICTABLE>
    1d90:	c8040000 	stmdagt	r4, {}	@ <UNPREDICTABLE>
    1d94:	02000009 	andeq	r0, r0, #9
    1d98:	011b0317 	tsteq	fp, r7, lsl r3
  if (owner == sMutex.owner) {
    1d9c:	1a050000 	bne	141da4 <cpsr_cp+0x13eb1c>
    1da0:	00000165 	andeq	r0, r0, r5, ror #2
    1da4:	0009d401 	andeq	sp, r9, r1, lsl #8
    1da8:	00501b00 	subseq	r1, r0, r0, lsl #22
    1dac:	00010000 	andeq	r0, r1, r0
    1db0:	00077101 	andeq	r7, r7, r1, lsl #2
    sMutex.lock = false;
    1db4:	00501c00 	subseq	r1, r0, r0, lsl #24
    1db8:	011f0000 	tsteq	pc, r0
    1dbc:	0afc0600 	beq	fff035c4 <cpsr_cp+0xfff0033c>
    1dc0:	84180000 	ldrhi	r0, [r8], #-0
    return true;
    1dc4:	07000001 	streq	r0, [r0, -r1]
    1dc8:	006c6c61 	rsbeq	r6, ip, r1, ror #24
  return false;
    1dcc:	00005019 	andeq	r5, r0, r9, lsl r0
    1dd0:	095c0800 	ldmdbeq	ip, {fp}^
    1dd4:	461d0000 	ldrmi	r0, [sp], -r0
    1dd8:	00000001 	andeq	r0, r0, r1
    1ddc:	000afc04 	andeq	pc, sl, r4, lsl #24
void Kernel_task_init(void) {
    1de0:	031e0200 	tsteq	lr, #0, 4
    1de4:	00000165 	andeq	r0, r0, r5, ror #2
    1de8:	000d3c0f 	andeq	r3, sp, pc, lsl #24
  sAllocated_tcb_index = 0;
    1dec:	1f021c00 	svcne	0x00021c00
    1df0:	0001eb10 	andeq	lr, r1, r0, lsl fp
    1df4:	0b9f0300 	bleq	fe7c29fc <cpsr_cp+0xfe7bf774>
    1df8:	50200000 	eorpl	r0, r0, r0
  sCurrent_tcb_index = 0;
    1dfc:	00000000 	andeq	r0, r0, r0
    1e00:	000c1b03 	andeq	r1, ip, r3, lsl #22
    1e04:	00502100 	subseq	r2, r0, r0, lsl #2
    1e08:	03040000 	movweq	r0, #16384	@ 0x4000
  __asm__ ("MRS r0, cpsr");
    1e0c:	00000ce0 	andeq	r0, r0, r0, ror #25
  __asm__ ("LDR r1, =cpsr_cp");
    1e10:	0000f022 	andeq	pc, r0, r2, lsr #32
  __asm__ ("STR r0, [r1]");
    1e14:	81030800 	tsthi	r3, r0, lsl #16
  for (uint32_t i = 0; i < MAX_TASK_NUM; ++i) {
    1e18:	2300000b 	movwcs	r0, #11
    1e1c:	00000050 	andeq	r0, r0, r0, asr r0
    1e20:	0c36030c 	ldceq	3, cr0, [r6], #-48	@ 0xffffffd0
    sTask_list[i].stack_base = (uint8_t*)(TASK_STACK_START + (i * USR_TASK_STACK_SIZE));
    1e24:	3a240000 	bcc	901e2c <cpsr_cp+0x8feba4>
    1e28:	10000001 	andne	r0, r0, r1
    1e2c:	000b1203 	andeq	r1, fp, r3, lsl #4
    1e30:	01842500 	orreq	r2, r4, r0, lsl #10
    1e34:	03140000 	tsteq	r4, #0
    1e38:	00000baa 	andeq	r0, r0, sl, lsr #23
    1e3c:	00005026 	andeq	r5, r0, r6, lsr #32
    1e40:	04001800 	streq	r1, [r0], #-2048	@ 0xfffff800
    1e44:	00000d3c 	andeq	r0, r0, ip, lsr sp
    1e48:	90032702 	andls	r2, r3, r2, lsl #14
    sTask_list[i].sp = (uint32_t)sTask_list[i].stack_base + USR_TASK_STACK_SIZE - 4;
    1e4c:	10000001 	andne	r0, r0, r1
    1e50:	000001eb 	andeq	r0, r0, fp, ror #3
    1e54:	00089004 	andeq	r9, r8, r4
    1e58:	10080400 	andne	r0, r8, r0, lsl #8
    1e5c:	00000208 	andeq	r0, r0, r8, lsl #4
    1e60:	00020d0a 	andeq	r0, r2, sl, lsl #26
    1e64:	6d121100 	ldfvss	f1, [r2, #-0]
    1e68:	0100000b 	tsteq	r0, fp
    1e6c:	021a1a06 	andseq	r1, sl, #24576	@ 0x6000
    1e70:	f70a0000 			@ <UNDEFINED> instruction: 0xf70a0000
    1e74:	0b000001 	bleq	1e80 <Kernel_task_init+0xa0>
    1e78:	00000d9a 	muleq	r0, sl, sp
    sTask_list[i].sp -= sizeof(KernelTaskContext_t);
    1e7c:	0050110a 	subseq	r1, r0, sl, lsl #2
    1e80:	03050000 	movweq	r0, #20480	@ 0x5000
    1e84:	00002648 	andeq	r2, r0, r8, asr #12
    1e88:	00085e0c 	andeq	r5, r8, ip, lsl #28
    1e8c:	02450d00 	subeq	r0, r5, #0, 26
    1e90:	fc090000 	stc2	0, cr0, [r9], {-0}
    1e94:	09000001 	stmdbeq	r0, {r0}
    1e98:	00000050 	andeq	r0, r0, r0, asr r0
    1e9c:	012d0c00 			@ <UNDEFINED> instruction: 0x012d0c00
    KernelTaskContext_t* ctx = (KernelTaskContext_t*)sTask_list[i].sp;
    1ea0:	550b0000 	strpl	r0, [fp, #-0]
    1ea4:	09000002 	stmdbeq	r0, {r1}
    1ea8:	00000050 	andeq	r0, r0, r0, asr r0
    1eac:	0dc91300 	stcleq	3, cr1, [r9]
    1eb0:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
    ctx->spsr = cpsr_cp;
    1eb4:	000bf40d 	andeq	pc, fp, sp, lsl #8
    1eb8:	00004800 	andeq	r4, r0, r0, lsl #16
    1ebc:	149c0100 	ldrne	r0, [ip], #256	@ 0x100
    1ec0:	00000daf 	andeq	r0, r0, pc, lsr #27
    1ec4:	500a2a01 	andpl	r2, sl, r1, lsl #20
  for (uint32_t i = 0; i < MAX_TASK_NUM; ++i) {
    1ec8:	d0000000 	andle	r0, r0, r0
    1ecc:	2400000b 	strcs	r0, [r0], #-11
    1ed0:	01000000 	mrseq	r0, (UNDEF: 0)
    1ed4:	0223159c 	eoreq	r1, r3, #156, 10	@ 0x27000000
    1ed8:	0c010000 	stceq	0, cr0, [r1], {-0}
    1edc:	000a2c06 	andeq	r2, sl, r6, lsl #24
}
    1ee0:	0001a400 	andeq	sl, r1, r0, lsl #8
    1ee4:	0b9c0100 	bleq	fe7022ec <cpsr_cp+0xfe6ff064>
    1ee8:	00000d8d 	andeq	r0, r0, sp, lsl #27
    1eec:	00500c1e 	subseq	r0, r0, lr, lsl ip
    1ef0:	91020000 	mrsls	r0, (UNDEF: 2)
uint32_t Kernel_task_create(KernelTaskFunc_t startFunc) {
    1ef4:	0c000074 	stceq	0, cr0, [r0], {116}	@ 0x74
    1ef8:	0500000b 	streq	r0, [r0, #-11]
    1efc:	6c040100 	stfvss	f0, [r4], {-0}
    1f00:	11000007 	tstne	r0, r7
  KernelTcb_t* new_tcb = &sTask_list[sAllocated_tcb_index++];
    1f04:	000000be 	strheq	r0, [r0], -lr
    1f08:	000ddb1d 	andeq	sp, sp, sp, lsl fp
    1f0c:	00000d00 	andeq	r0, r0, r0, lsl #26
    1f10:	000c3c00 	andeq	r3, ip, r0, lsl #24
    1f14:	0001f800 	andeq	pc, r1, r0, lsl #16
    1f18:	0005e100 	andeq	lr, r5, r0, lsl #2
    1f1c:	06010b00 	streq	r0, [r1], -r0, lsl #22
    1f20:	0000005e 	andeq	r0, r0, lr, asr r0
    1f24:	b405020b 	strlt	r0, [r5], #-523	@ 0xfffffdf5
    1f28:	12000000 	andne	r0, r0, #0
    1f2c:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    1f30:	080b0074 	stmdaeq	fp, {r2, r4, r5, r6}
  if (sAllocated_tcb_index > MAX_TASK_NUM) {
    1f34:	00007905 	andeq	r7, r0, r5, lsl #18
    1f38:	01fc0300 	mvnseq	r0, r0, lsl #6
    1f3c:	17020000 	strne	r0, [r2, -r0]
    1f40:	00004e18 	andeq	r4, r0, r8, lsl lr
    1f44:	08010b00 	stmdaeq	r1, {r8, r9, fp}
    return NOT_ENOUGH_TASK_NUM;
    1f48:	0000005c 	andeq	r0, r0, ip, asr r0
    1f4c:	8707020b 	strhi	r0, [r7, -fp, lsl #4]
  KernelTaskContext_t* ctx = (KernelTaskContext_t*)new_tcb->sp;
    1f50:	03000000 	movweq	r0, #0
    1f54:	00000248 	andeq	r0, r0, r8, asr #4
    1f58:	68171a02 	ldmdavs	r7, {r1, r9, fp, ip}
  ctx->pc = (uint32_t)startFunc;
    1f5c:	0b000000 	bleq	1f64 <Kernel_task_create+0x70>
    1f60:	00430704 	subeq	r0, r3, r4, lsl #14
    1f64:	080b0000 	stmdaeq	fp, {}	@ <UNPREDICTABLE>
  return (sAllocated_tcb_index - 1);
    1f68:	00003907 	andeq	r3, r0, r7, lsl #18
    1f6c:	bd060600 	stclt	6, cr0, [r6, #-0]
    1f70:	01000000 	mrseq	r0, (UNDEF: 0)
    1f74:	00000b2e 	andeq	r0, r0, lr, lsr #22
}
    1f78:	00005c07 	andeq	r5, r0, r7, lsl #24
    1f7c:	02000800 	andeq	r0, r0, #0, 16
    1f80:	08004546 	stmdaeq	r0, {r1, r2, r6, r8, sl, lr}
    1f84:	0000005c 	andeq	r0, r0, ip, asr r0
void Kernel_task_scheduling(void) {
    1f88:	45500208 	ldrbmi	r0, [r0, #-520]	@ 0xfffffdf8
    1f8c:	005c0900 	subseq	r0, ip, r0, lsl #18
  sCurrent_tcb = &sTask_list[sCurrent_tcb_index];
    1f90:	02090000 	andeq	r0, r9, #0
    1f94:	0a004542 	beq	134a4 <cpsr_cp+0x1021c>
    1f98:	0000005c 	andeq	r0, r0, ip, asr r0
    1f9c:	454f020a 	strbmi	r0, [pc, #-522]	@ 1d9a <Kernel_mutex_unlock+0xe>
    1fa0:	005c0b00 	subseq	r0, ip, r0, lsl #22
    1fa4:	010b0000 	mrseq	r0, (UNDEF: 11)
    1fa8:	000008c7 	andeq	r0, r0, r7, asr #17
    1fac:	00005c0c 	andeq	r5, r0, ip, lsl #24
    1fb0:	000c1400 	andeq	r1, ip, r0, lsl #8
    1fb4:	000cca07 	andeq	ip, ip, r7, lsl #20
  sNext_tcb = Scheduler_round_robin();
    1fb8:	00dc0400 	sbcseq	r0, ip, r0, lsl #8
    1fbc:	61080000 	mrsvs	r0, (UNDEF: 8)
    1fc0:	05006c6c 	streq	r6, [r0, #-3180]	@ 0xfffff394
    1fc4:	0000005c 	andeq	r0, r0, ip, asr r0
    1fc8:	00095c09 	andeq	r5, r9, r9, lsl #24
  Kernel_task_context_switching();
    1fcc:	00760d00 	rsbseq	r0, r6, r0, lsl #26
}
    1fd0:	03000000 	movweq	r0, #0
    1fd4:	00000cca 	andeq	r0, r0, sl, asr #25
void Kernel_task_start(void) {
    1fd8:	bd030e03 	stclt	14, cr0, [r3, #-12]
    1fdc:	06000000 	streq	r0, [r0], -r0
  sNext_tcb = &sTask_list[sCurrent_tcb_index];
    1fe0:	00012311 	andeq	r2, r1, r1, lsl r3
    1fe4:	45460200 	strbmi	r0, [r6, #-512]	@ 0xfffffe00
    1fe8:	005c1200 	subseq	r1, ip, r0, lsl #4
    1fec:	02000000 	andeq	r0, r0, #0
    1ff0:	13004550 	movwne	r4, #1360	@ 0x550
    1ff4:	0000005c 	andeq	r0, r0, ip, asr r0
    1ff8:	45420201 	strbmi	r0, [r2, #-513]	@ 0xfffffdff
    1ffc:	005c1400 	subseq	r1, ip, r0, lsl #8
    2000:	02020000 	andeq	r0, r2, #0
    2004:	1500454f 	strne	r4, [r0, #-1359]	@ 0xfffffab1
  __asm__ ("LDR r0, =sNext_tcb");
    2008:	0000005c 	andeq	r0, r0, ip, asr r0
  __asm__ ("LDR r0, [r0]");
    200c:	08c70103 	stmiaeq	r7, {r0, r1, r8}^
  __asm__ ("LDMIA r0!, {sp}");
    2010:	5c160000 	ldcpl	0, cr0, [r6], {-0}
  __asm__ ("POP {r0}");
    2014:	1c000000 	stcne	0, cr0, [r0], {-0}
  __asm__ ("MSR cpsr, r0");
    2018:	97070004 	strls	r0, [r7, -r4]
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}"); // 쓰레기 값들로 채워짐
    201c:	0f00000c 	svceq	0x0000000c
  __asm__ ("POP {pc}"); // 태스크 함수의 위치로 점프
    2020:	00000142 	andeq	r0, r0, r2, asr #2
}
    2024:	6c6c6108 	stfvse	f6, [ip], #-32	@ 0xffffffe0
    2028:	005c1000 	subseq	r1, ip, r0
    202c:	5c090000 	stcpl	0, cr0, [r9], {-0}
    2030:	17000009 	strne	r0, [r0, -r9]
uint32_t Kernel_task_get_current_task_id(void) {
    2034:	000000e8 	andeq	r0, r0, r8, ror #1
    2038:	0c970300 	ldceq	3, cr0, [r7], {0}
  return sCurrent_tcb_index;
    203c:	18030000 	stmdane	r3, {}	@ <UNPREDICTABLE>
    2040:	00012303 	andeq	r2, r1, r3, lsl #6
    2044:	c81b0600 	ldmdagt	fp, {r9, sl}
}
    2048:	02000001 	andeq	r0, r0, #1
    204c:	00535443 	subseq	r5, r3, r3, asr #8
    2050:	00005c1c 	andeq	r5, r0, ip, lsl ip
    2054:	44020000 	strmi	r0, [r2], #-0
static KernelTcb_t* Scheduler_round_robin(void) {
    2058:	1d005253 	sfmne	f5, 4, [r0, #-332]	@ 0xfffffeb4
    205c:	0000005c 	andeq	r0, r0, ip, asr r0
  ++sCurrent_tcb_index;
    2060:	43440201 	movtmi	r0, #16897	@ 0x4201
    2064:	5c1e0044 	ldcpl	0, cr0, [lr], {68}	@ 0x44
    2068:	02000000 	andeq	r0, r0, #0
    206c:	000d4d01 	andeq	r4, sp, r1, lsl #26
    2070:	005c1f00 	subseq	r1, ip, r0, lsl #30
    2074:	03010000 	movweq	r0, #4096	@ 0x1000
    2078:	000d1601 	andeq	r1, sp, r1, lsl #12
  sCurrent_tcb_index %= sAllocated_tcb_index;
    207c:	005c2000 	subseq	r2, ip, r0
    2080:	04010000 	streq	r0, [r1], #-0
    2084:	000c4d01 	andeq	r4, ip, r1, lsl #26
    2088:	005c2100 	subseq	r2, ip, r0, lsl #2
    208c:	05010000 	streq	r0, [r1, #-0]
    2090:	000d1b01 	andeq	r1, sp, r1, lsl #22
    2094:	005c2200 	subseq	r2, ip, r0, lsl #4
    2098:	06010000 	streq	r0, [r1], -r0
    209c:	000c4801 	andeq	r4, ip, r1, lsl #16
    20a0:	005c2300 	subseq	r2, ip, r0, lsl #6
    20a4:	07010000 	streq	r0, [r1, -r0]
    20a8:	00495202 	subeq	r5, r9, r2, lsl #4
    20ac:	00005c24 	andeq	r5, r0, r4, lsr #24
    20b0:	c7010800 	strgt	r0, [r1, -r0, lsl #16]
  return &sTask_list[sCurrent_tcb_index];
    20b4:	25000008 	strcs	r0, [r0, #-8]
    20b8:	0000005c 	andeq	r0, r0, ip, asr r0
    20bc:	07000917 	smladeq	r0, r7, r9, r0
    20c0:	00000be9 	andeq	r0, r0, r9, ror #23
    20c4:	0001e719 	andeq	lr, r1, r9, lsl r7
    20c8:	6c610800 	stclvs	8, cr0, [r1], #-0
    20cc:	5c1a006c 	ldcpl	0, cr0, [sl], {108}	@ 0x6c
}
    20d0:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    20d4:	0000095c 	andeq	r0, r0, ip, asr r9
  __asm__ ("PUSH {lr}");
    20d8:	00014e26 	andeq	r4, r1, r6, lsr #28
  __asm__ ("PUSH {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
    20dc:	e9030000 	stmdb	r3, {}	@ <UNPREDICTABLE>
  __asm__ ("MRS r0, cpsr");
    20e0:	0300000b 	movweq	r0, #11
  __asm__ ("PUSH {r0}");
    20e4:	01c80327 	biceq	r0, r8, r7, lsr #6
  __asm__ ("LDR r0, =sCurrent_tcb");
    20e8:	2a060000 	bcs	1820f0 <cpsr_cp+0x17ee68>
  __asm__ ("LDR r0, [r0]");
    20ec:	00000212 	andeq	r0, r0, r2, lsl r2
  __asm__ ("STMIA r0!, {sp}");
    20f0:	000b3f01 	andeq	r3, fp, r1, lsl #30
  __asm__ ("LDR r0, =sNext_tcb");
    20f4:	005c2b00 	subseq	r2, ip, r0, lsl #22
  __asm__ ("LDR r0, [r0]");
    20f8:	00080000 	andeq	r0, r8, r0
  __asm__ ("LDMIA r0!, {sp}");
    20fc:	0008c701 	andeq	ip, r8, r1, lsl #14
  __asm__ ("POP {r0}");
    2100:	005c2c00 	subseq	r2, ip, r0, lsl #24
  __asm__ ("MSR cpsr, r0");
    2104:	08180000 	ldmdaeq	r8, {}	@ <UNPREDICTABLE>
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
    2108:	0a230700 	beq	8c3d10 <cpsr_cp+0x8c0a88>
  __asm__ ("POP {pc}");
    210c:	31280000 			@ <UNDEFINED> instruction: 0x31280000
    2110:	08000002 	stmdaeq	r0, {r1}
    2114:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    2118:	00005c29 	andeq	r5, r0, r9, lsr #24
    211c:	095c0900 	ldmdbeq	ip, {r8, fp}^
    2120:	f32d0000 	vhadd.u32	d0, d13, d0
    2124:	00000001 	andeq	r0, r0, r1
    2128:	000a2303 	andeq	r2, sl, r3, lsl #6
    212c:	032e0300 			@ <UNDEFINED> instruction: 0x032e0300
    2130:	00000212 	andeq	r0, r0, r2, lsl r2
    2134:	025c3106 	subseq	r3, ip, #-2147483647	@ 0x80000001
    2138:	80010000 	andhi	r0, r1, r0
    213c:	3200000c 	andcc	r0, r0, #12
    2140:	0000005c 	andeq	r0, r0, ip, asr r0
    2144:	c7010010 	smladgt	r1, r0, r0, r0
    2148:	33000008 	movwcc	r0, #8
    214c:	0000005c 	andeq	r0, r0, ip, asr r0
    2150:	07001010 	smladeq	r0, r0, r0, r1
    2154:	00000a40 	andeq	r0, r0, r0, asr #20
    2158:	00027b2f 	andeq	r7, r2, pc, lsr #22
    215c:	6c610800 	stclvs	8, cr0, [r1], #-0
    2160:	5c30006c 	ldcpl	0, cr0, [r0], #-432	@ 0xfffffe50
    2164:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    2168:	0000095c 	andeq	r0, r0, ip, asr r9
    216c:	00023d34 	andeq	r3, r2, r4, lsr sp
    2170:	40030000 	andmi	r0, r3, r0
    2174:	0300000a 	movweq	r0, #10
    2178:	025c0335 	subseq	r0, ip, #-738197504	@ 0xd4000000
    217c:	38060000 	stmdacc	r6, {}	@ <UNPREDICTABLE>
    2180:	000002a6 	andeq	r0, r0, r6, lsr #5
    2184:	000b3301 	andeq	r3, fp, r1, lsl #6
    2188:	005c3900 	subseq	r3, ip, r0, lsl #18
    218c:	00060000 	andeq	r0, r6, r0
    2190:	0008c701 	andeq	ip, r8, r1, lsl #14
    2194:	005c3a00 	subseq	r3, ip, r0, lsl #20
    2198:	061a0000 	ldreq	r0, [sl], -r0
    219c:	0c100700 	ldceq	7, cr0, [r0], {-0}
    21a0:	c5360000 	ldrgt	r0, [r6, #-0]!
    21a4:	08000002 	stmdaeq	r0, {r1}
    21a8:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    21ac:	00005c37 	andeq	r5, r0, r7, lsr ip
    21b0:	095c0900 	ldmdbeq	ip, {r8, fp}^
    21b4:	873b0000 	ldrhi	r0, [fp, -r0]!
    21b8:	00000002 	andeq	r0, r0, r2
    21bc:	000c1003 	andeq	r1, ip, r3
    21c0:	033c0300 	teqeq	ip, #0, 6
    21c4:	000002a6 	andeq	r0, r0, r6, lsr #5
    21c8:	03333f06 	teqeq	r3, #6, 30
    21cc:	42020000 	andmi	r0, r2, #0
    21d0:	40004b52 	andmi	r4, r0, r2, asr fp
    21d4:	0000005c 	andeq	r0, r0, ip, asr r0
    21d8:	45500200 	ldrbmi	r0, [r0, #-512]	@ 0xfffffe00
    21dc:	5c41004e 	mcrrpl	0, 4, r0, r1, cr14
    21e0:	01000000 	mrseq	r0, (UNDEF: 0)
    21e4:	53504502 	cmppl	r0, #8388608	@ 0x800000
    21e8:	005c4200 	subseq	r4, ip, r0, lsl #4
    21ec:	01020000 	mrseq	r0, (UNDEF: 2)
    21f0:	00000ca8 	andeq	r0, r0, r8, lsr #25
    21f4:	00005c43 	andeq	r5, r0, r3, asr #24
    21f8:	02030100 	andeq	r0, r3, #0, 2
    21fc:	004e4546 	subeq	r4, lr, r6, asr #10
    2200:	00005c44 	andeq	r5, r0, r4, asr #24
    2204:	23010400 	movwcs	r0, #5120	@ 0x1400
    2208:	4500000b 	strmi	r0, [r0, #-11]
    220c:	0000005c 	andeq	r0, r0, ip, asr r0
    2210:	53020502 	movwpl	r0, #9474	@ 0x2502
    2214:	46005350 			@ <UNDEFINED> instruction: 0x46005350
    2218:	0000005c 	andeq	r0, r0, ip, asr r0
    221c:	08c70107 	stmiaeq	r7, {r0, r1, r2, r8}^
    2220:	5c470000 	marpl	acc0, r0, r7
    2224:	18000000 	stmdane	r0, {}	@ <UNPREDICTABLE>
    2228:	8b070008 	blhi	1c2250 <cpsr_cp+0x1befc8>
    222c:	3d00000c 	stccc	0, cr0, [r0, #-48]	@ 0xffffffd0
    2230:	00000352 	andeq	r0, r0, r2, asr r3
    2234:	6c6c6108 	stfvse	f6, [ip], #-32	@ 0xffffffe0
    2238:	005c3e00 	subseq	r3, ip, r0, lsl #28
    223c:	5c090000 	stcpl	0, cr0, [r9], {-0}
    2240:	48000009 	stmdami	r0, {r0, r3}
    2244:	000002d1 	ldrdeq	r0, [r0], -r1
    2248:	0c8b0300 	stceq	3, cr0, [fp], {0}
    224c:	49030000 	stmdbmi	r3, {}	@ <UNPREDICTABLE>
    2250:	00033303 	andeq	r3, r3, r3, lsl #6
    2254:	084c0600 	stmdaeq	ip, {r9, sl}^
    2258:	01000004 	tsteq	r0, r4
    225c:	00000a7f 	andeq	r0, r0, pc, ror sl
    2260:	00005c4d 	andeq	r5, r0, sp, asr #24
    2264:	01000100 	mrseq	r0, (UNDEF: 16)
    2268:	00000d61 	andeq	r0, r0, r1, ror #26
    226c:	00005c4e 	andeq	r5, r0, lr, asr #24
    2270:	01010100 	mrseq	r0, (UNDEF: 17)
    2274:	00000d28 	andeq	r0, r0, r8, lsr #26
    2278:	00005c4f 	andeq	r5, r0, pc, asr #24
    227c:	01020100 	mrseq	r0, (UNDEF: 18)
    2280:	00000a67 	andeq	r0, r0, r7, ror #20
    2284:	00005c50 	andeq	r5, r0, r0, asr ip
    2288:	02030400 	andeq	r0, r3, #0, 8
    228c:	0045424c 	subeq	r4, r5, ip, asr #4
    2290:	00005c51 	andeq	r5, r0, r1, asr ip
    2294:	54020700 	strpl	r0, [r2], #-1792	@ 0xfffff900
    2298:	52004558 	andpl	r4, r0, #88, 10	@ 0x16000000
    229c:	0000005c 	andeq	r0, r0, ip, asr r0
    22a0:	58520208 	ldmdapl	r2, {r3, r9}^
    22a4:	5c530045 	mrrcpl	0, 4, r0, r3, cr5
    22a8:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    22ac:	52544402 	subspl	r4, r4, #33554432	@ 0x2000000
    22b0:	005c5400 	subseq	r5, ip, r0, lsl #8
    22b4:	020a0000 	andeq	r0, sl, #0
    22b8:	00535452 	subseq	r5, r3, r2, asr r4
    22bc:	00005c55 	andeq	r5, r0, r5, asr ip
    22c0:	67010b00 	strvs	r0, [r1, -r0, lsl #22]
    22c4:	5600000d 	strpl	r0, [r0], -sp
    22c8:	0000005c 	andeq	r0, r0, ip, asr r0
    22cc:	6c010c01 	stcvs	12, cr0, [r1], {1}
    22d0:	5700000d 	strpl	r0, [r0, -sp]
    22d4:	0000005c 	andeq	r0, r0, ip, asr r0
    22d8:	e3010d01 	movw	r0, #7425	@ 0x1d01
    22dc:	58000009 	stmdapl	r0, {r0, r3}
    22e0:	0000005c 	andeq	r0, r0, ip, asr r0
    22e4:	fa010e01 	blx	45af0 <cpsr_cp+0x42868>
    22e8:	5900000b 	stmdbpl	r0, {r0, r1, r3}
    22ec:	0000005c 	andeq	r0, r0, ip, asr r0
    22f0:	83010f01 	movwhi	r0, #7937	@ 0x1f01
    22f4:	5a000009 	bpl	2320 <sHandlers+0xd4>
    22f8:	0000005c 	andeq	r0, r0, ip, asr r0
    22fc:	07001010 	smladeq	r0, r0, r0, r1
    2300:	00000d2e 	andeq	r0, r0, lr, lsr #26
    2304:	0004274a 	andeq	r2, r4, sl, asr #14
    2308:	6c610800 	stclvs	8, cr0, [r1], #-0
    230c:	5c4b006c 	mcrrpl	0, 6, r0, fp, cr12
    2310:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    2314:	0000095c 	andeq	r0, r0, ip, asr r9
    2318:	00035e5b 	andeq	r5, r3, fp, asr lr
    231c:	2e030000 	cdpcs	0, 0, cr0, cr3, cr0, {0}
    2320:	0300000d 	movweq	r0, #13
    2324:	0408035c 	streq	r0, [r8], #-860	@ 0xfffffca4
    2328:	5f060000 	svcpl	0x00060000
    232c:	0000045e 	andeq	r0, r0, lr, asr r4
    2330:	000a8601 	andeq	r8, sl, r1, lsl #12
    2334:	005c6000 	subseq	r6, ip, r0
    2338:	00030000 	andeq	r0, r3, r0
    233c:	000b6401 	andeq	r6, fp, r1, lsl #8
    2340:	005c6100 	subseq	r6, ip, r0, lsl #2
    2344:	03030000 	movweq	r0, #12288	@ 0x3000
    2348:	0008c701 	andeq	ip, r8, r1, lsl #14
    234c:	005c6200 	subseq	r6, ip, r0, lsl #4
    2350:	061a0000 	ldreq	r0, [sl], -r0
    2354:	0bb70700 	bleq	fedc3f5c <cpsr_cp+0xfedc0cd4>
    2358:	7d5d0000 	ldclvc	0, cr0, [sp, #-0]
    235c:	08000004 	stmdaeq	r0, {r2}
    2360:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    2364:	00005c5e 	andeq	r5, r0, lr, asr ip
    2368:	095c0900 	ldmdbeq	ip, {r8, fp}^
    236c:	33630000 	cmncc	r3, #0
    2370:	00000004 	andeq	r0, r0, r4
    2374:	000bb703 	andeq	fp, fp, r3, lsl #14
    2378:	03640300 	cmneq	r4, #0, 6
    237c:	0000045e 	andeq	r0, r0, lr, asr r4
    2380:	05206706 	streq	r6, [r0, #-1798]!	@ 0xfffff8fa
    2384:	b4010000 	strlt	r0, [r1], #-0
    2388:	6800000c 	stmdavs	r0, {r2, r3}
    238c:	0000005c 	andeq	r0, r0, ip, asr r0
    2390:	4b010001 	blmi	4239c <cpsr_cp+0x3f114>
    2394:	6900000a 	stmdbvs	r0, {r1, r3}
    2398:	0000005c 	andeq	r0, r0, ip, asr r0
    239c:	a2010101 	andge	r0, r1, #1073741824	@ 0x40000000
    23a0:	6a00000a 	bvs	23d0 <sHandlers+0x184>
    23a4:	0000005c 	andeq	r0, r0, ip, asr r0
    23a8:	6f010201 	svcvs	0x00010201
    23ac:	6b00000c 	blvs	23e4 <sHandlers+0x198>
    23b0:	0000005c 	andeq	r0, r0, ip, asr r0
    23b4:	bc010301 	stclt	3, cr0, [r1], {1}
    23b8:	6c00000a 	stcvs	0, cr0, [r0], {10}
    23bc:	0000005c 	andeq	r0, r0, ip, asr r0
    23c0:	ee010401 	cdp	4, 0, cr0, cr1, cr1, {0}
    23c4:	6d00000c 	stcvs	0, cr0, [r0, #-48]	@ 0xffffffd0
    23c8:	0000005c 	andeq	r0, r0, ip, asr r0
    23cc:	de010501 	cfsh32le	mvfx0, mvfx1, #1
    23d0:	6e000009 	cdpvs	0, 0, cr0, cr0, cr9, {0}
    23d4:	0000005c 	andeq	r0, r0, ip, asr r0
    23d8:	07010601 	streq	r0, [r1, -r1, lsl #12]
    23dc:	6f00000a 	svcvs	0x0000000a
    23e0:	0000005c 	andeq	r0, r0, ip, asr r0
    23e4:	ae010701 	cdpge	7, 0, cr0, cr1, cr1, {0}
    23e8:	7000000a 	andvc	r0, r0, sl
    23ec:	0000005c 	andeq	r0, r0, ip, asr r0
    23f0:	1e010801 	cdpne	8, 0, cr0, cr1, cr1, {0}
    23f4:	7100000a 	tstvc	r0, sl
    23f8:	0000005c 	andeq	r0, r0, ip, asr r0
    23fc:	19010901 	stmdbne	r1, {r0, r8, fp}
    2400:	7200000a 	andvc	r0, r0, #10
    2404:	0000005c 	andeq	r0, r0, ip, asr r0
    2408:	c7010a01 	strgt	r0, [r1, -r1, lsl #20]
    240c:	73000008 	movwvc	r0, #8
    2410:	0000005c 	andeq	r0, r0, ip, asr r0
    2414:	07000b15 	smladeq	r0, r5, fp, r0
    2418:	00000a35 	andeq	r0, r0, r5, lsr sl
    241c:	00053f65 	andeq	r3, r5, r5, ror #30
    2420:	6c610800 	stclvs	8, cr0, [r1], #-0
    2424:	5c66006c 	stclpl	0, cr0, [r6], #-432	@ 0xfffffe50
    2428:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    242c:	0000095c 	andeq	r0, r0, ip, asr r9
    2430:	00048974 	andeq	r8, r4, r4, ror r9
    2434:	35030000 	strcc	r0, [r3, #-0]
    2438:	0300000a 	movweq	r0, #10
    243c:	05200375 	streq	r0, [r0, #-885]!	@ 0xfffffc8b
    2440:	78060000 	stmdavc	r6, {}	@ <UNPREDICTABLE>
    2444:	000005e2 	andeq	r0, r0, r2, ror #11
    2448:	000acb01 	andeq	ip, sl, r1, lsl #22
    244c:	005c7900 	subseq	r7, ip, r0, lsl #18
    2450:	00010000 	andeq	r0, r1, r0
    2454:	000bf201 	andeq	pc, fp, r1, lsl #4
    2458:	005c7a00 	subseq	r7, ip, r0, lsl #20
    245c:	01010000 	mrseq	r0, (UNDEF: 1)
    2460:	000aec01 	andeq	lr, sl, r1, lsl #24
    2464:	005c7b00 	subseq	r7, ip, r0, lsl #22
    2468:	02010000 	andeq	r0, r1, #0
    246c:	000af401 	andeq	pc, sl, r1, lsl #8
    2470:	005c7c00 	subseq	r7, ip, r0, lsl #24
    2474:	03010000 	movweq	r0, #4096	@ 0x1000
    2478:	000a9c01 	andeq	r9, sl, r1, lsl #24
    247c:	005c7d00 	subseq	r7, ip, r0, lsl #26
    2480:	04010000 	streq	r0, [r1], #-0
    2484:	000b7301 	andeq	r7, fp, r1, lsl #6
    2488:	005c7e00 	subseq	r7, ip, r0, lsl #28
    248c:	05010000 	streq	r0, [r1, #-0]
    2490:	000c5201 	andeq	r5, ip, r1, lsl #4
    2494:	005c7f00 	subseq	r7, ip, r0, lsl #30
    2498:	06010000 	streq	r0, [r1], -r0
    249c:	000cba01 	andeq	fp, ip, r1, lsl #20
    24a0:	005c8000 	subseq	r8, ip, r0
    24a4:	07010000 	streq	r0, [r1, -r0]
    24a8:	000d7101 	andeq	r7, sp, r1, lsl #2
    24ac:	005c8100 	subseq	r8, ip, r0, lsl #2
    24b0:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    24b4:	000c6901 	andeq	r6, ip, r1, lsl #18
    24b8:	005c8200 	subseq	r8, ip, r0, lsl #4
    24bc:	09010000 	stmdbeq	r1, {}	@ <UNPREDICTABLE>
    24c0:	000b4701 	andeq	r4, fp, r1, lsl #14
    24c4:	005c8300 	subseq	r8, ip, r0, lsl #6
    24c8:	0a010000 	beq	424d0 <cpsr_cp+0x3f248>
    24cc:	0008c701 	andeq	ip, r8, r1, lsl #14
    24d0:	005c8400 	subseq	r8, ip, r0, lsl #8
    24d4:	0b150000 	bleq	5424dc <cpsr_cp+0x53f254>
    24d8:	0c580700 	mrrceq	7, 0, r0, r8, cr0
    24dc:	01760000 	cmneq	r6, r0
    24e0:	08000006 	stmdaeq	r0, {r1, r2}
    24e4:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    24e8:	00005c77 	andeq	r5, r0, r7, ror ip
    24ec:	095c0900 	ldmdbeq	ip, {r8, fp}^
    24f0:	4b850000 	blmi	fe1424f8 <cpsr_cp+0xfe13f270>
    24f4:	00000005 	andeq	r0, r0, r5
    24f8:	000c5803 	andeq	r5, ip, r3, lsl #16
    24fc:	03860300 	orreq	r0, r6, #0, 6
    2500:	000005e2 	andeq	r0, r0, r2, ror #11
    2504:	06a48906 	strteq	r8, [r4], r6, lsl #18
    2508:	8f010000 	svchi	0x00010000
    250c:	8a00000a 	bhi	253c <sHandlers+0x2f0>
    2510:	0000005c 	andeq	r0, r0, ip, asr r0
    2514:	52010001 	andpl	r0, r1, #1
    2518:	8b00000a 	blhi	2548 <sHandlers+0x2fc>
    251c:	0000005c 	andeq	r0, r0, ip, asr r0
    2520:	2e010101 	adfcss	f0, f1, f1
    2524:	8c00000c 	stchi	0, cr0, [r0], {12}
    2528:	0000005c 	andeq	r0, r0, ip, asr r0
    252c:	20010201 	andcs	r0, r1, r1, lsl #4
    2530:	8d00000d 	stchi	0, cr0, [r0, #-52]	@ 0xffffffcc
    2534:	0000005c 	andeq	r0, r0, ip, asr r0
    2538:	5a010301 	bpl	43144 <cpsr_cp+0x3febc>
    253c:	8e00000a 	cdphi	0, 0, cr0, cr0, cr10, {0}
    2540:	0000005c 	andeq	r0, r0, ip, asr r0
    2544:	28010401 	stmdacs	r1, {r0, sl}
    2548:	8f00000b 	svchi	0x0000000b
    254c:	0000005c 	andeq	r0, r0, ip, asr r0
    2550:	e3010501 	movw	r0, #5377	@ 0x1501
    2554:	9000000b 	andls	r0, r0, fp
    2558:	0000005c 	andeq	r0, r0, ip, asr r0
    255c:	d2010601 	andle	r0, r1, #1048576	@ 0x100000
    2560:	9100000a 	tstls	r0, sl
    2564:	0000005c 	andeq	r0, r0, ip, asr r0
    2568:	5b010701 	blpl	44174 <cpsr_cp+0x40eec>
    256c:	9200000d 	andls	r0, r0, #13
    2570:	0000005c 	andeq	r0, r0, ip, asr r0
    2574:	71010801 	tstvc	r1, r1, lsl #16
    2578:	9300000a 	movwls	r0, #10
    257c:	0000005c 	andeq	r0, r0, ip, asr r0
    2580:	96010901 	strls	r0, [r1], -r1, lsl #18
    2584:	9400000a 	strls	r0, [r0], #-10
    2588:	0000005c 	andeq	r0, r0, ip, asr r0
    258c:	c7010a01 	strgt	r0, [r1, -r1, lsl #20]
    2590:	95000008 	strls	r0, [r0, #-8]
    2594:	0000005c 	andeq	r0, r0, ip, asr r0
    2598:	07000b15 	smladeq	r0, r5, fp, r0
    259c:	00000b95 	muleq	r0, r5, fp
    25a0:	0006c387 	andeq	ip, r6, r7, lsl #7
    25a4:	6c610800 	stclvs	8, cr0, [r1], #-0
    25a8:	5c88006c 	stcpl	0, cr0, [r8], {108}	@ 0x6c
    25ac:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    25b0:	0000095c 	andeq	r0, r0, ip, asr r9
    25b4:	00060d96 	muleq	r6, r6, sp
    25b8:	95030000 	strls	r0, [r3, #-0]
    25bc:	0300000b 	movweq	r0, #11
    25c0:	06a40397 	ssateq	r0, #5, r7, lsl #7
    25c4:	9a060000 	bls	1825cc <cpsr_cp+0x17f344>
    25c8:	00000766 	andeq	r0, r0, r6, ror #14
    25cc:	000d0601 	andeq	r0, sp, r1, lsl #12
    25d0:	005c9b00 	subseq	r9, ip, r0, lsl #22
    25d4:	00010000 	andeq	r0, r1, r0
    25d8:	000a2e01 	andeq	r2, sl, r1, lsl #28
    25dc:	005c9c00 	subseq	r9, ip, r0, lsl #24
    25e0:	01010000 	mrseq	r0, (UNDEF: 1)
    25e4:	000a6001 	andeq	r6, sl, r1
    25e8:	005c9d00 	subseq	r9, ip, r0, lsl #26
    25ec:	02010000 	andeq	r0, r1, #0
    25f0:	000c6201 	andeq	r6, ip, r1, lsl #4
    25f4:	005c9e00 	subseq	r9, ip, r0, lsl #28
    25f8:	03010000 	movweq	r0, #4096	@ 0x1000
    25fc:	000aa901 	andeq	sl, sl, r1, lsl #18
    2600:	005c9f00 	subseq	r9, ip, r0, lsl #30
    2604:	04010000 	streq	r0, [r1], #-0
    2608:	000a1401 	andeq	r1, sl, r1, lsl #8
    260c:	005ca000 	subseq	sl, ip, r0
    2610:	05010000 	streq	r0, [r1, #-0]
    2614:	000d7701 	andeq	r7, sp, r1, lsl #14
    2618:	005ca100 	subseq	sl, ip, r0, lsl #2
    261c:	06010000 	streq	r0, [r1], -r0
    2620:	0009e901 	andeq	lr, r9, r1, lsl #18
    2624:	005ca200 	subseq	sl, ip, r0, lsl #4
    2628:	07010000 	streq	r0, [r1, -r0]
    262c:	000d3701 	andeq	r3, sp, r1, lsl #14
    2630:	005ca300 	subseq	sl, ip, r0, lsl #6
    2634:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    2638:	000b5601 	andeq	r5, fp, r1, lsl #12
    263c:	005ca400 	subseq	sl, ip, r0, lsl #8
    2640:	09010000 	stmdbeq	r1, {}	@ <UNPREDICTABLE>
    2644:	0009fa01 	andeq	pc, r9, r1, lsl #20
    2648:	005ca500 	subseq	sl, ip, r0, lsl #10
    264c:	0a010000 	beq	42654 <cpsr_cp+0x3f3cc>
    2650:	0008c701 	andeq	ip, r8, r1, lsl #14
    2654:	005ca600 	subseq	sl, ip, r0, lsl #12
    2658:	0b150000 	bleq	542660 <cpsr_cp+0x53f3d8>
    265c:	0cf30700 	ldcleq	7, cr0, [r3]
    2660:	85980000 	ldrhi	r0, [r8]
    2664:	08000007 	stmdaeq	r0, {r0, r1, r2}
    2668:	006c6c61 	rsbeq	r6, ip, r1, ror #24
    266c:	00005c99 	muleq	r0, r9, ip
    2670:	095c0900 	ldmdbeq	ip, {r8, fp}^
    2674:	cfa70000 	svcgt	0x00a70000
    2678:	00000006 	andeq	r0, r0, r6
    267c:	000cf303 	andeq	pc, ip, r3, lsl #6
    2680:	03a80300 			@ <UNDEFINED> instruction: 0x03a80300
    2684:	00000766 	andeq	r0, r0, r6, ror #14
    2688:	07c8ab06 	strbeq	sl, [r8, r6, lsl #22]
    268c:	8e010000 	cdphi	0, 0, cr0, cr1, cr0, {0}
    2690:	ac00000b 	stcge	0, cr0, [r0], {11}
    2694:	0000005c 	andeq	r0, r0, ip, asr r0
    2698:	ad010001 	stcge	0, cr0, [r1, #-4]
    269c:	ad00000c 	stcge	0, cr0, [r0, #-48]	@ 0xffffffd0
    26a0:	0000005c 	andeq	r0, r0, ip, asr r0
    26a4:	c2010101 	andgt	r0, r1, #1073741824	@ 0x40000000
    26a8:	ae00000b 	cdpge	0, 0, cr0, cr0, cr11, {0}
    26ac:	0000005c 	andeq	r0, r0, ip, asr r0
    26b0:	c7010201 	strgt	r0, [r1, -r1, lsl #4]
    26b4:	af000008 	svcge	0x00000008
    26b8:	0000005c 	andeq	r0, r0, ip, asr r0
    26bc:	0700031d 	smladeq	r0, sp, r3, r0
    26c0:	000009ee 	andeq	r0, r0, lr, ror #19
    26c4:	0007e7a9 	andeq	lr, r7, r9, lsr #15
    26c8:	6c610800 	stclvs	8, cr0, [r1], #-0
    26cc:	5caa006c 	stcpl	0, cr0, [sl], #432	@ 0x1b0
    26d0:	09000000 	stmdbeq	r0, {}	@ <UNPREDICTABLE>
    26d4:	0000095c 	andeq	r0, r0, ip, asr r9
    26d8:	000791b0 			@ <UNDEFINED> instruction: 0x000791b0
    26dc:	ee030000 	cdp	0, 0, cr0, cr3, cr0, {0}
    26e0:	03000009 	movweq	r0, #9
    26e4:	07c803b1 			@ <UNDEFINED> instruction: 0x07c803b1
    26e8:	40130000 	andsmi	r0, r3, r0
    26ec:	4c00000c 	stcmi	0, cr0, [r0], {12}
    26f0:	b110b303 	tstlt	r0, r3, lsl #6
    26f4:	04000008 	streq	r0, [r0], #-8
    26f8:	00000b1c 	andeq	r0, r0, ip, lsl fp
    26fc:	0000dcb4 			@ <UNDEFINED> instruction: 0x0000dcb4
    2700:	d8040000 	stmdale	r4, {}	@ <UNPREDICTABLE>
    2704:	b500000c 	strlt	r0, [r0, #-12]
    2708:	00000142 	andeq	r0, r0, r2, asr #2
    270c:	08860404 	stmeq	r6, {r2, sl}
    2710:	b1b60000 			@ <UNDEFINED> instruction: 0xb1b60000
    2714:	08000008 	stmdaeq	r0, {r3}
    2718:	000c2704 	andeq	r2, ip, r4, lsl #14
    271c:	01e7b700 	mvneq	fp, r0, lsl #14
    2720:	04180000 	ldreq	r0, [r8], #-0
    2724:	0000099e 	muleq	r0, lr, r9
    2728:	00005cb8 			@ <UNDEFINED> instruction: 0x00005cb8
    272c:	fd041c00 	stc2	12, cr1, [r4, #-0]
    2730:	b900000c 	stmdblt	r0, {r2, r3}
    2734:	00000231 	andeq	r0, r0, r1, lsr r2
    2738:	0d520420 	cfldrdeq	mvd0, [r2, #-128]	@ 0xffffff80
    273c:	7bba0000 	blvc	fee82744 <cpsr_cp+0xfee7f4bc>
    2740:	24000002 	strcs	r0, [r0], #-2
    2744:	000ab304 	andeq	fp, sl, r4, lsl #6
    2748:	02c5bb00 	sbceq	fp, r5, #0, 22
    274c:	04280000 	strteq	r0, [r8], #-0
    2750:	00000ae2 	andeq	r0, r0, r2, ror #21
    2754:	000352bc 			@ <UNDEFINED> instruction: 0x000352bc
    2758:	a1042c00 	tstge	r4, r0, lsl #24
    275c:	bd00000c 	stclt	0, cr0, [r0, #-48]	@ 0xffffffd0
    2760:	00000427 	andeq	r0, r0, r7, lsr #8
    2764:	0b5b0430 	bleq	16c382c <cpsr_cp+0x16c05a4>
    2768:	7dbe0000 	ldcvc	0, cr0, [lr]
    276c:	34000004 	strcc	r0, [r0], #-4
    2770:	000b4d04 	andeq	r4, fp, r4, lsl #26
    2774:	053fbf00 	ldreq	fp, [pc, #-3840]!	@ 187c <Kernel_msgQ_is_empty+0x4>
    2778:	04380000 	ldrteq	r0, [r8], #-0
    277c:	00000a77 	andeq	r0, r0, r7, ror sl
    2780:	000601c0 	andeq	r0, r6, r0, asr #3
    2784:	db043c00 	blle	11178c <cpsr_cp+0x10e504>
    2788:	c100000b 	tstgt	r0, fp
    278c:	000006c3 	andeq	r0, r0, r3, asr #13
    2790:	0b790440 	bleq	1e43898 <cpsr_cp+0x1e40610>
    2794:	85c20000 	strbhi	r0, [r2]
    2798:	44000007 	strmi	r0, [r0], #-7
    279c:	000ad804 	andeq	sp, sl, r4, lsl #16
    27a0:	07e7c300 	strbeq	ip, [r7, r0, lsl #6]!
    27a4:	00480000 	subeq	r0, r8, r0
    27a8:	00005c14 	andeq	r5, r0, r4, lsl ip
    27ac:	0008c100 	andeq	ip, r8, r0, lsl #2
    27b0:	00681500 	rsbeq	r1, r8, r0, lsl #10
    27b4:	00030000 	andeq	r0, r3, r0
    27b8:	000c4003 	andeq	r4, ip, r3
    27bc:	03c40300 	biceq	r0, r4, #0, 6
    27c0:	000007f3 	strdeq	r0, [r0], -r3
    27c4:	0008c116 	andeq	ip, r8, r6, lsl r1
    27c8:	08900300 	ldmeq	r0, {r8, r9}
    27cc:	08040000 	stmdaeq	r4, {}	@ <UNPREDICTABLE>
    27d0:	0008de10 	andeq	sp, r8, r0, lsl lr
    27d4:	08e30e00 	stmiaeq	r3!, {r9, sl, fp}^
    27d8:	0f170000 	svceq	0x00170000
    27dc:	0000041b 	andeq	r0, r0, fp, lsl r4
    27e0:	00006804 	andeq	r6, r0, r4, lsl #16
    27e4:	f3060500 	vrshl.u8	d0, d0, d6
    27e8:	0a000009 	beq	2814 <printf_buf+0x1c8>
    27ec:	00000553 	andeq	r0, r0, r3, asr r5
    27f0:	03120a01 	tsteq	r2, #4096	@ 0x1000
    27f4:	0a020000 	beq	827fc <cpsr_cp+0x7f574>
    27f8:	00000657 	andeq	r0, r0, r7, asr r6
    27fc:	073b0a04 	ldreq	r0, [fp, -r4, lsl #20]!
    2800:	0a080000 	beq	202808 <cpsr_cp+0x1ff580>
    2804:	00000690 	muleq	r0, r0, r6
    2808:	06ab0a10 	ssateq	r0, #12, r0, lsl #20
    280c:	0a200000 	beq	802814 <cpsr_cp+0x7ff58c>
    2810:	000006c6 	andeq	r0, r0, r6, asr #13
    2814:	06e10a40 	strbteq	r0, [r1], r0, asr #20
    2818:	0c800000 	stceq	0, cr0, [r0], {0}
    281c:	000006fc 	strdeq	r0, [r0], -ip
    2820:	170c0100 	strne	r0, [ip, -r0, lsl #2]
    2824:	00000007 	andeq	r0, r0, r7
    2828:	057d0c02 	ldrbeq	r0, [sp, #-3074]!	@ 0xfffff3fe
    282c:	04000000 	streq	r0, [r0], #-0
    2830:	0003280c 	andeq	r2, r3, ip, lsl #16
    2834:	0c080000 	stceq	0, cr0, [r8], {-0}
    2838:	00000343 	andeq	r0, r0, r3, asr #6
    283c:	5e0c1000 	cdppl	0, 0, cr1, cr12, cr0, {0}
    2840:	00000003 	andeq	r0, r0, r3
    2844:	03790c20 	cmneq	r9, #32, 24	@ 0x2000
    2848:	40000000 	andmi	r0, r0, r0
    284c:	0003940c 	andeq	r9, r3, ip, lsl #8
    2850:	05800000 	streq	r0, [r0]
    2854:	000003af 	andeq	r0, r0, pc, lsr #7
    2858:	00010000 	andeq	r0, r1, r0
    285c:	0003ca05 	andeq	ip, r3, r5, lsl #20
    2860:	02000000 	andeq	r0, r0, #0
    2864:	03e50500 	mvneq	r0, #0, 10
    2868:	00000000 	andeq	r0, r0, r0
    286c:	00050004 	andeq	r0, r5, r4
    2870:	00000004 	andeq	r0, r0, r4
    2874:	05000800 	streq	r0, [r0, #-2048]	@ 0xfffff800
    2878:	00000460 	andeq	r0, r0, r0, ror #8
    287c:	00100000 	andseq	r0, r0, r0
    2880:	00047b05 	andeq	r7, r4, r5, lsl #22
    2884:	20000000 	andcs	r0, r0, r0
    2888:	04960500 	ldreq	r0, [r6], #1280	@ 0x500
    288c:	00000000 	andeq	r0, r0, r0
    2890:	b1050040 	tstlt	r5, r0, asr #32
    2894:	00000004 	andeq	r0, r0, r4
    2898:	05008000 	streq	r8, [r0, #-0]
    289c:	000004cc 	andeq	r0, r0, ip, asr #9
    28a0:	01000000 	mrseq	r0, (UNDEF: 0)
    28a4:	0004e705 	andeq	lr, r4, r5, lsl #14
    28a8:	00000000 	andeq	r0, r0, r0
    28ac:	05020502 	streq	r0, [r2, #-1282]	@ 0xfffffafe
    28b0:	00000000 	andeq	r0, r0, r0
    28b4:	1d050400 	cfstrsne	mvf0, [r5, #-0]
    28b8:	00000005 	andeq	r0, r0, r5
    28bc:	05080000 	streq	r0, [r8, #-0]
    28c0:	00000538 	andeq	r0, r0, r8, lsr r5
    28c4:	10000000 	andne	r0, r0, r0
    28c8:	0002c405 	andeq	ip, r2, r5, lsl #8
    28cc:	00000000 	andeq	r0, r0, r0
    28d0:	061b0520 	ldreq	r0, [fp], -r0, lsr #10
    28d4:	00000000 	andeq	r0, r0, r0
    28d8:	36054000 	strcc	r4, [r5], -r0
    28dc:	00000006 	andeq	r0, r0, r6
    28e0:	0a800000 	beq	fe0028e8 <cpsr_cp+0xfdfff660>
    28e4:	00000278 	andeq	r0, r0, r8, ror r2
    28e8:	ac0f0000 	stcge	0, cr0, [pc], {-0}
    28ec:	01000005 	tsteq	r0, r5
    28f0:	0000004e 	andeq	r0, r0, lr, asr #32
    28f4:	0a1c0906 	beq	704d14 <cpsr_cp+0x701a8c>
    28f8:	ce0a0000 	cdpgt	0, 0, cr0, cr10, cr0, {0}
    28fc:	00000005 	andeq	r0, r0, r5
    2900:	0005df0a 	andeq	sp, r5, sl, lsl #30
    2904:	f00a0100 			@ <UNDEFINED> instruction: 0xf00a0100
    2908:	02000005 	andeq	r0, r0, #5
    290c:	0002e90a 	andeq	lr, r2, sl, lsl #18
    2910:	03000300 	movweq	r0, #768	@ 0x300
    2914:	000005ac 	andeq	r0, r0, ip, lsr #11
    2918:	f3030f06 	vpmax.f32	d0, d3, d6
    291c:	18000009 	stmdane	r0, {r0, r3}
    2920:	00000cd3 	ldrdeq	r0, [r0], -r3
    2924:	341a0701 	ldrcc	r0, [sl], #-1793	@ 0xfffff8ff
    2928:	0e00000a 	cdpeq	0, 0, cr0, cr0, cr10, {0}
    292c:	000008cd 	andeq	r0, r0, sp, asr #17
    2930:	0005b919 	andeq	fp, r5, r9, lsl r9
    2934:	060e0700 	streq	r0, [lr], -r0, lsl #14
    2938:	00000a59 	andeq	r0, r0, r9, asr sl
    293c:	00000a59 	andeq	r0, r0, r9, asr sl
    2940:	000a1c0d 	andeq	r1, sl, sp, lsl #24
    2944:	0a600d00 	beq	1805d4c <cpsr_cp+0x1802ac4>
    2948:	5c0d0000 	stcpl	0, cr0, [sp], {-0}
    294c:	00000000 	andeq	r0, r0, r0
    2950:	5102010b 	tstpl	r2, fp, lsl #2
    2954:	1a000002 	bne	2964 <printf_buf+0x318>
    2958:	028e1004 	addeq	r1, lr, #4
    295c:	0c070000 	stceq	0, cr0, [r7], {-0}
    2960:	00000a73 	andeq	r0, r0, r3, ror sl
    2964:	00005c0d 	andeq	r5, r0, sp, lsl #24
    2968:	5e100000 	cdppl	0, 1, cr0, cr0, cr0, {0}
    296c:	04000008 	streq	r0, [r0], #-8
    2970:	000a890d 	andeq	r8, sl, sp, lsl #18
    2974:	08d20d00 	ldmeq	r2, {r8, sl, fp}^
    2978:	5c0d0000 	stcpl	0, cr0, [sp], {-0}
    297c:	00000000 	andeq	r0, r0, r0
    2980:	000dc91b 	andeq	ip, sp, fp, lsl r9
    2984:	0d300100 	ldfeqs	f0, [r0, #-0]
    2988:	00000dbc 			@ <UNDEFINED> instruction: 0x00000dbc
    298c:	00000078 	andeq	r0, r0, r8, ror r0
    2990:	0aae9c01 	beq	feba999c <cpsr_cp+0xfeba6714>
    2994:	631c0000 	tstvs	ip, #0
    2998:	31010068 	tstcc	r1, r8, rrx
    299c:	0000420b 	andeq	r4, r0, fp, lsl #4
    29a0:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    29a4:	0deb1d00 	stcleq	13, cr1, [fp]
    29a8:	1f010000 	svcne	0x00010000
    29ac:	00004209 	andeq	r4, r0, r9, lsl #4
    29b0:	000d3800 	andeq	r3, sp, r0, lsl #16
    29b4:	00008400 	andeq	r8, r0, r0, lsl #8
    29b8:	d89c0100 	ldmle	ip, {r8}
    29bc:	1e00000a 	cdpne	0, 0, cr0, cr0, cr10, {0}
    29c0:	00000ff4 	strdeq	r0, [r0], -r4
    29c4:	5c0c2001 	stcpl	0, cr2, [ip], {1}
    29c8:	02000000 	andeq	r0, r0, #0
    29cc:	1f007491 	svcne	0x00007491
    29d0:	00000113 	andeq	r0, r0, r3, lsl r1
    29d4:	d4061a01 	strle	r1, [r6], #-2561	@ 0xfffff5ff
    29d8:	6400000c 	strvs	r0, [r0], #-12
    29dc:	01000000 	mrseq	r0, (UNDEF: 0)
    29e0:	000afd9c 	muleq	sl, ip, sp
    29e4:	68632000 	stmdavs	r3!, {sp}^
    29e8:	201a0100 	andscs	r0, sl, r0, lsl #2
    29ec:	00000042 	andeq	r0, r0, r2, asr #32
    29f0:	00779102 	rsbseq	r9, r7, r2, lsl #2
    29f4:	0001b721 	andeq	fp, r1, r1, lsr #14
    29f8:	060b0100 	streq	r0, [fp], -r0, lsl #2
    29fc:	00000c3c 	andeq	r0, r0, ip, lsr ip
    2a00:	00000098 	muleq	r0, r8, r0
    2a04:	63009c01 	movwvs	r9, #3073	@ 0xc01
    2a08:	05000000 	streq	r0, [r0, #-0]
    2a0c:	83040100 	movwhi	r0, #16640	@ 0x4100
    2a10:	02000009 	andeq	r0, r0, #9
    2a14:	000000be 	strheq	r0, [r0], -lr
    2a18:	000e091d 	andeq	r0, lr, sp, lsl r9
    2a1c:	00000d00 	andeq	r0, r0, r0, lsl #26
    2a20:	000e3400 	andeq	r3, lr, r0, lsl #8
    2a24:	0000b000 	andeq	fp, r0, r0
    2a28:	00071700 	andeq	r1, r7, r0, lsl #14
    2a2c:	0dfd0100 	ldfeqe	f0, [sp]
    2a30:	b8180000 	ldmdalt	r8, {}	@ <UNPREDICTABLE>
    2a34:	2c00000e 	stccs	0, cr0, [r0], {14}
    2a38:	01000000 	mrseq	r0, (UNDEF: 0)
    2a3c:	0e21019c 	mcreq	1, 1, r0, cr1, cr12, {4}
    2a40:	8c110000 	ldchi	0, cr0, [r1], {-0}
    2a44:	2c00000e 	stccs	0, cr0, [r0], {14}
    2a48:	01000000 	mrseq	r0, (UNDEF: 0)
    2a4c:	0e16019c 	mrceq	1, 0, r0, cr6, cr12, {4}
    2a50:	600a0000 	andvs	r0, sl, r0
    2a54:	2c00000e 	stccs	0, cr0, [r0], {14}
    2a58:	01000000 	mrseq	r0, (UNDEF: 0)
    2a5c:	0939019c 	ldmdbeq	r9!, {r2, r3, r4, r7, r8}
    2a60:	34030000 	strcc	r0, [r3], #-0
    2a64:	2c00000e 	stccs	0, cr0, [r0], {14}
    2a68:	01000000 	mrseq	r0, (UNDEF: 0)
    2a6c:	02ab009c 	adceq	r0, fp, #156	@ 0x9c
    2a70:	00050000 	andeq	r0, r5, r0
    2a74:	09b20401 	ldmibeq	r2!, {r0, sl}
    2a78:	be0c0000 	cdplt	0, 0, cr0, cr12, cr0, {0}
    2a7c:	1d000000 	stcne	0, cr0, [r0, #-0]
    2a80:	00000e48 	andeq	r0, r0, r8, asr #28
    2a84:	0000000d 	andeq	r0, r0, sp
    2a88:	00000ee4 	andeq	r0, r0, r4, ror #29
    2a8c:	00000438 	andeq	r0, r0, r8, lsr r4
    2a90:	00000784 	andeq	r0, r0, r4, lsl #15
    2a94:	000e6c03 	andeq	r6, lr, r3, lsl #24
    2a98:	1b040200 	blne	1032a0 <cpsr_cp+0x100018>
    2a9c:	00000032 	andeq	r0, r0, r2, lsr r0
    2aa0:	000e6a0d 	andeq	r6, lr, sp, lsl #20
    2aa4:	00050400 	andeq	r0, r5, r0, lsl #8
    2aa8:	00000049 	andeq	r0, r0, r9, asr #32
    2aac:	000e600e 	andeq	r6, lr, lr
    2ab0:	00004900 	andeq	r4, r0, r0, lsl #18
    2ab4:	0f000000 	svceq	0x00000000
    2ab8:	06010204 	streq	r0, [r1], -r4, lsl #4
    2abc:	0000005e 	andeq	r0, r0, lr, asr r0
    2ac0:	b4050202 	strlt	r0, [r5], #-514	@ 0xfffffdfe
    2ac4:	03000000 	movweq	r0, #0
    2ac8:	00000249 	andeq	r0, r0, r9, asr #4
    2acc:	650f0d03 	strvs	r0, [pc, #-3331]	@ 1dd1 <Kernel_mutex_unlock+0x45>
    2ad0:	10000000 	andne	r0, r0, r0
    2ad4:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    2ad8:	08020074 	stmdaeq	r2, {r2, r4, r5, r6}
    2adc:	00007905 	andeq	r7, r0, r5, lsl #18
    2ae0:	01fc0300 	mvnseq	r0, r0, lsl #6
    2ae4:	17030000 	strne	r0, [r3, -r0]
    2ae8:	00007f18 	andeq	r7, r0, r8, lsl pc
    2aec:	08010200 	stmdaeq	r1, {r9}
    2af0:	0000005c 	andeq	r0, r0, ip, asr r0
    2af4:	87070202 	strhi	r0, [r7, -r2, lsl #4]
    2af8:	03000000 	movweq	r0, #0
    2afc:	00000248 	andeq	r0, r0, r8, asr #4
    2b00:	99171a03 	ldmdbls	r7, {r0, r1, r9, fp, ip}
    2b04:	02000000 	andeq	r0, r0, #0
    2b08:	00430704 	subeq	r0, r3, r4, lsl #14
    2b0c:	08020000 	stmdaeq	r2, {}	@ <UNPREDICTABLE>
    2b10:	00003907 	andeq	r3, r0, r7, lsl #18
    2b14:	0e2d1100 	sufeqe	f1, f5, f0
    2b18:	01070000 	mrseq	r0, (UNDEF: 7)
    2b1c:	0000007f 	andeq	r0, r0, pc, ror r0
    2b20:	c60e0704 	strgt	r0, [lr], -r4, lsl #14
    2b24:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    2b28:	00000e3f 	andeq	r0, r0, pc, lsr lr
    2b2c:	0e79080a 	cdpeq	8, 7, cr0, cr9, cr10, {0}
    2b30:	00100000 	andseq	r0, r0, r0
    2b34:	000e2d03 	andeq	r2, lr, r3, lsl #26
    2b38:	030a0400 	movweq	r0, #41984	@ 0xa400
    2b3c:	000000a7 	andeq	r0, r0, r7, lsr #1
    2b40:	0000e309 	andeq	lr, r0, r9, lsl #6
    2b44:	0000e300 	andeq	lr, r0, r0, lsl #6
    2b48:	00991200 	addseq	r1, r9, r0, lsl #4
    2b4c:	03ff0000 	mvnseq	r0, #0
    2b50:	08010200 	stmdaeq	r1, {r9}
    2b54:	00000065 	andeq	r0, r0, r5, rrx
    2b58:	0000e313 	andeq	lr, r0, r3, lsl r3
    2b5c:	0e340500 	cfabs32eq	mvfx0, mvfx4
    2b60:	0d080000 	stceq	0, cr0, [r8, #-0]
    2b64:	000000d2 	ldrdeq	r0, [r0], -r2
    2b68:	264c0305 	strbcs	r0, [ip], -r5, lsl #6
    2b6c:	13140000 	tstne	r4, #0
    2b70:	06000001 	streq	r0, [r0], -r1
    2b74:	01120605 	tsteq	r2, r5, lsl #12
    2b78:	73150000 	tstvc	r5, #0
    2b7c:	00000000 	andeq	r0, r0, r0
    2b80:	000e6506 	andeq	r6, lr, r6, lsl #10
    2b84:	008d4d00 	addeq	r4, sp, r0, lsl #26
    2b88:	12140000 	andsne	r0, r4, #0
    2b8c:	01080000 	mrseq	r0, (UNDEF: 8)
    2b90:	9c010000 	stcls	0, cr0, [r1], {-0}
    2b94:	00000193 	muleq	r0, r3, r1
    2b98:	66756204 	ldrbtvs	r6, [r5], -r4, lsl #4
    2b9c:	93154d00 	tstls	r5, #0, 26
    2ba0:	02000001 	andeq	r0, r0, #1
    2ba4:	76045c91 			@ <UNDEFINED> instruction: 0x76045c91
    2ba8:	4d006c61 	stcmi	12, cr6, [r0, #-388]	@ 0xfffffe7c
    2bac:	00008d23 	andeq	r8, r0, r3, lsr #26
    2bb0:	58910200 	ldmpl	r1, {r9}
    2bb4:	00116007 	andseq	r6, r1, r7
    2bb8:	c62f4d00 	strtgt	r4, [pc], -r0, lsl #26
    2bbc:	02000000 	andeq	r0, r0, #0
    2bc0:	63015791 	movwvs	r5, #6033	@ 0x1791
    2bc4:	8d0c4e00 	stchi	14, cr4, [ip, #-0]
    2bc8:	02000000 	andeq	r0, r0, #0
    2bcc:	69017491 	stmdbvs	r1, {r0, r4, r7, sl, ip, sp, lr}
    2bd0:	4f007864 	svcmi	0x00007864
    2bd4:	0000590b 	andeq	r5, r0, fp, lsl #18
    2bd8:	70910200 	addsvc	r0, r1, r0, lsl #4
    2bdc:	706d7401 	rsbvc	r7, sp, r1, lsl #8
    2be0:	98085000 	stmdals	r8, {ip, lr}
    2be4:	02000001 	andeq	r0, r0, #1
    2be8:	400a6091 	mulmi	sl, r1, r0
    2bec:	74000012 	strvc	r0, [r0], #-18	@ 0xffffffee
    2bf0:	01000000 	mrseq	r0, (UNDEF: 0)
    2bf4:	0e530074 	mrceq	0, 2, r0, cr3, cr4, {3}
    2bf8:	0000008d 	andeq	r0, r0, sp, lsl #1
    2bfc:	006c9102 	rsbeq	r9, ip, r2, lsl #2
    2c00:	00e30b00 	rsceq	r0, r3, r0, lsl #22
    2c04:	e3090000 	movw	r0, #36864	@ 0x9000
    2c08:	a8000000 	stmdage	r0, {}	@ <UNPREDICTABLE>
    2c0c:	16000001 	strne	r0, [r0], -r1
    2c10:	00000099 	muleq	r0, r9, r0
    2c14:	8206000a 	andhi	r0, r6, #10
    2c18:	1c00000e 	stcne	0, cr0, [r0], {14}
    2c1c:	0000008d 	andeq	r0, r0, sp, lsl #1
    2c20:	00000f94 	muleq	r0, r4, pc	@ <UNPREDICTABLE>
    2c24:	00000280 	andeq	r0, r0, r0, lsl #5
    2c28:	02449c01 	subeq	r9, r4, #256	@ 0x100
    2c2c:	62040000 	andvs	r0, r4, #0
    2c30:	1c006675 	stcne	6, cr6, [r0], {117}	@ 0x75
    2c34:	00019319 	andeq	r9, r1, r9, lsl r3
    2c38:	5c910200 	lfmpl	f0, 4, [r1], {0}
    2c3c:	000e5907 	andeq	r5, lr, r7, lsl #18
    2c40:	442a1c00 	strtmi	r1, [sl], #-3072	@ 0xfffff400
    2c44:	02000002 	andeq	r0, r0, #2
    2c48:	61045891 			@ <UNDEFINED> instruction: 0x61045891
    2c4c:	1c006772 	stcne	7, cr6, [r0], {114}	@ 0x72
    2c50:	0000263a 	andeq	r2, r0, sl, lsr r6
    2c54:	54910200 	ldrpl	r0, [r1], #512	@ 0x200
    2c58:	1d006301 	stcne	3, cr6, [r0, #-4]
    2c5c:	00008d0c 	andeq	r8, r0, ip, lsl #26
    2c60:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
    2c64:	00686301 	rsbeq	r6, r8, r1, lsl #6
    2c68:	00e3081f 	rsceq	r0, r3, pc, lsl r8
    2c6c:	91020000 	mrsls	r0, (UNDEF: 2)
    2c70:	74730163 	ldrbtvc	r0, [r3], #-355	@ 0xfffffe9d
    2c74:	09200072 	stmdbeq	r0!, {r1, r4, r5, r6}
    2c78:	00000193 	muleq	r0, r3, r1
    2c7c:	05709102 	ldrbeq	r9, [r0, #-258]!	@ 0xfffffefe
    2c80:	00000e54 	andeq	r0, r0, r4, asr lr
    2c84:	008d0c21 	addeq	r0, sp, r1, lsr #24
    2c88:	91020000 	mrsls	r0, (UNDEF: 2)
    2c8c:	65680164 	strbvs	r0, [r8, #-356]!	@ 0xfffffe9c
    2c90:	0c220078 	stceq	0, cr0, [r2], #-480	@ 0xfffffe20
    2c94:	0000008d 	andeq	r0, r0, sp, lsl #1
    2c98:	0a689102 	beq	1a270a8 <cpsr_cp+0x1a23e20>
    2c9c:	00000fb4 			@ <UNDEFINED> instruction: 0x00000fb4
    2ca0:	0000023c 	andeq	r0, r0, ip, lsr r2
    2ca4:	24006901 	strcs	r6, [r0], #-2305	@ 0xfffff6ff
    2ca8:	00008d11 	andeq	r8, r0, r1, lsl sp
    2cac:	6c910200 	lfmvs	f0, 4, [r1], {0}
    2cb0:	ea0b0000 	b	2c2cb8 <cpsr_cp+0x2bfa30>
    2cb4:	06000000 	streq	r0, [r0], -r0
    2cb8:	00000204 	andeq	r0, r0, r4, lsl #4
    2cbc:	00008d13 	andeq	r8, r0, r3, lsl sp
    2cc0:	000f4400 	andeq	r4, pc, r0, lsl #8
    2cc4:	00005000 	andeq	r5, r0, r0
    2cc8:	7f9c0100 	svcvc	0x009c0100
    2ccc:	07000002 	streq	r0, [r0, -r2]
    2cd0:	00000e59 	andeq	r0, r0, r9, asr lr
    2cd4:	02442313 	subeq	r2, r4, #1275068416	@ 0x4c000000
    2cd8:	91020000 	mrsls	r0, (UNDEF: 2)
    2cdc:	74051770 	strvc	r1, [r5], #-1904	@ 0xfffff890
    2ce0:	1400000e 	strne	r0, [r0], #-14
    2ce4:	0000260b 	andeq	r2, r0, fp, lsl #12
    2ce8:	64910200 	ldrvs	r0, [r1], #512	@ 0x200
    2cec:	021c1800 	andseq	r1, ip, #0, 16
    2cf0:	0a010000 	beq	42cf8 <cpsr_cp+0x3fa70>
    2cf4:	00008d0a 	andeq	r8, r0, sl, lsl #26
    2cf8:	000ee400 	andeq	lr, lr, r0, lsl #8
    2cfc:	00006000 	andeq	r6, r0, r0
    2d00:	049c0100 	ldreq	r0, [ip], #256	@ 0x100
    2d04:	1d0a0073 	stcne	0, cr0, [sl, #-460]	@ 0xfffffe34
    2d08:	00000244 	andeq	r0, r0, r4, asr #4
    2d0c:	016c9102 	cmneq	ip, r2, lsl #2
    2d10:	0c0b0063 	stceq	0, cr0, [fp], {99}	@ 0x63
    2d14:	0000008d 	andeq	r0, r0, sp, lsl #1
    2d18:	00749102 	rsbseq	r9, r4, r2, lsl #2
    2d1c:	0000a300 	andeq	sl, r0, r0, lsl #6
    2d20:	01000500 	tsteq	r0, r0, lsl #10
    2d24:	000b0404 	andeq	r0, fp, r4, lsl #8
    2d28:	00be0200 	adcseq	r0, lr, r0, lsl #4
    2d2c:	901d0000 	andsls	r0, sp, r0
    2d30:	0d00000e 	stceq	0, cr0, [r0, #-56]	@ 0xffffffc8
    2d34:	24000000 	strcs	r0, [r0], #-0
    2d38:	4c000013 	stcmi	0, cr0, [r0], {19}
    2d3c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    2d40:	01000009 	tsteq	r0, r9
    2d44:	005e0601 	subseq	r0, lr, r1, lsl #12
    2d48:	02010000 	andeq	r0, r1, #0
    2d4c:	0000b405 	andeq	fp, r0, r5, lsl #8
    2d50:	05040300 	streq	r0, [r4, #-768]	@ 0xfffffd00
    2d54:	00746e69 	rsbseq	r6, r4, r9, ror #28
    2d58:	79050801 	stmdbvc	r5, {r0, fp}
    2d5c:	01000000 	mrseq	r0, (UNDEF: 0)
    2d60:	005c0801 	subseq	r0, ip, r1, lsl #16
    2d64:	02010000 	andeq	r0, r1, #0
    2d68:	00008707 	andeq	r8, r0, r7, lsl #14
    2d6c:	02480400 	subeq	r0, r8, #0, 8
    2d70:	1a020000 	bne	82d78 <cpsr_cp+0x7faf0>
    2d74:	00005c17 	andeq	r5, r0, r7, lsl ip
    2d78:	07040100 	streq	r0, [r4, -r0, lsl #2]
    2d7c:	00000043 	andeq	r0, r0, r3, asr #32
    2d80:	39070801 	stmdbcc	r7, {r0, fp}
    2d84:	05000000 	streq	r0, [r0, #-0]
    2d88:	00000daf 	andeq	r0, r0, pc, lsr #27
    2d8c:	500a0503 	andpl	r0, sl, r3, lsl #10
    2d90:	06000000 	streq	r0, [r0], -r0
    2d94:	0000030c 	andeq	r0, r0, ip, lsl #6
    2d98:	24060501 	strcs	r0, [r6], #-1281	@ 0xfffffaff
    2d9c:	4c000013 	stcmi	0, cr0, [r0], {19}
    2da0:	01000000 	mrseq	r0, (UNDEF: 0)
    2da4:	736d079c 	cmnvc	sp, #156, 14	@ 0x2700000
    2da8:	15050100 	strne	r0, [r5, #-256]	@ 0xffffff00
    2dac:	00000050 	andeq	r0, r0, r0, asr r0
    2db0:	086c9102 	stmdaeq	ip!, {r1, r8, ip, pc}^
    2db4:	00000e8b 	andeq	r0, r0, fp, lsl #29
    2db8:	500c0601 	andpl	r0, ip, r1, lsl #12
    2dbc:	02000000 	andeq	r0, r0, #0
    2dc0:	00007491 	muleq	r0, r1, r4
    2dc4:	0000021e 	andeq	r0, r0, lr, lsl r2
    2dc8:	04010005 	streq	r0, [r1], #-5
    2dcc:	00000b8d 	andeq	r0, r0, sp, lsl #23
    2dd0:	0000be08 	andeq	fp, r0, r8, lsl #28
    2dd4:	0ee31d00 	cdpeq	13, 14, cr1, cr3, cr0, {0}
    2dd8:	000d0000 	andeq	r0, sp, r0
    2ddc:	13700000 	cmnne	r0, #0
    2de0:	00f80000 	rscseq	r0, r8, r0
    2de4:	098f0000 	stmibeq	pc, {}	@ <UNPREDICTABLE>
    2de8:	01030000 	mrseq	r0, (UNDEF: 3)
    2dec:	00005e06 	andeq	r5, r0, r6, lsl #28
    2df0:	05020300 	streq	r0, [r2, #-768]	@ 0xfffffd00
    2df4:	000000b4 	strheq	r0, [r0], -r4
    2df8:	69050409 	stmdbvs	r5, {r0, r3, sl}
    2dfc:	0300746e 	movweq	r7, #1134	@ 0x46e
    2e00:	00790508 	rsbseq	r0, r9, r8, lsl #10
    2e04:	01030000 	mrseq	r0, (UNDEF: 3)
    2e08:	00005c08 	andeq	r5, r0, r8, lsl #24
    2e0c:	07020300 	streq	r0, [r2, -r0, lsl #6]
    2e10:	00000087 	andeq	r0, r0, r7, lsl #1
    2e14:	00024806 	andeq	r4, r2, r6, lsl #16
    2e18:	171a0200 	ldrne	r0, [sl, -r0, lsl #4]
    2e1c:	0000005c 	andeq	r0, r0, ip, asr r0
    2e20:	43070403 	movwmi	r0, #29699	@ 0x7403
    2e24:	03000000 	movweq	r0, #0
    2e28:	00390708 	eorseq	r0, r9, r8, lsl #14
    2e2c:	1b0a0000 	blne	282e34 <cpsr_cp+0x27fbac>
    2e30:	07000004 	streq	r0, [r0, -r4]
    2e34:	00005c04 	andeq	r5, r0, r4, lsl #24
    2e38:	0e060300 	cdpeq	3, 0, cr0, cr6, cr0, {0}
    2e3c:	0000017b 	andeq	r0, r0, fp, ror r1
    2e40:	00055302 	andeq	r5, r5, r2, lsl #6
    2e44:	12020100 	andne	r0, r2, #0, 2
    2e48:	02000003 	andeq	r0, r0, #3
    2e4c:	00065702 	andeq	r5, r6, r2, lsl #14
    2e50:	3b020400 	blcc	83e58 <cpsr_cp+0x80bd0>
    2e54:	08000007 	stmdaeq	r0, {r0, r1, r2}
    2e58:	00069002 	andeq	r9, r6, r2
    2e5c:	ab021000 	blge	86e64 <cpsr_cp+0x83bdc>
    2e60:	20000006 	andcs	r0, r0, r6
    2e64:	0006c602 	andeq	ip, r6, r2, lsl #12
    2e68:	e1024000 	mrs	r4, (UNDEF: 2)
    2e6c:	80000006 	andhi	r0, r0, r6
    2e70:	0006fc04 	andeq	pc, r6, r4, lsl #24
    2e74:	04010000 	streq	r0, [r1], #-0
    2e78:	00000717 	andeq	r0, r0, r7, lsl r7
    2e7c:	7d040200 	sfmvc	f0, 4, [r4, #-0]
    2e80:	00000005 	andeq	r0, r0, r5
    2e84:	03280404 			@ <UNDEFINED> instruction: 0x03280404
    2e88:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    2e8c:	00034304 	andeq	r4, r3, r4, lsl #6
    2e90:	04100000 	ldreq	r0, [r0], #-0
    2e94:	0000035e 	andeq	r0, r0, lr, asr r3
    2e98:	79042000 	stmdbvc	r4, {sp}
    2e9c:	00000003 	andeq	r0, r0, r3
    2ea0:	03940440 	orrseq	r0, r4, #64, 8	@ 0x40000000
    2ea4:	80000000 	andhi	r0, r0, r0
    2ea8:	0003af01 	andeq	sl, r3, r1, lsl #30
    2eac:	01000000 	mrseq	r0, (UNDEF: 0)
    2eb0:	03ca0100 	biceq	r0, sl, #0, 2
    2eb4:	00000000 	andeq	r0, r0, r0
    2eb8:	e5010002 	str	r0, [r1, #-2]
    2ebc:	00000003 	andeq	r0, r0, r3
    2ec0:	01000400 	tsteq	r0, r0, lsl #8
    2ec4:	00000400 	andeq	r0, r0, r0, lsl #8
    2ec8:	00080000 	andeq	r0, r8, r0
    2ecc:	00046001 	andeq	r6, r4, r1
    2ed0:	10000000 	andne	r0, r0, r0
    2ed4:	047b0100 	ldrbteq	r0, [fp], #-256	@ 0xffffff00
    2ed8:	00000000 	andeq	r0, r0, r0
    2edc:	96010020 	strls	r0, [r1], -r0, lsr #32
    2ee0:	00000004 	andeq	r0, r0, r4
    2ee4:	01004000 	mrseq	r4, (UNDEF: 0)
    2ee8:	000004b1 			@ <UNDEFINED> instruction: 0x000004b1
    2eec:	00800000 	addeq	r0, r0, r0
    2ef0:	0004cc01 	andeq	ip, r4, r1, lsl #24
    2ef4:	00000000 	andeq	r0, r0, r0
    2ef8:	04e70101 	strbteq	r0, [r7], #257	@ 0x101
    2efc:	00000000 	andeq	r0, r0, r0
    2f00:	02010200 	andeq	r0, r1, #0, 4
    2f04:	00000005 	andeq	r0, r0, r5
    2f08:	01040000 	mrseq	r0, (UNDEF: 4)
    2f0c:	0000051d 	andeq	r0, r0, sp, lsl r5
    2f10:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    2f14:	00053801 	andeq	r3, r5, r1, lsl #16
    2f18:	00000000 	andeq	r0, r0, r0
    2f1c:	02c40110 	sbceq	r0, r4, #16, 2
    2f20:	00000000 	andeq	r0, r0, r0
    2f24:	1b012000 	blne	4af2c <cpsr_cp+0x47ca4>
    2f28:	00000006 	andeq	r0, r0, r6
    2f2c:	01400000 	mrseq	r0, (UNDEF: 64)
    2f30:	00000636 	andeq	r0, r0, r6, lsr r6
    2f34:	80000000 	andhi	r0, r0, r0
    2f38:	00027802 	andeq	r7, r2, r2, lsl #16
    2f3c:	06000000 	streq	r0, [r0], -r0
    2f40:	0000041b 	andeq	r0, r0, fp, lsl r4
    2f44:	6a032903 	bvs	cd358 <cpsr_cp+0xca0d0>
    2f48:	0b000000 	bleq	2f50 <sMsgQ+0x500>
    2f4c:	00000ef2 	strdeq	r0, [r0], -r2
    2f50:	50110701 	andspl	r0, r1, r1, lsl #14
    2f54:	05000000 	streq	r0, [r0, #-0]
    2f58:	002a4c03 	eoreq	r4, sl, r3, lsl #24
    2f5c:	0e9d0c00 	cdpeq	12, 9, cr0, cr13, cr0, {0}
    2f60:	12010000 	andne	r0, r1, #0
    2f64:	0001c206 	andeq	ip, r1, r6, lsl #4
    2f68:	00141c00 	andseq	r1, r4, r0, lsl #24
    2f6c:	00004c00 	andeq	r4, r0, r0, lsl #24
    2f70:	c29c0100 	addsgt	r0, ip, #0, 2
    2f74:	05000001 	streq	r0, [r0, #-1]
    2f78:	000002a8 	andeq	r0, r0, r8, lsr #5
    2f7c:	017b3012 	cmneq	fp, r2, lsl r0
    2f80:	91020000 	mrsls	r0, (UNDEF: 2)
    2f84:	01030074 	tsteq	r3, r4, ror r0
    2f88:	00025102 	andeq	r5, r2, r2, lsl #2
    2f8c:	0ecb0700 	cdpeq	7, 12, cr0, cr11, cr0, {0}
    2f90:	d80f0000 	stmdale	pc, {}	@ <UNPREDICTABLE>
    2f94:	44000013 	strmi	r0, [r0], #-19	@ 0xffffffed
    2f98:	01000000 	mrseq	r0, (UNDEF: 0)
    2f9c:	0001ec9c 	muleq	r1, ip, ip
    2fa0:	02a80500 	adceq	r0, r8, #0, 10
    2fa4:	300f0000 	andcc	r0, pc, r0
    2fa8:	0000017b 	andeq	r0, r0, fp, ror r1
    2fac:	00749102 	rsbseq	r9, r4, r2, lsl #2
    2fb0:	000eb507 	andeq	fp, lr, r7, lsl #10
    2fb4:	13980c00 	orrsne	r0, r8, #0, 24
    2fb8:	00400000 	subeq	r0, r0, r0
    2fbc:	9c010000 	stcls	0, cr0, [r1], {-0}
    2fc0:	0000020f 	andeq	r0, r0, pc, lsl #4
    2fc4:	0002a805 	andeq	sl, r2, r5, lsl #16
    2fc8:	7b2e0c00 	blvc	b85fd0 <cpsr_cp+0xb82d48>
    2fcc:	02000001 	andeq	r0, r0, #1
    2fd0:	0d007491 	cfstrseq	mvf7, [r0, #-580]	@ 0xfffffdbc
    2fd4:	00000142 	andeq	r0, r0, r2, asr #2
    2fd8:	70060901 	andvc	r0, r6, r1, lsl #18
    2fdc:	28000013 	stmdacs	r0, {r0, r1, r4}
    2fe0:	01000000 	mrseq	r0, (UNDEF: 0)
    2fe4:	04b1009c 	ldrteq	r0, [r1], #156	@ 0x9c
    2fe8:	00050000 	andeq	r0, r5, r0
    2fec:	0c6c0401 	cfstrdeq	mvd0, [ip], #-4
    2ff0:	be120000 	cdplt	0, 1, cr0, cr2, cr0, {0}
    2ff4:	1d000000 	stcne	0, cr0, [r0, #-0]
    2ff8:	00000f4d 	andeq	r0, r0, sp, asr #30
    2ffc:	0000000d 	andeq	r0, r0, sp
    3000:	00001468 	andeq	r1, r0, r8, ror #8
    3004:	00000388 	andeq	r0, r0, r8, lsl #7
    3008:	00000a1a 	andeq	r0, r0, sl, lsl sl
    300c:	5e060103 	adfpls	f0, f6, f3
    3010:	03000000 	movweq	r0, #0
    3014:	00b40502 	adcseq	r0, r4, r2, lsl #10
    3018:	04130000 	ldreq	r0, [r3], #-0
    301c:	746e6905 	strbtvc	r6, [lr], #-2309	@ 0xfffff6fb
    3020:	05080300 	streq	r0, [r8, #-768]	@ 0xfffffd00
    3024:	00000079 	andeq	r0, r0, r9, ror r0
    3028:	0001fc0b 	andeq	pc, r1, fp, lsl #24
    302c:	18170200 	ldmdane	r7, {r9}
    3030:	0000004e 	andeq	r0, r0, lr, asr #32
    3034:	5c080103 	stfpls	f0, [r8], {3}
    3038:	03000000 	movweq	r0, #0
    303c:	00870702 	addeq	r0, r7, r2, lsl #14
    3040:	480b0000 	stmdami	fp, {}	@ <UNPREDICTABLE>
    3044:	02000002 	andeq	r0, r0, #2
    3048:	0068171a 	rsbeq	r1, r8, sl, lsl r7
    304c:	04030000 	streq	r0, [r3], #-0
    3050:	00004307 	andeq	r4, r0, r7, lsl #6
    3054:	07080300 	streq	r0, [r8, -r0, lsl #6]
    3058:	00000039 	andeq	r0, r0, r9, lsr r0
    305c:	00420414 	subeq	r0, r2, r4, lsl r4
    3060:	1b100000 	blne	403068 <cpsr_cp+0x3ffde0>
    3064:	04000004 	streq	r0, [r0], #-4
    3068:	00000068 	andeq	r0, r0, r8, rrx
    306c:	018b0603 	orreq	r0, fp, r3, lsl #12
    3070:	53020000 	movwpl	r0, #8192	@ 0x2000
    3074:	01000005 	tsteq	r0, r5
    3078:	00031202 	andeq	r1, r3, r2, lsl #4
    307c:	57020200 	strpl	r0, [r2, -r0, lsl #4]
    3080:	04000006 	streq	r0, [r0], #-6
    3084:	00073b02 	andeq	r3, r7, r2, lsl #22
    3088:	90020800 	andls	r0, r2, r0, lsl #16
    308c:	10000006 	andne	r0, r0, r6
    3090:	0006ab02 	andeq	sl, r6, r2, lsl #22
    3094:	c6022000 	strgt	r2, [r2], -r0
    3098:	40000006 	andmi	r0, r0, r6
    309c:	0006e102 	andeq	lr, r6, r2, lsl #2
    30a0:	fc048000 	stc2	0, cr8, [r4], {-0}
    30a4:	00000006 	andeq	r0, r0, r6
    30a8:	07170401 	ldreq	r0, [r7, -r1, lsl #8]
    30ac:	02000000 	andeq	r0, r0, #0
    30b0:	00057d04 	andeq	r7, r5, r4, lsl #26
    30b4:	04040000 	streq	r0, [r4], #-0
    30b8:	00000328 	andeq	r0, r0, r8, lsr #6
    30bc:	43040800 	movwmi	r0, #18432	@ 0x4800
    30c0:	00000003 	andeq	r0, r0, r3
    30c4:	035e0410 	cmpeq	lr, #16, 8	@ 0x10000000
    30c8:	20000000 	andcs	r0, r0, r0
    30cc:	00037904 	andeq	r7, r3, r4, lsl #18
    30d0:	04400000 	strbeq	r0, [r0], #-0
    30d4:	00000394 	muleq	r0, r4, r3
    30d8:	af018000 	svcge	0x00018000
    30dc:	00000003 	andeq	r0, r0, r3
    30e0:	01000100 	mrseq	r0, (UNDEF: 16)
    30e4:	000003ca 	andeq	r0, r0, sl, asr #7
    30e8:	00020000 	andeq	r0, r2, r0
    30ec:	0003e501 	andeq	lr, r3, r1, lsl #10
    30f0:	04000000 	streq	r0, [r0], #-0
    30f4:	04000100 	streq	r0, [r0], #-256	@ 0xffffff00
    30f8:	00000000 	andeq	r0, r0, r0
    30fc:	60010008 	andvs	r0, r1, r8
    3100:	00000004 	andeq	r0, r0, r4
    3104:	01001000 	mrseq	r1, (UNDEF: 0)
    3108:	0000047b 	andeq	r0, r0, fp, ror r4
    310c:	00200000 	eoreq	r0, r0, r0
    3110:	00049601 	andeq	r9, r4, r1, lsl #12
    3114:	40000000 	andmi	r0, r0, r0
    3118:	04b10100 	ldrteq	r0, [r1], #256	@ 0x100
    311c:	00000000 	andeq	r0, r0, r0
    3120:	cc010080 	stcgt	0, cr0, [r1], {128}	@ 0x80
    3124:	00000004 	andeq	r0, r0, r4
    3128:	01010000 	mrseq	r0, (UNDEF: 1)
    312c:	000004e7 	andeq	r0, r0, r7, ror #9
    3130:	02000000 	andeq	r0, r0, #0
    3134:	00050201 	andeq	r0, r5, r1, lsl #4
    3138:	00000000 	andeq	r0, r0, r0
    313c:	051d0104 	ldreq	r0, [sp, #-260]	@ 0xfffffefc
    3140:	00000000 	andeq	r0, r0, r0
    3144:	38010800 	stmdacc	r1, {fp}
    3148:	00000005 	andeq	r0, r0, r5
    314c:	01100000 	tsteq	r0, r0
    3150:	000002c4 	andeq	r0, r0, r4, asr #5
    3154:	20000000 	andcs	r0, r0, r0
    3158:	00061b01 	andeq	r1, r6, r1, lsl #22
    315c:	00000000 	andeq	r0, r0, r0
    3160:	06360140 	ldrteq	r0, [r6], -r0, asr #2
    3164:	00000000 	andeq	r0, r0, r0
    3168:	78028000 	stmdavc	r2, {pc}
    316c:	00000002 	andeq	r0, r0, r2
    3170:	041b0b00 	ldreq	r0, [fp], #-2816	@ 0xfffff500
    3174:	29030000 	stmdbcs	r3, {}	@ <UNPREDICTABLE>
    3178:	00007c03 	andeq	r7, r0, r3, lsl #24
    317c:	05ac1000 	streq	r1, [ip, #0]!
    3180:	4e010000 	cdpmi	0, 0, cr0, cr1, cr0, {0}
    3184:	04000000 	streq	r0, [r0], #-0
    3188:	0001c009 	andeq	ip, r1, r9
    318c:	05ce0200 	strbeq	r0, [lr, #512]	@ 0x200
    3190:	02000000 	andeq	r0, r0, #0
    3194:	000005df 	ldrdeq	r0, [r0], -pc	@ <UNPREDICTABLE>
    3198:	05f00201 	ldrbeq	r0, [r0, #513]!	@ 0x201
    319c:	02020000 	andeq	r0, r2, #0
    31a0:	000002e9 	andeq	r0, r0, r9, ror #5
    31a4:	ac0b0003 	stcge	0, cr0, [fp], {3}
    31a8:	04000005 	streq	r0, [r0], #-5
    31ac:	0197030f 	orrseq	r0, r7, pc, lsl #6
    31b0:	01030000 	mrseq	r0, (UNDEF: 3)
    31b4:	00025102 	andeq	r5, r2, r2, lsl #2
    31b8:	0efd0900 	vmoveq.f16	s1, #208	@ 0xbe800000 -0.250	@ <UNPREDICTABLE>
    31bc:	12050000 	andne	r0, r5, #0
    31c0:	000001cc 	andeq	r0, r0, ip, asr #3
    31c4:	000001e8 	andeq	r0, r0, r8, ror #3
    31c8:	00005c05 	andeq	r5, r0, r5, lsl #24
    31cc:	3b090000 	blcc	2431d4 <cpsr_cp+0x23ff4c>
    31d0:	0500000f 	streq	r0, [r0, #-15]
    31d4:	0001cc11 	andeq	ip, r1, r1, lsl ip
    31d8:	0001fd00 	andeq	pc, r1, r0, lsl #26
    31dc:	005c0500 	subseq	r0, ip, r0, lsl #10
    31e0:	11000000 	mrsne	r0, (UNDEF: 0)
    31e4:	00000fa9 	andeq	r0, r0, r9, lsr #31
    31e8:	5c0a1c06 	stcpl	12, cr1, [sl], {6}
    31ec:	0d000000 	stceq	0, cr0, [r0, #-0]
    31f0:	00000fc9 	andeq	r0, r0, r9, asr #31
    31f4:	2b110905 	blcs	445610 <cpsr_cp+0x442388>
    31f8:	0500000f 	streq	r0, [r0, #-15]
    31fc:	01cc0608 	biceq	r0, ip, r8, lsl #12
    3200:	75090000 	strvc	r0, [r9, #-0]
    3204:	0400000f 	streq	r0, [r0], #-15
    3208:	0001cc1b 	andeq	ip, r1, fp, lsl ip
    320c:	00023600 	andeq	r3, r2, r0, lsl #12
    3210:	01c00500 	biceq	r0, r0, r0, lsl #10
    3214:	76050000 	strvc	r0, [r5], -r0
    3218:	00000000 	andeq	r0, r0, r0
    321c:	000fdc09 	andeq	sp, pc, r9, lsl #24
    3220:	cc1a0400 	cfldrsgt	mvf0, [sl], {-0}
    3224:	50000001 	andpl	r0, r0, r1
    3228:	05000002 	streq	r0, [r0, #-2]
    322c:	000001c0 	andeq	r0, r0, r0, asr #3
    3230:	00004205 	andeq	r4, r0, r5, lsl #4
    3234:	9d090000 	stcls	0, cr0, [r9, #-0]
    3238:	0300000e 	movweq	r0, #14
    323c:	0001cc2e 	andeq	ip, r1, lr, lsr #24
    3240:	00026500 	andeq	r6, r2, r0, lsl #10
    3244:	018b0500 	orreq	r0, fp, r0, lsl #10
    3248:	15000000 	strne	r0, [r0, #-0]
    324c:	00000eb5 			@ <UNDEFINED> instruction: 0x00000eb5
    3250:	77062c03 	strvc	r2, [r6, -r3, lsl #24]
    3254:	05000002 	streq	r0, [r0, #-2]
    3258:	0000018b 	andeq	r0, r0, fp, lsl #3
    325c:	10090d00 	andne	r0, r9, r0, lsl #26
    3260:	1a060000 	bne	183268 <cpsr_cp+0x17ffe0>
    3264:	000f970d 	andeq	r9, pc, sp, lsl #14
    3268:	0e1b0600 	cfmsub32eq	mvax0, mvfx0, mvfx11, mvfx0
    326c:	00000598 	muleq	r0, r8, r5
    3270:	0017b05e 	andseq	fp, r7, lr, asr r0
    3274:	00004000 	andeq	r4, r0, r0
    3278:	a89c0100 	ldmge	ip, {r8}
    327c:	0a000002 	beq	328c <cpsr_cp+0x4>
    3280:	00000fb9 			@ <UNDEFINED> instruction: 0x00000fb9
    3284:	005c0c5f 	subseq	r0, ip, pc, asr ip
    3288:	91020000 	mrsls	r0, (UNDEF: 2)
    328c:	7e0e0074 	mcrvc	0, 0, r0, cr14, cr4, {3}
    3290:	52000006 	andpl	r0, r0, #6
    3294:	00001768 	andeq	r1, r0, r8, ror #14
    3298:	00000048 	andeq	r0, r0, r8, asr #32
    329c:	02d19c01 	sbcseq	r9, r1, #256	@ 0x100
    32a0:	0c160000 	ldceq	0, cr0, [r6], {-0}
    32a4:	0a000000 	beq	32ac <cpsr_cp+0x24>
    32a8:	00000fb9 			@ <UNDEFINED> instruction: 0x00000fb9
    32ac:	005c0e54 	subseq	r0, ip, r4, asr lr
    32b0:	91020000 	mrsls	r0, (UNDEF: 2)
    32b4:	0c000074 	stceq	0, cr0, [r0], {116}	@ 0x74
    32b8:	0000043b 	andeq	r0, r0, fp, lsr r4
    32bc:	0017544e 	andseq	r5, r7, lr, asr #8
    32c0:	00001400 	andeq	r1, r0, r0, lsl #8
    32c4:	0c9c0100 	ldfeqs	f0, [ip], {0}
    32c8:	00000ff9 	strdeq	r0, [r0], -r9
    32cc:	00172048 	andseq	r2, r7, r8, asr #32
    32d0:	00003400 	andeq	r3, r0, r0, lsl #8
    32d4:	0f9c0100 	svceq	0x009c0100
    32d8:	0000066e 	andeq	r0, r0, lr, ror #12
    32dc:	005c0a3b 	subseq	r0, ip, fp, lsr sl
    32e0:	168c0000 	strne	r0, [ip], r0
    32e4:	00940000 	addseq	r0, r4, r0
    32e8:	9c010000 	stcls	0, cr0, [r1], {-0}
    32ec:	00000357 	andeq	r0, r0, r7, asr r3
    32f0:	000f1106 	andeq	r1, pc, r6, lsl #2
    32f4:	c0273b00 	eorgt	r3, r7, r0, lsl #22
    32f8:	02000001 	andeq	r0, r0, #1
    32fc:	f0066f91 			@ <UNDEFINED> instruction: 0xf0066f91
    3300:	3b00000f 	blcc	3344 <cpsr_cp+0xbc>
    3304:	00035734 	andeq	r5, r3, r4, lsr r7
    3308:	68910200 	ldmvs	r1, {r9}
    330c:	000f1706 	andeq	r1, pc, r6, lsl #14
    3310:	5c473b00 	mcrrpl	11, 0, r3, r7, cr0
    3314:	02000000 	andeq	r0, r0, #0
    3318:	64086491 	strvs	r6, [r8], #-1169	@ 0xfffffb6f
    331c:	760c3c00 	strvc	r3, [ip], -r0, lsl #24
    3320:	02000000 	andeq	r0, r0, #0
    3324:	b0077491 	mullt	r7, r1, r4
    3328:	60000016 	andvs	r0, r0, r6, lsl r0
    332c:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    3330:	103e0069 	eorsne	r0, lr, r9, rrx
    3334:	0000005c 	andeq	r0, r0, ip, asr r0
    3338:	00709102 	rsbseq	r9, r0, r2, lsl #2
    333c:	0f041700 	svceq	0x00041700
    3340:	000005b9 			@ <UNDEFINED> instruction: 0x000005b9
    3344:	01cc062a 	biceq	r0, ip, sl, lsr #12
    3348:	15b40000 	ldrne	r0, [r4, #0]!
    334c:	00d80000 	sbcseq	r0, r8, r0
    3350:	9c010000 	stcls	0, cr0, [r1], {-0}
    3354:	000003ed 	andeq	r0, r0, sp, ror #7
    3358:	000f1106 	andeq	r1, pc, r6, lsl #2
    335c:	c0232a00 	eorgt	r2, r3, r0, lsl #20
    3360:	02000001 	andeq	r0, r0, #1
    3364:	f4066791 	vst1.32	{d6}, [r6 :64], r1
    3368:	2a00000f 	bcs	33ac <cpsr_cp+0x124>
    336c:	00035730 	andeq	r5, r3, r0, lsr r7
    3370:	60910200 	addsvs	r0, r1, r0, lsl #4
    3374:	000f1706 	andeq	r1, pc, r6, lsl #14
    3378:	5c3f2a00 			@ <UNDEFINED> instruction: 0x5c3f2a00
    337c:	02000000 	andeq	r0, r0, #0
    3380:	64085c91 	strvs	r5, [r8], #-3217	@ 0xfffff36f
    3384:	760c2b00 	strvc	r2, [ip], -r0, lsl #22
    3388:	02000000 	andeq	r0, r0, #0
    338c:	d8077491 	stmdale	r7, {r0, r4, r7, sl, ip, sp, lr}
    3390:	a4000015 	strge	r0, [r0], #-21	@ 0xffffffeb
    3394:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    3398:	102d0069 	eorne	r0, sp, r9, rrx
    339c:	0000005c 	andeq	r0, r0, ip, asr r0
    33a0:	07709102 	ldrbeq	r9, [r0, -r2, lsl #2]!
    33a4:	00001610 	andeq	r1, r0, r0, lsl r6
    33a8:	0000003c 	andeq	r0, r0, ip, lsr r0
    33ac:	2f006a08 	svccs	0x00006a08
    33b0:	00005c14 	andeq	r5, r0, r4, lsl ip
    33b4:	6c910200 	lfmvs	f0, 4, [r1], {0}
    33b8:	00161c07 	andseq	r1, r6, r7, lsl #24
    33bc:	00001400 	andeq	r1, r0, r0, lsl #8
    33c0:	07320a00 	ldreq	r0, [r2, -r0, lsl #20]!
    33c4:	11300000 	teqne	r0, r0
    33c8:	00000042 	andeq	r0, r0, r2, asr #32
    33cc:	006b9102 	rsbeq	r9, fp, r2, lsl #2
    33d0:	0f000000 	svceq	0x00000000
    33d4:	0000044d 	andeq	r0, r0, sp, asr #8
    33d8:	018b131b 	orreq	r1, fp, fp, lsl r3
    33dc:	15180000 	ldrne	r0, [r8, #-0]
    33e0:	009c0000 	addseq	r0, ip, r0
    33e4:	9c010000 	stcls	0, cr0, [r1], {-0}
    33e8:	00000443 	andeq	r0, r0, r3, asr #8
    33ec:	000f5d06 	andeq	r5, pc, r6, lsl #26
    33f0:	5c2f1b00 			@ <UNDEFINED> instruction: 0x5c2f1b00
    33f4:	02000000 	andeq	r0, r0, #0
    33f8:	28076c91 	stmdacs	r7, {r0, r4, r7, sl, fp, sp, lr}
    33fc:	7c000015 	stcvc	0, cr0, [r0], {21}
    3400:	08000000 	stmdaeq	r0, {}	@ <UNPREDICTABLE>
    3404:	101c0069 	andsne	r0, ip, r9, rrx
    3408:	0000005c 	andeq	r0, r0, ip, asr r0
    340c:	07749102 	ldrbeq	r9, [r4, -r2, lsl #2]!
    3410:	0000154c 	andeq	r1, r0, ip, asr #10
    3414:	00000040 	andeq	r0, r0, r0, asr #32
    3418:	000f890a 	andeq	r8, pc, sl, lsl #18
    341c:	8b191e00 	blhi	64ac24 <cpsr_cp+0x64799c>
    3420:	02000001 	andeq	r0, r0, #1
    3424:	00007091 	muleq	r0, r1, r0
    3428:	028e0e00 	addeq	r0, lr, #0, 28
    342c:	90110000 	andsls	r0, r1, r0
    3430:	88000014 	stmdahi	r0, {r2, r4}
    3434:	01000000 	mrseq	r0, (UNDEF: 0)
    3438:	0004949c 	muleq	r4, ip, r4
    343c:	0f6a0600 	svceq	0x006a0600
    3440:	22110000 	andscs	r0, r1, #0
    3444:	0000005c 	andeq	r0, r0, ip, asr r0
    3448:	076c9102 	strbeq	r9, [ip, -r2, lsl #2]!
    344c:	000014a0 	andeq	r1, r0, r0, lsr #9
    3450:	00000068 	andeq	r0, r0, r8, rrx
    3454:	12006908 	andne	r6, r0, #8, 18	@ 0x20000
    3458:	00005c10 	andeq	r5, r0, r0, lsl ip
    345c:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
    3460:	0014c407 	andseq	ip, r4, r7, lsl #8
    3464:	00002c00 	andeq	r2, r0, r0, lsl #24
    3468:	0f1d0a00 	svceq	0x001d0a00
    346c:	19140000 	ldmdbne	r4, {}	@ <UNPREDICTABLE>
    3470:	0000018b 	andeq	r0, r0, fp, lsl #3
    3474:	00709102 	rsbseq	r9, r0, r2, lsl #2
    3478:	0e0c0000 	cdpeq	0, 0, cr0, cr12, cr0, {0}
    347c:	0d000006 	stceq	0, cr0, [r0, #-24]	@ 0xffffffe8
    3480:	0000147c 	andeq	r1, r0, ip, ror r4
    3484:	00000014 	andeq	r0, r0, r4, lsl r0
    3488:	9e0c9c01 	cdpls	12, 0, cr9, cr12, cr1, {0}
    348c:	09000001 	stmdbeq	r0, {r0}
    3490:	00001468 	andeq	r1, r0, r8, ror #8
    3494:	00000014 	andeq	r0, r0, r4, lsl r0
    3498:	0b009c01 	bleq	2a4a4 <cpsr_cp+0x2721c>
    349c:	05000002 	streq	r0, [r0, #-2]
    34a0:	e0040100 	and	r0, r4, r0, lsl #2
    34a4:	0900000d 	stmdbeq	r0, {r0, r2, r3}
    34a8:	000000be 	strheq	r0, [r0], -lr
    34ac:	00104b1d 	andseq	r4, r0, sp, lsl fp
    34b0:	00000d00 	andeq	r0, r0, r0, lsl #26
    34b4:	0017f000 	andseq	pc, r7, r0
    34b8:	0003f000 	andeq	pc, r3, r0
    34bc:	000bd600 	andeq	sp, fp, r0, lsl #12
    34c0:	06010100 	streq	r0, [r1], -r0, lsl #2
    34c4:	0000005e 	andeq	r0, r0, lr, asr r0
    34c8:	b4050201 	strlt	r0, [r5], #-513	@ 0xfffffdff
    34cc:	0a000000 	beq	34d4 <cpsr_cp+0x24c>
    34d0:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    34d4:	08010074 	stmdaeq	r1, {r2, r4, r5, r6}
    34d8:	00007905 	andeq	r7, r0, r5, lsl #18
    34dc:	01fc0300 	mvnseq	r0, r0, lsl #6
    34e0:	17020000 	strne	r0, [r2, -r0]
    34e4:	00004e18 	andeq	r4, r0, r8, lsl lr
    34e8:	08010100 	stmdaeq	r1, {r8}
    34ec:	0000005c 	andeq	r0, r0, ip, asr r0
    34f0:	87070201 	strhi	r0, [r7, -r1, lsl #4]
    34f4:	03000000 	movweq	r0, #0
    34f8:	00000248 	andeq	r0, r0, r8, asr #4
    34fc:	68171a02 	ldmdavs	r7, {r1, r9, fp, ip}
    3500:	01000000 	mrseq	r0, (UNDEF: 0)
    3504:	00430704 	subeq	r0, r3, r4, lsl #14
    3508:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    350c:	00003907 	andeq	r3, r0, r7, lsl #18
    3510:	05ac0b00 	streq	r0, [ip, #2816]!	@ 0xb00
    3514:	01070000 	mrseq	r0, (UNDEF: 7)
    3518:	0000004e 	andeq	r0, r0, lr, asr #32
    351c:	a10e0903 	tstge	lr, r3, lsl #18
    3520:	04000000 	streq	r0, [r0], #-0
    3524:	000005ce 	andeq	r0, r0, lr, asr #11
    3528:	05df0400 	ldrbeq	r0, [pc, #1024]	@ 3930 <cpsr_cp+0x6a8>
    352c:	04010000 	streq	r0, [r1], #-0
    3530:	000005f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
    3534:	02e90402 	rsceq	r0, r9, #33554432	@ 0x2000000
    3538:	00030000 	andeq	r0, r3, r0
    353c:	0005ac03 	andeq	sl, r5, r3, lsl #24
    3540:	030f0300 	movweq	r0, #62208	@ 0xf300
    3544:	00000076 	andeq	r0, r0, r6, ror r0
    3548:	00106d0c 	andseq	r6, r0, ip, lsl #26
    354c:	03020800 	movweq	r0, #10240	@ 0x2800
    3550:	00e01011 	rsceq	r1, r0, r1, lsl r0
    3554:	45050000 	strmi	r0, [r5, #-0]
    3558:	12000010 	andne	r0, r0, #16
    355c:	00005c0c 	andeq	r5, r0, ip, lsl #24
    3560:	2c050000 	stccs	0, cr0, [r5], {-0}
    3564:	13000010 	movwne	r0, #16
    3568:	00005c0c 	andeq	r5, r0, ip, lsl #24
    356c:	26050400 	strcs	r0, [r5], -r0, lsl #8
    3570:	14000010 	strne	r0, [r0], #-16
    3574:	0000e00b 	andeq	lr, r0, fp
    3578:	06000800 	streq	r0, [r0], -r0, lsl #16
    357c:	00000042 	andeq	r0, r0, r2, asr #32
    3580:	000000f1 	strdeq	r0, [r0], -r1
    3584:	0000680d 	andeq	r6, r0, sp, lsl #16
    3588:	0001ff00 	andeq	pc, r1, r0, lsl #30
    358c:	00106d03 	andseq	r6, r0, r3, lsl #26
    3590:	03150300 	tsteq	r5, #0, 6
    3594:	000000ad 	andeq	r0, r0, sp, lsr #1
    3598:	0000f106 	andeq	pc, r0, r6, lsl #2
    359c:	00010d00 	andeq	r0, r1, r0, lsl #26
    35a0:	00680e00 	rsbeq	r0, r8, r0, lsl #28
    35a4:	00020000 	andeq	r0, r2, r0
    35a8:	0010200f 	andseq	r2, r0, pc
    35ac:	15070100 	strne	r0, [r7, #-256]	@ 0xffffff00
    35b0:	000000fd 	strdeq	r0, [r0], -sp
    35b4:	2a500305 	bcs	14041d0 <cpsr_cp+0x1400f48>
    35b8:	75070000 	strvc	r0, [r7, #-0]
    35bc:	2e00000f 	cdpcs	0, 0, cr0, cr0, cr15, {0}
    35c0:	00000154 	andeq	r0, r0, r4, asr r1
    35c4:	00001ac4 	andeq	r1, r0, r4, asr #21
    35c8:	0000011c 	andeq	r0, r0, ip, lsl r1
    35cc:	01549c01 	cmpeq	r4, r1, lsl #24
    35d0:	11020000 	mrsne	r0, (UNDEF: 2)
    35d4:	2e00000f 	cdpcs	0, 0, cr0, cr0, cr15, {0}
    35d8:	0000a127 	andeq	sl, r0, r7, lsr #2
    35dc:	77910200 	ldrvc	r0, [r1, r0, lsl #4]
    35e0:	000ff002 	andeq	pc, pc, r2
    35e4:	5b372e00 	blpl	dcedec <cpsr_cp+0xdcbb64>
    35e8:	02000001 	andeq	r0, r0, #1
    35ec:	01007091 	swpeq	r7, r1, [r0]
    35f0:	02510201 	subseq	r0, r1, #268435456	@ 0x10000000
    35f4:	04100000 	ldreq	r0, [r0], #-0
    35f8:	00000042 	andeq	r0, r0, r2, asr #32
    35fc:	000fdc07 	andeq	sp, pc, r7, lsl #24
    3600:	01542100 	cmpeq	r4, r0, lsl #2
    3604:	19900000 	ldmibne	r0, {}	@ <UNPREDICTABLE>
    3608:	01340000 	teqeq	r4, r0
    360c:	9c010000 	stcls	0, cr0, [r1], {-0}
    3610:	00000196 	muleq	r0, r6, r1
    3614:	000f1102 	andeq	r1, pc, r2, lsl #2
    3618:	a1272100 			@ <UNDEFINED> instruction: 0xa1272100
    361c:	02000000 	andeq	r0, r0, #0
    3620:	f4027791 	vst1.32	{d7}, [r2 :64], r1
    3624:	2100000f 	tstcs	r0, pc
    3628:	00004236 	andeq	r4, r0, r6, lsr r2
    362c:	76910200 	ldrvc	r0, [r1], r0, lsl #4
    3630:	10310800 	eorsne	r0, r1, r0, lsl #16
    3634:	54180000 	ldrpl	r0, [r8], #-0
    3638:	00000001 	andeq	r0, r0, r1
    363c:	90000019 	andls	r0, r0, r9, lsl r0
    3640:	01000000 	mrseq	r0, (UNDEF: 0)
    3644:	0001bd9c 	muleq	r1, ip, sp
    3648:	0f110200 	svceq	0x00110200
    364c:	27180000 	ldrcs	r0, [r8, -r0]
    3650:	000000a1 	andeq	r0, r0, r1, lsr #1
    3654:	00779102 	rsbseq	r9, r7, r2, lsl #2
    3658:	00105808 	andseq	r5, r0, r8, lsl #16
    365c:	01540f00 	cmpeq	r4, r0, lsl #30
    3660:	18780000 	ldmdane	r8!, {}^	@ <UNPREDICTABLE>
    3664:	00880000 	addeq	r0, r8, r0
    3668:	9c010000 	stcls	0, cr0, [r1], {-0}
    366c:	000001e4 	andeq	r0, r0, r4, ror #3
    3670:	000f1102 	andeq	r1, pc, r2, lsl #2
    3674:	a1280f00 			@ <UNDEFINED> instruction: 0xa1280f00
    3678:	02000000 	andeq	r0, r0, #0
    367c:	11007791 			@ <UNDEFINED> instruction: 0x11007791
    3680:	00000159 	andeq	r0, r0, r9, asr r1
    3684:	f0060901 			@ <UNDEFINED> instruction: 0xf0060901
    3688:	88000017 	stmdahi	r0, {r0, r1, r2, r4}
    368c:	01000000 	mrseq	r0, (UNDEF: 0)
    3690:	17fc129c 			@ <UNDEFINED> instruction: 0x17fc129c
    3694:	00680000 	rsbeq	r0, r8, r0
    3698:	69130000 	ldmdbvs	r3, {}	@ <UNPREDICTABLE>
    369c:	110a0100 	mrsne	r0, (UNDEF: 26)
    36a0:	0000005c 	andeq	r0, r0, ip, asr r0
    36a4:	00749102 	rsbseq	r9, r4, r2, lsl #2
    36a8:	01850000 	orreq	r0, r5, r0
    36ac:	00050000 	andeq	r0, r5, r0
    36b0:	0f120401 	svceq	0x00120401
    36b4:	be080000 	cdplt	0, 0, cr0, cr8, cr0, {0}
    36b8:	1d000000 	stcne	0, cr0, [r0, #-0]
    36bc:	00001094 	muleq	r0, r4, r0
    36c0:	0000000d 	andeq	r0, r0, sp
    36c4:	00001be0 	andeq	r1, r0, r0, ror #23
    36c8:	00000200 	andeq	r0, r0, r0, lsl #4
    36cc:	00000cff 	strdeq	r0, [r0], -pc	@ <UNPREDICTABLE>
    36d0:	5e060101 	adfpls	f0, f6, f1
    36d4:	01000000 	mrseq	r0, (UNDEF: 0)
    36d8:	00b40502 	adcseq	r0, r4, r2, lsl #10
    36dc:	49020000 	stmdbmi	r2, {}	@ <UNPREDICTABLE>
    36e0:	02000002 	andeq	r0, r0, #2
    36e4:	00400f0d 	subeq	r0, r0, sp, lsl #30
    36e8:	04090000 	streq	r0, [r9], #-0
    36ec:	746e6905 	strbtvc	r6, [lr], #-2309	@ 0xfffff6fb
    36f0:	05080100 	streq	r0, [r8, #-256]	@ 0xffffff00
    36f4:	00000079 	andeq	r0, r0, r9, ror r0
    36f8:	5c080101 	stfpls	f0, [r8], {1}
    36fc:	01000000 	mrseq	r0, (UNDEF: 0)
    3700:	00870702 	addeq	r0, r7, r2, lsl #14
    3704:	48020000 	stmdami	r2, {}	@ <UNPREDICTABLE>
    3708:	02000002 	andeq	r0, r0, #2
    370c:	0068171a 	rsbeq	r1, r8, sl, lsl r7
    3710:	04010000 	streq	r0, [r1], #-0
    3714:	00004307 	andeq	r4, r0, r7, lsl #6
    3718:	07080100 	streq	r0, [r8, -r0, lsl #2]
    371c:	00000039 	andeq	r0, r0, r9, lsr r0
    3720:	0010a30a 	andseq	sl, r0, sl, lsl #6
    3724:	0b030800 	bleq	c572c <cpsr_cp+0xc24a4>
    3728:	00009c10 	andeq	r9, r0, r0, lsl ip
    372c:	108e0400 	addne	r0, lr, r0, lsl #8
    3730:	0c0c0000 	stceq	0, cr0, [ip], {-0}
    3734:	0000005c 	andeq	r0, r0, ip, asr r0
    3738:	0f480400 	svceq	0x00480400
    373c:	080d0000 	stmdaeq	sp, {}	@ <UNPREDICTABLE>
    3740:	0000009c 	muleq	r0, ip, r0
    3744:	01010004 	tsteq	r1, r4
    3748:	00025102 	andeq	r5, r2, r2, lsl #2
    374c:	10b10200 	adcsne	r0, r1, r0, lsl #4
    3750:	0e030000 	cdpeq	0, 0, cr0, cr3, cr0, {0}
    3754:	00007603 	andeq	r7, r0, r3, lsl #12
    3758:	107f0300 	rsbsne	r0, pc, r0, lsl #6
    375c:	10050000 	andne	r0, r5, r0
    3760:	00000034 	andeq	r0, r0, r4, lsr r0
    3764:	30680305 	rsbcc	r0, r8, r5, lsl #6
    3768:	7a030000 	bvc	c3770 <cpsr_cp+0xc04e8>
    376c:	06000010 			@ <UNDEFINED> instruction: 0x06000010
    3770:	00003410 	andeq	r3, r0, r0, lsl r4
    3774:	6c030500 	cfstr32vs	mvfx0, [r3], {-0}
    3778:	03000030 	movweq	r0, #48	@ 0x30
    377c:	00001087 	andeq	r1, r0, r7, lsl #1
    3780:	00a3171b 	adceq	r1, r3, fp, lsl r7
    3784:	03050000 	movweq	r0, #20480	@ 0x5000
    3788:	00003070 	andeq	r3, r0, r0, ror r0
    378c:	000efd05 	andeq	pc, lr, r5, lsl #26
    3790:	009c2900 	addseq	r2, ip, r0, lsl #18
    3794:	1d8c0000 	stcne	0, cr0, [ip]
    3798:	00540000 	subseq	r0, r4, r0
    379c:	9c010000 	stcls	0, cr0, [r1], {-0}
    37a0:	00000109 	andeq	r0, r0, r9, lsl #2
    37a4:	00108e06 	andseq	r8, r0, r6, lsl #28
    37a8:	5c232900 			@ <UNDEFINED> instruction: 0x5c232900
    37ac:	02000000 	andeq	r0, r0, #0
    37b0:	05007491 	streq	r7, [r0, #-1169]	@ 0xfffffb6f
    37b4:	00000f3b 	andeq	r0, r0, fp, lsr pc
    37b8:	00009c20 	andeq	r9, r0, r0, lsr #24
    37bc:	001d2c00 	andseq	r2, sp, r0, lsl #24
    37c0:	00006000 	andeq	r6, r0, r0
    37c4:	309c0100 	addscc	r0, ip, r0, lsl #2
    37c8:	06000001 	streq	r0, [r0], -r1
    37cc:	0000108e 	andeq	r1, r0, lr, lsl #1
    37d0:	005c2120 	subseq	r2, ip, r0, lsr #2
    37d4:	91020000 	mrsls	r0, (UNDEF: 2)
    37d8:	5f070074 	svcpl	0x00070074
    37dc:	1c000002 	stcne	0, cr0, [r0], {2}
    37e0:	00001cf4 	strdeq	r1, [r0], -r4
    37e4:	00000038 	andeq	r0, r0, r8, lsr r0
    37e8:	c9079c01 	stmdbgt	r7, {r0, sl, fp, ip, pc}
    37ec:	1400000f 	strne	r0, [r0], #-15
    37f0:	00001c88 	andeq	r1, r0, r8, lsl #25
    37f4:	0000006c 	andeq	r0, r0, ip, rrx
    37f8:	2b0b9c01 	blcs	2ea804 <cpsr_cp+0x2e757c>
    37fc:	0100000f 	tsteq	r0, pc
    3800:	009c060d 	addseq	r0, ip, sp, lsl #12
    3804:	1c340000 	ldcne	0, cr0, [r4], #-0
    3808:	00540000 	subseq	r0, r4, r0
    380c:	9c010000 	stcls	0, cr0, [r1], {-0}
    3810:	00018e0c 	andeq	r8, r1, ip, lsl #28
    3814:	06080100 	streq	r0, [r8], -r0, lsl #2
    3818:	00001be0 	andeq	r1, r0, r0, ror #23
    381c:	00000054 	andeq	r0, r0, r4, asr r0
    3820:	6d0d9c01 	stcvs	12, cr9, [sp, #-4]
    3824:	01007861 	tsteq	r0, r1, ror #16
    3828:	00341e08 	eorseq	r1, r4, r8, lsl #28
    382c:	91020000 	mrsls	r0, (UNDEF: 2)
    3830:	68000074 	stmdavs	r0, {r2, r4, r5, r6}
    3834:	05000002 	streq	r0, [r0, #-2]
    3838:	11040100 	mrsne	r0, (UNDEF: 20)
    383c:	0c000010 	stceq	0, cr0, [r0], {16}
    3840:	000000be 	strheq	r0, [r0], -lr
    3844:	0011101d 	andseq	r1, r1, sp, lsl r0
    3848:	00000d00 	andeq	r0, r0, r0, lsl #26
    384c:	001de000 	andseq	lr, sp, r0
    3850:	00033400 	andeq	r3, r3, r0, lsl #8
    3854:	000dc800 	andeq	ip, sp, r0, lsl #16
    3858:	06010100 	streq	r0, [r1], -r0, lsl #2
    385c:	0000005e 	andeq	r0, r0, lr, asr r0
    3860:	b4050201 	strlt	r0, [r5], #-513	@ 0xfffffdff
    3864:	0d000000 	stceq	0, cr0, [r0, #-0]
    3868:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
    386c:	08010074 	stmdaeq	r1, {r2, r4, r5, r6}
    3870:	00007905 	andeq	r7, r0, r5, lsl #18
    3874:	01fc0300 	mvnseq	r0, r0, lsl #6
    3878:	17020000 	strne	r0, [r2, -r0]
    387c:	00004e18 	andeq	r4, r0, r8, lsl lr
    3880:	08010100 	stmdaeq	r1, {r8}
    3884:	0000005c 	andeq	r0, r0, ip, asr r0
    3888:	87070201 	strhi	r0, [r7, -r1, lsl #4]
    388c:	03000000 	movweq	r0, #0
    3890:	00000248 	andeq	r0, r0, r8, asr #4
    3894:	68171a02 	ldmdavs	r7, {r1, r9, fp, ip}
    3898:	01000000 	mrseq	r0, (UNDEF: 0)
    389c:	00430704 	subeq	r0, r3, r4, lsl #14
    38a0:	08010000 	stmdaeq	r1, {}	@ <UNPREDICTABLE>
    38a4:	00003907 	andeq	r3, r0, r7, lsl #18
    38a8:	11340700 	teqne	r4, r0, lsl #14
    38ac:	0b3c0000 	bleq	f038b4 <cpsr_cp+0xf0062c>
    38b0:	000000a2 	andeq	r0, r0, r2, lsr #1
    38b4:	0010eb05 	andseq	lr, r0, r5, lsl #22
    38b8:	005c0c00 	subseq	r0, ip, r0, lsl #24
    38bc:	05000000 	streq	r0, [r0, #-0]
    38c0:	00001170 	andeq	r1, r0, r0, ror r1
    38c4:	0000a20d 	andeq	sl, r0, sp, lsl #4
    38c8:	70080400 	andvc	r0, r8, r0, lsl #8
    38cc:	5c0e0063 	stcpl	0, cr0, [lr], {99}	@ 0x63
    38d0:	38000000 	stmdacc	r0, {}	@ <UNPREDICTABLE>
    38d4:	005c0900 	subseq	r0, ip, r0, lsl #18
    38d8:	00b20000 	adcseq	r0, r2, r0
    38dc:	680a0000 	stmdavs	sl, {}	@ <UNPREDICTABLE>
    38e0:	0c000000 	stceq	0, cr0, [r0], {-0}
    38e4:	11340300 	teqne	r4, r0, lsl #6
    38e8:	0f030000 	svceq	0x00030000
    38ec:	00007603 	andeq	r7, r0, r3, lsl #12
    38f0:	10ca0700 	sbcne	r0, sl, r0, lsl #14
    38f4:	11080000 	mrsne	r0, (UNDEF: 8)
    38f8:	000000df 	ldrdeq	r0, [r0], -pc	@ <UNPREDICTABLE>
    38fc:	00707308 	rsbseq	r7, r0, r8, lsl #6
    3900:	00005c12 	andeq	r5, r0, r2, lsl ip
    3904:	5a050000 	bpl	14390c <cpsr_cp+0x140684>
    3908:	13000011 	movwne	r0, #17
    390c:	000000df 	ldrdeq	r0, [r0], -pc	@ <UNPREDICTABLE>
    3910:	42040004 	andmi	r0, r4, #4
    3914:	03000000 	movweq	r0, #0
    3918:	000010ca 	andeq	r1, r0, sl, asr #1
    391c:	be031403 	cdplt	4, 0, cr1, cr3, cr3, {0}
    3920:	03000000 	movweq	r0, #0
    3924:	0000017d 	andeq	r0, r0, sp, ror r1
    3928:	fc101603 	ldc2	6, cr1, [r0], {3}
    392c:	04000000 	streq	r0, [r0], #-0
    3930:	00000101 	andeq	r0, r0, r1, lsl #2
    3934:	00e4090e 	rsceq	r0, r4, lr, lsl #18
    3938:	01120000 	tsteq	r2, r0
    393c:	680a0000 	stmdavs	sl, {}	@ <UNPREDICTABLE>
    3940:	3f000000 	svccc	0x00000000
    3944:	11650200 	cmnne	r5, r0, lsl #4
    3948:	14070000 	strne	r0, [r7], #-0
    394c:	00000102 	andeq	r0, r0, r2, lsl #2
    3950:	30780305 	rsbscc	r0, r8, r5, lsl #6
    3954:	d6020000 	strle	r0, [r2], -r0
    3958:	08000010 	stmdaeq	r0, {r4}
    395c:	00005c11 	andeq	r5, r0, r1, lsl ip
    3960:	78030500 	stmdavc	r3, {r8, sl}
    3964:	02000032 	andeq	r0, r0, #50	@ 0x32
    3968:	000010fd 	strdeq	r1, [r0], -sp
    396c:	005c110a 	subseq	r1, ip, sl, lsl #2
    3970:	03050000 	movweq	r0, #20480	@ 0x5000
    3974:	0000327c 	andeq	r3, r0, ip, ror r2
    3978:	0010f002 	andseq	pc, r0, r2
    397c:	56150b00 	ldrpl	r0, [r5], -r0, lsl #22
    3980:	05000001 	streq	r0, [r0, #-1]
    3984:	00328003 	eorseq	r8, r2, r3
    3988:	00e40400 	rsceq	r0, r4, r0, lsl #8
    398c:	c0020000 	andgt	r0, r2, r0
    3990:	0c000010 	stceq	0, cr0, [r0], {16}
    3994:	00015615 	andeq	r5, r1, r5, lsl r6
    3998:	84030500 	strhi	r0, [r3], #-1280	@ 0xfffffb00
    399c:	02000032 	andeq	r0, r0, #50	@ 0x32
    39a0:	00001195 	muleq	r0, r5, r1
    39a4:	005c1111 	subseq	r1, ip, r1, lsl r1
    39a8:	03050000 	movweq	r0, #20480	@ 0x5000
    39ac:	00003288 	andeq	r3, r0, r8, lsl #5
    39b0:	0011770f 	andseq	r7, r1, pc, lsl #14
    39b4:	254f0100 	strbcs	r0, [pc, #-256]	@ 38bc <cpsr_cp+0x634>
    39b8:	000020d8 	ldrdeq	r2, [r0], -r8
    39bc:	0000003c 	andeq	r0, r0, ip, lsr r0
    39c0:	1e109c01 	cdpne	12, 1, cr9, cr0, cr1, {0}
    39c4:	01000011 	tsteq	r0, r1, lsl r0
    39c8:	01561548 	cmpeq	r6, r8, asr #10
    39cc:	20580000 	subscs	r0, r8, r0
    39d0:	00800000 	addeq	r0, r0, r0
    39d4:	9c010000 	stcls	0, cr0, [r1], {-0}
    39d8:	000fa911 	andeq	sl, pc, r1, lsl r9	@ <UNPREDICTABLE>
    39dc:	0a440100 	beq	1103de4 <cpsr_cp+0x1100b5c>
    39e0:	0000005c 	andeq	r0, r0, ip, asr r0
    39e4:	00002034 	andeq	r2, r0, r4, lsr r0
    39e8:	00000024 	andeq	r0, r0, r4, lsr #32
    39ec:	97129c01 	ldrls	r9, [r2, -r1, lsl #24]
    39f0:	0100000f 	tsteq	r0, pc
    39f4:	1fd80638 	svcne	0x00d80638
    39f8:	005c0000 	subseq	r0, ip, r0
    39fc:	9c010000 	stcls	0, cr0, [r1], {-0}
    3a00:	00100913 	andseq	r0, r0, r3, lsl r9
    3a04:	06310100 	ldrteq	r0, [r1], -r0, lsl #2
    3a08:	00001f88 	andeq	r1, r0, r8, lsl #31
    3a0c:	00000050 	andeq	r0, r0, r0, asr r0
    3a10:	6a149c01 	bvs	52aa1c <cpsr_cp+0x527794>
    3a14:	01000005 	tsteq	r0, r5
    3a18:	005c0a24 	subseq	r0, ip, r4, lsr #20
    3a1c:	1ef40000 	cdpne	0, 15, cr0, cr4, cr0, {0}
    3a20:	00940000 	addseq	r0, r4, r0
    3a24:	9c010000 	stcls	0, cr0, [r1], {-0}
    3a28:	00000225 	andeq	r0, r0, r5, lsr #4
    3a2c:	00114815 	andseq	r4, r1, r5, lsl r8
    3a30:	2e240100 	sufcss	f0, f4, f0
    3a34:	000000f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
    3a38:	026c9102 	rsbeq	r9, ip, #-2147483648	@ 0x80000000
    3a3c:	00001152 	andeq	r1, r0, r2, asr r1
    3a40:	01561025 	cmpeq	r6, r5, lsr #32
    3a44:	91020000 	mrsls	r0, (UNDEF: 2)
    3a48:	74630674 	strbtvc	r0, [r3], #-1652	@ 0xfffff98c
    3a4c:	182b0078 	stmdane	fp!, {r3, r4, r5, r6}
    3a50:	00000225 	andeq	r0, r0, r5, lsr #4
    3a54:	00709102 	rsbseq	r9, r0, r2, lsl #2
    3a58:	0000b204 	andeq	fp, r0, r4, lsl #4
    3a5c:	01c51600 	biceq	r1, r5, r0, lsl #12
    3a60:	12010000 	andne	r0, r1, #0
    3a64:	001de006 	andseq	lr, sp, r6
    3a68:	00011400 	andeq	r1, r1, r0, lsl #8
    3a6c:	0b9c0100 	bleq	fe703e74 <cpsr_cp+0xfe700bec>
    3a70:	00001e18 	andeq	r1, r0, r8, lsl lr
    3a74:	000000c8 	andeq	r0, r0, r8, asr #1
    3a78:	1a006906 	bne	1de98 <cpsr_cp+0x1ac10>
    3a7c:	00005c11 	andeq	r5, r0, r1, lsl ip
    3a80:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
    3a84:	001e240b 	andseq	r2, lr, fp, lsl #8
    3a88:	0000a400 	andeq	sl, r0, r0, lsl #8
    3a8c:	74630600 	strbtvc	r0, [r3], #-1536	@ 0xfffffa00
    3a90:	1a1f0078 	bne	7c3c78 <cpsr_cp+0x7c09f0>
    3a94:	00000225 	andeq	r0, r0, r5, lsr #4
    3a98:	00709102 	rsbseq	r9, r0, r2, lsl #2
    3a9c:	37000000 	strcc	r0, [r0, -r0]
    3aa0:	05000000 	streq	r0, [r0, #-0]
    3aa4:	97040100 	strls	r0, [r4, -r0, lsl #2]
    3aa8:	01000011 	tsteq	r0, r1, lsl r0
    3aac:	00000f1c 	andeq	r0, r0, ip, lsl pc
    3ab0:	00002120 	andeq	r2, r0, r0, lsr #2
    3ab4:	119d0294 			@ <UNDEFINED> instruction: 0x119d0294
    3ab8:	11c40000 	bicne	r0, r4, r0
    3abc:	121b0000 	andsne	r0, fp, #0
    3ac0:	80010000 	andhi	r0, r1, r0
    3ac4:	00122702 	andseq	r2, r2, r2, lsl #14
    3ac8:	00212000 	eoreq	r2, r1, r0
    3acc:	0201f400 	andeq	pc, r1, #0, 8
    3ad0:	00001231 	andeq	r1, r0, r1, lsr r2
    3ad4:	00002214 	andeq	r2, r0, r4, lsl r2
    3ad8:	00350020 	eorseq	r0, r5, r0, lsr #32
    3adc:	00050000 	andeq	r0, r5, r0
    3ae0:	11b80401 			@ <UNDEFINED> instruction: 0x11b80401
    3ae4:	83010000 	movwhi	r0, #4096	@ 0x1000
    3ae8:	3400000f 	strcc	r0, [r0], #-15
    3aec:	04000022 	streq	r0, [r0], #-34	@ 0xffffffde
    3af0:	0000119d 	muleq	r0, sp, r1
    3af4:	000011c4 	andeq	r1, r0, r4, asr #3
    3af8:	0000121b 	andeq	r1, r0, fp, lsl r2
    3afc:	42028001 	andmi	r8, r2, #1
    3b00:	34000012 	strcc	r0, [r0], #-18	@ 0xffffffee
    3b04:	04000022 	streq	r0, [r0], #-34	@ 0xffffffde
    3b08:	00125002 	andseq	r5, r2, r2
    3b0c:	00223400 	eoreq	r3, r2, r0, lsl #8
    3b10:	Address 0x3b10 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
    LDR PC, reset_handler_addr
       0:	10001101 	andne	r1, r0, r1, lsl #2
    LDR PC, undef_handler_addr
       4:	12011117 	andne	r1, r1, #-1073741819	@ 0xc0000005
    LDR PC, svc_handler_addr
       8:	1b0e030f 	blne	380c4c <cpsr_cp+0x37d9c4>
    LDR PC, pfch_abt_handler_addr
       c:	130e250e 	movwne	r2, #58638	@ 0xe50e
    LDR PC, data_abt_handler_addr
      10:	00000005 	andeq	r0, r0, r5
    B .
      14:	0b002401 	bleq	9020 <cpsr_cp+0x5d98>
    LDR PC, irq_handler_addr
      18:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
    LDR PC, fiq_handler_addr
      1c:	0200000e 	andeq	r0, r0, #14
      20:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
      24:	0e030b13 	vmoveq.32	d3[0], r0
      28:	01110e1b 	tsteq	r1, fp, lsl lr
      2c:	17100612 			@ <UNDEFINED> instruction: 0x17100612
      30:	24030000 	strcs	r0, [r3], #-0
      34:	3e0b0b00 	vmlacc.f64	d0, d11, d0
      38:	0008030b 	andeq	r0, r8, fp, lsl #6
    MRS r0, cpsr @ move PSR to Register
      3c:	002e0400 	eoreq	r0, lr, r0, lsl #8
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
      40:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
      44:	0b3b0b3a 	bleq	ec2d34 <cpsr_cp+0xebfaac>
    MSR cpsr, r1 @ 동작 모드 변경
      48:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      4c:	0000193c 	andeq	r1, r0, ip, lsr r9
    MRS r0, cpsr
      50:	3f002e05 	svccc	0x00002e05
    BIC r1, r0, #0x1F
      54:	3a0e0319 	bcc	380cc0 <cpsr_cp+0x37da38>
    ORR r1, r1, #ARM_MODE_BIT_IRQ
      58:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
    MSR cpsr, r1
      5c:	1119270b 	tstne	r9, fp, lsl #14
    LDR sp, =IRQ_STACK_TOP
      60:	40061201 	andmi	r1, r6, r1, lsl #4
    MRS r0, cpsr
      64:	00197a18 	andseq	r7, r9, r8, lsl sl
    BIC r1, r0, #0x1F
      68:	002e0600 	eoreq	r0, lr, r0, lsl #12
    ORR r1, r1, #ARM_MODE_BIT_FIQ
      6c:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
    MSR cpsr, r1
      70:	0b3b0b3a 	bleq	ec2d60 <cpsr_cp+0xebfad8>
    LDR sp, =FIQ_STACK_TOP
      74:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
    MRS r0, cpsr
      78:	06120111 			@ <UNDEFINED> instruction: 0x06120111
    BIC r1, r0, #0x1F
      7c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
    ORR r1, r1, #ARM_MODE_BIT_ABT
      80:	01000000 	mrseq	r0, (UNDEF: 0)
    MSR cpsr, r1
      84:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	@ <UNPREDICTABLE>
    LDR sp, =ABT_STACK_TOP
      88:	0b3a0e03 	bleq	e8389c <cpsr_cp+0xe80614>
    MRS r0, cpsr
      8c:	21390b3b 	teqcs	r9, fp, lsr fp
    BIC r1, r0, #0x1F
      90:	3c192706 	ldccc	7, cr2, [r9], {6}
    ORR r1, r1, #ARM_MODE_BIT_UND
      94:	02000019 	andeq	r0, r0, #25
    MSR cpsr, r1
      98:	0b0b0024 	bleq	2c0130 <cpsr_cp+0x2bcea8>
    LDR sp, =UND_STACK_TOP
      9c:	0e030b3e 	vmoveq.16	d3[0], r0
    MRS r0, cpsr
      a0:	05030000 	streq	r0, [r3, #-0]
    BIC r1, r0, #0x1F
      a4:	00134900 	andseq	r4, r3, r0, lsl #18
    ORR r1, r1, #ARM_MODE_BIT_SYS
      a8:	00160400 	andseq	r0, r6, r0, lsl #8
    MSR cpsr, r1
      ac:	0b3a0e03 	bleq	e838c0 <cpsr_cp+0xe80638>
    LDR sp, =USRSYS_STACK_TOP
      b0:	0b390b3b 	bleq	e42da4 <cpsr_cp+0xe3fb1c>
    BL main
      b4:	00001349 	andeq	r1, r0, r9, asr #6
    B .
      b8:	3f012e05 	svccc	0x00012e05
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      bc:	3a0e0319 	bcc	380d28 <cpsr_cp+0x37daa0>
    LDR sp, =IRQ_STACK_TOP
      c0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
    LDR sp, =FIQ_STACK_TOP
      c4:	19270621 	stmdbne	r7!, {r0, r5, r9, sl}
    LDR sp, =ABT_STACK_TOP
      c8:	1301193c 	movwne	r1, #6460	@ 0x193c
    LDR sp, =UND_STACK_TOP
      cc:	0f060000 	svceq	0x00060000
    LDR sp, =USRSYS_STACK_TOP
      d0:	04210b00 	strteq	r0, [r1], #-2816	@ 0xfffff500
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
      d4:	00001349 	andeq	r1, r0, r9, asr #6
      d8:	03003407 	movweq	r3, #1031	@ 0x407
      dc:	01213a08 			@ <UNDEFINED> instruction: 0x01213a08
  Hal_interrupt_run_handler();
      e0:	0b390b3b 	bleq	e42dd4 <cpsr_cp+0xe3fb4c>
}
      e4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
      e8:	2e080000 	cdpcs	0, 0, cr0, cr8, cr0, {0}
      ec:	03193f01 	tsteq	r9, #1, 30
__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
      f0:	0b213a0e 	bleq	84e930 <cpsr_cp+0x84b6a8>
  while (true);
      f4:	21390b3b 	teqcs	r9, fp, lsr fp
void main(void) {
      f8:	4919270a 	ldmdbmi	r9, {r1, r3, r8, r9, sl, sp}
      fc:	01193c13 	tsteq	r9, r3, lsl ip
     100:	09000013 	stmdbeq	r0, {r0, r1, r4}
  Hw_init();
     104:	00000018 	andeq	r0, r0, r8, lsl r0
  Kernel_init();
     108:	03002e0a 	movweq	r2, #3594	@ 0xe0a
  uint32_t i = 100;
     10c:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
     110:	21390b3b 	teqcs	r9, fp, lsr fp
  while(i--) {
     114:	1119270d 	tstne	r9, sp, lsl #14
    Hal_uart_put_char('N');
     118:	40061201 	andmi	r1, r6, r1, lsl #4
     11c:	00197c18 	andseq	r7, r9, r8, lsl ip
  while(i--) {
     120:	01110b00 	tsteq	r1, r0, lsl #22
     124:	0b130e25 	bleq	4c39c0 <cpsr_cp+0x4c0738>
     128:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
     12c:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     130:	00001710 	andeq	r1, r0, r0, lsl r7
  Hal_uart_put_char('\n');
     134:	0b00240c 	bleq	916c <cpsr_cp+0x5ee4>
     138:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
  putstr("Hello World!\n");
     13c:	0d000008 	stceq	0, cr0, [r0, #-32]	@ 0xffffffe0
     140:	19270015 	stmdbne	r7!, {r0, r2, r4}
     144:	260e0000 	strcs	r0, [lr], -r0
  Printf_test();
     148:	00134900 	andseq	r4, r3, r0, lsl #18
  Hal_interrupt_enable(UART_INTERRUPT0);
     14c:	012e0f00 			@ <UNDEFINED> instruction: 0x012e0f00
     150:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
  Kernel_start();
     154:	0b3b0b3a 	bleq	ec2e44 <cpsr_cp+0xebfbbc>
}
     158:	193c0b39 	ldmdbne	ip!, {r0, r3, r4, r5, r8, r9, fp}
     15c:	00001301 	andeq	r1, r0, r1, lsl #6
     160:	03012e10 	movweq	r2, #7696	@ 0x1e10
static void Hw_init(void){
     164:	3b0b3a0e 	blcc	2ce9a4 <cpsr_cp+0x2cb71c>
     168:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
  Hal_interrupt_init();
     16c:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
  Hal_uart_init();
     170:	7c184006 	ldcvc	0, cr4, [r8], {6}
  Hal_timer_init();
     174:	00130119 	andseq	r0, r3, r9, lsl r1
}
     178:	00341100 	eorseq	r1, r4, r0, lsl #2
     17c:	0b3a0e03 	bleq	e83990 <cpsr_cp+0xe80708>
static void Kernel_init(void) {
     180:	0b390b3b 	bleq	e42e74 <cpsr_cp+0xe3fbec>
     184:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
  Kernel_task_init();
     188:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
  Kernel_event_flag_init();
     18c:	03193f01 	tsteq	r9, #1, 30
  Kernel_msgQ_init();
     190:	3b0b3a0e 	blcc	2ce9d0 <cpsr_cp+0x2cb748>
  Kernel_sem_init(1);
     194:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     198:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
  Kernel_mutex_init();
     19c:	7c184006 	ldcvc	0, cr4, [r8], {6}
  add_task(User_task0, 0);
     1a0:	00000019 	andeq	r0, r0, r9, lsl r0
     1a4:	03002801 	movweq	r2, #2049	@ 0x801
     1a8:	00061c0e 	andeq	r1, r6, lr, lsl #24
     1ac:	00280200 	eoreq	r0, r8, r0, lsl #4
  add_task(User_task1, 1);
     1b0:	0b1c0e03 	bleq	7039c4 <cpsr_cp+0x70073c>
     1b4:	34030000 	strcc	r0, [r3], #-0
     1b8:	3a0e0300 	bcc	380dc0 <cpsr_cp+0x37db38>
     1bc:	0b3b0121 	bleq	ec0648 <cpsr_cp+0xebd3c0>
  add_task(User_task2, 2);
     1c0:	13490b39 	movtne	r0, #39737	@ 0x9b39
     1c4:	00001802 	andeq	r1, r0, r2, lsl #16
     1c8:	49000504 	stmdbmi	r0, {r2, r8, sl}
     1cc:	05000013 	streq	r0, [r0, #-19]	@ 0xffffffed
}
     1d0:	0b0b0024 	bleq	2c0268 <cpsr_cp+0x2bcfe0>
     1d4:	0e030b3e 	vmoveq.16	d3[0], r0
static void Printf_test(void) {
     1d8:	28060000 	stmdacs	r6, {}	@ <UNPREDICTABLE>
     1dc:	1c0e0300 	stcne	3, cr0, [lr], {-0}
     1e0:	07000005 	streq	r0, [r0, -r5]
  char* str = "printf pointer test";
     1e4:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     1e8:	0b3b0b3a 	bleq	ec2ed8 <cpsr_cp+0xebfc50>
     1ec:	13490b39 	movtne	r0, #39737	@ 0x9b39
  char* nullptr = 0;
     1f0:	2e080000 	cdpcs	0, 0, cr0, cr8, cr0, {0}
     1f4:	03193f01 	tsteq	r9, #1, 30
  uint32_t i = 5;
     1f8:	3b0b3a0e 	blcc	2cea38 <cpsr_cp+0x2cb7b0>
     1fc:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
  debug_printf("%s\n", "Hello printf");
     200:	3c134919 			@ <UNDEFINED> instruction: 0x3c134919
     204:	00130119 	andseq	r0, r3, r9, lsl r1
     208:	002e0900 	eoreq	r0, lr, r0, lsl #18
     20c:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     210:	3b06213a 	blcc	188700 <cpsr_cp+0x185478>
  debug_printf("output string pointer: %s\n", str);
     214:	0621390b 	strteq	r3, [r1], -fp, lsl #18
     218:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
     21c:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
     220:	03193f01 	tsteq	r9, #1, 30
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
     224:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
     228:	21390b3b 	teqcs	r9, fp, lsr fp
     22c:	11192706 	tstne	r9, r6, lsl #14
     230:	40061201 	andmi	r1, r6, r1, lsl #4
     234:	01197c18 	tsteq	r9, r8, lsl ip
  debug_printf("%u = 5\n", i);
     238:	0b000013 	bleq	28c <Printf_test+0xb4>
     23c:	0111010b 	tsteq	r1, fp, lsl #2
     240:	00000612 	andeq	r0, r0, r2, lsl r6
     244:	0b000f0c 	bleq	3e7c <cpsr_cp+0xbf4>
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
     248:	13490421 	movtne	r0, #37921	@ 0x9421
     24c:	040d0000 	streq	r0, [sp], #-0
     250:	3e0e0301 	cdpcc	3, 0, cr0, cr14, cr1, {0}
     254:	0b0b0721 	bleq	2c1ee0 <cpsr_cp+0x2bec58>
     258:	0b3a1349 	bleq	e84f84 <cpsr_cp+0xe81cfc>
  debug_printf("print zero %u\n", 0);
     25c:	21390b3b 	teqcs	r9, fp, lsr fp
     260:	0013010e 	andseq	r0, r3, lr, lsl #2
     264:	012e0e00 			@ <UNDEFINED> instruction: 0x012e0e00
     268:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
     26c:	0b3b0b3a 	bleq	ec2f5c <cpsr_cp+0xebfcd4>
     270:	27062139 	smladxcs	r6, r9, r1, r2
     274:	01193c19 	tsteq	r9, r9, lsl ip
     278:	0f000013 	svceq	0x00000013
     27c:	08030005 	stmdaeq	r3, {r0, r2}
     280:	3b01213a 	blcc	48770 <cpsr_cp+0x454e8>
     284:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     288:	00180213 	andseq	r0, r8, r3, lsl r2
     28c:	00051000 	andeq	r1, r5, r0
     290:	213a0e03 	teqcs	sl, r3, lsl #28
     294:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
     298:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     29c:	11000018 	tstne	r0, r8, lsl r0
     2a0:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
     2a4:	0e030b13 	vmoveq.32	d3[0], r0
     2a8:	01110e1b 	tsteq	r1, fp, lsl lr
     2ac:	17100612 			@ <UNDEFINED> instruction: 0x17100612
     2b0:	24120000 	ldrcs	r0, [r2], #-0
     2b4:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     2b8:	0008030b 	andeq	r0, r8, fp, lsl #6
     2bc:	00151300 	andseq	r1, r5, r0, lsl #6
     2c0:	00001927 	andeq	r1, r0, r7, lsr #18
     2c4:	0b000f14 	bleq	3f1c <cpsr_cp+0xc94>
     2c8:	1500000b 	strne	r0, [r0, #-11]
     2cc:	00000018 	andeq	r0, r0, r8, lsl r0
     2d0:	49002616 	stmdbmi	r0, {r1, r2, r4, r9, sl, sp}
     2d4:	17000013 	smladne	r0, r3, r0, r0
     2d8:	08030034 	stmdaeq	r3, {r2, r4, r5}
     2dc:	0b3b0b3a 	bleq	ec2fcc <cpsr_cp+0xebfd44>
     2e0:	13490b39 	movtne	r0, #39737	@ 0x9b39
     2e4:	00001802 	andeq	r1, r0, r2, lsl #16
     2e8:	49010118 	stmdbmi	r1, {r3, r4, r8}
     2ec:	00130113 	andseq	r0, r3, r3, lsl r1
     2f0:	00211900 	eoreq	r1, r1, r0, lsl #18
     2f4:	0b2f1349 	bleq	bc5020 <cpsr_cp+0xbc1d98>
     2f8:	2e1a0000 	cdpcs	0, 1, cr0, cr10, cr0, {0}
     2fc:	3a0e0301 	bcc	380f08 <cpsr_cp+0x37dc80>
     300:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     304:	1119270b 	tstne	r9, fp, lsl #14
     308:	40061201 	andmi	r1, r6, r1, lsl #4
     30c:	01197c18 	tsteq	r9, r8, lsl ip
     310:	1b000013 	blne	364 <add_task+0x24>
     314:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
     318:	0b3a0e03 	bleq	e83b2c <cpsr_cp+0xe808a4>
     31c:	0b390b3b 	bleq	e43010 <cpsr_cp+0xe3fd88>
     320:	01111927 	tsteq	r1, r7, lsr #18
     324:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     328:	0000197c 	andeq	r1, r0, ip, ror r9
     32c:	000d0100 	andeq	r0, sp, r0, lsl #2
     330:	213a0e03 	teqcs	sl, r3, lsl #28
     334:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
     338:	13490e21 	movtne	r0, #40481	@ 0x9e21
     33c:	0b6b0b0d 	bleq	1ac2f78 <cpsr_cp+0x1abfcf0>
void add_task(KernelTaskFunc_t f, uint32_t t_id) {
     340:	16020000 	strne	r0, [r2], -r0
     344:	3a0e0300 	bcc	380f4c <cpsr_cp+0x37dcc4>
     348:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     34c:	0013490b 	andseq	r4, r3, fp, lsl #18
     350:	000d0300 	andeq	r0, sp, r0, lsl #6
  taskId = Kernel_task_create(f);
     354:	213a0e03 	teqcs	sl, r3, lsl #28
     358:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
     35c:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
  if (taskId == NOT_ENOUGH_TASK_NUM) {
     360:	0400000b 	streq	r0, [r0], #-11
     364:	210b0113 	tstcs	fp, r3, lsl r1
     368:	02213a04 	eoreq	r3, r1, #4, 20	@ 0x4000
    debug_printf("Task%u creation fail\n", t_id);
     36c:	21390b3b 	teqcs	r9, fp, lsr fp
     370:	00130103 	andseq	r0, r3, r3, lsl #2
     374:	01170500 	tsteq	r7, r0, lsl #10
     378:	210b0e03 	tstcs	fp, r3, lsl #28
}
     37c:	02213a04 	eoreq	r3, r1, #4, 20	@ 0x4000
     380:	21390b3b 	teqcs	r9, fp, lsr fp
     384:	0013010f 	andseq	r0, r3, pc, lsl #2
static void Test_critical_section(uint32_t p, uint32_t taskId) {
     388:	000d0600 	andeq	r0, sp, r0, lsl #12
     38c:	213a0803 	teqcs	sl, r3, lsl #16
     390:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
     394:	13490c21 	movtne	r0, #39969	@ 0x9c21
     398:	0d070000 	stceq	0, cr0, [r7, #-0]
  Kernel_lock_mutex();
     39c:	3a0e0300 	bcc	380fa4 <cpsr_cp+0x37dd1c>
  debug_printf("User Task #%u Send=%u\n", taskId, p);
     3a0:	0b3b0221 	bleq	ec0c2c <cpsr_cp+0xebd9a4>
     3a4:	49052139 	stmdbmi	r5, {r0, r3, r4, r5, r8, sp}
     3a8:	08000013 	stmdaeq	r0, {r0, r1, r4}
     3ac:	0b0b0024 	bleq	2c0444 <cpsr_cp+0x2bd1bc>
     3b0:	0e030b3e 	vmoveq.16	d3[0], r0
  shared_value = p;
     3b4:	0d090000 	stceq	0, cr0, [r9, #-0]
     3b8:	3a0e0300 	bcc	380fc0 <cpsr_cp+0x37dd38>
     3bc:	0b3b0221 	bleq	ec0c48 <cpsr_cp+0xebd9c0>
     3c0:	49172139 	ldmdbmi	r7, {r0, r3, r4, r5, r8, sp}
  Kernel_yield();
     3c4:	00053813 	andeq	r3, r5, r3, lsl r8
  delay(1000);
     3c8:	00340a00 	eorseq	r0, r4, r0, lsl #20
     3cc:	213a0e03 	teqcs	sl, r3, lsl #28
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
     3d0:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
     3d4:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     3d8:	0b000018 	bleq	440 <User_task0+0x40>
     3dc:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     3e0:	3b01213a 	blcc	488d0 <cpsr_cp+0x45648>
     3e4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     3e8:	00180213 	andseq	r0, r8, r3, lsl r2
     3ec:	01010c00 	tsteq	r1, r0, lsl #24
  Kernel_unlock_mutex();
     3f0:	13011349 	movwne	r1, #4937	@ 0x1349
}
     3f4:	210d0000 	mrscs	r0, (UNDEF: 13)
     3f8:	2f134900 	svccs	0x00134900
     3fc:	0e00000b 	cdpeq	0, 0, cr0, cr0, cr11, {0}
void User_task0(void) {
     400:	210b000f 	tstcs	fp, pc
     404:	00134904 	andseq	r4, r3, r4, lsl #18
     408:	012e0f00 			@ <UNDEFINED> instruction: 0x012e0f00
  uint32_t local = 0;
     40c:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     410:	3b01213a 	blcc	48900 <cpsr_cp+0x45678>
  debug_printf("User Task #0 SP=0x%x\n", &local);
     414:	0621390b 	strteq	r3, [r1], -fp, lsl #18
     418:	01111927 	tsteq	r1, r7, lsr #18
     41c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     420:	1301197a 	movwne	r1, #6522	@ 0x197a
     424:	35100000 	ldrcc	r0, [r0, #-0]
  uint8_t cmdBufIdx = 0;
     428:	00134900 	andseq	r4, r3, r0, lsl #18
     42c:	00341100 	eorseq	r1, r4, r0, lsl #2
  uint8_t uartch = 0;
     430:	213a0e03 	teqcs	sl, r3, lsl #28
     434:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
     438:	13491c21 	movtne	r1, #39969	@ 0x9c21
     43c:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
     440:	11120000 	tstne	r2, r0
    switch(handle_event) {
     444:	130e2501 	movwne	r2, #58625	@ 0xe501
     448:	1b0e030b 	blne	38107c <cpsr_cp+0x37ddf4>
     44c:	1201110e 	andne	r1, r1, #-2147483645	@ 0x80000003
     450:	00171006 	andseq	r1, r7, r6
     454:	00241300 	eoreq	r1, r4, r0, lsl #6
     458:	0b3e0b0b 	bleq	f8308c <cpsr_cp+0xf7fe04>
     45c:	00000803 	andeq	r0, r0, r3, lsl #16
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
     460:	03011314 	movweq	r1, #4884	@ 0x1314
     464:	3a0b0b0e 	bcc	2c30a4 <cpsr_cp+0x2bfe1c>
     468:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     46c:	0013010b 	andseq	r0, r3, fp, lsl #2
     470:	01131500 	tsteq	r3, r0, lsl #10
      if (uartch == '\r') {
     474:	050b0e03 	streq	r0, [fp, #-3587]	@ 0xfffff1fd
     478:	0b3b0b3a 	bleq	ec3168 <cpsr_cp+0xebfee0>
     47c:	13010b39 	movwne	r0, #6969	@ 0x1b39
        cmdBuf[cmdBufIdx] = '\0';
     480:	15160000 	ldrne	r0, [r6, #-0]
     484:	00192700 	andseq	r2, r9, r0, lsl #14
     488:	002e1700 	eoreq	r1, lr, r0, lsl #14
     48c:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     490:	0b3b0b3a 	bleq	ec3180 <cpsr_cp+0xebfef8>
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     494:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
     498:	0000193c 	andeq	r1, r0, ip, lsr r9
     49c:	3f012e18 	svccc	0x00012e18
     4a0:	3a0e0319 	bcc	38110c <cpsr_cp+0x37de84>
     4a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     4a8:	1119270b 	tstne	r9, fp, lsl #14
     4ac:	40061201 	andmi	r1, r6, r1, lsl #4
     4b0:	01197c18 	tsteq	r9, r8, lsl ip
     4b4:	19000013 	stmdbne	r0, {r0, r1, r4}
     4b8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
            Kernel_yield();
     4bc:	0b3a0e03 	bleq	e83cd0 <cpsr_cp+0xe80a48>
     4c0:	0b390b3b 	bleq	e431b4 <cpsr_cp+0xe3ff2c>
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
     4c4:	01111927 	tsteq	r1, r7, lsr #18
     4c8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     4cc:	0000197c 	andeq	r1, r0, ip, ror r9
     4d0:	11010b1a 	tstne	r1, sl, lsl fp
     4d4:	00061201 	andeq	r1, r6, r1, lsl #4
     4d8:	00341b00 	eorseq	r1, r4, r0, lsl #22
     4dc:	0b3a0803 	bleq	e824f0 <cpsr_cp+0xe7f268>
     4e0:	0b390b3b 	bleq	e431d4 <cpsr_cp+0xe3ff4c>
     4e4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
     4e8:	01000000 	mrseq	r0, (UNDEF: 0)
     4ec:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
     4f0:	0b3b0b3a 	bleq	ec31e0 <cpsr_cp+0xebff58>
     4f4:	490e2139 	stmdbmi	lr, {r0, r3, r4, r5, r8, sp}
     4f8:	6b0b0d13 	blvs	2c394c <cpsr_cp+0x2c06c4>
     4fc:	0200000b 	andeq	r0, r0, #11
     500:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
            Kernel_yield();
     504:	0b3b0b3a 	bleq	ec31f4 <cpsr_cp+0xebff6c>
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     508:	13490b39 	movtne	r0, #39737	@ 0x9b39
            break;
     50c:	00000b38 	andeq	r0, r0, r8, lsr fp
        Kernel_send_events(KernelEventFlag_CmdIn);
     510:	03001603 	movweq	r1, #1539	@ 0x603
     514:	3b0b3a0e 	blcc	2ced54 <cpsr_cp+0x2cbacc>
        cmdBufIdx = 0;
     518:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     51c:	04000013 	streq	r0, [r0], #-19	@ 0xffffffed
      break;
     520:	210b0113 	tstcs	fp, r3, lsl r1
        cmdBuf[cmdBufIdx] = uartch;
     524:	3b0b3a04 	blcc	2ced3c <cpsr_cp+0x2cbab4>
     528:	0321390b 			@ <UNDEFINED> instruction: 0x0321390b
     52c:	00001301 	andeq	r1, r0, r1, lsl #6
     530:	03011705 	movweq	r1, #5893	@ 0x1705
     534:	04210b0e 	strteq	r0, [r1], #-2830	@ 0xfffff4f2
        cmdBufIdx = (cmdBufIdx + 1) % 16;
     538:	0b3b0b3a 	bleq	ec3228 <cpsr_cp+0xebffa0>
     53c:	010f2139 	tsteq	pc, r9, lsr r1	@ <UNPREDICTABLE>
     540:	06000013 			@ <UNDEFINED> instruction: 0x06000013
     544:	0803000d 	stmdaeq	r3, {r0, r2, r3}
     548:	0b3b0b3a 	bleq	ec3238 <cpsr_cp+0xebffb0>
     54c:	490c2139 	stmdbmi	ip, {r0, r3, r4, r5, r8, sp}
     550:	07000013 	smladeq	r0, r3, r0, r0
     554:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
      break;
     558:	0b3b0b3a 	bleq	ec3248 <cpsr_cp+0xebffc0>
      Test_critical_section(5, 0);
     55c:	49052139 	stmdbmi	r5, {r0, r3, r4, r5, r8, sp}
     560:	08000013 	stmdaeq	r0, {r0, r1, r4}
     564:	0803000d 	stmdaeq	r3, {r0, r2, r3}
      break;
     568:	3b02213a 	blcc	88a58 <cpsr_cp+0x857d0>
    Kernel_yield();
     56c:	0e21390b 	vmuleq.f16	s6, s2, s22	@ <UNPREDICTABLE>
  while(true) {
     570:	210d1349 	tstcs	sp, r9, asr #6
void User_task1(void) {
     574:	000b6b01 	andeq	r6, fp, r1, lsl #22
     578:	00240900 	eoreq	r0, r4, r0, lsl #18
     57c:	0b3e0b0b 	bleq	f831b0 <cpsr_cp+0xf7ff28>
  uint32_t local = 0;
     580:	00000e03 	andeq	r0, r0, r3, lsl #28
     584:	03000d0a 	movweq	r0, #3338	@ 0xd0a
  debug_printf("User Task #1 SP=0x%x\n", &local);
     588:	04213a0e 	strteq	r3, [r1], #-2574	@ 0xfffff5f2
     58c:	21390b3b 	teqcs	r9, fp, lsr fp
     590:	38134917 	ldmdacc	r3, {r0, r1, r2, r4, r8, fp, lr}
     594:	0b000005 	bleq	5b0 <User_task1+0x3c>
     598:	13490035 	movtne	r0, #36917	@ 0x9035
  uint8_t cmdlen = 0;
     59c:	340c0000 	strcc	r0, [ip], #-0
     5a0:	3a0e0300 	bcc	3811a8 <cpsr_cp+0x37df20>
  uint8_t cmd[16] = {0, };
     5a4:	0b3b0121 	bleq	ec0a30 <cpsr_cp+0xebd7a8>
     5a8:	13490b39 	movtne	r0, #39737	@ 0x9b39
     5ac:	1802193f 	stmdane	r2, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
     5b0:	0f0d0000 	svceq	0x000d0000
     5b4:	04210b00 	strteq	r0, [r1], #-2816	@ 0xfffff500
     5b8:	00001349 	andeq	r1, r0, r9, asr #6
     5bc:	0301130e 	movweq	r1, #4878	@ 0x130e
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
     5c0:	3a0b0b0e 	bcc	2c3200 <cpsr_cp+0x2bff78>
     5c4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     5c8:	13011021 	movwne	r1, #4129	@ 0x1021
    switch(handle_event) {
     5cc:	010f0000 	mrseq	r0, CPSR
     5d0:	01134901 	tsteq	r3, r1, lsl #18
     5d4:	10000013 	andne	r0, r0, r3, lsl r0
     5d8:	13490021 	movtne	r0, #36897	@ 0x9021
     5dc:	00000b2f 	andeq	r0, r0, pc, lsr #22
     5e0:	25011111 	strcs	r1, [r1, #-273]	@ 0xfffffeef
     5e4:	030b130e 	movweq	r1, #45838	@ 0xb30e
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
     5e8:	100e1b0e 	andne	r1, lr, lr, lsl #22
     5ec:	12000017 	andne	r0, r0, #23
     5f0:	0b0b0024 	bleq	2c0688 <cpsr_cp+0x2bd400>
     5f4:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
     5f8:	13130000 	tstne	r3, #0
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
     5fc:	0b0e0301 	bleq	381208 <cpsr_cp+0x37df80>
     600:	3b0b3a05 	blcc	2cee1c <cpsr_cp+0x2cbb94>
     604:	010b390b 	tsteq	fp, fp, lsl #18
     608:	00000013 	andeq	r0, r0, r3, lsl r0
     60c:	03000d01 	movweq	r0, #3329	@ 0xd01
     610:	02213a0e 	eoreq	r3, r1, #57344	@ 0xe000
      cmd[cmdlen] = 0;
     614:	21390b3b 	teqcs	r9, fp, lsr fp
     618:	0d13490e 	vldreq.16	s8, [r3, #-28]	@ 0xffffffe4	@ <UNPREDICTABLE>
     61c:	000b6b0b 	andeq	r6, fp, fp, lsl #22
     620:	00240200 	eoreq	r0, r4, r0, lsl #4
     624:	0b3e0b0b 	bleq	f83258 <cpsr_cp+0xf7ffd0>
      debug_printf("\nRecv Cmd: %s\n", cmd);
     628:	00000e03 	andeq	r0, r0, r3, lsl #28
     62c:	03000d03 	movweq	r0, #3331	@ 0xd03
     630:	02213a0e 	eoreq	r3, r1, #57344	@ 0xe000
     634:	21390b3b 	teqcs	r9, fp, lsr fp
     638:	38134913 	ldmdacc	r3, {r0, r1, r4, r8, fp, lr}
      break;
     63c:	0400000b 	streq	r0, [r0], #-11
      Kernel_unlock_sem();
     640:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
      break;
     644:	0b3b0b3a 	bleq	ec3334 <cpsr_cp+0xec00ac>
    Kernel_yield();
     648:	13490b39 	movtne	r0, #39737	@ 0x9b39
  while(true) {
     64c:	13050000 	movwne	r0, #20480	@ 0x5000
void User_task2(void) {
     650:	04210b01 	strteq	r0, [r1], #-2817	@ 0xfffff4ff
     654:	3b02213a 	blcc	88b44 <cpsr_cp+0x858bc>
     658:	0321390b 			@ <UNDEFINED> instruction: 0x0321390b
  uint32_t local = 0;
     65c:	00001301 	andeq	r1, r0, r1, lsl #6
     660:	03011706 	movweq	r1, #5894	@ 0x1706
  debug_printf("User Task #2 SP=0x%x\n", &local);
     664:	04210b0e 	strteq	r0, [r1], #-2830	@ 0xfffff4f2
     668:	3b02213a 	blcc	88b58 <cpsr_cp+0x858d0>
     66c:	0f21390b 	svceq	0x0021390b
     670:	00001301 	andeq	r1, r0, r1, lsl #6
     674:	03000d07 	movweq	r0, #3335	@ 0xd07
    Test_critical_section(3, 2);
     678:	02213a08 	eoreq	r3, r1, #8, 20	@ 0x8000
     67c:	21390b3b 	teqcs	r9, fp, lsr fp
     680:	0013490c 	andseq	r4, r3, ip, lsl #18
    Kernel_yield();
     684:	000d0800 	andeq	r0, sp, r0, lsl #16
    Test_critical_section(3, 2);
     688:	213a0e03 	teqcs	sl, r3, lsl #28
     68c:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
     690:	13490521 	movtne	r0, #38177	@ 0x9521
     694:	05090000 	streq	r0, [r9, #-0]
     698:	00134900 	andseq	r4, r3, r0, lsl #18
     69c:	000f0a00 	andeq	r0, pc, r0, lsl #20
     6a0:	4904210b 	stmdbmi	r4, {r0, r1, r3, r8, sp}
     6a4:	0b000013 	bleq	6f8 <User_task2+0xa8>
     6a8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
     6ac:	3b01213a 	blcc	48b9c <cpsr_cp+0x45914>
     6b0:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     6b4:	00180213 	andseq	r0, r8, r3, lsl r2
     6b8:	012e0c00 			@ <UNDEFINED> instruction: 0x012e0c00
     6bc:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     6c0:	3b04213a 	blcc	108bb0 <cpsr_cp+0x105928>
     6c4:	0621390b 	strteq	r3, [r1], -fp, lsl #18
     6c8:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
     6cc:	00001301 	andeq	r1, r0, r1, lsl #6
     6d0:	2501110d 	strcs	r1, [r1, #-269]	@ 0xfffffef3
     6d4:	030b130e 	movweq	r1, #45838	@ 0xb30e
     6d8:	110e1b0e 	tstne	lr, lr, lsl #22
     6dc:	10061201 	andne	r1, r6, r1, lsl #4
     6e0:	0e000017 	mcreq	0, 0, r0, cr0, cr7, {0}
     6e4:	0b0b0024 	bleq	2c077c <cpsr_cp+0x2bd4f4>
     6e8:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
     6ec:	130f0000 	movwne	r0, #61440	@ 0xf000
     6f0:	0b0e0301 	bleq	3812fc <cpsr_cp+0x37e074>
     6f4:	3b0b3a0b 	blcc	2cef28 <cpsr_cp+0x2cbca0>
     6f8:	010b390b 	tsteq	fp, fp, lsl #18
     6fc:	10000013 	andne	r0, r0, r3, lsl r0
     700:	13490035 	movtne	r0, #36917	@ 0x9035
     704:	15110000 	ldrne	r0, [r1, #-0]
     708:	00192700 	andseq	r2, r9, r0, lsl #14
     70c:	00341200 	eorseq	r1, r4, r0, lsl #4
     710:	0b3a0e03 	bleq	e83f24 <cpsr_cp+0xe80c9c>
     714:	0b390b3b 	bleq	e43408 <cpsr_cp+0xe40180>
     718:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	@ <UNPREDICTABLE>
     71c:	0000193c 	andeq	r1, r0, ip, lsr r9
     720:	03002e13 	movweq	r2, #3603	@ 0xe13
     724:	3b0b3a0e 	blcc	2cef64 <cpsr_cp+0x2cbcdc>
     728:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     72c:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     730:	7a184006 	bvc	610750 <cpsr_cp+0x60d4c8>
void Hal_interrupt_init(void) {
     734:	14000019 	strne	r0, [r0], #-25	@ 0xffffffe7
     738:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	@ <UNPREDICTABLE>
     73c:	0b3a0e03 	bleq	e83f50 <cpsr_cp+0xe80cc8>
  GicCpu->cpucontrol.bits.Enable = 1;
     740:	0b390b3b 	bleq	e43434 <cpsr_cp+0xe401ac>
     744:	13491927 	movtne	r1, #39207	@ 0x9927
     748:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     74c:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
     750:	2e150000 	cdpcs	0, 1, cr0, cr5, cr0, {0}
     754:	03193f01 	tsteq	r9, #1, 30
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
     758:	3b0b3a0e 	blcc	2cef98 <cpsr_cp+0x2cbd10>
     75c:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     760:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     764:	7c184006 	ldcvc	0, cr4, [r8], {6}
     768:	00000019 	andeq	r0, r0, r9, lsl r0
     76c:	03000d01 	movweq	r0, #3329	@ 0xd01
  GicDist->distributorctrl.bits.Enable = 1;
     770:	03213a0e 			@ <UNDEFINED> instruction: 0x03213a0e
     774:	21390b3b 	teqcs	r9, fp, lsr fp
     778:	0d13490e 	vldreq.16	s8, [r3, #-28]	@ 0xffffffe4	@ <UNPREDICTABLE>
     77c:	000b6b0b 	andeq	r6, fp, fp, lsl #22
     780:	000d0200 	andeq	r0, sp, r0, lsl #4
     784:	213a0803 	teqcs	sl, r3, lsl #16
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     788:	390b3b03 	stmdbcc	fp, {r0, r1, r8, r9, fp, ip, sp}
     78c:	13490e21 	movtne	r0, #40481	@ 0x9e21
     790:	6b01210d 	blvs	48bcc <cpsr_cp+0x45944>
    sHandlers[i] = NULL;
     794:	0300000b 	movweq	r0, #11
     798:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     79c:	0b3b0b3a 	bleq	ec348c <cpsr_cp+0xec0204>
     7a0:	13490b39 	movtne	r0, #39737	@ 0x9b39
     7a4:	0d040000 	stceq	0, cr0, [r4, #-0]
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     7a8:	3a0e0300 	bcc	3813b0 <cpsr_cp+0x37e128>
     7ac:	0b3b0321 	bleq	ec1438 <cpsr_cp+0xebe1b0>
     7b0:	490f2139 	stmdbmi	pc, {r0, r3, r4, r5, r8, sp}	@ <UNPREDICTABLE>
     7b4:	000b3813 	andeq	r3, fp, r3, lsl r8
     7b8:	00280500 	eoreq	r0, r8, r0, lsl #10
     7bc:	061c0e03 	ldreq	r0, [ip], -r3, lsl #28
  enable_irq();
     7c0:	13060000 	movwne	r0, #24576	@ 0x6000
}
     7c4:	04210b01 	strteq	r0, [r1], #-2817	@ 0xfffff4ff
     7c8:	3b03213a 	blcc	c8cb8 <cpsr_cp+0xc5a30>
     7cc:	0321390b 			@ <UNDEFINED> instruction: 0x0321390b
void Hal_interrupt_enable(uint32_t interrupt_num) {
     7d0:	00001301 	andeq	r1, r0, r1, lsl #6
     7d4:	03011707 	movweq	r1, #5895	@ 0x1707
     7d8:	04210b0e 	strteq	r0, [r1], #-2830	@ 0xfffff4f2
     7dc:	3b03213a 	blcc	c8ccc <cpsr_cp+0xc5a44>
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     7e0:	0f21390b 	svceq	0x0021390b
     7e4:	00001301 	andeq	r1, r0, r1, lsl #6
     7e8:	03000d08 	movweq	r0, #3336	@ 0xd08
     7ec:	03213a08 			@ <UNDEFINED> instruction: 0x03213a08
     7f0:	21390b3b 	teqcs	r9, fp, lsr fp
     7f4:	0013490c 	andseq	r4, r3, ip, lsl #18
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     7f8:	000d0900 	andeq	r0, sp, r0, lsl #18
     7fc:	213a0e03 	teqcs	sl, r3, lsl #28
     800:	390b3b03 	stmdbcc	fp, {r0, r1, r8, r9, fp, ip, sp}
  if (bit_num < GIC_IRQ_START) {
     804:	13490521 	movtne	r0, #38177	@ 0x9521
     808:	280a0000 	stmdacs	sl, {}	@ <UNPREDICTABLE>
     80c:	1c0e0300 	stcne	3, cr0, [lr], {-0}
    SET_BIT(GicDist->setenable1, bit_num);
     810:	0b00000b 	bleq	844 <Hal_interrupt_enable+0x74>
     814:	0b0b0024 	bleq	2c08ac <cpsr_cp+0x2bd624>
     818:	0e030b3e 	vmoveq.16	d3[0], r0
     81c:	280c0000 	stmdacs	ip, {}	@ <UNPREDICTABLE>
     820:	1c0e0300 	stcne	3, cr0, [lr], {-0}
     824:	0d000005 	stceq	0, cr0, [r0, #-20]	@ 0xffffffec
     828:	13490005 	movtne	r0, #36869	@ 0x9005
     82c:	0f0e0000 	svceq	0x000e0000
     830:	04210b00 	strteq	r0, [r1], #-2816	@ 0xfffff500
     834:	00001349 	andeq	r1, r0, r9, asr #6
     838:	0301040f 	movweq	r0, #5135	@ 0x140f
     83c:	07213e0e 	streq	r3, [r1, -lr, lsl #28]!
     840:	13490b0b 	movtne	r0, #39691	@ 0x9b0b
     844:	0b3b0b3a 	bleq	ec3534 <cpsr_cp+0xec02ac>
    bit_num -= GIC_IRQ_START;
     848:	010e2139 	tsteq	lr, r9, lsr r1
     84c:	10000013 	andne	r0, r0, r3, lsl r0
     850:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
    SET_BIT(GicDist->setenable2, bit_num);
     854:	0b3a0e03 	bleq	e84068 <cpsr_cp+0xe80de0>
     858:	21390b3b 	teqcs	r9, fp, lsr fp
     85c:	3c192706 	ldccc	7, cr2, [r9], {6}
     860:	00130119 	andseq	r0, r3, r9, lsl r1
     864:	01111100 	tsteq	r1, r0, lsl #2
     868:	0b130e25 	bleq	4c4104 <cpsr_cp+0x4c0e7c>
     86c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
     870:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     874:	00001710 	andeq	r1, r0, r0, lsl r7
     878:	0b002412 	bleq	98c8 <cpsr_cp+0x6640>
     87c:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
     880:	13000008 	movwne	r0, #8
     884:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
     888:	0b3a0b0b 	bleq	e834bc <cpsr_cp+0xe80234>
    return;
     88c:	0b390b3b 	bleq	e43580 <cpsr_cp+0xe402f8>
}
     890:	00001301 	andeq	r1, r0, r1, lsl #6
     894:	49010114 	stmdbmi	r1, {r2, r4, r8}
     898:	00130113 	andseq	r0, r3, r3, lsl r1
void Hal_interrupt_disable(uint32_t interrupt_num) {
     89c:	00211500 	eoreq	r1, r1, r0, lsl #10
     8a0:	0b2f1349 	bleq	bc55cc <cpsr_cp+0xbc2344>
     8a4:	35160000 	ldrcc	r0, [r6, #-0]
     8a8:	00134900 	andseq	r4, r3, r0, lsl #18
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     8ac:	00151700 	andseq	r1, r5, r0, lsl #14
     8b0:	00001927 	andeq	r1, r0, r7, lsr #18
     8b4:	03003418 	movweq	r3, #1048	@ 0x418
     8b8:	3b0b3a0e 	blcc	2cf0f8 <cpsr_cp+0x2cbe70>
     8bc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     8c0:	3c193f13 	ldccc	15, cr3, [r9], {19}
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     8c4:	19000019 	stmdbne	r0, {r0, r3, r4}
     8c8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
     8cc:	0b3a0e03 	bleq	e840e0 <cpsr_cp+0xe80e58>
  if (bit_num < GIC_IRQ_START) {
     8d0:	0b390b3b 	bleq	e435c4 <cpsr_cp+0xe4033c>
     8d4:	13491927 	movtne	r1, #39207	@ 0x9927
     8d8:	1301193c 	movwne	r1, #6460	@ 0x193c
    CLR_BIT(GicDist->setenable1, bit_num);
     8dc:	0f1a0000 	svceq	0x001a0000
     8e0:	000b0b00 	andeq	r0, fp, r0, lsl #22
     8e4:	012e1b00 			@ <UNDEFINED> instruction: 0x012e1b00
     8e8:	0b3a0e03 	bleq	e840fc <cpsr_cp+0xe80e74>
     8ec:	0b390b3b 	bleq	e435e0 <cpsr_cp+0xe40358>
     8f0:	01111927 	tsteq	r1, r7, lsr #18
     8f4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     8f8:	1301197c 	movwne	r1, #6524	@ 0x197c
     8fc:	341c0000 	ldrcc	r0, [ip], #-0
     900:	3a080300 	bcc	201508 <cpsr_cp+0x1fe280>
     904:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     908:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     90c:	1d000018 	stcne	0, cr0, [r0, #-96]	@ 0xffffffa0
     910:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
     914:	0b3a0e03 	bleq	e84128 <cpsr_cp+0xe80ea0>
    bit_num -= GIC_IRQ_START;
     918:	0b390b3b 	bleq	e4360c <cpsr_cp+0xe40384>
     91c:	13491927 	movtne	r1, #39207	@ 0x9927
     920:	06120111 			@ <UNDEFINED> instruction: 0x06120111
    CLR_BIT(GicDist->setenable2, bit_num);
     924:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
     928:	00001301 	andeq	r1, r0, r1, lsl #6
     92c:	0300341e 	movweq	r3, #1054	@ 0x41e
     930:	3b0b3a0e 	blcc	2cf170 <cpsr_cp+0x2cbee8>
     934:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     938:	00180213 	andseq	r0, r8, r3, lsl r2
     93c:	012e1f00 			@ <UNDEFINED> instruction: 0x012e1f00
     940:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     944:	0b3b0b3a 	bleq	ec3634 <cpsr_cp+0xec03ac>
     948:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
     94c:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     950:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
     954:	00001301 	andeq	r1, r0, r1, lsl #6
     958:	03000520 	movweq	r0, #1312	@ 0x520
     95c:	3b0b3a08 	blcc	2cf184 <cpsr_cp+0x2cbefc>
    return;
     960:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
}
     964:	00180213 	andseq	r0, r8, r3, lsl r2
     968:	002e2100 	eoreq	r2, lr, r0, lsl #2
     96c:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num) {
     970:	0b3b0b3a 	bleq	ec3660 <cpsr_cp+0xec03d8>
     974:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
     978:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     97c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
     980:	01000000 	mrseq	r0, (UNDEF: 0)
  sHandlers[interrupt_num] = handler;
     984:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	@ <UNPREDICTABLE>
     988:	213a0e03 	teqcs	sl, r3, lsl #28
     98c:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
     990:	19270621 	stmdbne	r7!, {r0, r5, r9, sl}
     994:	06120111 			@ <UNDEFINED> instruction: 0x06120111
}
     998:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
     99c:	11020000 	mrsne	r0, (UNDEF: 2)
     9a0:	130e2501 	movwne	r2, #58625	@ 0xe501
     9a4:	1b0e030b 	blne	3815d8 <cpsr_cp+0x37e350>
void Hal_interrupt_run_handler(void) {
     9a8:	1201110e 	andne	r1, r1, #-2147483645	@ 0x80000003
     9ac:	00171006 	andseq	r1, r7, r6
     9b0:	34010000 	strcc	r0, [r1], #-0
  uint32_t interrupt_num = GicCpu->interruptack.bits.InterruptID;
     9b4:	3a080300 	bcc	2015bc <cpsr_cp+0x1fe334>
     9b8:	0b3b0121 	bleq	ec0e44 <cpsr_cp+0xebdbbc>
     9bc:	13490b39 	movtne	r0, #39737	@ 0x9b39
     9c0:	00001802 	andeq	r1, r0, r2, lsl #16
     9c4:	0b002402 	bleq	99d4 <cpsr_cp+0x674c>
     9c8:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
     9cc:	0300000e 	movweq	r0, #14
  if (sHandlers[interrupt_num] != NULL) {
     9d0:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
     9d4:	0b3b0b3a 	bleq	ec36c4 <cpsr_cp+0xec043c>
     9d8:	13490b39 	movtne	r0, #39737	@ 0x9b39
     9dc:	05040000 	streq	r0, [r4, #-0]
     9e0:	3a080300 	bcc	2015e8 <cpsr_cp+0x1fe360>
     9e4:	0b3b0121 	bleq	ec0e70 <cpsr_cp+0xebdbe8>
    sHandlers[interrupt_num]();
     9e8:	13490b39 	movtne	r0, #39737	@ 0x9b39
     9ec:	00001802 	andeq	r1, r0, r2, lsl #16
     9f0:	03003405 	movweq	r3, #1029	@ 0x405
     9f4:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
     9f8:	0b390b3b 	bleq	e436ec <cpsr_cp+0xe40464>
  GicCpu->endofinterrupt.bits.InterruptID = interrupt_num;
     9fc:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
     a00:	2e060000 	cdpcs	0, 0, cr0, cr6, cr0, {0}
     a04:	03193f01 	tsteq	r9, #1, 30
     a08:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
     a0c:	21390b3b 	teqcs	r9, fp, lsr fp
     a10:	4919270a 	ldmdbmi	r9, {r1, r3, r8, r9, sl, sp}
     a14:	12011113 	andne	r1, r1, #-1073741820	@ 0xc0000004
     a18:	7c184006 	ldcvc	0, cr4, [r8], {6}
     a1c:	00130119 	andseq	r0, r3, r9, lsl r1
     a20:	00050700 	andeq	r0, r5, r0, lsl #14
     a24:	213a0e03 	teqcs	sl, r3, lsl #28
     a28:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
void Hal_timer_init(void) {
     a2c:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     a30:	08000018 	stmdaeq	r0, {r3, r4}
     a34:	0e030028 	cdpeq	0, 0, cr0, cr3, cr8, {1}
  Timer->timerxcontrol.bits.TimerEn = 0;
     a38:	00000b1c 	andeq	r0, r0, ip, lsl fp
     a3c:	49010109 	stmdbmi	r1, {r0, r3, r8}
     a40:	00130113 	andseq	r0, r3, r3, lsl r1
     a44:	010b0a00 	tsteq	fp, r0, lsl #20
     a48:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     a4c:	0f0b0000 	svceq	0x000b0000
  Timer->timerxcontrol.bits.TimerMode = 0;
     a50:	04210b00 	strteq	r0, [r1], #-2816	@ 0xfffff500
     a54:	00001349 	andeq	r1, r0, r9, asr #6
     a58:	2501110c 	strcs	r1, [r1, #-268]	@ 0xfffffef4
     a5c:	030b130e 	movweq	r1, #45838	@ 0xb30e
     a60:	110e1b0e 	tstne	lr, lr, lsl #22
     a64:	10061201 	andne	r1, r6, r1, lsl #4
  Timer->timerxcontrol.bits.OneShot = 0;
     a68:	0d000017 	stceq	0, cr0, [r0, #-92]	@ 0xffffffa4
     a6c:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
     a70:	0b3a0b0b 	bleq	e836a4 <cpsr_cp+0xe8041c>
     a74:	13010b3b 	movwne	r0, #6971	@ 0x1b3b
     a78:	0d0e0000 	stceq	0, cr0, [lr, #-0]
     a7c:	490e0300 	stmdbmi	lr, {r8, r9}
  Timer->timerxcontrol.bits.TimerSize = 0;
     a80:	340b3813 	strcc	r3, [fp], #-2067	@ 0xfffff7ed
     a84:	0f000019 	svceq	0x00000019
     a88:	0b0b000f 	bleq	2c0acc <cpsr_cp+0x2bd844>
     a8c:	24100000 	ldrcs	r0, [r0], #-0
     a90:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     a94:	0008030b 	andeq	r0, r8, fp, lsl #6
  Timer->timerxcontrol.bits.TimerPre = 0;
     a98:	01041100 	mrseq	r1, (UNDEF: 20)
     a9c:	0b3e0e03 	bleq	f842b0 <cpsr_cp+0xf81028>
     aa0:	13490b0b 	movtne	r0, #39691	@ 0x9b0b
     aa4:	0b3b0b3a 	bleq	ec3794 <cpsr_cp+0xec050c>
     aa8:	13010b39 	movwne	r0, #6969	@ 0x1b39
     aac:	21120000 	tstcs	r2, r0
  Timer->timerxcontrol.bits.IntEnable = 1;
     ab0:	2f134900 	svccs	0x00134900
     ab4:	13000005 	movwne	r0, #5
     ab8:	13490026 	movtne	r0, #36902	@ 0x9026
     abc:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
     ac0:	03193f01 	tsteq	r9, #1, 30
     ac4:	3b0b3a0e 	blcc	2cf304 <cpsr_cp+0x2cc07c>
  Timer->timerxload = 0;
     ac8:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     acc:	01193c19 	tsteq	r9, r9, lsl ip
     ad0:	15000013 	strne	r0, [r0, #-19]	@ 0xffffffed
     ad4:	13490005 	movtne	r0, #36869	@ 0x9005
     ad8:	21160000 	tstcs	r6, r0
  Timer->timerxvalue = 0xFFFFFFFF;
     adc:	2f134900 	svccs	0x00134900
     ae0:	1700000b 	strne	r0, [r0, -fp]
     ae4:	00000018 	andeq	r0, r0, r8, lsl r0
     ae8:	3f012e18 	svccc	0x00012e18
     aec:	3a0e0319 	bcc	381758 <cpsr_cp+0x37e4d0>
  Timer->timerxcontrol.bits.TimerMode = TIMER_PERIOIC;
     af0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     af4:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
     af8:	12011113 	andne	r1, r1, #-1073741820	@ 0xc0000004
     afc:	7c184006 	ldcvc	0, cr4, [r8], {6}
     b00:	00000019 	andeq	r0, r0, r9, lsl r0
     b04:	0b002401 	bleq	9b10 <cpsr_cp+0x6888>
  Timer->timerxcontrol.bits.TimerSize = TIMER_32BIT_COUNTER;
     b08:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
     b0c:	0200000e 	andeq	r0, r0, #14
     b10:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
     b14:	0e030b13 	vmoveq.32	d3[0], r0
     b18:	01110e1b 	tsteq	r1, fp, lsl lr
     b1c:	17100612 			@ <UNDEFINED> instruction: 0x17100612
  Timer->timerxcontrol.bits.OneShot = 0;
     b20:	24030000 	strcs	r0, [r3], #-0
     b24:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     b28:	0008030b 	andeq	r0, r8, fp, lsl #6
     b2c:	00160400 	andseq	r0, r6, r0, lsl #8
     b30:	0b3a0e03 	bleq	e84344 <cpsr_cp+0xe810bc>
     b34:	0b390b3b 	bleq	e43828 <cpsr_cp+0xe405a0>
  Timer->timerxcontrol.bits.TimerPre = 0;
     b38:	00001349 	andeq	r1, r0, r9, asr #6
     b3c:	3f002e05 	svccc	0x00002e05
     b40:	3a0e0319 	bcc	3817ac <cpsr_cp+0x37e524>
     b44:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     b48:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
     b4c:	00193c13 	andseq	r3, r9, r3, lsl ip
  Timer->timerxcontrol.bits.IntEnable = 1;
     b50:	012e0600 			@ <UNDEFINED> instruction: 0x012e0600
     b54:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     b58:	0b3b0b3a 	bleq	ec3848 <cpsr_cp+0xec05c0>
     b5c:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
     b60:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     b64:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
  uint32_t interval_1ms = TIMER_INTERVAL / 100;
     b68:	05070000 	streq	r0, [r7, #-0]
     b6c:	3a080300 	bcc	201774 <cpsr_cp+0x1fe4ec>
  Timer->timerxload = interval_1ms;
     b70:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     b74:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     b78:	08000018 	stmdaeq	r0, {r3, r4}
     b7c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
     b80:	0b3b0b3a 	bleq	ec3870 <cpsr_cp+0xec05e8>
  Timer->timerxcontrol.bits.TimerEn = 1;
     b84:	13490b39 	movtne	r0, #39737	@ 0x9b39
     b88:	00001802 	andeq	r1, r0, r2, lsl #16
     b8c:	00280100 	eoreq	r0, r8, r0, lsl #2
     b90:	061c0e03 	ldreq	r0, [ip], -r3, lsl #28
     b94:	28020000 	stmdacs	r2, {}	@ <UNPREDICTABLE>
     b98:	1c0e0300 	stcne	3, cr0, [lr], {-0}
  internal_1ms_counter = 0;
     b9c:	0300000b 	movweq	r0, #11
     ba0:	0b0b0024 	bleq	2c0c38 <cpsr_cp+0x2bd9b0>
     ba4:	0e030b3e 	vmoveq.16	d3[0], r0
     ba8:	28040000 	stmdacs	r4, {}	@ <UNPREDICTABLE>
  Hal_interrupt_enable(TIMER_INTERRUPT);
     bac:	1c0e0300 	stcne	3, cr0, [lr], {-0}
     bb0:	05000005 	streq	r0, [r0, #-5]
  Hal_interrupt_register_handler(interrupt_handler, TIMER_INTERRUPT);
     bb4:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     bb8:	3b01213a 	blcc	490a8 <cpsr_cp+0x45e20>
     bbc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     bc0:	00180213 	andseq	r0, r8, r3, lsl r2
}
     bc4:	00160600 	andseq	r0, r6, r0, lsl #12
     bc8:	0b3a0e03 	bleq	e843dc <cpsr_cp+0xe81154>
     bcc:	0b390b3b 	bleq	e438c0 <cpsr_cp+0xe40638>
uint32_t Hal_timer_get_1ms_counter(void) {
     bd0:	00001349 	andeq	r1, r0, r9, asr #6
     bd4:	3f012e07 	svccc	0x00012e07
  return internal_1ms_counter;
     bd8:	3a0e0319 	bcc	381844 <cpsr_cp+0x37e5bc>
     bdc:	0b3b0121 	bleq	ec1068 <cpsr_cp+0xebdde0>
     be0:	27062139 	smladxcs	r6, r9, r1, r2
}
     be4:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     be8:	7a184006 	bvc	610c08 <cpsr_cp+0x60d980>
     bec:	00130119 	andseq	r0, r3, r9, lsl r1
     bf0:	01110800 	tsteq	r1, r0, lsl #16
static void interrupt_handler(void) {
     bf4:	0b130e25 	bleq	4c4490 <cpsr_cp+0x4c1208>
     bf8:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
  ++internal_1ms_counter;
     bfc:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     c00:	00001710 	andeq	r1, r0, r0, lsl r7
     c04:	0b002409 	bleq	9c30 <cpsr_cp+0x69a8>
     c08:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
     c0c:	0a000008 	beq	c34 <interrupt_handler+0x40>
     c10:	0e030104 	adfeqs	f0, f3, f4
     c14:	0b0b0b3e 	bleq	2c3914 <cpsr_cp+0x2c068c>
  Timer->timerxintclr = 1;
     c18:	0b3a1349 	bleq	e85944 <cpsr_cp+0xe826bc>
     c1c:	0b390b3b 	bleq	e43910 <cpsr_cp+0xe40688>
     c20:	00001301 	andeq	r1, r0, r1, lsl #6
     c24:	0300340b 	movweq	r3, #1035	@ 0x40b
     c28:	3b0b3a0e 	blcc	2cf468 <cpsr_cp+0x2cc1e0>
     c2c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     c30:	00180213 	andseq	r0, r8, r3, lsl r2
     c34:	012e0c00 			@ <UNDEFINED> instruction: 0x012e0c00
     c38:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
void Hal_uart_init(void) {
     c3c:	0b3b0b3a 	bleq	ec392c <cpsr_cp+0xec06a4>
     c40:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
  Uart->uartcr.bits.UARTEN = 0;
     c44:	01111349 	tsteq	r1, r9, asr #6
     c48:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     c4c:	1301197c 	movwne	r1, #6524	@ 0x197c
     c50:	2e0d0000 	cdpcs	0, 0, cr0, cr13, cr0, {0}
     c54:	03193f00 	tsteq	r9, #0, 30
     c58:	3b0b3a0e 	blcc	2cf498 <cpsr_cp+0x2cc210>
  Uart->uartcr.bits.TXE = 1;
     c5c:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     c60:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     c64:	7a184006 	bvc	610c84 <cpsr_cp+0x60d9fc>
     c68:	00000019 	andeq	r0, r0, r9, lsl r0
     c6c:	03002801 	movweq	r2, #2049	@ 0x801
     c70:	00061c0e 	andeq	r1, r6, lr, lsl #24
  Uart->uartcr.bits.RXE = 1;
     c74:	00280200 	eoreq	r0, r8, r0, lsl #4
     c78:	0b1c0e03 	bleq	70448c <cpsr_cp+0x701204>
     c7c:	24030000 	strcs	r0, [r3], #-0
     c80:	3e0b0b00 	vmlacc.f64	d0, d11, d0
     c84:	000e030b 	andeq	r0, lr, fp, lsl #6
     c88:	00280400 	eoreq	r0, r8, r0, lsl #8
  Uart->uartcr.bits.UARTEN = 1;
     c8c:	051c0e03 	ldreq	r0, [ip, #-3587]	@ 0xfffff1fd
     c90:	05050000 	streq	r0, [r5, #-0]
     c94:	00134900 	andseq	r4, r3, r0, lsl #18
     c98:	00050600 	andeq	r0, r5, r0, lsl #12
     c9c:	213a0e03 	teqcs	sl, r3, lsl #28
     ca0:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
  Uart->uartimsc.bits.RXIM = 1;
     ca4:	0213490b 	andseq	r4, r3, #180224	@ 0x2c000
     ca8:	07000018 	smladeq	r0, r8, r0, r0
     cac:	0111010b 	tsteq	r1, fp, lsl #2
     cb0:	00000612 	andeq	r0, r0, r2, lsl r6
     cb4:	03003408 	movweq	r3, #1032	@ 0x408
     cb8:	01213a08 			@ <UNDEFINED> instruction: 0x01213a08
  Hal_interrupt_register_handler(interrupt_handler, UART_INTERRUPT0);
     cbc:	0b390b3b 	bleq	e439b0 <cpsr_cp+0xe40728>
     cc0:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
     cc4:	2e090000 	cdpcs	0, 0, cr0, cr9, cr0, {0}
     cc8:	03193f01 	tsteq	r9, #1, 30
}
     ccc:	3b0b3a0e 	blcc	2cf50c <cpsr_cp+0x2cc284>
     cd0:	0621390b 	strteq	r3, [r1], -fp, lsl #18
void Hal_uart_put_char(uint8_t ch) {
     cd4:	13491927 	movtne	r1, #39207	@ 0x9927
     cd8:	1301193c 	movwne	r1, #6460	@ 0x193c
     cdc:	340a0000 	strcc	r0, [sl], #-0
     ce0:	3a0e0300 	bcc	3818e8 <cpsr_cp+0x37e660>
     ce4:	0b3b0121 	bleq	ec1170 <cpsr_cp+0xebdee8>
  while(Uart->uartfr.bits.TXFF);
     ce8:	13490b39 	movtne	r0, #39737	@ 0x9b39
     cec:	00001802 	andeq	r1, r0, r2, lsl #16
     cf0:	0300160b 	movweq	r1, #1547	@ 0x60b
     cf4:	3b0b3a0e 	blcc	2cf534 <cpsr_cp+0x2cc2ac>
     cf8:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     cfc:	0c000013 	stceq	0, cr0, [r0], {19}
     d00:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	@ <UNPREDICTABLE>
     d04:	213a0e03 	teqcs	sl, r3, lsl #28
     d08:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
  Uart->uartdr.bits.DATA = (ch & 0xFF);
     d0c:	19270621 	stmdbne	r7!, {r0, r5, r9, sl}
     d10:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     d14:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
     d18:	2e0d0000 	cdpcs	0, 0, cr0, cr13, cr0, {0}
     d1c:	03193f00 	tsteq	r9, #0, 30
     d20:	3b0b3a0e 	blcc	2cf560 <cpsr_cp+0x2cc2d8>
     d24:	0621390b 	strteq	r3, [r1], -fp, lsl #18
}
     d28:	193c1927 	ldmdbne	ip!, {r0, r1, r2, r5, r8, fp, ip}
     d2c:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
     d30:	03193f01 	tsteq	r9, #1, 30
     d34:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
uint8_t Hal_uart_get_char(void) {
     d38:	21390b3b 	teqcs	r9, fp, lsr fp
     d3c:	11192706 	tstne	r9, r6, lsl #14
     d40:	40061201 	andmi	r1, r6, r1, lsl #4
  while(Uart->uartfr.bits.RXFE);
     d44:	01197c18 	tsteq	r9, r8, lsl ip
     d48:	0f000013 	svceq	0x00000013
     d4c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
     d50:	213a0e03 	teqcs	sl, r3, lsl #28
     d54:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
     d58:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
     d5c:	12011113 	andne	r1, r1, #-1073741820	@ 0xc0000004
     d60:	7c184006 	ldcvc	0, cr4, [r8], {6}
     d64:	00130119 	andseq	r0, r3, r9, lsl r1
  data = Uart->uartdr.all;
     d68:	01041000 	mrseq	r1, (UNDEF: 4)
     d6c:	213e0e03 	teqcs	lr, r3, lsl #28
     d70:	490b0b07 	stmdbmi	fp, {r0, r1, r2, r8, r9, fp}
     d74:	3b0b3a13 	blcc	2cf5c8 <cpsr_cp+0x2cc340>
     d78:	0e21390b 	vmuleq.f16	s6, s2, s22	@ <UNPREDICTABLE>
  if(data & 0xFFFFFF00) {
     d7c:	00001301 	andeq	r1, r0, r1, lsl #6
     d80:	3f002e11 	svccc	0x00002e11
     d84:	3a0e0319 	bcc	3819f0 <cpsr_cp+0x37e768>
    Uart->uartrsr.all = 0xFF;
     d88:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
     d8c:	4919270b 	ldmdbmi	r9, {r0, r1, r3, r8, r9, sl, sp}
     d90:	00193c13 	andseq	r3, r9, r3, lsl ip
     d94:	01111200 	tsteq	r1, r0, lsl #4
     d98:	0b130e25 	bleq	4c4634 <cpsr_cp+0x4c13ac>
    return 0;
     d9c:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
     da0:	06120111 			@ <UNDEFINED> instruction: 0x06120111
  return (uint8_t)(data & 0xFF);
     da4:	00001710 	andeq	r1, r0, r0, lsl r7
     da8:	0b002413 	bleq	9dfc <cpsr_cp+0x6b74>
}
     dac:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
     db0:	14000008 	strne	r0, [r0], #-8
     db4:	0b0b000f 	bleq	2c0df8 <cpsr_cp+0x2bdb70>
     db8:	00001349 	andeq	r1, r0, r9, asr #6
static void interrupt_handler(void) {
     dbc:	3f012e15 	svccc	0x00012e15
     dc0:	3a0e0319 	bcc	381a2c <cpsr_cp+0x37e7a4>
     dc4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  uint8_t ch = Hal_uart_get_char();
     dc8:	3c19270b 	ldccc	7, cr2, [r9], {11}
     dcc:	00130119 	andseq	r0, r3, r9, lsl r1
     dd0:	010b1600 	tsteq	fp, r0, lsl #12
  if (ch == 'U') {
     dd4:	00001755 	andeq	r1, r0, r5, asr r7
     dd8:	0b000f17 	bleq	4a3c <cpsr_cp+0x17b4>
     ddc:	0000000b 	andeq	r0, r0, fp
    Kernel_send_events(KernelEventFlag_Unlock);
     de0:	0b002401 	bleq	9dec <cpsr_cp+0x6b64>
     de4:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
    return;
     de8:	0200000e 	andeq	r0, r0, #14
  if (ch == 'X') {
     dec:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     df0:	3b01213a 	blcc	492e0 <cpsr_cp+0x46058>
     df4:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
    Kernel_send_events(KernelEventFlag_CmdOut);
     df8:	00180213 	andseq	r0, r8, r3, lsl r2
     dfc:	00160300 	andseq	r0, r6, r0, lsl #6
    return;
     e00:	0b3a0e03 	bleq	e84614 <cpsr_cp+0xe8138c>
  Hal_uart_put_char(ch);
     e04:	0b390b3b 	bleq	e43af8 <cpsr_cp+0xe40870>
     e08:	00001349 	andeq	r1, r0, r9, asr #6
     e0c:	03002804 	movweq	r2, #2052	@ 0x804
  Kernel_send_msg(KernelMsgQ_Task0, &ch, 1);
     e10:	000b1c0e 	andeq	r1, fp, lr, lsl #24
     e14:	000d0500 	andeq	r0, sp, r0, lsl #10
     e18:	213a0e03 	teqcs	sl, r3, lsl #28
     e1c:	390b3b03 	stmdbcc	fp, {r0, r1, r8, r9, fp, ip, sp}
     e20:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
  Kernel_send_events(KernelEventFlag_UartIn);
     e24:	0600000b 	streq	r0, [r0], -fp
     e28:	13490101 	movtne	r0, #37121	@ 0x9101
     e2c:	00001301 	andeq	r1, r0, r1, lsl #6
     e30:	3f012e07 	svccc	0x00012e07
void enable_irq(void) {
     e34:	3a0e0319 	bcc	381aa0 <cpsr_cp+0x37e818>
     e38:	0b3b0121 	bleq	ec12c4 <cpsr_cp+0xebe03c>
  __asm__ ("PUSH {r0, r1}");
     e3c:	27062139 	smladxcs	r6, r9, r1, r2
  __asm__ ("MRS r0, cpsr");
     e40:	11134919 	tstne	r3, r9, lsl r9
  __asm__ ("BIC r1, r0, #0x80");
     e44:	40061201 	andmi	r1, r6, r1, lsl #4
  __asm__ ("MSR cpsr, r1");
     e48:	01197c18 	tsteq	r9, r8, lsl ip
  __asm__ ("POP {r0, r1}");
     e4c:	08000013 	stmdaeq	r0, {r0, r1, r4}
}
     e50:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
     e54:	213a0e03 	teqcs	sl, r3, lsl #28
     e58:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
     e5c:	19270621 	stmdbne	r7!, {r0, r5, r9, sl}
void enable_fiq(void) {
     e60:	01111349 	tsteq	r1, r9, asr #6
     e64:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  __asm__ ("PUSH {r0, r1}");
     e68:	1301197a 	movwne	r1, #6522	@ 0x197a
  __asm__ ("MRS r0, cpsr");
     e6c:	11090000 	mrsne	r0, (UNDEF: 9)
  __asm__ ("BIC r1, r0, #0x40");
     e70:	130e2501 	movwne	r2, #58625	@ 0xe501
  __asm__ ("MSR cpsr, r1");
     e74:	1b0e030b 	blne	381aa8 <cpsr_cp+0x37e820>
  __asm__ ("POP {r0, r1}");
     e78:	1201110e 	andne	r1, r1, #-2147483645	@ 0x80000003
}
     e7c:	00171006 	andseq	r1, r7, r6
     e80:	00240a00 	eoreq	r0, r4, r0, lsl #20
     e84:	0b3e0b0b 	bleq	f83ab8 <cpsr_cp+0xf80830>
     e88:	00000803 	andeq	r0, r0, r3, lsl #16
void disable_irq(void) {
     e8c:	0301040b 	movweq	r0, #5131	@ 0x140b
     e90:	0b0b3e0e 	bleq	2d06d0 <cpsr_cp+0x2cd448>
  __asm__ ("PUSH {r0, r1}");
     e94:	3a13490b 	bcc	4d32c8 <cpsr_cp+0x4d0040>
  __asm__ ("MRS r0, cpsr");
     e98:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  __asm__ ("ORR r1, r0, #0x80");
     e9c:	0013010b 	andseq	r0, r3, fp, lsl #2
  __asm__ ("MSR cpsr, r1");
     ea0:	01130c00 	tsteq	r3, r0, lsl #24
  __asm__ ("POP {r0, r1}");
     ea4:	050b0e03 	streq	r0, [fp, #-3587]	@ 0xfffff1fd
}
     ea8:	0b3b0b3a 	bleq	ec3b98 <cpsr_cp+0xec0910>
     eac:	13010b39 	movwne	r0, #6969	@ 0x1b39
     eb0:	210d0000 	mrscs	r0, (UNDEF: 13)
     eb4:	2f134900 	svccs	0x00134900
void disable_fiq(void) {
     eb8:	0e000005 	cdpeq	0, 0, cr0, cr0, cr5, {0}
     ebc:	13490021 	movtne	r0, #36897	@ 0x9021
  __asm__ ("PUSH {r0, r1}");
     ec0:	00000b2f 	andeq	r0, r0, pc, lsr #22
  __asm__ ("MRS r0, cpsr");
     ec4:	0300340f 	movweq	r3, #1039	@ 0x40f
  __asm__ ("ORR r1, r0, #0x40");
     ec8:	3b0b3a0e 	blcc	2cf708 <cpsr_cp+0x2cc480>
  __asm__ ("MSR cpsr, r1");
     ecc:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
  __asm__ ("POP {r0, r1}");
     ed0:	00180213 	andseq	r0, r8, r3, lsl r2
     ed4:	000f1000 	andeq	r1, pc, r0
     ed8:	13490b0b 	movtne	r0, #39691	@ 0x9b0b
     edc:	2e110000 	cdpcs	0, 1, cr0, cr1, cr0, {0}
     ee0:	03193f01 	tsteq	r9, #1, 30
uint32_t putstr(const char* s) {
     ee4:	3b0b3a0e 	blcc	2cf724 <cpsr_cp+0x2cc49c>
     ee8:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     eec:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     ef0:	7a184006 	bvc	610f10 <cpsr_cp+0x60dc88>
  uint32_t c = 0;
     ef4:	12000019 	andne	r0, r0, #25
     ef8:	0111010b 	tsteq	r1, fp, lsl #2
  while(*s) {
     efc:	00000612 	andeq	r0, r0, r2, lsl r6
    Hal_uart_put_char(*s++);
     f00:	03003413 	movweq	r3, #1043	@ 0x413
     f04:	3b0b3a08 	blcc	2cf72c <cpsr_cp+0x2cc4a4>
     f08:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     f0c:	00180213 	andseq	r0, r8, r3, lsl r2
     f10:	24010000 	strcs	r0, [r1], #-0
     f14:	3e0b0b00 	vmlacc.f64	d0, d11, d0
    ++c;
     f18:	000e030b 	andeq	r0, lr, fp, lsl #6
     f1c:	00160200 	andseq	r0, r6, r0, lsl #4
     f20:	0b3a0e03 	bleq	e84734 <cpsr_cp+0xe814ac>
  while(*s) {
     f24:	0b390b3b 	bleq	e43c18 <cpsr_cp+0xe40990>
     f28:	00001349 	andeq	r1, r0, r9, asr #6
     f2c:	03003403 	movweq	r3, #1027	@ 0x403
     f30:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
  return c;
     f34:	0b390b3b 	bleq	e43c28 <cpsr_cp+0xe409a0>
}
     f38:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
     f3c:	0d040000 	stceq	0, cr0, [r4, #-0]
     f40:	3a0e0300 	bcc	381b48 <cpsr_cp+0x37e8c0>
uint32_t debug_printf(const char* format, ...) { 
     f44:	0b3b0321 	bleq	ec1bd0 <cpsr_cp+0xebe948>
     f48:	13490b39 	movtne	r0, #39737	@ 0x9b39
     f4c:	00000b38 	andeq	r0, r0, r8, lsr fp
     f50:	3f012e05 	svccc	0x00012e05
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
     f54:	3a0e0319 	bcc	381bc0 <cpsr_cp+0x37e938>
     f58:	0b3b0121 	bleq	ec13e4 <cpsr_cp+0xebe15c>
  vsprintf(printf_buf, format, args);
     f5c:	27062139 	smladxcs	r6, r9, r1, r2
     f60:	11134919 	tstne	r3, r9, lsl r9
     f64:	40061201 	andmi	r1, r6, r1, lsl #4
     f68:	01197a18 	tsteq	r9, r8, lsl sl
     f6c:	06000013 			@ <UNDEFINED> instruction: 0x06000013
  return putstr(printf_buf);
     f70:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
     f74:	3b01213a 	blcc	49464 <cpsr_cp+0x461dc>
     f78:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
     f7c:	00180213 	andseq	r0, r8, r3, lsl r2
}
     f80:	002e0700 	eoreq	r0, lr, r0, lsl #14
     f84:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
     f88:	3b01213a 	blcc	49478 <cpsr_cp+0x461f0>
     f8c:	0621390b 	strteq	r3, [r1], -fp, lsl #18
     f90:	01111927 	tsteq	r1, r7, lsr #18
uint32_t vsprintf(char* buf, const char* format, va_list arg) {
     f94:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
     f98:	0000197a 	andeq	r1, r0, sl, ror r9
     f9c:	25011108 	strcs	r1, [r1, #-264]	@ 0xfffffef8
     fa0:	030b130e 	movweq	r1, #45838	@ 0xb30e
     fa4:	110e1b0e 	tstne	lr, lr, lsl #22
     fa8:	10061201 	andne	r1, r6, r1, lsl #4
  uint32_t c = 0;
     fac:	09000017 	stmdbeq	r0, {r0, r1, r2, r4}
     fb0:	0b0b0024 	bleq	2c1048 <cpsr_cp+0x2bddc0>
  for (uint32_t i = 0; format[i]; ++i) {
     fb4:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
     fb8:	130a0000 	movwne	r0, #40960	@ 0xa000
     fbc:	0b0e0301 	bleq	381bc8 <cpsr_cp+0x37e940>
    if (format[i] == '%') {
     fc0:	3b0b3a0b 	blcc	2cf7f4 <cpsr_cp+0x2cc56c>
     fc4:	010b390b 	tsteq	fp, fp, lsl #18
     fc8:	0b000013 	bleq	101c <vsprintf+0x88>
     fcc:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	@ <UNPREDICTABLE>
     fd0:	0b3a0e03 	bleq	e847e4 <cpsr_cp+0xe8155c>
     fd4:	0b390b3b 	bleq	e43cc8 <cpsr_cp+0xe40a40>
      ++i;
     fd8:	13491927 	movtne	r1, #39207	@ 0x9927
     fdc:	06120111 			@ <UNDEFINED> instruction: 0x06120111
     fe0:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
      switch(format[i]) {
     fe4:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
     fe8:	03193f01 	tsteq	r9, #1, 30
     fec:	3b0b3a0e 	blcc	2cf82c <cpsr_cp+0x2cc5a4>
     ff0:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
     ff4:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
     ff8:	7a184006 	bvc	611018 <cpsr_cp+0x60dd90>
     ffc:	0d000019 	stceq	0, cr0, [r0, #-100]	@ 0xffffff9c
    1000:	08030005 	stmdaeq	r3, {r0, r2}
    1004:	0b3b0b3a 	bleq	ec3cf4 <cpsr_cp+0xec0a6c>
    1008:	13490b39 	movtne	r0, #39737	@ 0x9b39
    100c:	00001802 	andeq	r1, r0, r2, lsl #16
    1010:	00240100 	eoreq	r0, r4, r0, lsl #2
    1014:	0b3e0b0b 	bleq	f83c48 <cpsr_cp+0xf809c0>
    1018:	00000e03 	andeq	r0, r0, r3, lsl #28
    101c:	03003402 	movweq	r3, #1026	@ 0x402
    1020:	01213a0e 			@ <UNDEFINED> instruction: 0x01213a0e
    1024:	0b390b3b 	bleq	e43d18 <cpsr_cp+0xe40a90>
    1028:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
    102c:	16030000 	strne	r0, [r3], -r0
    1030:	3a0e0300 	bcc	381c38 <cpsr_cp+0x37e9b0>
    1034:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
    1038:	0013490b 	andseq	r4, r3, fp, lsl #18
    103c:	000f0400 	andeq	r0, pc, r0, lsl #8
    1040:	4904210b 	stmdbmi	r4, {r0, r1, r3, r8, sp}
    1044:	05000013 	streq	r0, [r0, #-19]	@ 0xffffffed
    1048:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
    104c:	3b03213a 	blcc	c953c <cpsr_cp+0xc62b4>
    1050:	0c21390b 			@ <UNDEFINED> instruction: 0x0c21390b
    1054:	0b381349 	bleq	e05d80 <cpsr_cp+0xe02af8>
    1058:	34060000 	strcc	r0, [r6], #-0
        ch = (char)va_arg(arg, int32_t);
    105c:	3a080300 	bcc	201c64 <cpsr_cp+0x1fe9dc>
    1060:	0b3b0121 	bleq	ec14ec <cpsr_cp+0xebe264>
    1064:	13490b39 	movtne	r0, #39737	@ 0x9b39
    1068:	00001802 	andeq	r1, r0, r2, lsl #16
    106c:	03011307 	movweq	r1, #4871	@ 0x1307
        buf[c++] = ch;
    1070:	3a0b0b0e 	bcc	2c3cb0 <cpsr_cp+0x2c0a28>
    1074:	0b3b0321 	bleq	ec1d00 <cpsr_cp+0xebea78>
    1078:	01102139 	tsteq	r0, r9, lsr r1
    107c:	08000013 	stmdaeq	r0, {r0, r1, r4}
    1080:	0803000d 	stmdaeq	r3, {r0, r2, r3}
    1084:	3b03213a 	blcc	c9574 <cpsr_cp+0xc62ec>
    1088:	0c21390b 			@ <UNDEFINED> instruction: 0x0c21390b
        break;
    108c:	0b381349 	bleq	e05db8 <cpsr_cp+0xe02b30>
        str = (char*)va_arg(arg, char*);
    1090:	01090000 	mrseq	r0, (UNDEF: 9)
    1094:	01134901 	tsteq	r3, r1, lsl #18
    1098:	0a000013 	beq	10ec <vsprintf+0x158>
    109c:	13490021 	movtne	r0, #36897	@ 0x9021
    10a0:	00000b2f 	andeq	r0, r0, pc, lsr #22
        if (str == NULL) {
    10a4:	11010b0b 	tstne	r1, fp, lsl #22
    10a8:	00061201 	andeq	r1, r6, r1, lsl #4
    10ac:	01110c00 	tsteq	r1, r0, lsl #24
          str = "(null)";
    10b0:	0b130e25 	bleq	4c494c <cpsr_cp+0x4c16c4>
    10b4:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
    10b8:	06120111 			@ <UNDEFINED> instruction: 0x06120111
        while (*str) {
    10bc:	00001710 	andeq	r1, r0, r0, lsl r7
          buf[c++] = (*str++);
    10c0:	0b00240d 	bleq	a0fc <cpsr_cp+0x6e74>
    10c4:	030b3e0b 	movweq	r3, #48651	@ 0xbe0b
    10c8:	0e000008 	cdpeq	0, 0, cr0, cr0, cr8, {0}
    10cc:	19270015 	stmdbne	r7!, {r0, r2, r4}
    10d0:	2e0f0000 	cdpcs	0, 0, cr0, cr15, cr0, {0}
    10d4:	3a0e0300 	bcc	381cdc <cpsr_cp+0x37ea54>
    10d8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
    10dc:	1119270b 	tstne	r9, fp, lsl #14
    10e0:	40061201 	andmi	r1, r6, r1, lsl #4
    10e4:	00197a18 	andseq	r7, r9, r8, lsl sl
        while (*str) {
    10e8:	002e1000 	eoreq	r1, lr, r0
    10ec:	0b3a0e03 	bleq	e84900 <cpsr_cp+0xe81678>
    10f0:	0b390b3b 	bleq	e43de4 <cpsr_cp+0xe40b5c>
    10f4:	13491927 	movtne	r1, #39207	@ 0x9927
        break;
    10f8:	06120111 			@ <UNDEFINED> instruction: 0x06120111
        uint = (uint32_t)va_arg(arg, uint32_t);
    10fc:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
    1100:	2e110000 	cdpcs	0, 1, cr0, cr1, cr0, {0}
    1104:	03193f00 	tsteq	r9, #0, 30
    1108:	3b0b3a0e 	blcc	2cf948 <cpsr_cp+0x2cc6c0>
    110c:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
        c += utoa(&buf[c], uint, utoa_dec);
    1110:	11134919 	tstne	r3, r9, lsl r9
    1114:	40061201 	andmi	r1, r6, r1, lsl #4
    1118:	00197a18 	andseq	r7, r9, r8, lsl sl
    111c:	002e1200 	eoreq	r1, lr, r0, lsl #4
    1120:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
    1124:	0b3b0b3a 	bleq	ec3e14 <cpsr_cp+0xec0b8c>
    1128:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
    112c:	06120111 			@ <UNDEFINED> instruction: 0x06120111
    1130:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
    1134:	2e130000 	cdpcs	0, 1, cr0, cr3, cr0, {0}
    1138:	03193f00 	tsteq	r9, #0, 30
        break;
    113c:	3b0b3a0e 	blcc	2cf97c <cpsr_cp+0x2cc6f4>
        hex = (uint32_t)va_arg(arg, uint32_t);
    1140:	270b390b 	strcs	r3, [fp, -fp, lsl #18]
    1144:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
    1148:	7c184006 	ldcvc	0, cr4, [r8], {6}
    114c:	14000019 	strne	r0, [r0], #-25	@ 0xffffffe7
    1150:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	@ <UNPREDICTABLE>
        c += utoa(&buf[c], hex, utoa_hex);
    1154:	0b3a0e03 	bleq	e84968 <cpsr_cp+0xe816e0>
    1158:	0b390b3b 	bleq	e43e4c <cpsr_cp+0xe40bc4>
    115c:	13491927 	movtne	r1, #39207	@ 0x9927
    1160:	06120111 			@ <UNDEFINED> instruction: 0x06120111
    1164:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
    1168:	00001301 	andeq	r1, r0, r1, lsl #6
    116c:	03000515 	movweq	r0, #1301	@ 0x515
    1170:	3b0b3a0e 	blcc	2cf9b0 <cpsr_cp+0x2cc728>
    1174:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
    1178:	00180213 	andseq	r0, r8, r3, lsl r2
    117c:	012e1600 			@ <UNDEFINED> instruction: 0x012e1600
        break;
    1180:	0e03193f 			@ <UNDEFINED> instruction: 0x0e03193f
      buf[c++] = format[i];
    1184:	0b3b0b3a 	bleq	ec3e74 <cpsr_cp+0xec0bec>
    1188:	19270b39 	stmdbne	r7!, {r0, r3, r4, r5, r8, r9, fp}
    118c:	06120111 			@ <UNDEFINED> instruction: 0x06120111
    1190:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
    1194:	01000000 	mrseq	r0, (UNDEF: 0)
    1198:	17100111 			@ <UNDEFINED> instruction: 0x17100111
    119c:	0f120111 	svceq	0x00120111
    11a0:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
    11a4:	05130e25 	ldreq	r0, [r3, #-3621]	@ 0xfffff1db
    11a8:	2e020000 	cdpcs	0, 0, cr0, cr2, cr0, {0}
    if (c >= PRINTF_BUF_LEN) {
    11ac:	3f0e0300 	svccc	0x000e0300
    11b0:	12011119 	andne	r1, r1, #1073741830	@ 0x40000006
    11b4:	0000000f 	andeq	r0, r0, pc
        buf[0] = '\0';
    11b8:	10011101 	andne	r1, r1, r1, lsl #2
    11bc:	12011117 	andne	r1, r1, #-1073741819	@ 0xc0000005
    11c0:	1b0e030f 	blne	381e04 <cpsr_cp+0x37eb7c>
        return 0;
    11c4:	130e250e 	movwne	r2, #58638	@ 0xe50e
    11c8:	02000005 	andeq	r0, r0, #5
  for (uint32_t i = 0; format[i]; ++i) {
    11cc:	0e03002e 	cdpeq	0, 0, cr0, cr3, cr14, {1}
    11d0:	0f120111 	svceq	0x00120111
    11d4:	Address 0x11d4 is out of bounds.


Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
    LDR PC, reset_handler_addr
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
    LDR PC, undef_handler_addr
   4:	00000002 	andeq	r0, r0, r2
    LDR PC, svc_handler_addr
   8:	00040000 	andeq	r0, r4, r0
	...
    B .
  14:	000000d4 	ldrdeq	r0, [r0], -r4
	...
    LDR PC, fiq_handler_addr
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	00250002 	eoreq	r0, r5, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	000000d4 	ldrdeq	r0, [r0], -r4
  34:	00000024 	andeq	r0, r0, r4, lsr #32
	...
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	00b00002 	adcseq	r0, r0, r2
    MSR cpsr, r1 @ 동작 모드 변경
  48:	00040000 	andeq	r0, r4, r0
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	00000000 	andeq	r0, r0, r0
    MRS r0, cpsr
  50:	000000f8 	strdeq	r0, [r0], -r8
    BIC r1, r0, #0x1F
  54:	0000019c 	muleq	r0, ip, r1
	...
    LDR sp, =IRQ_STACK_TOP
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
    MRS r0, cpsr
  64:	02a70002 	adceq	r0, r7, #2
    BIC r1, r0, #0x1F
  68:	00040000 	andeq	r0, r4, r0
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	00000000 	andeq	r0, r0, r0
    MSR cpsr, r1
  70:	00000340 	andeq	r0, r0, r0, asr #6
    LDR sp, =FIQ_STACK_TOP
  74:	0000034c 	andeq	r0, r0, ip, asr #6
	...
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
    MSR cpsr, r1
  84:	06dc0002 	ldrbeq	r0, [ip], r2
    LDR sp, =ABT_STACK_TOP
  88:	00040000 	andeq	r0, r4, r0
    MRS r0, cpsr
  8c:	00000000 	andeq	r0, r0, r0
    BIC r1, r0, #0x1F
  90:	00000734 	andeq	r0, r0, r4, lsr r7
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	000002f8 	strdeq	r0, [r0], -r8
	...
    MRS r0, cpsr
  a0:	00000014 	andeq	r0, r0, r4, lsl r0
    BIC r1, r0, #0x1F
  a4:	0c8f0002 	stceq	0, cr0, [pc], {2}
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	00040000 	andeq	r0, r4, r0
	...
    B .
  b8:	0000001c 	andeq	r0, r0, ip, lsl r0
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  bc:	1c580002 	mrrcne	0, 0, r0, r8, cr2
    LDR sp, =IRQ_STACK_TOP
  c0:	00040000 	andeq	r0, r4, r0
    LDR sp, =FIQ_STACK_TOP
  c4:	00000000 	andeq	r0, r0, r0
    LDR sp, =ABT_STACK_TOP
  c8:	00000a2c 	andeq	r0, r0, ip, lsr #20
    LDR sp, =UND_STACK_TOP
  cc:	00000210 	andeq	r0, r0, r0, lsl r2
	...
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
  d8:	0000001c 	andeq	r0, r0, ip, lsl r0
  dc:	1ef70002 	cdpne	0, 15, cr0, cr7, cr2, {0}
  Hal_interrupt_run_handler();
  e0:	00040000 	andeq	r0, r4, r0
}
  e4:	00000000 	andeq	r0, r0, r0
  e8:	00000c3c 	andeq	r0, r0, ip, lsr ip
  ec:	000001f8 	strdeq	r0, [r0], -r8
	...
void main(void) {
  f8:	0000001c 	andeq	r0, r0, ip, lsl r0
  fc:	2a070002 	bcs	1c010c <cpsr_cp+0x1bce84>
 100:	00040000 	andeq	r0, r4, r0
  Hw_init();
 104:	00000000 	andeq	r0, r0, r0
  Kernel_init();
 108:	00000e34 	andeq	r0, r0, r4, lsr lr
  uint32_t i = 100;
 10c:	000000b0 	strheq	r0, [r0], -r0	@ <UNPREDICTABLE>
	...
    Hal_uart_put_char('N');
 118:	0000001c 	andeq	r0, r0, ip, lsl r0
 11c:	2a6e0002 	bcs	1b8012c <cpsr_cp+0x1b7cea4>
  while(i--) {
 120:	00040000 	andeq	r0, r4, r0
 124:	00000000 	andeq	r0, r0, r0
 128:	00000ee4 	andeq	r0, r0, r4, ror #29
 12c:	00000438 	andeq	r0, r0, r8, lsr r4
	...
  Hal_uart_put_char('\n');
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
  putstr("Hello World!\n");
 13c:	2d1d0002 	ldccs	0, cr0, [sp, #-8]
 140:	00040000 	andeq	r0, r4, r0
 144:	00000000 	andeq	r0, r0, r0
  Printf_test();
 148:	00001324 	andeq	r1, r0, r4, lsr #6
  Hal_interrupt_enable(UART_INTERRUPT0);
 14c:	0000004c 	andeq	r0, r0, ip, asr #32
	...
}
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	2dc40002 	stclcs	0, cr0, [r4, #8]
 160:	00040000 	andeq	r0, r4, r0
static void Hw_init(void){
 164:	00000000 	andeq	r0, r0, r0
 168:	00001370 	andeq	r1, r0, r0, ror r3
  Hal_interrupt_init();
 16c:	000000f8 	strdeq	r0, [r0], -r8
	...
}
 178:	0000001c 	andeq	r0, r0, ip, lsl r0
 17c:	2fe60002 	svccs	0x00e60002
static void Kernel_init(void) {
 180:	00040000 	andeq	r0, r4, r0
 184:	00000000 	andeq	r0, r0, r0
  Kernel_task_init();
 188:	00001468 	andeq	r1, r0, r8, ror #8
  Kernel_event_flag_init();
 18c:	00000388 	andeq	r0, r0, r8, lsl #7
	...
  Kernel_sem_init(1);
 198:	0000001c 	andeq	r0, r0, ip, lsl r0
  Kernel_mutex_init();
 19c:	349b0002 	ldrcc	r0, [fp], #2
  add_task(User_task0, 0);
 1a0:	00040000 	andeq	r0, r4, r0
 1a4:	00000000 	andeq	r0, r0, r0
 1a8:	000017f0 	strdeq	r1, [r0], -r0
 1ac:	000003f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
	...
  add_task(User_task1, 1);
 1b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1bc:	36aa0002 	strtcc	r0, [sl], r2
  add_task(User_task2, 2);
 1c0:	00040000 	andeq	r0, r4, r0
 1c4:	00000000 	andeq	r0, r0, r0
 1c8:	00001be0 	andeq	r1, r0, r0, ror #23
 1cc:	00000200 	andeq	r0, r0, r0, lsl #4
	...
static void Printf_test(void) {
 1d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1dc:	38330002 	ldmdacc	r3!, {r1}
 1e0:	00040000 	andeq	r0, r4, r0
  char* str = "printf pointer test";
 1e4:	00000000 	andeq	r0, r0, r0
 1e8:	00001de0 	andeq	r1, r0, r0, ror #27
 1ec:	00000334 	andeq	r0, r0, r4, lsr r3
	...
  uint32_t i = 5;
 1f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1fc:	3a9f0002 	bcc	fe7c020c <cpsr_cp+0xfe7bcf84>
  debug_printf("%s\n", "Hello printf");
 200:	00040000 	andeq	r0, r4, r0
 204:	00000000 	andeq	r0, r0, r0
 208:	00002120 	andeq	r2, r0, r0, lsr #2
 20c:	00000114 	andeq	r0, r0, r4, lsl r1
	...
  debug_printf("output string pointer: %s\n", str);
 218:	0000001c 	andeq	r0, r0, ip, lsl r0
 21c:	3ada0002 	bcc	ff68022c <cpsr_cp+0xff67cfa4>
 220:	00040000 	andeq	r0, r4, r0
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
 224:	00000000 	andeq	r0, r0, r0
 228:	00002234 	andeq	r2, r0, r4, lsr r2
 22c:	00000004 	andeq	r0, r0, r4
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
    LDR PC, reset_handler_addr
       0:	746f6f62 	strbtvc	r6, [pc], #-3938	@ 8 <vector_start+0x8>
    LDR PC, undef_handler_addr
       4:	746e452f 	strbtvc	r4, [lr], #-1327	@ 0xfffffad1
    LDR PC, svc_handler_addr
       8:	532e7972 			@ <UNDEFINED> instruction: 0x532e7972
    LDR PC, pfch_abt_handler_addr
       c:	6f682f00 	svcvs	0x00682f00
    LDR PC, data_abt_handler_addr
      10:	6a2f656d 	bvs	bd95cc <cpsr_cp+0xbd6344>
    B .
      14:	79686e69 	stmdbvc	r8!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
    LDR PC, irq_handler_addr
      18:	2f6b6f65 	svccs	0x006b6f65
    LDR PC, fiq_handler_addr
      1c:	736f7472 	cmnvc	pc, #1912602624	@ 0x72000000
      20:	554e4700 	strbpl	r4, [lr, #-1792]	@ 0xfffff900
      24:	20534120 	subscs	r4, r3, r0, lsr #2
      28:	30342e32 	eorscc	r2, r4, r2, lsr lr
      2c:	71724900 	cmnvc	r2, r0, lsl #18
      30:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
      34:	72656c64 	rsbvc	r6, r5, #100, 24	@ 0x6400
      38:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
    MRS r0, cpsr @ move PSR to Register
      3c:	6f6c2067 	svcvs	0x006c2067
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
      40:	7520676e 	strvc	r6, [r0, #-1902]!	@ 0xfffff892
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
      44:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
    MSR cpsr, r1 @ 동작 모드 변경
      48:	2064656e 	rsbcs	r6, r4, lr, ror #10
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      4c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    MRS r0, cpsr
      50:	5f716946 	svcpl	0x00716946
    BIC r1, r0, #0x1F
      54:	646e6148 	strbtvs	r6, [lr], #-328	@ 0xfffffeb8
    ORR r1, r1, #ARM_MODE_BIT_IRQ
      58:	0072656c 	rsbseq	r6, r2, ip, ror #10
    MSR cpsr, r1
      5c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
    LDR sp, =IRQ_STACK_TOP
      60:	64656e67 	strbtvs	r6, [r5], #-3687	@ 0xfffff199
    MRS r0, cpsr
      64:	61686320 	cmnvs	r8, r0, lsr #6
    BIC r1, r0, #0x1F
      68:	6f620072 	svcvs	0x00620072
    ORR r1, r1, #ARM_MODE_BIT_FIQ
      6c:	482f746f 	stmdami	pc!, {r0, r1, r2, r3, r5, r6, sl, ip, sp, lr}	@ <UNPREDICTABLE>
    MSR cpsr, r1
      70:	6c646e61 	stclvs	14, cr6, [r4], #-388	@ 0xfffffe7c
    LDR sp, =FIQ_STACK_TOP
      74:	632e7265 			@ <UNDEFINED> instruction: 0x632e7265
    MRS r0, cpsr
      78:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
    BIC r1, r0, #0x1F
      7c:	6f6c2067 	svcvs	0x006c2067
    ORR r1, r1, #ARM_MODE_BIT_ABT
      80:	6920676e 	stmdbvs	r0!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
    MSR cpsr, r1
      84:	7300746e 	movwvc	r7, #1134	@ 0x46e
    LDR sp, =ABT_STACK_TOP
      88:	74726f68 	ldrbtvc	r6, [r2], #-3944	@ 0xfffff098
    MRS r0, cpsr
      8c:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    BIC r1, r0, #0x1F
      90:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    ORR r1, r1, #ARM_MODE_BIT_UND
      94:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
    MSR cpsr, r1
      98:	61480074 	hvcvs	32772	@ 0x8004
    LDR sp, =UND_STACK_TOP
      9c:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
    MRS r0, cpsr
      a0:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
    BIC r1, r0, #0x1F
      a4:	5f747075 	svcpl	0x00747075
    ORR r1, r1, #ARM_MODE_BIT_SYS
      a8:	5f6e7572 	svcpl	0x006e7572
    MSR cpsr, r1
      ac:	646e6168 	strbtvs	r6, [lr], #-360	@ 0xfffffe98
    LDR sp, =USRSYS_STACK_TOP
      b0:	0072656c 	rsbseq	r6, r2, ip, ror #10
    BL main
      b4:	726f6873 	rsbvc	r6, pc, #7536640	@ 0x730000
    B .
      b8:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
      bc:	4e470074 	mcrmi	0, 2, r0, cr7, cr4, {3}
    LDR sp, =IRQ_STACK_TOP
      c0:	31432055 	qdaddcc	r2, r5, r3
    LDR sp, =FIQ_STACK_TOP
      c4:	32312037 	eorscc	r2, r1, #55	@ 0x37
    LDR sp, =ABT_STACK_TOP
      c8:	312e322e 			@ <UNDEFINED> instruction: 0x312e322e
    LDR sp, =UND_STACK_TOP
      cc:	32303220 	eorscc	r3, r0, #32, 4
    LDR sp, =USRSYS_STACK_TOP
      d0:	30323132 	eorscc	r3, r2, r2, lsr r1
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
      d4:	6d2d2035 	stcvs	0, cr2, [sp, #-212]!	@ 0xffffff2c
      d8:	206d7261 	rsbcs	r7, sp, r1, ror #4
      dc:	70636d2d 	rsbvc	r6, r3, sp, lsr #26
  Hal_interrupt_run_handler();
      e0:	6f633d75 	svcvs	0x00633d75
}
      e4:	78657472 	stmdavc	r5!, {r1, r4, r5, r6, sl, ip, sp, lr}^
      e8:	2038612d 	eorscs	r6, r8, sp, lsr #2
      ec:	6c666d2d 	stclvs	13, cr6, [r6], #-180	@ 0xffffff4c
__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
      f0:	2d74616f 	ldfcse	f6, [r4, #-444]!	@ 0xfffffe44
  while (true);
      f4:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	@ 0xfffffe7c
void main(void) {
      f8:	74666f73 	strbtvc	r6, [r6], #-3955	@ 0xfffff08d
      fc:	616d2d20 	cmnvs	sp, r0, lsr #26
     100:	3d686372 	stclcc	3, cr6, [r8, #-456]!	@ 0xfffffe38
  Hw_init();
     104:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
  Kernel_init();
     108:	2b612d37 	blcs	184b5ec <cpsr_cp+0x1848364>
  uint32_t i = 100;
     10c:	20636573 	rsbcs	r6, r3, r3, ror r5
     110:	4800672d 	stmdami	r0, {r0, r2, r3, r5, r8, r9, sl, sp, lr}
  while(i--) {
     114:	755f6c61 	ldrbvc	r6, [pc, #-3169]	@ fffff4bb <cpsr_cp+0xffffc233>
    Hal_uart_put_char('N');
     118:	5f747261 	svcpl	0x00747261
     11c:	5f747570 	svcpl	0x00747570
  while(i--) {
     120:	72616863 	rsbvc	r6, r1, #6488064	@ 0x630000
     124:	5f774800 	svcpl	0x00774800
     128:	74696e69 	strbtvc	r6, [r9], #-3689	@ 0xfffff197
     12c:	6c614800 	stclvs	8, cr4, [r1], #-0
     130:	746e695f 	strbtvc	r6, [lr], #-2399	@ 0xfffff6a1
  Hal_uart_put_char('\n');
     134:	75727265 	ldrbvc	r7, [r2, #-613]!	@ 0xfffffd9b
     138:	655f7470 	ldrbvs	r7, [pc, #-1136]	@ fffffcd0 <cpsr_cp+0xffffca48>
  putstr("Hello World!\n");
     13c:	6c62616e 	stfvse	f6, [r2], #-440	@ 0xfffffe48
     140:	654b0065 	strbvs	r0, [fp, #-101]	@ 0xffffff9b
     144:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
  Printf_test();
     148:	6576655f 	ldrbvs	r6, [r6, #-1375]!	@ 0xfffffaa1
  Hal_interrupt_enable(UART_INTERRUPT0);
     14c:	665f746e 	ldrbvs	r7, [pc], -lr, ror #8
     150:	5f67616c 	svcpl	0x0067616c
  Kernel_start();
     154:	74696e69 	strbtvc	r6, [r9], #-3689	@ 0xfffff197
}
     158:	72654b00 	rsbvc	r4, r5, #0, 22
     15c:	5f6c656e 	svcpl	0x006c656e
     160:	5167736d 	cmnpl	r7, sp, ror #6
static void Hw_init(void){
     164:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     168:	61480074 	hvcvs	32772	@ 0x8004
  Hal_interrupt_init();
     16c:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
  Hal_uart_init();
     170:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
  Hal_timer_init();
     174:	5f747075 	svcpl	0x00747075
}
     178:	74696e69 	strbtvc	r6, [r9], #-3689	@ 0xfffff197
     17c:	72654b00 	rsbvc	r4, r5, #0, 22
static void Kernel_init(void) {
     180:	546c656e 	strbtpl	r6, [ip], #-1390	@ 0xfffffa92
     184:	466b7361 	strbtmi	r7, [fp], -r1, ror #6
  Kernel_task_init();
     188:	5f636e75 	svcpl	0x00636e75
  Kernel_event_flag_init();
     18c:	654b0074 	strbvs	r0, [fp, #-116]	@ 0xffffff8c
  Kernel_msgQ_init();
     190:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
  Kernel_sem_init(1);
     194:	6d65735f 	stclvs	3, cr7, [r5, #-380]!	@ 0xfffffe84
     198:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
  Kernel_mutex_init();
     19c:	654b0074 	strbvs	r0, [fp, #-116]	@ 0xffffff8c
  add_task(User_task0, 0);
     1a0:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     1a4:	6174735f 	cmnvs	r4, pc, asr r3
     1a8:	4b007472 	blmi	1d378 <cpsr_cp+0x1a0f0>
     1ac:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
  add_task(User_task1, 1);
     1b0:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
     1b4:	48007469 	stmdami	r0, {r0, r3, r5, r6, sl, ip, sp, lr}
     1b8:	755f6c61 	ldrbvc	r6, [pc, #-3169]	@ fffff55f <cpsr_cp+0xffffc2d7>
     1bc:	5f747261 	svcpl	0x00747261
  add_task(User_task2, 2);
     1c0:	74696e69 	strbtvc	r6, [r9], #-3689	@ 0xfffff197
     1c4:	72654b00 	rsbvc	r4, r5, #0, 22
     1c8:	5f6c656e 	svcpl	0x006c656e
     1cc:	6b736174 	blvs	1cd87a4 <cpsr_cp+0x1cd551c>
}
     1d0:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     1d4:	6f620074 	svcvs	0x00620074
static void Printf_test(void) {
     1d8:	4d2f746f 	cfstrsmi	mvf7, [pc, #-444]!	@ 24 <undef_handler_addr>
     1dc:	2e6e6961 	vnmulcs.f16	s13, s28, s3	@ <UNPREDICTABLE>
     1e0:	616d0063 	cmnvs	sp, r3, rrx
  char* str = "printf pointer test";
     1e4:	61006e69 	tstvs	r0, r9, ror #28
     1e8:	745f6464 	ldrbvc	r6, [pc], #-1124	@ 1f0 <Printf_test+0x18>
     1ec:	006b7361 	rsbeq	r7, fp, r1, ror #6
  char* nullptr = 0;
     1f0:	6e697250 	mcrvs	2, 3, r7, cr9, cr0, {2}
     1f4:	745f6674 	ldrbvc	r6, [pc], #-1652	@ 1fc <Printf_test+0x24>
  uint32_t i = 5;
     1f8:	00747365 	rsbseq	r7, r4, r5, ror #6
     1fc:	746e6975 	strbtvc	r6, [lr], #-2421	@ 0xfffff68b
  debug_printf("%s\n", "Hello printf");
     200:	00745f38 	rsbseq	r5, r4, r8, lsr pc
     204:	75626564 	strbvc	r6, [r2, #-1380]!	@ 0xfffffa9c
     208:	72705f67 	rsbsvc	r5, r0, #412	@ 0x19c
     20c:	66746e69 	ldrbtvs	r6, [r4], -r9, ror #28
     210:	65735500 	ldrbvs	r5, [r3, #-1280]!	@ 0xfffffb00
  debug_printf("output string pointer: %s\n", str);
     214:	61745f72 	cmnvs	r4, r2, ror pc
     218:	00316b73 	eorseq	r6, r1, r3, ror fp
     21c:	73747570 	cmnvc	r4, #112, 10	@ 0x1c000000
     220:	48007274 	stmdami	r0, {r2, r4, r5, r6, r9, ip, sp, lr}
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
     224:	745f6c61 	ldrbvc	r6, [pc], #-3169	@ 22c <Printf_test+0x54>
     228:	72656d69 	rsbvc	r6, r5, #6720	@ 0x1a40
     22c:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     230:	73550074 	cmpvc	r5, #116	@ 0x74
     234:	745f7265 	ldrbvc	r7, [pc], #-613	@ 23c <Printf_test+0x64>
  debug_printf("%u = 5\n", i);
     238:	306b7361 	rsbcc	r7, fp, r1, ror #6
     23c:	65735500 	ldrbvs	r5, [r3, #-1280]!	@ 0xfffffb00
     240:	61745f72 	cmnvs	r4, r2, ror pc
     244:	00326b73 	eorseq	r6, r2, r3, ror fp
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
     248:	746e6975 	strbtvc	r6, [lr], #-2421	@ 0xfffff68b
     24c:	745f3233 	ldrbvc	r3, [pc], #-563	@ 254 <Printf_test+0x7c>
     250:	6f425f00 	svcvs	0x00425f00
     254:	6e006c6f 	cdpvs	12, 0, cr6, cr0, cr15, {3}
     258:	706c6c75 	rsbvc	r6, ip, r5, ror ip
  debug_printf("print zero %u\n", 0);
     25c:	4b007274 	blmi	1cc34 <cpsr_cp+0x199ac>
     260:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     264:	756d5f6c 	strbvc	r5, [sp, #-3948]!	@ 0xfffff094
     268:	5f786574 	svcpl	0x00786574
  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
     26c:	74696e69 	strbtvc	r6, [r9], #-3689	@ 0xfffff197
     270:	72617500 	rsbvc	r7, r1, #0, 10
     274:	00686374 	rsbeq	r6, r8, r4, ror r3
     278:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     27c:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     280:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     284:	5f67616c 	svcpl	0x0067616c
     288:	74706d45 	ldrbtvc	r6, [r0], #-3397	@ 0xfffff2bb
     28c:	654b0079 	strbvs	r0, [fp, #-121]	@ 0xffffff87
     290:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     294:	6e65735f 	mcrvs	3, 3, r7, cr5, cr15, {2}
     298:	76655f64 	strbtvc	r5, [r5], -r4, ror #30
     29c:	73746e65 	cmnvc	r4, #1616	@ 0x650
     2a0:	6e616800 	cdpvs	8, 6, cr6, cr1, cr0, {0}
     2a4:	5f656c64 	svcpl	0x00656c64
     2a8:	6e657665 	cdpvs	6, 6, cr7, cr5, cr5, {3}
     2ac:	65540074 	ldrbvs	r0, [r4, #-116]	@ 0xffffff8c
     2b0:	635f7473 	cmpvs	pc, #1929379840	@ 0x73000000
     2b4:	69746972 	ldmdbvs	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     2b8:	5f6c6163 	svcpl	0x006c6163
     2bc:	74636573 	strbtvc	r6, [r3], #-1395	@ 0xfffffa8d
     2c0:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     2c4:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     2c8:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     2cc:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     2d0:	5f67616c 	svcpl	0x0067616c
     2d4:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     2d8:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     2dc:	63003932 	movwvs	r3, #2354	@ 0x932
     2e0:	7542646d 	strbvc	r6, [r2, #-1133]	@ 0xfffffb93
     2e4:	78644966 	stmdavc	r4!, {r1, r2, r5, r6, r8, fp, lr}^
     2e8:	72654b00 	rsbvc	r4, r5, #0, 22
     2ec:	4d6c656e 	cfstr64mi	mvdx6, [ip, #-440]!	@ 0xfffffe48
     2f0:	5f516773 	svcpl	0x00516773
     2f4:	006d754e 	rsbeq	r7, sp, lr, asr #10
     2f8:	746f6f62 	strbtvc	r6, [pc], #-3938	@ 300 <Printf_test+0x128>
     2fc:	7361542f 	cmnvc	r1, #788529152	@ 0x2f000000
     300:	632e736b 			@ <UNDEFINED> instruction: 0x632e736b
     304:	646d6300 	strbtvs	r6, [sp], #-768	@ 0xfffffd00
     308:	006e656c 	rsbeq	r6, lr, ip, ror #10
     30c:	616c6564 	cmnvs	ip, r4, ror #10
     310:	654b0079 	strbvs	r0, [fp, #-121]	@ 0xffffff87
     314:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     318:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     31c:	616c4674 	smcvs	50276	@ 0xc464
     320:	6d435f67 	stclvs	15, cr5, [r3, #-412]	@ 0xfffffe64
     324:	006e4964 	rsbeq	r4, lr, r4, ror #18
     328:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     32c:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     330:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     334:	5f67616c 	svcpl	0x0067616c
     338:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     33c:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
void add_task(KernelTaskFunc_t f, uint32_t t_id) {
     340:	4b003131 	blmi	c80c <cpsr_cp+0x9584>
     344:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     348:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     34c:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     350:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
  taskId = Kernel_task_create(f);
     354:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     358:	31646576 	smccc	18006	@ 0x4656
     35c:	654b0032 	strbvs	r0, [fp, #-50]	@ 0xffffffce
  if (taskId == NOT_ENOUGH_TASK_NUM) {
     360:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     364:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     368:	616c4674 	smcvs	50276	@ 0xc464
    debug_printf("Task%u creation fail\n", t_id);
     36c:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
     370:	76726573 			@ <UNDEFINED> instruction: 0x76726573
     374:	33316465 	teqcc	r1, #1694498816	@ 0x65000000
     378:	72654b00 	rsbvc	r4, r5, #0, 22
}
     37c:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
     380:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
     384:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
static void Test_critical_section(uint32_t p, uint32_t taskId) {
     388:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
     38c:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     390:	00343164 	eorseq	r3, r4, r4, ror #2
     394:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     398:	76456c65 	strbvc	r6, [r5], -r5, ror #24
  Kernel_lock_mutex();
     39c:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
  debug_printf("User Task #%u Send=%u\n", taskId, p);
     3a0:	5f67616c 	svcpl	0x0067616c
     3a4:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     3a8:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     3ac:	4b003531 	blmi	d878 <cpsr_cp+0xa5f0>
     3b0:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
  shared_value = p;
     3b4:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     3b8:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     3bc:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     3c0:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
  Kernel_yield();
     3c4:	31646576 	smccc	18006	@ 0x4656
  delay(1000);
     3c8:	654b0036 	strbvs	r0, [fp, #-54]	@ 0xffffffca
     3cc:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
     3d0:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     3d4:	616c4674 	smcvs	50276	@ 0xc464
     3d8:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
     3dc:	76726573 			@ <UNDEFINED> instruction: 0x76726573
     3e0:	37316465 	ldrcc	r6, [r1, -r5, ror #8]!
     3e4:	72654b00 	rsbvc	r4, r5, #0, 22
     3e8:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
     3ec:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
  Kernel_unlock_mutex();
     3f0:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
}
     3f4:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
     3f8:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     3fc:	00383164 	eorseq	r3, r8, r4, ror #2
void User_task0(void) {
     400:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     404:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     408:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
  uint32_t local = 0;
     40c:	5f67616c 	svcpl	0x0067616c
     410:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
  debug_printf("User Task #0 SP=0x%x\n", &local);
     414:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     418:	4b003931 	blmi	e8e4 <cpsr_cp+0xb65c>
     41c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     420:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     424:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
  uint8_t cmdBufIdx = 0;
     428:	745f6761 	ldrbvc	r6, [pc], #-1889	@ 430 <User_task0+0x30>
     42c:	646d6300 	strbtvs	r6, [sp], #-768	@ 0xfffffd00
  uint8_t uartch = 0;
     430:	00667542 	rsbeq	r7, r6, r2, asr #10
     434:	6b736174 	blvs	1cd8a0c <cpsr_cp+0x1cd5784>
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
     438:	4b006449 	blmi	19564 <cpsr_cp+0x162dc>
     43c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     440:	6e755f6c 	cdpvs	15, 7, cr5, cr5, cr12, {3}
    switch(handle_event) {
     444:	6b636f6c 	blvs	18dc1fc <cpsr_cp+0x18d8f74>
     448:	6d65735f 	stclvs	3, cr7, [r5, #-380]!	@ 0xfffffe84
     44c:	72654b00 	rsbvc	r4, r5, #0, 22
     450:	5f6c656e 	svcpl	0x006c656e
     454:	74696177 	strbtvc	r6, [r9], #-375	@ 0xfffffe89
     458:	6576655f 	ldrbvs	r6, [r6, #-1375]!	@ 0xfffffaa1
     45c:	0073746e 	rsbseq	r7, r3, lr, ror #8
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
     460:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     464:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     468:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     46c:	5f67616c 	svcpl	0x0067616c
     470:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
      if (uartch == '\r') {
     474:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     478:	4b003032 	blmi	c548 <cpsr_cp+0x92c0>
     47c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
        cmdBuf[cmdBufIdx] = '\0';
     480:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     484:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     488:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     48c:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     490:	32646576 	rsbcc	r6, r4, #494927872	@ 0x1d800000
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     494:	654b0031 	strbvs	r0, [fp, #-49]	@ 0xffffffcf
     498:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     49c:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     4a0:	616c4674 	smcvs	50276	@ 0xc464
     4a4:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
     4a8:	76726573 			@ <UNDEFINED> instruction: 0x76726573
     4ac:	32326465 	eorscc	r6, r2, #1694498816	@ 0x65000000
     4b0:	72654b00 	rsbvc	r4, r5, #0, 22
     4b4:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
     4b8:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
            Kernel_yield();
     4bc:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
     4c0:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
     4c4:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     4c8:	00333264 	eorseq	r3, r3, r4, ror #4
     4cc:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     4d0:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     4d4:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     4d8:	5f67616c 	svcpl	0x0067616c
     4dc:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     4e0:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     4e4:	4b003432 	blmi	d5b4 <cpsr_cp+0xa32c>
     4e8:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     4ec:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
     4f0:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     4f4:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     4f8:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     4fc:	32646576 	rsbcc	r6, r4, #494927872	@ 0x1d800000
     500:	654b0035 	strbvs	r0, [fp, #-53]	@ 0xffffffcb
            Kernel_yield();
     504:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
     508:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
            break;
     50c:	616c4674 	smcvs	50276	@ 0xc464
        Kernel_send_events(KernelEventFlag_CmdIn);
     510:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
     514:	76726573 			@ <UNDEFINED> instruction: 0x76726573
        cmdBufIdx = 0;
     518:	36326465 	ldrtcc	r6, [r2], -r5, ror #8
     51c:	72654b00 	rsbvc	r4, r5, #0, 22
      break;
     520:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
        cmdBuf[cmdBufIdx] = uartch;
     524:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
     528:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
     52c:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
     530:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     534:	00373264 	eorseq	r3, r7, r4, ror #4
        cmdBufIdx = (cmdBufIdx + 1) % 16;
     538:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     53c:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     540:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     544:	5f67616c 	svcpl	0x0067616c
     548:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     54c:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     550:	4b003832 	blmi	e620 <cpsr_cp+0xb398>
     554:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
      break;
     558:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
      Test_critical_section(5, 0);
     55c:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     560:	555f6761 	ldrbpl	r6, [pc, #-1889]	@ fffffe07 <cpsr_cp+0xffffcb7f>
     564:	49747261 	ldmdbmi	r4!, {r0, r5, r6, r9, ip, sp, lr}^
      break;
     568:	654b006e 	strbvs	r0, [fp, #-110]	@ 0xffffff92
    Kernel_yield();
     56c:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
  while(true) {
     570:	7361745f 	cmnvc	r1, #1593835520	@ 0x5f000000
void User_task1(void) {
     574:	72635f6b 	rsbvc	r5, r3, #428	@ 0x1ac
     578:	65746165 	ldrbvs	r6, [r4, #-357]!	@ 0xfffffe9b
     57c:	72654b00 	rsbvc	r4, r5, #0, 22
  uint32_t local = 0;
     580:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
     584:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
  debug_printf("User Task #1 SP=0x%x\n", &local);
     588:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
     58c:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
     590:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     594:	00303164 	eorseq	r3, r0, r4, ror #2
     598:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
  uint8_t cmdlen = 0;
     59c:	755f6c65 	ldrbvc	r6, [pc, #-3173]	@ fffff93f <cpsr_cp+0xffffc6b7>
     5a0:	636f6c6e 	cmnvs	pc, #28160	@ 0x6e00
  uint8_t cmd[16] = {0, };
     5a4:	756d5f6b 	strbvc	r5, [sp, #-3947]!	@ 0xfffff095
     5a8:	00786574 	rsbseq	r6, r8, r4, ror r5
     5ac:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     5b0:	734d6c65 	movtvc	r6, #56421	@ 0xdc65
     5b4:	745f5167 	ldrbvc	r5, [pc], #-359	@ 5bc <User_task1+0x48>
     5b8:	72654b00 	rsbvc	r4, r5, #0, 22
     5bc:	5f6c656e 	svcpl	0x006c656e
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
     5c0:	646e6573 	strbtvs	r6, [lr], #-1395	@ 0xfffffa8d
     5c4:	67736d5f 			@ <UNDEFINED> instruction: 0x67736d5f
     5c8:	695f7400 	ldmdbvs	pc, {sl, ip, sp, lr}^	@ <UNPREDICTABLE>
    switch(handle_event) {
     5cc:	654b0064 	strbvs	r0, [fp, #-100]	@ 0xffffff9c
     5d0:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     5d4:	5167734d 	cmnpl	r7, sp, asr #6
     5d8:	7361545f 	cmnvc	r1, #1593835520	@ 0x5f000000
     5dc:	4b00306b 	blmi	c790 <cpsr_cp+0x9508>
     5e0:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     5e4:	67734d6c 	ldrbvs	r4, [r3, -ip, ror #26]!
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
     5e8:	61545f51 	cmpvs	r4, r1, asr pc
     5ec:	00316b73 	eorseq	r6, r1, r3, ror fp
     5f0:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     5f4:	734d6c65 	movtvc	r6, #56421	@ 0xdc65
     5f8:	545f5167 	ldrbpl	r5, [pc], #-359	@ 600 <User_task1+0x8c>
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
     5fc:	326b7361 	rsbcc	r7, fp, #-2080374783	@ 0x84000001
     600:	61687300 	cmnvs	r8, r0, lsl #6
     604:	5f646572 	svcpl	0x00646572
     608:	756c6176 	strbvc	r6, [ip, #-374]!	@ 0xfffffe8a
     60c:	654b0065 	strbvs	r0, [fp, #-101]	@ 0xffffff9b
     610:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
      cmd[cmdlen] = 0;
     614:	6569795f 	strbvs	r7, [r9, #-2399]!	@ 0xfffff6a1
     618:	4b00646c 	blmi	197d0 <cpsr_cp+0x16548>
     61c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     620:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     624:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
      debug_printf("\nRecv Cmd: %s\n", cmd);
     628:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     62c:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     630:	33646576 	cmncc	r4, #494927872	@ 0x1d800000
     634:	654b0030 	strbvs	r0, [fp, #-48]	@ 0xffffffd0
     638:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
      break;
     63c:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
      Kernel_unlock_sem();
     640:	616c4674 	smcvs	50276	@ 0xc464
      break;
     644:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
    Kernel_yield();
     648:	76726573 			@ <UNDEFINED> instruction: 0x76726573
  while(true) {
     64c:	31336465 	teqcc	r3, r5, ror #8
void User_task2(void) {
     650:	636f6c00 	cmnvs	pc, #0, 24
     654:	4b006c61 	blmi	1b7e0 <cpsr_cp+0x18558>
     658:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
  uint32_t local = 0;
     65c:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     660:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
  debug_printf("User Task #2 SP=0x%x\n", &local);
     664:	435f6761 	cmpmi	pc, #25427968	@ 0x1840000
     668:	754f646d 	strbvc	r6, [pc, #-1133]	@ 203 <Printf_test+0x2b>
     66c:	654b0074 	strbvs	r0, [fp, #-116]	@ 0xffffff8c
     670:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     674:	6365725f 	cmnvs	r5, #-268435451	@ 0xf0000005
    Test_critical_section(3, 2);
     678:	736d5f76 	cmnvc	sp, #472	@ 0x1d8
     67c:	654b0067 	strbvs	r0, [fp, #-103]	@ 0xffffff99
     680:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
    Kernel_yield();
     684:	636f6c5f 	cmnvs	pc, #24320	@ 0x5f00
    Test_critical_section(3, 2);
     688:	756d5f6b 	strbvc	r5, [sp, #-3947]!	@ 0xfffff095
     68c:	00786574 	rsbseq	r6, r8, r4, ror r5
     690:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     694:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     698:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     69c:	5f67616c 	svcpl	0x0067616c
     6a0:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     6a4:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     6a8:	4b003430 	blmi	d770 <cpsr_cp+0xa4e8>
     6ac:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     6b0:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     6b4:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     6b8:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     6bc:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     6c0:	30646576 	rsbcc	r6, r4, r6, ror r5
     6c4:	654b0035 	strbvs	r0, [fp, #-53]	@ 0xffffffcb
     6c8:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
     6cc:	6e657645 	cdpvs	6, 6, cr7, cr5, cr5, {2}
     6d0:	616c4674 	smcvs	50276	@ 0xc464
     6d4:	65525f67 	ldrbvs	r5, [r2, #-3943]	@ 0xfffff099
     6d8:	76726573 			@ <UNDEFINED> instruction: 0x76726573
     6dc:	36306465 	ldrtcc	r6, [r0], -r5, ror #8
     6e0:	72654b00 	rsbvc	r4, r5, #0, 22
     6e4:	456c656e 	strbmi	r6, [ip, #-1390]!	@ 0xfffffa92
     6e8:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
     6ec:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
     6f0:	7365525f 	cmnvc	r5, #-268435451	@ 0xf0000005
     6f4:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     6f8:	00373064 	eorseq	r3, r7, r4, rrx
     6fc:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     700:	76456c65 	strbvc	r6, [r5], -r5, ror #24
     704:	46746e65 	ldrbtmi	r6, [r4], -r5, ror #28
     708:	5f67616c 	svcpl	0x0067616c
     70c:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     710:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     714:	4b003830 	blmi	e7dc <cpsr_cp+0xb554>
     718:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     71c:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     720:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     724:	525f6761 	subspl	r6, pc, #25427968	@ 0x1840000
     728:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     72c:	30646576 	rsbcc	r6, r4, r6, ror r5
     730:	6f720039 	svcvs	0x00720039
void Hal_interrupt_init(void) {
     734:	61626c6c 	cmnvs	r2, ip, ror #24
     738:	4b006b63 	blmi	1b4cc <cpsr_cp+0x18244>
     73c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
  GicCpu->cpucontrol.bits.Enable = 1;
     740:	6576456c 	ldrbvs	r4, [r6, #-1388]!	@ 0xfffffa94
     744:	6c46746e 	cfstrdvs	mvd7, [r6], {110}	@ 0x6e
     748:	555f6761 	ldrbpl	r6, [pc, #-1889]	@ ffffffef <cpsr_cp+0xffffcd67>
     74c:	636f6c6e 	cmnvs	pc, #28160	@ 0x6e00
     750:	6e69006b 	cdpvs	0, 6, cr0, cr9, cr11, {3}
     754:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
     758:	61747075 	cmnvs	r4, r5, ror r0
     75c:	44006b63 	strmi	r6, [r0], #-2915	@ 0xfffff49d
     760:	72747369 	rsbsvc	r7, r4, #-1543503871	@ 0xa4000001
     764:	74756269 	ldrbtvc	r6, [r5], #-617	@ 0xfffffd97
     768:	7443726f 	strbvc	r7, [r3], #-623	@ 0xfffffd91
     76c:	745f6c72 	ldrbvc	r6, [pc], #-3186	@ 774 <Hal_interrupt_init+0x40>
  GicDist->distributorctrl.bits.Enable = 1;
     770:	73655200 	cmnvc	r5, #0, 4
     774:	65767265 	ldrbvs	r7, [r6, #-613]!	@ 0xfffffd9b
     778:	69470064 	stmdbvs	r7, {r2, r5, r6}^
     77c:	75704363 	ldrbvc	r4, [r0, #-867]!	@ 0xfffffc9d
     780:	00745f74 	rsbseq	r5, r4, r4, ror pc
     784:	2f6c6168 	svccs	0x006c6168
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     788:	62707672 	rsbsvs	r7, r0, #119537664	@ 0x7200000
     78c:	6369472f 	cmnvs	r9, #12320768	@ 0xbc0000
     790:	5000632e 	andpl	r6, r0, lr, lsr #6
    sHandlers[i] = NULL;
     794:	726f6972 	rsbvc	r6, pc, #1867776	@ 0x1c8000
     798:	6d797469 	cfldrdvs	mvd7, [r9, #-420]!	@ 0xfffffe5c
     79c:	006b7361 	rsbeq	r7, fp, r1, ror #6
     7a0:	616e6942 	cmnvs	lr, r2, asr #18
     7a4:	6f707972 	svcvs	0x00707972
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
     7a8:	00746e69 	rsbseq	r6, r4, r9, ror #28
     7ac:	61656c63 	cmnvs	r5, r3, ror #24
     7b0:	616e6572 	smcvs	58962	@ 0xe652
     7b4:	32656c62 	rsbcc	r6, r5, #25088	@ 0x6200
     7b8:	6e694200 	cdpvs	2, 6, cr4, cr9, cr0, {0}
     7bc:	50797261 	rsbspl	r7, r9, r1, ror #4
  enable_irq();
     7c0:	746e696f 	strbtvc	r6, [lr], #-2415	@ 0xfffff691
}
     7c4:	4300745f 	movwmi	r7, #1119	@ 0x45f
     7c8:	6f735550 	svcvs	0x00735550
     7cc:	65637275 	strbvs	r7, [r3, #-629]!	@ 0xfffffd8b
void Hal_interrupt_enable(uint32_t interrupt_num) {
     7d0:	63004449 	movwvs	r4, #1097	@ 0x449
     7d4:	6f637570 	svcvs	0x00637570
     7d8:	6f72746e 	svcvs	0x0072746e
     7dc:	6962006c 	stmdbvs	r2!, {r2, r3, r5, r6}^
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     7e0:	756e5f74 	strbvc	r5, [lr, #-3956]!	@ 0xfffff08c
     7e4:	6c63006d 	stclvs	0, cr0, [r3], #-436	@ 0xfffffe4c
     7e8:	65726165 	ldrbvs	r6, [r2, #-357]!	@ 0xfffffe9b
     7ec:	6c62616e 	stfvse	f6, [r2], #-440	@ 0xfffffe48
     7f0:	73003165 	movwvc	r3, #357	@ 0x165
     7f4:	646e6148 	strbtvs	r6, [lr], #-328	@ 0xfffffeb8
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     7f8:	7372656c 	cmnvc	r2, #108, 10	@ 0x1b000000
     7fc:	646e6500 	strbtvs	r6, [lr], #-1280	@ 0xfffffb00
     800:	6e69666f 	cdpvs	6, 6, cr6, cr9, cr15, {3}
  if (bit_num < GIC_IRQ_START) {
     804:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
     808:	00747075 	rsbseq	r7, r4, r5, ror r0
     80c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	@ 0xfffff197
    SET_BIT(GicDist->setenable1, bit_num);
     810:	70757272 	rsbsvc	r7, r5, r2, ror r2
     814:	756e5f74 	strbvc	r5, [lr, #-3956]!	@ 0xfffff08c
     818:	6962006d 	stmdbvs	r2!, {r0, r2, r3, r5, r6}^
     81c:	7972616e 	ldmdbvc	r2!, {r1, r2, r3, r5, r6, r8, sp, lr}^
     820:	6e696f70 	mcrvs	15, 3, r6, cr9, cr0, {3}
     824:	69470074 	stmdbvs	r7, {r2, r4, r5, r6}^
     828:	73694463 	cmnvc	r9, #1660944384	@ 0x63000000
     82c:	72700074 	rsbsvc	r0, r0, #116	@ 0x74
     830:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     834:	616d7974 	smcvs	55188	@ 0xd794
     838:	43006b73 	movwmi	r6, #2931	@ 0xb73
     83c:	6f437570 	svcvs	0x00437570
     840:	6f72746e 	svcvs	0x0072746e
     844:	00745f6c 	rsbseq	r5, r4, ip, ror #30
    bit_num -= GIC_IRQ_START;
     848:	65746573 	ldrbvs	r6, [r4, #-1395]!	@ 0xfffffa8d
     84c:	6c62616e 	stfvse	f6, [r2], #-440	@ 0xfffffe48
     850:	73003165 	movwvc	r3, #357	@ 0x165
    SET_BIT(GicDist->setenable2, bit_num);
     854:	6e657465 	cdpvs	4, 6, cr7, cr5, cr5, {3}
     858:	656c6261 	strbvs	r6, [ip, #-609]!	@ 0xfffffd9f
     85c:	61480032 	cmpvs	r8, r2, lsr r0
     860:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
     864:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
     868:	5f747075 	svcpl	0x00747075
     86c:	69676572 	stmdbvs	r7!, {r1, r4, r5, r6, r8, sl, sp, lr}^
     870:	72657473 	rsbvc	r7, r5, #1929379840	@ 0x73000000
     874:	6e61685f 	mcrvs	8, 3, r6, cr1, cr15, {2}
     878:	72656c64 	rsbvc	r6, r5, #100, 24	@ 0x6400
     87c:	69725000 	ldmdbvs	r2!, {ip, lr}^
     880:	7469726f 	strbtvc	r7, [r9], #-623	@ 0xfffffd91
     884:	65720079 	ldrbvs	r0, [r2, #-121]!	@ 0xffffff87
     888:	76726573 			@ <UNDEFINED> instruction: 0x76726573
    return;
     88c:	00306465 	eorseq	r6, r0, r5, ror #8
}
     890:	65746e49 	ldrbvs	r6, [r4, #-3657]!	@ 0xfffff1b7
     894:	6c644872 	stclvs	8, cr4, [r4], #-456	@ 0xfffffe38
     898:	70665f72 	rsbvc	r5, r6, r2, ror pc
void Hal_interrupt_disable(uint32_t interrupt_num) {
     89c:	64007274 	strvs	r7, [r0], #-628	@ 0xfffffd8c
     8a0:	72747369 	rsbsvc	r7, r4, #-1543503871	@ 0xa4000001
     8a4:	74756269 	ldrbtvc	r6, [r5], #-617	@ 0xfffffd97
     8a8:	7463726f 	strbtvc	r7, [r3], #-623	@ 0xfffffd91
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
     8ac:	47006c72 	smlsdxmi	r0, r2, ip, r6
     8b0:	70436369 	subvc	r6, r3, r9, ror #6
     8b4:	69680075 	stmdbvs	r8!, {r0, r2, r4, r5, r6}^
     8b8:	73656867 	cmnvc	r5, #6750208	@ 0x670000
     8bc:	6e657074 	mcrvs	0, 3, r7, cr5, cr4, {3}
     8c0:	746e6964 	strbtvc	r6, [lr], #-2404	@ 0xfffff69c
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
     8c4:	72007265 	andvc	r7, r0, #1342177286	@ 0x50000006
     8c8:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     8cc:	00646576 	rsbeq	r6, r4, r6, ror r5
  if (bit_num < GIC_IRQ_START) {
     8d0:	4f646e45 	svcmi	0x00646e45
     8d4:	746e4966 	strbtvc	r4, [lr], #-2406	@ 0xfffff69a
     8d8:	75727265 	ldrbvc	r7, [r2, #-613]!	@ 0xfffffd9b
    CLR_BIT(GicDist->setenable1, bit_num);
     8dc:	745f7470 	ldrbvc	r7, [pc], #-1136	@ 8e4 <Hal_interrupt_disable+0x48>
     8e0:	69725000 	ldmdbvs	r2!, {ip, lr}^
     8e4:	7469726f 	strbtvc	r7, [r9], #-623	@ 0xfffffd91
     8e8:	73614d79 	cmnvc	r1, #7744	@ 0x1e40
     8ec:	00745f6b 	rsbseq	r5, r4, fp, ror #30
     8f0:	68676948 	stmdavs	r7!, {r3, r6, r8, fp, sp, lr}^
     8f4:	50747365 	rsbspl	r7, r4, r5, ror #6
     8f8:	49646e65 	stmdbmi	r4!, {r0, r2, r5, r6, r9, sl, fp, sp, lr}^
     8fc:	7265746e 	rsbvc	r7, r5, #1845493760	@ 0x6e000000
     900:	4800745f 	stmdami	r0, {r0, r1, r2, r3, r4, r6, sl, ip, sp, lr}
     904:	695f6c61 	ldmdbvs	pc, {r0, r5, r6, sl, fp, sp, lr}^	@ <UNPREDICTABLE>
     908:	7265746e 	rsbvc	r7, r5, #1845493760	@ 0x6e000000
     90c:	74707572 	ldrbtvc	r7, [r0], #-1394	@ 0xfffffa8e
     910:	7369645f 	cmnvc	r9, #1593835520	@ 0x5f000000
     914:	656c6261 	strbvs	r6, [ip, #-609]!	@ 0xfffffd9f
    bit_num -= GIC_IRQ_START;
     918:	6e757200 	cdpvs	2, 7, cr7, cr5, cr0, {0}
     91c:	676e696e 	strbvs	r6, [lr, -lr, ror #18]!
     920:	65746e69 	ldrbvs	r6, [r4, #-3689]!	@ 0xfffff197
    CLR_BIT(GicDist->setenable2, bit_num);
     924:	70757272 	rsbsvc	r7, r5, r2, ror r2
     928:	6e490074 	mcrvs	0, 2, r0, cr9, cr4, {3}
     92c:	72726574 	rsbsvc	r6, r2, #116, 10	@ 0x1d000000
     930:	41747075 	cmnmi	r4, r5, ror r0
     934:	745f6b63 	ldrbvc	r6, [pc], #-2915	@ 93c <Hal_interrupt_disable+0xa0>
     938:	616e6500 	cmnvs	lr, r0, lsl #10
     93c:	5f656c62 	svcpl	0x00656c62
     940:	00717269 	rsbseq	r7, r1, r9, ror #4
     944:	696c4449 	stmdbvs	ip!, {r0, r3, r6, sl, lr}^
     948:	6e73656e 	cdpvs	5, 7, cr6, cr3, cr14, {3}
     94c:	65626d75 	strbvs	r6, [r2, #-3445]!	@ 0xfffff28b
     950:	50430072 	subpl	r0, r3, r2, ror r0
     954:	6d756e55 	ldclvs	14, cr6, [r5, #-340]!	@ 0xfffffeac
     958:	00726562 	rsbseq	r6, r2, r2, ror #10
     95c:	73746962 	cmnvc	r4, #1605632	@ 0x188000
    return;
     960:	6e6f6300 	cdpvs	3, 6, cr6, cr15, cr0, {0}
}
     964:	6c6f7274 	sfmvs	f7, 2, [pc], #-464	@ 79c <Hal_interrupt_init+0x68>
     968:	7472656c 	ldrbtvc	r6, [r2], #-1388	@ 0xfffffa94
     96c:	00657079 	rsbeq	r7, r5, r9, ror r0
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num) {
     970:	6e6e7552 	mcrvs	5, 3, r7, cr14, cr2, {2}
     974:	49676e69 	stmdbmi	r7!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
     978:	7265746e 	rsbvc	r7, r5, #1845493760	@ 0x6e000000
     97c:	74707572 	ldrbtvc	r7, [r0], #-1394	@ 0xfffffa8e
     980:	7200745f 	andvc	r7, r0, #1593835520	@ 0x5f000000
  sHandlers[interrupt_num] = handler;
     984:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     988:	32646576 	rsbcc	r6, r4, #494927872	@ 0x1d800000
     98c:	6e6f4300 	cdpvs	3, 6, cr4, cr15, cr0, {0}
     990:	6c6f7274 	sfmvs	f7, 2, [pc], #-464	@ 7c8 <Hal_interrupt_init+0x94>
     994:	5472656c 	ldrbtpl	r6, [r2], #-1388	@ 0xfffffa94
}
     998:	5f657079 	svcpl	0x00657079
     99c:	65720074 	ldrbvs	r0, [r2, #-116]!	@ 0xffffff8c
     9a0:	76726573 			@ <UNDEFINED> instruction: 0x76726573
     9a4:	00316465 	eorseq	r6, r1, r5, ror #8
void Hal_interrupt_run_handler(void) {
     9a8:	65746e49 	ldrbvs	r6, [r4, #-3657]!	@ 0xfffff1b7
     9ac:	70757272 	rsbsvc	r7, r5, r2, ror r2
     9b0:	00444974 	subeq	r4, r4, r4, ror r9
  uint32_t interrupt_num = GicCpu->interruptack.bits.InterruptID;
     9b4:	65736572 	ldrbvs	r6, [r3, #-1394]!	@ 0xfffffa8e
     9b8:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     9bc:	69470033 	stmdbvs	r7, {r0, r1, r4, r5}^
     9c0:	73694463 	cmnvc	r9, #1660944384	@ 0x63000000
     9c4:	00745f74 	rsbseq	r5, r4, r4, ror pc
     9c8:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     9cc:	49525872 	ldmdbmi	r2, {r1, r4, r5, r6, fp, ip, lr}^
  if (sHandlers[interrupt_num] != NULL) {
     9d0:	00745f53 	rsbseq	r5, r4, r3, asr pc
     9d4:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     9d8:	494d5872 	stmdbmi	sp, {r1, r4, r5, r6, fp, ip, lr}^
     9dc:	54520053 	ldrbpl	r0, [r2], #-83	@ 0xffffffad
     9e0:	52004d49 	andpl	r4, r0, #4672	@ 0x1240
     9e4:	6e455354 	mcrvs	3, 2, r5, cr5, cr4, {2}
    sHandlers[interrupt_num]();
     9e8:	49454600 	stmdbmi	r5, {r9, sl, lr}^
     9ec:	41550043 	cmpmi	r5, r3, asr #32
     9f0:	4d445452 	cfstrdmi	mvd5, [r4, #-328]	@ 0xfffffeb8
     9f4:	5f524341 	svcpl	0x00524341
     9f8:	454f0074 	strbmi	r0, [pc, #-116]	@ 98c <Hal_interrupt_register_handler+0x1c>
  GicCpu->endofinterrupt.bits.InterruptID = interrupt_num;
     9fc:	54004349 	strpl	r4, [r0], #-841	@ 0xfffffcb7
     a00:	72656d69 	rsbvc	r6, r5, #6720	@ 0x1a40
     a04:	46006e45 	strmi	r6, [r0], -r5, asr #28
     a08:	004d4945 	subeq	r4, sp, r5, asr #18
     a0c:	53656e4f 	cmnpl	r5, #1264	@ 0x4f0
     a10:	00746f68 	rsbseq	r6, r4, r8, ror #30
     a14:	43495854 	movtmi	r5, #38996	@ 0x9854
     a18:	49454f00 	stmdbmi	r5, {r8, r9, sl, fp, lr}^
     a1c:	4542004d 	strbmi	r0, [r2, #-77]	@ 0xffffffb3
     a20:	55004d49 	strpl	r4, [r0, #-3401]	@ 0xfffff2b7
     a24:	49545241 	ldmdbmi	r4, {r0, r6, r9, ip, lr}^
     a28:	5f52504c 	svcpl	0x0052504c
void Hal_timer_init(void) {
     a2c:	54430074 	strbpl	r0, [r3], #-116	@ 0xffffff8c
     a30:	43494d53 	movtmi	r4, #40275	@ 0x9d53
     a34:	52415500 	subpl	r5, r1, #0, 10
  Timer->timerxcontrol.bits.TimerEn = 0;
     a38:	534d4954 	movtpl	r4, #55636	@ 0xd954
     a3c:	00745f43 	rsbseq	r5, r4, r3, asr #30
     a40:	54524155 	ldrbpl	r4, [r2], #-341	@ 0xfffffeab
     a44:	44524249 	ldrbmi	r4, [r2], #-585	@ 0xfffffdb7
     a48:	4300745f 	movwmi	r7, #1119	@ 0x45f
     a4c:	494d5354 	stmdbmi	sp, {r2, r4, r6, r8, r9, ip, lr}^
  Timer->timerxcontrol.bits.TimerMode = 0;
     a50:	5443004d 	strbpl	r0, [r3], #-77	@ 0xffffffb3
     a54:	494d4d53 	stmdbmi	sp, {r0, r1, r4, r6, r8, sl, fp, lr}^
     a58:	58520053 	ldmdapl	r2, {r0, r1, r4, r6}^
     a5c:	0053494d 	subseq	r4, r3, sp, asr #18
     a60:	4d444344 	stclmi	3, cr4, [r4, #-272]	@ 0xfffffef0
     a64:	52004349 	andpl	r4, r0, #603979777	@ 0x24000001
  Timer->timerxcontrol.bits.OneShot = 0;
     a68:	72657365 	rsbvc	r7, r5, #-1811939327	@ 0x94000001
     a6c:	31646576 	smccc	18006	@ 0x4656
     a70:	4d454200 	sfmmi	f4, 2, [r5, #-0]
     a74:	75005349 	strvc	r5, [r0, #-841]	@ 0xfffffcb7
     a78:	72747261 	rsbsvc	r7, r4, #268435462	@ 0x10000006
     a7c:	55007369 	strpl	r7, [r0, #-873]	@ 0xfffffc97
  Timer->timerxcontrol.bits.TimerSize = 0;
     a80:	45545241 	ldrbmi	r5, [r4, #-577]	@ 0xfffffdbf
     a84:	5854004e 	ldmdapl	r4, {r1, r2, r3, r6}^
     a88:	534c4649 	movtpl	r4, #50761	@ 0xc649
     a8c:	52004c45 	andpl	r4, r0, #17664	@ 0x4500
     a90:	494d4d49 	stmdbmi	sp, {r0, r3, r6, r8, sl, fp, lr}^
     a94:	454f0053 	strbmi	r0, [pc, #-83]	@ a49 <Hal_timer_init+0x1d>
  Timer->timerxcontrol.bits.TimerPre = 0;
     a98:	0053494d 	subseq	r4, r3, sp, asr #18
     a9c:	49525852 	ldmdbmi	r2, {r1, r4, r6, fp, ip, lr}^
     aa0:	43440053 	movtmi	r0, #16467	@ 0x4053
     aa4:	4d494d44 	stclmi	13, cr4, [r9, #-272]	@ 0xfffffef0
     aa8:	49585200 	ldmdbmi	r8, {r9, ip, lr}^
     aac:	45500043 	ldrbmi	r0, [r0, #-67]	@ 0xffffffbd
  Timer->timerxcontrol.bits.IntEnable = 1;
     ab0:	75004d49 	strvc	r4, [r0, #-3401]	@ 0xfffff2b7
     ab4:	66747261 	ldrbtvs	r7, [r4], -r1, ror #4
     ab8:	00647262 	rsbeq	r7, r4, r2, ror #4
     abc:	4d495852 	stclmi	8, cr5, [r9, #-328]	@ 0xfffffeb8
     ac0:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
     ac4:	69537265 	ldmdbvs	r3, {r0, r2, r5, r6, r9, ip, sp, lr}^
  Timer->timerxload = 0;
     ac8:	5200657a 	andpl	r6, r0, #511705088	@ 0x1e800000
     acc:	494d5249 	stmdbmi	sp, {r0, r3, r6, r9, ip, lr}^
     ad0:	45460053 	strbmi	r0, [r6, #-83]	@ 0xffffffad
     ad4:	0053494d 	subseq	r4, r3, sp, asr #18
     ad8:	74726175 	ldrbtvc	r6, [r2], #-373	@ 0xfffffe8b
  Timer->timerxvalue = 0xFFFFFFFF;
     adc:	63616d64 	cmnvs	r1, #100, 26	@ 0x1900
     ae0:	61750072 	cmnvs	r5, r2, ror r0
     ae4:	636c7472 	cmnvs	ip, #1912602624	@ 0x72000000
     ae8:	00685f72 	rsbeq	r5, r8, r2, ror pc
     aec:	52444344 	subpl	r4, r4, #68, 6	@ 0x10000001
  Timer->timerxcontrol.bits.TimerMode = TIMER_PERIOIC;
     af0:	0053494d 	subseq	r4, r3, sp, asr #18
     af4:	52525344 	subspl	r5, r2, #68, 6	@ 0x10000001
     af8:	0053494d 	subseq	r4, r3, sp, asr #18
     afc:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     b00:	494d5872 	stmdbmi	sp, {r1, r4, r5, r6, fp, ip, lr}^
     b04:	00745f53 	rsbseq	r5, r4, r3, asr pc
  Timer->timerxcontrol.bits.TimerSize = TIMER_32BIT_COUNTER;
     b08:	65736552 	ldrbvs	r6, [r3, #-1362]!	@ 0xfffffaae
     b0c:	64657672 	strbtvs	r7, [r5], #-1650	@ 0xfffff98e
     b10:	69740030 	ldmdbvs	r4!, {r4, r5}^
     b14:	7872656d 	ldmdavc	r2!, {r0, r2, r3, r5, r6, r8, sl, sp, lr}^
     b18:	0073696d 	rsbseq	r6, r3, sp, ror #18
     b1c:	74726175 	ldrbtvc	r6, [r2], #-373	@ 0xfffffe8b
  Timer->timerxcontrol.bits.OneShot = 0;
     b20:	57007264 	strpl	r7, [r0, -r4, ror #4]
     b24:	004e454c 	subeq	r4, lr, ip, asr #10
     b28:	494d5854 	stmdbmi	sp, {r2, r4, r6, fp, ip, lr}^
     b2c:	41440053 	qdaddmi	r0, r3, r4
     b30:	42004154 	andmi	r4, r0, #84, 2
     b34:	44445541 	strbmi	r5, [r4], #-1345	@ 0xfffffabf
  Timer->timerxcontrol.bits.TimerPre = 0;
     b38:	52465649 	subpl	r5, r6, #76546048	@ 0x4900000
     b3c:	49004341 	stmdbmi	r0, {r0, r6, r8, r9, lr}
     b40:	5644504c 	strbpl	r5, [r4], -ip, asr #32
     b44:	4f005253 	svcmi	0x00005253
     b48:	53495245 	movtpl	r5, #37445	@ 0x9245
     b4c:	72617500 	rsbvc	r7, r1, #0, 10
  Timer->timerxcontrol.bits.IntEnable = 1;
     b50:	736d6974 	cmnvc	sp, #116, 18	@ 0x1d0000
     b54:	45420063 	strbmi	r0, [r2, #-99]	@ 0xffffff9d
     b58:	75004349 	strvc	r4, [r0, #-841]	@ 0xfffffcb7
     b5c:	69747261 	ldmdbvs	r4!, {r0, r5, r6, r9, ip, sp, lr}^
     b60:	00736c66 	rsbseq	r6, r3, r6, ror #24
     b64:	46495852 			@ <UNDEFINED> instruction: 0x46495852
  uint32_t interval_1ms = TIMER_INTERVAL / 100;
     b68:	4c45534c 	mcrrmi	3, 4, r5, r5, cr12
     b6c:	6d695400 	cfstrdvs	mvd5, [r9, #-0]
  Timer->timerxload = interval_1ms;
     b70:	54007265 	strpl	r7, [r0], #-613	@ 0xfffffd9b
     b74:	53495258 	movtpl	r5, #37464	@ 0x9258
     b78:	72617500 	rsbvc	r7, r1, #0, 10
     b7c:	72636974 	rsbvc	r6, r3, #116, 18	@ 0x1d0000
     b80:	6d697400 	cfstrdvs	mvd7, [r9, #-0]
  Timer->timerxcontrol.bits.TimerEn = 1;
     b84:	69787265 	ldmdbvs	r8!, {r0, r2, r5, r6, r9, ip, sp, lr}^
     b88:	6c63746e 	cfstrdvs	mvd7, [r3], #-440	@ 0xfffffe48
     b8c:	58520072 	ldmdapl	r2, {r1, r4, r5, r6}^
     b90:	45414d44 	strbmi	r4, [r1, #-3396]	@ 0xfffff2bc
     b94:	52415500 	subpl	r5, r1, #0, 10
     b98:	53494d54 	movtpl	r4, #40276	@ 0x9d54
  internal_1ms_counter = 0;
     b9c:	7400745f 	strvc	r7, [r0], #-1119	@ 0xfffffba1
     ba0:	72656d69 	rsbvc	r6, r5, #6720	@ 0x1a40
     ba4:	616f6c78 	smcvs	63176	@ 0xf6c8
     ba8:	69740064 	ldmdbvs	r4!, {r2, r5, r6}^
  Hal_interrupt_enable(TIMER_INTERRUPT);
     bac:	7872656d 	ldmdavc	r2!, {r0, r2, r3, r5, r6, r8, sl, sp, lr}^
     bb0:	6f6c6762 	svcvs	0x006c6762
  Hal_interrupt_register_handler(interrupt_handler, TIMER_INTERRUPT);
     bb4:	55006461 	strpl	r6, [r0, #-1121]	@ 0xfffffb9f
     bb8:	49545241 	ldmdbmi	r4, {r0, r6, r9, ip, lr}^
     bbc:	5f534c46 	svcpl	0x00534c46
     bc0:	4d440074 	stclmi	0, cr0, [r4, #-464]	@ 0xfffffe30
}
     bc4:	454e4f41 	strbmi	r4, [lr, #-3905]	@ 0xfffff0bf
     bc8:	68005252 	stmdavs	r0, {r1, r4, r6, r9, ip, lr}
     bcc:	722f6c61 	eorvc	r6, pc, #24832	@ 0x6100
uint32_t Hal_timer_get_1ms_counter(void) {
     bd0:	2f627076 	svccs	0x00627076
     bd4:	73676552 	cmnvc	r7, #343932928	@ 0x14800000
  return internal_1ms_counter;
     bd8:	7500632e 	strvc	r6, [r0, #-814]	@ 0xfffffcd2
     bdc:	6d747261 	lfmvs	f7, 2, [r4, #-388]!	@ 0xfffffe7c
     be0:	52007369 	andpl	r7, r0, #-1543503871	@ 0xa4000001
}
     be4:	53494d54 	movtpl	r4, #40276	@ 0x9d54
     be8:	52415500 	subpl	r5, r1, #0, 10
     bec:	5f524654 	svcpl	0x00524654
     bf0:	54430074 	strbpl	r0, [r3], #-116	@ 0xffffff8c
static void interrupt_handler(void) {
     bf4:	494d5253 	stmdbmi	sp, {r0, r1, r4, r6, r9, ip, lr}^
     bf8:	54430053 	strbpl	r0, [r3], #-83	@ 0xffffffad
  ++internal_1ms_counter;
     bfc:	006e4553 	rsbeq	r4, lr, r3, asr r5
     c00:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     c04:	6f435872 	svcvs	0x00435872
     c08:	6f72746e 	svcvs	0x0072746e
     c0c:	00745f6c 	rsbseq	r5, r4, ip, ror #30
     c10:	54524155 	ldrbpl	r4, [r2], #-341	@ 0xfffffeab
     c14:	44524246 	ldrbmi	r4, [r2], #-582	@ 0xfffffdba
  Timer->timerxintclr = 1;
     c18:	7400745f 	strvc	r7, [r0], #-1119	@ 0xfffffba1
     c1c:	72656d69 	rsbvc	r6, r5, #6720	@ 0x1a40
     c20:	6c617678 	stclvs	6, cr7, [r1], #-480	@ 0xfffffe20
     c24:	75006575 	strvc	r6, [r0, #-1397]	@ 0xfffffa8b
     c28:	66747261 	ldrbtvs	r7, [r4], -r1, ror #4
     c2c:	43440072 	movtmi	r0, #16498	@ 0x4072
     c30:	494d4d44 	stmdbmi	sp, {r2, r6, r8, sl, fp, lr}^
     c34:	69740053 	ldmdbvs	r4!, {r0, r1, r4, r6}^
     c38:	7872656d 	ldmdavc	r2!, {r0, r2, r3, r5, r6, r8, sl, sp, lr}^
void Hal_uart_init(void) {
     c3c:	00736972 	rsbseq	r6, r3, r2, ror r9
     c40:	31304c50 	teqcc	r0, r0, asr ip
  Uart->uartcr.bits.UARTEN = 0;
     c44:	00745f31 	rsbseq	r5, r4, r1, lsr pc
     c48:	45465854 	strbmi	r5, [r6, #-2132]	@ 0xfffff7ac
     c4c:	46585400 	ldrbmi	r5, [r8], -r0, lsl #8
     c50:	54520046 	ldrbpl	r0, [r2], #-70	@ 0xffffffba
     c54:	00534952 	subseq	r4, r3, r2, asr r9
     c58:	54524155 	ldrbpl	r4, [r2], #-341	@ 0xfffffeab
  Uart->uartcr.bits.TXE = 1;
     c5c:	5f534952 	svcpl	0x00534952
     c60:	53440074 	movtpl	r0, #16500	@ 0x4074
     c64:	43494d52 	movtmi	r4, #40274	@ 0x9d52
     c68:	52454200 	subpl	r4, r5, #0, 4
     c6c:	44005349 	strmi	r5, [r0], #-841	@ 0xfffffcb7
     c70:	494d5253 	stmdbmi	sp, {r0, r1, r4, r6, r9, ip, lr}^
  Uart->uartcr.bits.RXE = 1;
     c74:	6954004d 	ldmdbvs	r4, {r0, r2, r3, r6}^
     c78:	5872656d 	ldmdapl	r2!, {r0, r2, r3, r5, r6, r8, sl, sp, lr}^
     c7c:	00534952 	subseq	r4, r3, r2, asr r9
     c80:	44554142 	ldrbmi	r4, [r5], #-322	@ 0xfffffebe
     c84:	49564944 	ldmdbmi	r6, {r2, r6, r8, fp, lr}^
     c88:	5500544e 	strpl	r5, [r0, #-1102]	@ 0xfffffbb2
  Uart->uartcr.bits.UARTEN = 1;
     c8c:	4c545241 	lfmmi	f5, 2, [r4], {65}	@ 0x41
     c90:	485f5243 	ldmdami	pc, {r0, r1, r6, r9, ip, lr}^	@ <UNPREDICTABLE>
     c94:	5500745f 	strpl	r7, [r0, #-1119]	@ 0xfffffba1
     c98:	52545241 	subspl	r5, r4, #268435460	@ 0x10000004
     c9c:	745f5253 	ldrbvc	r5, [pc], #-595	@ ca4 <Hal_uart_init+0x68>
     ca0:	72617500 	rsbvc	r7, r1, #0, 10
  Uart->uartimsc.bits.RXIM = 1;
     ca4:	00726374 	rsbseq	r6, r2, r4, ror r3
     ca8:	32505453 	subscc	r5, r0, #1392508928	@ 0x53000000
     cac:	44585400 	ldrbmi	r5, [r8], #-1024	@ 0xfffffc00
     cb0:	0045414d 	subeq	r4, r5, sp, asr #2
     cb4:	494d4952 	stmdbmi	sp, {r1, r4, r6, r8, fp, lr}^
     cb8:	4546004d 	strbmi	r0, [r6, #-77]	@ 0xffffffb3
  Hal_interrupt_register_handler(interrupt_handler, UART_INTERRUPT0);
     cbc:	00534952 	subseq	r4, r3, r2, asr r9
     cc0:	45746e49 	ldrbmi	r6, [r4, #-3657]!	@ 0xfffff1b7
     cc4:	6c62616e 	stfvse	f6, [r2], #-440	@ 0xfffffe48
     cc8:	41550065 	cmpmi	r5, r5, rrx
}
     ccc:	52445452 	subpl	r5, r4, #1375731712	@ 0x52000000
     cd0:	5500745f 	strpl	r7, [r0, #-1119]	@ 0xfffffba1
void Hal_uart_put_char(uint8_t ch) {
     cd4:	00747261 	rsbseq	r7, r4, r1, ror #4
     cd8:	74726175 	ldrbtvc	r6, [r2], #-373	@ 0xfffffe8b
     cdc:	00727372 	rsbseq	r7, r2, r2, ror r3
     ce0:	656d6974 	strbvs	r6, [sp, #-2420]!	@ 0xfffff68c
     ce4:	6f637872 	svcvs	0x00637872
  while(Uart->uartfr.bits.TXFF);
     ce8:	6f72746e 	svcvs	0x0072746e
     cec:	5854006c 	ldmdapl	r4, {r2, r3, r5, r6}^
     cf0:	55004d49 	strpl	r4, [r0, #-3401]	@ 0xfffff2b7
     cf4:	49545241 	ldmdbmi	r4, {r0, r6, r9, ip, lr}^
     cf8:	745f5243 	ldrbvc	r5, [pc], #-579	@ d00 <Hal_uart_put_char+0x2c>
     cfc:	72617500 	rsbvc	r7, r1, #0, 10
     d00:	706c6974 	rsbvc	r6, ip, r4, ror r9
     d04:	49520072 	ldmdbmi	r2, {r1, r4, r5, r6}^
     d08:	0043494d 	subeq	r4, r3, sp, asr #18
  Uart->uartdr.bits.DATA = (ch & 0xFF);
     d0c:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     d10:	646f4d72 	strbtvs	r4, [pc], #-3442	@ d18 <Hal_uart_put_char+0x44>
     d14:	58520065 	ldmdapl	r2, {r0, r2, r5, r6}^
     d18:	52004546 	andpl	r4, r0, #293601280	@ 0x11800000
     d1c:	00464658 	subeq	r4, r6, r8, asr r6
     d20:	4d525344 	ldclmi	3, cr5, [r2, #-272]	@ 0xfffffef0
     d24:	0053494d 	subseq	r4, r3, sp, asr #18
}
     d28:	4c524953 	mrrcmi	9, 5, r4, r2, cr3	@ <UNPREDICTABLE>
     d2c:	41550050 	cmpmi	r5, r0, asr r0
     d30:	52435452 	subpl	r5, r3, #1375731712	@ 0x52000000
     d34:	5000745f 	andpl	r7, r0, pc, asr r4
uint8_t Hal_uart_get_char(void) {
     d38:	00434945 	subeq	r4, r3, r5, asr #18
     d3c:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     d40:	00745f72 	rsbseq	r5, r4, r2, ror pc
  while(Uart->uartfr.bits.RXFE);
     d44:	656d6954 	strbvs	r6, [sp, #-2388]!	@ 0xfffff6ac
     d48:	65725072 	ldrbvs	r5, [r2, #-114]!	@ 0xffffff8e
     d4c:	53554200 	cmppl	r5, #0, 4
     d50:	61750059 	cmnvs	r5, r9, asr r0
     d54:	62697472 	rsbvs	r7, r9, #1912602624	@ 0x72000000
     d58:	50006472 	andpl	r6, r0, r2, ror r4
     d5c:	53494d45 	movtpl	r4, #40261	@ 0x9d45
     d60:	52495300 	subpl	r5, r9, #0, 6
     d64:	4f004e45 	svcmi	0x00004e45
  data = Uart->uartdr.all;
     d68:	00317475 	eorseq	r7, r1, r5, ror r4
     d6c:	3274754f 	rsbscc	r7, r4, #331350016	@ 0x13c00000
     d70:	52455000 	subpl	r5, r5, #0
     d74:	52005349 	andpl	r5, r0, #603979777	@ 0x24000001
     d78:	00434954 	subeq	r4, r3, r4, asr r9
  if(data & 0xFFFFFF00) {
     d7c:	2f6c6168 	svccs	0x006c6168
     d80:	62707672 	rsbsvs	r7, r0, #119537664	@ 0x7200000
     d84:	6d69542f 	cfstrdvs	mvd5, [r9, #-188]!	@ 0xffffff44
    Uart->uartrsr.all = 0xFF;
     d88:	632e7265 			@ <UNDEFINED> instruction: 0x632e7265
     d8c:	746e6900 	strbtvc	r6, [lr], #-2304	@ 0xfffff700
     d90:	61767265 	cmnvs	r6, r5, ror #4
     d94:	6d315f6c 	ldcvs	15, cr5, [r1, #-432]!	@ 0xfffffe50
     d98:	6e690073 	mcrvs	0, 3, r0, cr9, cr3, {3}
    return 0;
     d9c:	6e726574 	mrcvs	5, 3, r6, cr2, cr4, {3}
     da0:	315f6c61 	cmpcc	pc, r1, ror #24
  return (uint8_t)(data & 0xFF);
     da4:	635f736d 	cmpvs	pc, #-1275068415	@ 0xb4000001
     da8:	746e756f 	strbtvc	r7, [lr], #-1391	@ 0xfffffa91
}
     dac:	48007265 	stmdami	r0, {r0, r2, r5, r6, r9, ip, sp, lr}
     db0:	745f6c61 	ldrbvc	r6, [pc], #-3169	@ db8 <Hal_uart_get_char+0x80>
     db4:	72656d69 	rsbvc	r6, r5, #6720	@ 0x1a40
     db8:	7465675f 	strbtvc	r6, [r5], #-1887	@ 0xfffff8a1
static void interrupt_handler(void) {
     dbc:	736d315f 	cmnvc	sp, #-1073741801	@ 0xc0000017
     dc0:	756f635f 	strbvc	r6, [pc, #-863]!	@ a69 <Hal_timer_init+0x3d>
     dc4:	7265746e 	rsbvc	r7, r5, #1845493760	@ 0x6e000000
  uint8_t ch = Hal_uart_get_char();
     dc8:	746e6900 	strbtvc	r6, [lr], #-2304	@ 0xfffff700
     dcc:	75727265 	ldrbvc	r7, [r2, #-613]!	@ 0xfffffd9b
     dd0:	685f7470 	ldmdavs	pc, {r4, r5, r6, sl, ip, sp, lr}^	@ <UNPREDICTABLE>
  if (ch == 'U') {
     dd4:	6c646e61 	stclvs	14, cr6, [r4], #-388	@ 0xfffffe7c
     dd8:	68007265 	stmdavs	r0, {r0, r2, r5, r6, r9, ip, sp, lr}
     ddc:	722f6c61 	eorvc	r6, pc, #24832	@ 0x6100
    Kernel_send_events(KernelEventFlag_Unlock);
     de0:	2f627076 	svccs	0x00627076
     de4:	74726155 	ldrbtvc	r6, [r2], #-341	@ 0xfffffeab
    return;
     de8:	4800632e 	stmdami	r0, {r1, r2, r3, r5, r8, r9, sp, lr}
  if (ch == 'X') {
     dec:	755f6c61 	ldrbvc	r6, [pc, #-3169]	@ 193 <Kernel_init+0x13>
     df0:	5f747261 	svcpl	0x00747261
     df4:	5f746567 	svcpl	0x00746567
    Kernel_send_events(KernelEventFlag_CmdOut);
     df8:	72616863 	rsbvc	r6, r1, #6488064	@ 0x630000
     dfc:	73696400 	cmnvc	r9, #0, 8
    return;
     e00:	656c6261 	strbvs	r6, [ip, #-609]!	@ 0xfffffd9f
  Hal_uart_put_char(ch);
     e04:	7169665f 	cmnvc	r9, pc, asr r6
     e08:	62696c00 	rsbvs	r6, r9, #0, 24
     e0c:	6d72612f 	ldfvse	f6, [r2, #-188]!	@ 0xffffff44
  Kernel_send_msg(KernelMsgQ_Task0, &ch, 1);
     e10:	2e757063 	cdpcs	0, 7, cr7, cr5, cr3, {3}
     e14:	6e650063 	cdpvs	0, 6, cr0, cr5, cr3, {3}
     e18:	656c6261 	strbvs	r6, [ip, #-609]!	@ 0xfffffd9f
     e1c:	7169665f 	cmnvc	r9, pc, asr r6
     e20:	73696400 	cmnvc	r9, #0, 8
  Kernel_send_events(KernelEventFlag_UartIn);
     e24:	656c6261 	strbvs	r6, [ip, #-609]!	@ 0xfffffd9f
     e28:	7172695f 	cmnvc	r2, pc, asr r9
     e2c:	6f747500 	svcvs	0x00747500
     e30:	00745f61 	rsbseq	r5, r4, r1, ror #30
void enable_irq(void) {
     e34:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
     e38:	625f6674 	subsvs	r6, pc, #116, 12	@ 0x7400000
  __asm__ ("PUSH {r0, r1}");
     e3c:	75006675 	strvc	r6, [r0, #-1653]	@ 0xfffff98b
  __asm__ ("MRS r0, cpsr");
     e40:	5f616f74 	svcpl	0x00616f74
  __asm__ ("BIC r1, r0, #0x80");
     e44:	00636564 	rsbeq	r6, r3, r4, ror #10
  __asm__ ("MSR cpsr, r1");
     e48:	2f62696c 	svccs	0x0062696c
  __asm__ ("POP {r0, r1}");
     e4c:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
}
     e50:	00632e6f 	rsbeq	r2, r3, pc, ror #28
     e54:	746e6975 	strbtvc	r6, [lr], #-2421	@ 0xfffff68b
     e58:	726f6600 	rsbvc	r6, pc, #0, 12
     e5c:	0074616d 	rsbseq	r6, r4, sp, ror #2
void enable_fiq(void) {
     e60:	70615f5f 	rsbvc	r5, r1, pc, asr pc
     e64:	6f747500 	svcvs	0x00747500
  __asm__ ("PUSH {r0, r1}");
     e68:	5f5f0061 	svcpl	0x005f0061
  __asm__ ("MRS r0, cpsr");
     e6c:	6c5f6176 	ldfvse	f6, [pc], {118}	@ 0x76
  __asm__ ("BIC r1, r0, #0x40");
     e70:	00747369 	rsbseq	r7, r4, r9, ror #6
  __asm__ ("MSR cpsr, r1");
     e74:	73677261 	cmnvc	r7, #268435462	@ 0x10000006
  __asm__ ("POP {r0, r1}");
     e78:	6f747500 	svcvs	0x00747500
}
     e7c:	65685f61 	strbvs	r5, [r8, #-3937]!	@ 0xfffff09f
     e80:	73760078 	cmnvc	r6, #120	@ 0x78
     e84:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
     e88:	67006674 	smlsdxvs	r0, r4, r6, r6
void disable_irq(void) {
     e8c:	006c616f 	rsbeq	r6, ip, pc, ror #2
     e90:	2f62696c 	svccs	0x0062696c
  __asm__ ("PUSH {r0, r1}");
     e94:	6c647473 	cfstrdvs	mvd7, [r4], #-460	@ 0xfffffe34
  __asm__ ("MRS r0, cpsr");
     e98:	632e6269 			@ <UNDEFINED> instruction: 0x632e6269
  __asm__ ("ORR r1, r0, #0x80");
     e9c:	72654b00 	rsbvc	r4, r5, #0, 22
  __asm__ ("MSR cpsr, r1");
     ea0:	5f6c656e 	svcpl	0x006c656e
  __asm__ ("POP {r0, r1}");
     ea4:	6e657665 	cdpvs	6, 6, cr7, cr5, cr5, {3}
}
     ea8:	6c665f74 	stclvs	15, cr5, [r6], #-464	@ 0xfffffe30
     eac:	635f6761 	cmpvs	pc, #25427968	@ 0x1840000
     eb0:	6b636568 	blvs	18da458 <cpsr_cp+0x18d71d0>
     eb4:	72654b00 	rsbvc	r4, r5, #0, 22
void disable_fiq(void) {
     eb8:	5f6c656e 	svcpl	0x006c656e
     ebc:	6e657665 	cdpvs	6, 6, cr7, cr5, cr5, {3}
  __asm__ ("PUSH {r0, r1}");
     ec0:	6c665f74 	stclvs	15, cr5, [r6], #-464	@ 0xfffffe30
  __asm__ ("MRS r0, cpsr");
     ec4:	735f6761 	cmpvc	pc, #25427968	@ 0x1840000
  __asm__ ("ORR r1, r0, #0x40");
     ec8:	4b007465 	blmi	1e064 <cpsr_cp+0x1addc>
  __asm__ ("MSR cpsr, r1");
     ecc:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
  __asm__ ("POP {r0, r1}");
     ed0:	76655f6c 	strbtvc	r5, [r5], -ip, ror #30
     ed4:	5f746e65 	svcpl	0x00746e65
     ed8:	67616c66 	strbvs	r6, [r1, -r6, ror #24]!
     edc:	656c635f 	strbvs	r6, [ip, #-863]!	@ 0xfffffca1
     ee0:	6b007261 	blvs	1d86c <cpsr_cp+0x1a5e4>
uint32_t putstr(const char* s) {
     ee4:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     ee8:	76652f6c 	strbtvc	r2, [r5], -ip, ror #30
     eec:	2e746e65 	cdpcs	14, 7, cr6, cr4, cr5, {3}
     ef0:	45730063 	ldrbmi	r0, [r3, #-99]!	@ 0xffffff9d
  uint32_t c = 0;
     ef4:	746e6576 	strbtvc	r6, [lr], #-1398	@ 0xfffffa8a
     ef8:	67616c46 	strbvs	r6, [r1, -r6, asr #24]!
  while(*s) {
     efc:	72654b00 	rsbvc	r4, r5, #0, 22
    Hal_uart_put_char(*s++);
     f00:	5f6c656e 	svcpl	0x006c656e
     f04:	6574756d 	ldrbvs	r7, [r4, #-1389]!	@ 0xfffffa93
     f08:	6e755f78 	mrcvs	15, 3, r5, cr5, cr8, {3}
     f0c:	6b636f6c 	blvs	18dccc4 <cpsr_cp+0x18d9a3c>
     f10:	616e5100 	cmnvs	lr, r0, lsl #2
     f14:	6300656d 	movwvs	r6, #1389	@ 0x56d
    ++c;
     f18:	746e756f 	strbtvc	r7, [lr], #-1391	@ 0xfffffa91
     f1c:	6e657300 	cdpvs	3, 6, cr7, cr5, cr0, {0}
     f20:	676e6964 	strbvs	r6, [lr, -r4, ror #18]!
  while(*s) {
     f24:	6576655f 	ldrbvs	r6, [r6, #-1375]!	@ 0xfffffaa1
     f28:	4b00746e 	blmi	1e0e8 <cpsr_cp+0x1ae60>
     f2c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     f30:	65735f6c 	ldrbvs	r5, [r3, #-3948]!	@ 0xfffff094
  return c;
     f34:	65745f6d 	ldrbvs	r5, [r4, #-3949]!	@ 0xfffff093
}
     f38:	4b007473 	blmi	1e10c <cpsr_cp+0x1ae84>
     f3c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     f40:	756d5f6c 	strbvc	r5, [sp, #-3948]!	@ 0xfffff094
uint32_t debug_printf(const char* format, ...) { 
     f44:	5f786574 	svcpl	0x00786574
     f48:	6b636f6c 	blvs	18dcd00 <cpsr_cp+0x18d9a78>
     f4c:	72656b00 	rsbvc	r6, r5, #0, 22
     f50:	2f6c656e 	svccs	0x006c656e
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
     f54:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     f58:	632e6c65 			@ <UNDEFINED> instruction: 0x632e6c65
  vsprintf(printf_buf, format, args);
     f5c:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     f60:	676e6974 			@ <UNDEFINED> instruction: 0x676e6974
     f64:	73696c5f 	cmnvc	r9, #24320	@ 0x5f00
     f68:	76650074 			@ <UNDEFINED> instruction: 0x76650074
     f6c:	5f746e65 	svcpl	0x00746e65
  return putstr(printf_buf);
     f70:	7473696c 	ldrbtvc	r6, [r3], #-2412	@ 0xfffff694
     f74:	72654b00 	rsbvc	r4, r5, #0, 22
     f78:	5f6c656e 	svcpl	0x006c656e
     f7c:	5167736d 	cmnpl	r7, sp, ror #6
}
     f80:	7165645f 	cmnvc	r5, pc, asr r4
     f84:	65756575 	ldrbvs	r6, [r5, #-1397]!	@ 0xfffffa8b
     f88:	69617700 	stmdbvs	r1!, {r8, r9, sl, ip, sp, lr}^
     f8c:	676e6974 			@ <UNDEFINED> instruction: 0x676e6974
     f90:	6576655f 	ldrbvs	r6, [r6, #-1375]!	@ 0xfffffaa1
uint32_t vsprintf(char* buf, const char* format, va_list arg) {
     f94:	4b00746e 	blmi	1e154 <cpsr_cp+0x1aecc>
     f98:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
     f9c:	61745f6c 	cmnvs	r4, ip, ror #30
     fa0:	735f6b73 	cmpvc	pc, #117760	@ 0x1cc00
     fa4:	74726174 	ldrbtvc	r6, [r2], #-372	@ 0xfffffe8c
     fa8:	72654b00 	rsbvc	r4, r5, #0, 22
  uint32_t c = 0;
     fac:	5f6c656e 	svcpl	0x006c656e
     fb0:	6b736174 	blvs	1cd9588 <cpsr_cp+0x1cd6300>
  for (uint32_t i = 0; format[i]; ++i) {
     fb4:	7465675f 	strbtvc	r6, [r5], #-1887	@ 0xfffff8a1
     fb8:	7275635f 	rsbsvc	r6, r5, #2080374785	@ 0x7c000001
     fbc:	746e6572 	strbtvc	r6, [lr], #-1394	@ 0xfffffa8e
    if (format[i] == '%') {
     fc0:	7361745f 	cmnvc	r1, #1593835520	@ 0x5f000000
     fc4:	64695f6b 	strbtvs	r5, [r9], #-3947	@ 0xfffff095
     fc8:	72654b00 	rsbvc	r4, r5, #0, 22
     fcc:	5f6c656e 	svcpl	0x006c656e
     fd0:	5f6d6573 	svcpl	0x006d6573
     fd4:	656c6572 	strbvs	r6, [ip, #-1394]!	@ 0xfffffa8e
      ++i;
     fd8:	00657361 	rsbeq	r7, r5, r1, ror #6
     fdc:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
     fe0:	6d5f6c65 	ldclvs	12, cr6, [pc, #-404]	@ e54 <enable_irq+0x20>
      switch(format[i]) {
     fe4:	5f516773 	svcpl	0x00516773
     fe8:	75716e65 	ldrbvc	r6, [r1, #-3685]!	@ 0xfffff19b
     fec:	00657565 	rsbeq	r7, r5, r5, ror #10
     ff0:	5f74756f 	svcpl	0x0074756f
     ff4:	61746164 	cmnvs	r4, r4, ror #2
     ff8:	72654b00 	rsbvc	r4, r5, #0, 22
     ffc:	5f6c656e 	svcpl	0x006c656e
    1000:	6b636f6c 	blvs	18dcdb8 <cpsr_cp+0x18d9b30>
    1004:	6d65735f 	stclvs	3, cr7, [r5, #-380]!	@ 0xfffffe84
    1008:	72654b00 	rsbvc	r4, r5, #0, 22
    100c:	5f6c656e 	svcpl	0x006c656e
    1010:	6b736174 	blvs	1cd95e8 <cpsr_cp+0x1cd6360>
    1014:	6863735f 	stmdavs	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, ip, sp, lr}^
    1018:	6c756465 	cfldrdvs	mvd6, [r5], #-404	@ 0xfffffe6c
    101c:	00676e69 	rsbeq	r6, r7, r9, ror #28
    1020:	67734d73 			@ <UNDEFINED> instruction: 0x67734d73
    1024:	75510051 	ldrbvc	r0, [r1, #-81]	@ 0xffffffaf
    1028:	00657565 	rsbeq	r7, r5, r5, ror #10
    102c:	72616572 	rsbvc	r6, r1, #478150656	@ 0x1c800000
    1030:	72654b00 	rsbvc	r4, r5, #0, 22
    1034:	5f6c656e 	svcpl	0x006c656e
    1038:	5167736d 	cmnpl	r7, sp, ror #6
    103c:	5f73695f 	svcpl	0x0073695f
    1040:	6c6c7566 	cfstr64vs	mvdx7, [ip], #-408	@ 0xfffffe68
    1044:	6f726600 	svcvs	0x00726600
    1048:	6b00746e 	blvs	1e208 <cpsr_cp+0x1af80>
    104c:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
    1050:	736d2f6c 	cmnvc	sp, #108, 30	@ 0x1b0
    1054:	00632e67 	rsbeq	r2, r3, r7, ror #28
    1058:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
        ch = (char)va_arg(arg, int32_t);
    105c:	6d5f6c65 	ldclvs	12, cr6, [pc, #-404]	@ ed0 <disable_fiq+0x18>
    1060:	5f516773 	svcpl	0x00516773
    1064:	655f7369 	ldrbvs	r7, [pc, #-873]	@ d03 <Hal_uart_put_char+0x2f>
    1068:	7974706d 	ldmdbvc	r4!, {r0, r2, r3, r5, r6, ip, sp, lr}^
    106c:	72654b00 	rsbvc	r4, r5, #0, 22
        buf[c++] = ch;
    1070:	436c656e 	cmnmi	ip, #461373440	@ 0x1b800000
    1074:	5f517269 	svcpl	0x00517269
    1078:	53730074 	cmnpl	r3, #116	@ 0x74
    107c:	73006d65 	movwvc	r6, #3429	@ 0xd65
    1080:	4d6d6553 	cfstr64mi	mvdx6, [sp, #-332]!	@ 0xfffffeb4
    1084:	73007861 	movwvc	r7, #2145	@ 0x861
    1088:	6574754d 	ldrbvs	r7, [r4, #-1357]!	@ 0xfffffab3
        break;
    108c:	776f0078 			@ <UNDEFINED> instruction: 0x776f0078
        str = (char*)va_arg(arg, char*);
    1090:	0072656e 	rsbseq	r6, r2, lr, ror #10
    1094:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
    1098:	732f6c65 			@ <UNDEFINED> instruction: 0x732f6c65
    109c:	68636e79 	stmdavs	r3!, {r0, r3, r4, r5, r6, r9, sl, fp, sp, lr}^
    10a0:	4b00632e 	blmi	19d60 <cpsr_cp+0x16ad8>
        if (str == NULL) {
    10a4:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
    10a8:	74754d6c 	ldrbtvc	r4, [r5], #-3436	@ 0xfffff294
    10ac:	745f7865 	ldrbvc	r7, [pc], #-2149	@ 10b4 <vsprintf+0x120>
          str = "(null)";
    10b0:	72654b00 	rsbvc	r4, r5, #0, 22
    10b4:	4d6c656e 	cfstr64mi	mvdx6, [ip, #-440]!	@ 0xfffffe48
    10b8:	78657475 	stmdavc	r5!, {r0, r2, r4, r5, r6, sl, ip, sp, lr}^
        while (*str) {
    10bc:	00745f74 	rsbseq	r5, r4, r4, ror pc
          buf[c++] = (*str++);
    10c0:	78654e73 	stmdavc	r5!, {r0, r1, r4, r5, r6, r9, sl, fp, lr}^
    10c4:	63745f74 	cmnvs	r4, #116, 30	@ 0x1d0
    10c8:	654b0062 	strbvs	r0, [fp, #-98]	@ 0xffffff9e
    10cc:	6c656e72 	stclvs	14, cr6, [r5], #-456	@ 0xfffffe38
    10d0:	5f626354 	svcpl	0x00626354
    10d4:	41730074 	cmnmi	r3, r4, ror r0
    10d8:	636f6c6c 	cmnvs	pc, #108, 24	@ 0x6c00
    10dc:	64657461 	strbtvs	r7, [r5], #-1121	@ 0xfffffb9f
    10e0:	6263745f 	rsbvs	r7, r3, #1593835520	@ 0x5f000000
    10e4:	646e695f 	strbtvs	r6, [lr], #-2399	@ 0xfffff6a1
        while (*str) {
    10e8:	73007865 	movwvc	r7, #2149	@ 0x865
    10ec:	00727370 	rsbseq	r7, r2, r0, ror r3
    10f0:	72754373 	rsbsvc	r4, r5, #-872415231	@ 0xcc000001
    10f4:	746e6572 	strbtvc	r6, [lr], #-1394	@ 0xfffffa8e
        break;
    10f8:	6263745f 	rsbvs	r7, r3, #1593835520	@ 0x5f000000
        uint = (uint32_t)va_arg(arg, uint32_t);
    10fc:	75437300 	strbvc	r7, [r3, #-768]	@ 0xfffffd00
    1100:	6e657272 	mcrvs	2, 3, r7, cr5, cr2, {3}
    1104:	63745f74 	cmnvs	r4, #116, 30	@ 0x1d0
    1108:	6e695f62 	cdpvs	15, 6, cr5, cr9, cr2, {3}
    110c:	00786564 	rsbseq	r6, r8, r4, ror #10
        c += utoa(&buf[c], uint, utoa_dec);
    1110:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
    1114:	742f6c65 	strtvc	r6, [pc], #-3173	@ 111c <vsprintf+0x188>
    1118:	2e6b7361 	cdpcs	3, 6, cr7, cr11, cr1, {3}
    111c:	63530063 	cmpvs	r3, #99	@ 0x63
    1120:	75646568 	strbvc	r6, [r4, #-1384]!	@ 0xfffffa98
    1124:	5f72656c 	svcpl	0x0072656c
    1128:	6e756f72 	mrcvs	15, 3, r6, cr5, cr2, {3}
    112c:	6f725f64 	svcvs	0x00725f64
    1130:	006e6962 	rsbeq	r6, lr, r2, ror #18
    1134:	6e72654b 	cdpvs	5, 7, cr6, cr2, cr11, {2}
    1138:	61546c65 	cmpvs	r4, r5, ror #24
        break;
    113c:	6f436b73 	svcvs	0x00436b73
        hex = (uint32_t)va_arg(arg, uint32_t);
    1140:	7865746e 	stmdavc	r5!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}^
    1144:	00745f74 	rsbseq	r5, r4, r4, ror pc
    1148:	72617473 	rsbvc	r7, r1, #1929379840	@ 0x73000000
    114c:	6e754674 	mrcvs	6, 3, r4, cr5, cr4, {3}
    1150:	656e0063 	strbvs	r0, [lr, #-99]!	@ 0xffffff9d
        c += utoa(&buf[c], hex, utoa_hex);
    1154:	63745f77 	cmnvs	r4, #476	@ 0x1dc
    1158:	74730062 	ldrbtvc	r0, [r3], #-98	@ 0xffffff9e
    115c:	5f6b6361 	svcpl	0x006b6361
    1160:	65736162 	ldrbvs	r6, [r3, #-354]!	@ 0xfffffe9e
    1164:	61547300 	cmpvs	r4, r0, lsl #6
    1168:	6c5f6b73 	mrrcvs	11, 7, r6, pc, cr3	@ <UNPREDICTABLE>
    116c:	00747369 	rsbseq	r7, r4, r9, ror #6
    1170:	725f3072 	subsvc	r3, pc, #114	@ 0x72
    1174:	4b003231 	blmi	da40 <cpsr_cp+0xa7b8>
    1178:	656e7265 	strbvs	r7, [lr, #-613]!	@ 0xfffffd9b
    117c:	61745f6c 	cmnvs	r4, ip, ror #30
        break;
    1180:	635f6b73 	cmpvs	pc, #117760	@ 0x1cc00
      buf[c++] = format[i];
    1184:	65746e6f 	ldrbvs	r6, [r4, #-3695]!	@ 0xfffff191
    1188:	735f7478 	cmpvc	pc, #120, 8	@ 0x78000000
    118c:	63746977 	cmnvs	r4, #1949696	@ 0x1dc000
    1190:	676e6968 	strbvs	r6, [lr, -r8, ror #18]!
    1194:	73706300 	cmnvc	r0, #0, 6
    1198:	70635f72 	rsbvc	r5, r3, r2, ror pc
    119c:	2f2e2e00 	svccs	0x002e2e00
    11a0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
    11a4:	696c2f2e 	stmdbvs	ip!, {r1, r2, r3, r5, r8, r9, sl, fp, sp}^
    11a8:	63636762 	cmnvs	r3, #25690112	@ 0x1880000
    if (c >= PRINTF_BUF_LEN) {
    11ac:	6e6f632f 	cdpvs	3, 6, cr6, cr15, cr15, {1}
    11b0:	2f676966 	svccs	0x00676966
    11b4:	2f6d7261 	svccs	0x006d7261
        buf[0] = '\0';
    11b8:	3162696c 	cmncc	r2, ip, ror #18
    11bc:	636e7566 	cmnvs	lr, #427819008	@ 0x19800000
    11c0:	00532e73 	subseq	r2, r3, r3, ror lr
        return 0;
    11c4:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
    11c8:	672f646c 	strvs	r6, [pc, -ip, ror #8]!
  for (uint32_t i = 0; format[i]; ++i) {
    11cc:	612d6363 			@ <UNDEFINED> instruction: 0x612d6363
    11d0:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
    11d4:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	@ 0xfffffe44
    11d8:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
    11dc:	5679782d 	ldrbtpl	r7, [r9], -sp, lsr #16
    11e0:	2f587470 	svccs	0x00587470
    11e4:	2d636367 	stclcs	3, cr6, [r3, #-412]!	@ 0xfffffe64
    11e8:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	@ 0xfffffe7c
    11ec:	656e6f6e 	strbvs	r6, [lr, #-3950]!	@ 0xfffff092
  buf[c] = '\0';
    11f0:	6261652d 	rsbvs	r6, r1, #188743680	@ 0xb400000
    11f4:	32312d69 	eorscc	r2, r1, #6720	@ 0x1a40
    11f8:	722e322e 	eorvc	r3, lr, #-536870910	@ 0xe0000002
    11fc:	2f316c65 	svccs	0x00316c65
    1200:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	@ 0xfffffe78
  return c;
    1204:	72612f64 	rsbvc	r2, r1, #100, 30	@ 0x190
}
    1208:	6f6e2d6d 	svcvs	0x006e2d6d
    120c:	652d656e 	strvs	r6, [sp, #-1390]!	@ 0xfffffa92
    1210:	2f696261 	svccs	0x00696261
uint32_t utoa(char* buf, uint32_t val, utoa_t base) {
    1214:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
    1218:	47006363 	strmi	r6, [r0, -r3, ror #6]
    121c:	4120554e 			@ <UNDEFINED> instruction: 0x4120554e
    1220:	2e322053 	mrccs	0, 1, r2, cr2, cr3, {2}
    1224:	5f003933 	svcpl	0x00003933
    1228:	6964755f 	stmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r8, sl, ip, sp, lr}^
    122c:	33697376 	cmncc	r9, #-671088639	@ 0xd8000001
  uint32_t c = 0;
    1230:	615f5f00 	cmpvs	pc, r0, lsl #30
    1234:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
  int32_t idx = 0;
    1238:	6469755f 	strbtvs	r7, [r9], #-1375	@ 0xfffffaa1
    123c:	6f6d7669 	svcvs	0x006d7669
    uint32_t t = val % (uint32_t)base;
    1240:	5f5f0064 	svcpl	0x005f0064
    1244:	62616561 	rsbvs	r6, r1, #406847488	@ 0x18400000
    1248:	64695f69 	strbtvs	r5, [r9], #-3945	@ 0xfffff097
    124c:	00307669 	eorseq	r7, r0, r9, ror #12
    1250:	65615f5f 	strbvs	r5, [r1, #-3935]!	@ 0xfffff0a1
    1254:	5f696261 	svcpl	0x00696261
    1258:	7669646c 	strbtvc	r6, [r9], -ip, ror #8
    if (t >= 10) {
    125c:	Address 0x125c is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
    LDR PC, reset_handler_addr
   0:	0000000c 	andeq	r0, r0, ip
    LDR PC, undef_handler_addr
   4:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
    LDR PC, svc_handler_addr
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
    LDR PC, pfch_abt_handler_addr
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
    LDR PC, data_abt_handler_addr
  10:	00000028 	andeq	r0, r0, r8, lsr #32
    B .
  14:	00000000 	andeq	r0, r0, r0
    LDR PC, irq_handler_addr
  18:	000000d4 	ldrdeq	r0, [r0], -r4
    LDR PC, fiq_handler_addr
  1c:	0000001c 	andeq	r0, r0, ip, lsl r0
  20:	80200e44 	eorhi	r0, r0, r4, asr #28
  24:	82078108 	andhi	r8, r7, #8, 2
  28:	84058306 	strhi	r8, [r5], #-774	@ 0xfffffcfa
  2c:	8c038b04 			@ <UNDEFINED> instruction: 0x8c038b04
  30:	42018e02 	andmi	r8, r1, #2, 28
  34:	46040b0c 	strmi	r0, [r4], -ip, lsl #22
  38:	00200d0c 	eoreq	r0, r0, ip, lsl #26
    MRS r0, cpsr @ move PSR to Register
  3c:	00000010 	andeq	r0, r0, r0, lsl r0
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	00000000 	andeq	r0, r0, r0
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	000000f0 	strdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
    MSR cpsr, r1 @ 동작 모드 변경
  48:	00000008 	andeq	r0, r0, r8
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	040b0c42 	streq	r0, [fp], #-3138	@ 0xfffff3be
    MRS r0, cpsr
  50:	0000000c 	andeq	r0, r0, ip
    BIC r1, r0, #0x1F
  54:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	7c020001 	stcvc	0, cr0, [r2], {1}
    MSR cpsr, r1
  5c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
    LDR sp, =IRQ_STACK_TOP
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
    MRS r0, cpsr
  64:	00000050 	andeq	r0, r0, r0, asr r0
    BIC r1, r0, #0x1F
  68:	000000f8 	strdeq	r0, [r0], -r8
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	0000006c 	andeq	r0, r0, ip, rrx
    MSR cpsr, r1
  70:	8b080e42 	blhi	203980 <cpsr_cp+0x2006f8>
    LDR sp, =FIQ_STACK_TOP
  74:	42018e02 	andmi	r8, r1, #2, 28
    MRS r0, cpsr
  78:	70040b0c 	andvc	r0, r4, ip, lsl #22
    BIC r1, r0, #0x1F
  7c:	00080d0c 	andeq	r0, r8, ip, lsl #26
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	00000018 	andeq	r0, r0, r8, lsl r0
    MSR cpsr, r1
  84:	00000050 	andeq	r0, r0, r0, asr r0
    LDR sp, =ABT_STACK_TOP
  88:	00000164 	andeq	r0, r0, r4, ror #2
    MRS r0, cpsr
  8c:	0000001c 	andeq	r0, r0, ip, lsl r0
    BIC r1, r0, #0x1F
  90:	8b080e42 	blhi	2039a0 <cpsr_cp+0x200718>
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	42018e02 	andmi	r8, r1, #2, 28
    MSR cpsr, r1
  98:	00040b0c 	andeq	r0, r4, ip, lsl #22
    LDR sp, =UND_STACK_TOP
  9c:	00000018 	andeq	r0, r0, r8, lsl r0
    MRS r0, cpsr
  a0:	00000050 	andeq	r0, r0, r0, asr r0
    BIC r1, r0, #0x1F
  a4:	00000180 	andeq	r0, r0, r0, lsl #3
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	00000058 	andeq	r0, r0, r8, asr r0
    MSR cpsr, r1
  ac:	8b080e42 	blhi	2039bc <cpsr_cp+0x200734>
    LDR sp, =USRSYS_STACK_TOP
  b0:	42018e02 	andmi	r8, r1, #2, 28
    BL main
  b4:	00040b0c 	andeq	r0, r4, ip, lsl #22
    B .
  b8:	0000001c 	andeq	r0, r0, ip, lsl r0
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  bc:	00000050 	andeq	r0, r0, r0, asr r0
    LDR sp, =IRQ_STACK_TOP
  c0:	000001d8 	ldrdeq	r0, [r0], -r8
    LDR sp, =FIQ_STACK_TOP
  c4:	000000bc 	strheq	r0, [r0], -ip
    LDR sp, =ABT_STACK_TOP
  c8:	8b080e42 	blhi	2039d8 <cpsr_cp+0x200750>
    LDR sp, =UND_STACK_TOP
  cc:	42018e02 	andmi	r8, r1, #2, 28
    LDR sp, =USRSYS_STACK_TOP
  d0:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
__attribute__ ((interrupt ("IRQ"))) void Irq_Handler(void) {
  d4:	080d0c58 	stmdaeq	sp, {r3, r4, r6, sl, fp}
  d8:	0000000c 	andeq	r0, r0, ip
  dc:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
  Hal_interrupt_run_handler();
  e0:	7c020001 	stcvc	0, cr0, [r2], {1}
}
  e4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  e8:	0000001c 	andeq	r0, r0, ip, lsl r0
  ec:	000000d8 	ldrdeq	r0, [r0], -r8
__attribute__ ((interrupt ("FIQ"))) void Fiq_Handler(void) {
  f0:	00000340 	andeq	r0, r0, r0, asr #6
  while (true);
  f4:	00000048 	andeq	r0, r0, r8, asr #32
void main(void) {
  f8:	8b080e42 	blhi	203a08 <cpsr_cp+0x200780>
  fc:	42018e02 	andmi	r8, r1, #2, 28
 100:	5e040b0c 	vmlapl.f64	d0, d4, d12
  Hw_init();
 104:	00080d0c 	andeq	r0, r8, ip, lsl #26
  Kernel_init();
 108:	0000001c 	andeq	r0, r0, ip, lsl r0
  uint32_t i = 100;
 10c:	000000d8 	ldrdeq	r0, [r0], -r8
 110:	00000388 	andeq	r0, r0, r8, lsl #7
  while(i--) {
 114:	00000078 	andeq	r0, r0, r8, ror r0
    Hal_uart_put_char('N');
 118:	8b080e42 	blhi	203a28 <cpsr_cp+0x2007a0>
 11c:	42018e02 	andmi	r8, r1, #2, 28
  while(i--) {
 120:	76040b0c 	strvc	r0, [r4], -ip, lsl #22
 124:	00080d0c 	andeq	r0, r8, ip, lsl #26
 128:	00000018 	andeq	r0, r0, r8, lsl r0
 12c:	000000d8 	ldrdeq	r0, [r0], -r8
 130:	00000400 	andeq	r0, r0, r0, lsl #8
  Hal_uart_put_char('\n');
 134:	00000174 	andeq	r0, r0, r4, ror r1
 138:	8b080e42 	blhi	203a48 <cpsr_cp+0x2007c0>
  putstr("Hello World!\n");
 13c:	42018e02 	andmi	r8, r1, #2, 28
 140:	00040b0c 	andeq	r0, r4, ip, lsl #22
 144:	00000018 	andeq	r0, r0, r8, lsl r0
  Printf_test();
 148:	000000d8 	ldrdeq	r0, [r0], -r8
  Hal_interrupt_enable(UART_INTERRUPT0);
 14c:	00000574 	andeq	r0, r0, r4, ror r5
 150:	000000dc 	ldrdeq	r0, [r0], -ip
  Kernel_start();
 154:	8b080e42 	blhi	203a64 <cpsr_cp+0x2007dc>
}
 158:	42018e02 	andmi	r8, r1, #2, 28
 15c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 160:	00000018 	andeq	r0, r0, r8, lsl r0
static void Hw_init(void){
 164:	000000d8 	ldrdeq	r0, [r0], -r8
 168:	00000650 	andeq	r0, r0, r0, asr r6
  Hal_interrupt_init();
 16c:	0000003c 	andeq	r0, r0, ip, lsr r0
  Hal_uart_init();
 170:	8b080e42 	blhi	203a80 <cpsr_cp+0x2007f8>
  Hal_timer_init();
 174:	42018e02 	andmi	r8, r1, #2, 28
}
 178:	00040b0c 	andeq	r0, r4, ip, lsl #22
 17c:	0000000c 	andeq	r0, r0, ip
static void Kernel_init(void) {
 180:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 184:	7c020001 	stcvc	0, cr0, [r2], {1}
  Kernel_task_init();
 188:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  Kernel_event_flag_init();
 18c:	0000001c 	andeq	r0, r0, ip, lsl r0
  Kernel_msgQ_init();
 190:	0000017c 	andeq	r0, r0, ip, ror r1
  Kernel_sem_init(1);
 194:	00000734 	andeq	r0, r0, r4, lsr r7
 198:	0000009c 	muleq	r0, ip, r0
  Kernel_mutex_init();
 19c:	8b080e42 	blhi	203aac <cpsr_cp+0x200824>
  add_task(User_task0, 0);
 1a0:	42018e02 	andmi	r8, r1, #2, 28
 1a4:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 1a8:	080d0c48 	stmdaeq	sp, {r3, r6, sl, fp}
 1ac:	0000001c 	andeq	r0, r0, ip, lsl r0
  add_task(User_task1, 1);
 1b0:	0000017c 	andeq	r0, r0, ip, ror r1
 1b4:	000007d0 	ldrdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
 1b8:	000000cc 	andeq	r0, r0, ip, asr #1
 1bc:	8b040e42 	blhi	103acc <cpsr_cp+0x100844>
  add_task(User_task2, 2);
 1c0:	0b0d4201 	bleq	3509cc <cpsr_cp+0x34d744>
 1c4:	0d0d5e02 	stceq	14, cr5, [sp, #-8]
 1c8:	000ecb42 	andeq	ip, lr, r2, asr #22
 1cc:	0000001c 	andeq	r0, r0, ip, lsl r0
}
 1d0:	0000017c 	andeq	r0, r0, ip, ror r1
 1d4:	0000089c 	muleq	r0, ip, r8
static void Printf_test(void) {
 1d8:	000000d4 	ldrdeq	r0, [r0], -r4
 1dc:	8b040e42 	blhi	103aec <cpsr_cp+0x100864>
 1e0:	0b0d4201 	bleq	3509ec <cpsr_cp+0x34d764>
  char* str = "printf pointer test";
 1e4:	0d0d6202 	sfmeq	f6, 4, [sp, #-8]
 1e8:	000ecb42 	andeq	ip, lr, r2, asr #22
 1ec:	0000001c 	andeq	r0, r0, ip, lsl r0
  char* nullptr = 0;
 1f0:	0000017c 	andeq	r0, r0, ip, ror r1
 1f4:	00000970 	andeq	r0, r0, r0, ror r9
  uint32_t i = 5;
 1f8:	00000038 	andeq	r0, r0, r8, lsr r0
 1fc:	8b040e42 	blhi	103b0c <cpsr_cp+0x100884>
  debug_printf("%s\n", "Hello printf");
 200:	0b0d4201 	bleq	350a0c <cpsr_cp+0x34d784>
 204:	420d0d54 	andmi	r0, sp, #84, 26	@ 0x1500
 208:	00000ecb 	andeq	r0, r0, fp, asr #29
 20c:	0000001c 	andeq	r0, r0, ip, lsl r0
 210:	0000017c 	andeq	r0, r0, ip, ror r1
  debug_printf("output string pointer: %s\n", str);
 214:	000009a8 	andeq	r0, r0, r8, lsr #19
 218:	00000084 	andeq	r0, r0, r4, lsl #1
 21c:	8b080e42 	blhi	203b2c <cpsr_cp+0x2008a4>
 220:	42018e02 	andmi	r8, r1, #2, 28
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
 224:	7c040b0c 			@ <UNDEFINED> instruction: 0x7c040b0c
 228:	00080d0c 	andeq	r0, r8, ip, lsl #26
 22c:	0000000c 	andeq	r0, r0, ip
 230:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 234:	7c020001 	stcvc	0, cr0, [r2], {1}
  debug_printf("%u = 5\n", i);
 238:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 23c:	0000001c 	andeq	r0, r0, ip, lsl r0
 240:	0000022c 	andeq	r0, r0, ip, lsr #4
 244:	00000a2c 	andeq	r0, r0, ip, lsr #20
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
 248:	000001a4 	andeq	r0, r0, r4, lsr #3
 24c:	8b080e42 	blhi	203b5c <cpsr_cp+0x2008d4>
 250:	42018e02 	andmi	r8, r1, #2, 28
 254:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 258:	080d0ccc 	stmdaeq	sp, {r2, r3, r6, r7, sl, fp}
  debug_printf("print zero %u\n", 0);
 25c:	0000001c 	andeq	r0, r0, ip, lsl r0
 260:	0000022c 	andeq	r0, r0, ip, lsr #4
 264:	00000bd0 	ldrdeq	r0, [r0], -r0	@ <UNPREDICTABLE>
 268:	00000024 	andeq	r0, r0, r4, lsr #32
  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
 26c:	8b040e42 	blhi	103b7c <cpsr_cp+0x1008f4>
 270:	0b0d4201 	bleq	350a7c <cpsr_cp+0x34d7f4>
 274:	420d0d4a 	andmi	r0, sp, #4736	@ 0x1280
 278:	00000ecb 	andeq	r0, r0, fp, asr #29
 27c:	0000001c 	andeq	r0, r0, ip, lsl r0
 280:	0000022c 	andeq	r0, r0, ip, lsr #4
 284:	00000bf4 	strdeq	r0, [r0], -r4
 288:	00000048 	andeq	r0, r0, r8, asr #32
 28c:	8b040e42 	blhi	103b9c <cpsr_cp+0x100914>
 290:	0b0d4201 	bleq	350a9c <cpsr_cp+0x34d814>
 294:	420d0d5c 	andmi	r0, sp, #92, 26	@ 0x1700
 298:	00000ecb 	andeq	r0, r0, fp, asr #29
 29c:	0000000c 	andeq	r0, r0, ip
 2a0:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 2a4:	7c020001 	stcvc	0, cr0, [r2], {1}
 2a8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 2ac:	00000018 	andeq	r0, r0, r8, lsl r0
 2b0:	0000029c 	muleq	r0, ip, r2
 2b4:	00000c3c 	andeq	r0, r0, ip, lsr ip
 2b8:	00000098 	muleq	r0, r8, r0
 2bc:	8b080e42 	blhi	203bcc <cpsr_cp+0x200944>
 2c0:	42018e02 	andmi	r8, r1, #2, 28
 2c4:	00040b0c 	andeq	r0, r4, ip, lsl #22
 2c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2cc:	0000029c 	muleq	r0, ip, r2
 2d0:	00000cd4 	ldrdeq	r0, [r0], -r4
 2d4:	00000064 	andeq	r0, r0, r4, rrx
 2d8:	8b040e42 	blhi	103be8 <cpsr_cp+0x100960>
 2dc:	0b0d4201 	bleq	350ae8 <cpsr_cp+0x34d860>
 2e0:	420d0d6a 	andmi	r0, sp, #6784	@ 0x1a80
 2e4:	00000ecb 	andeq	r0, r0, fp, asr #29
 2e8:	0000001c 	andeq	r0, r0, ip, lsl r0
 2ec:	0000029c 	muleq	r0, ip, r2
 2f0:	00000d38 	andeq	r0, r0, r8, lsr sp
 2f4:	00000084 	andeq	r0, r0, r4, lsl #1
 2f8:	8b040e42 	blhi	103c08 <cpsr_cp+0x100980>
 2fc:	0b0d4201 	bleq	350b08 <cpsr_cp+0x34d880>
 300:	420d0d7a 	andmi	r0, sp, #7808	@ 0x1e80
 304:	00000ecb 	andeq	r0, r0, fp, asr #29
 308:	0000001c 	andeq	r0, r0, ip, lsl r0
 30c:	0000029c 	muleq	r0, ip, r2
 310:	00000dbc 			@ <UNDEFINED> instruction: 0x00000dbc
 314:	00000078 	andeq	r0, r0, r8, ror r0
 318:	8b080e42 	blhi	203c28 <cpsr_cp+0x2009a0>
 31c:	42018e02 	andmi	r8, r1, #2, 28
 320:	76040b0c 	strvc	r0, [r4], -ip, lsl #22
 324:	00080d0c 	andeq	r0, r8, ip, lsl #26
 328:	0000000c 	andeq	r0, r0, ip
 32c:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 330:	7c020001 	stcvc	0, cr0, [r2], {1}
 334:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 338:	0000001c 	andeq	r0, r0, ip, lsl r0
 33c:	00000328 	andeq	r0, r0, r8, lsr #6
void add_task(KernelTaskFunc_t f, uint32_t t_id) {
 340:	00000e34 	andeq	r0, r0, r4, lsr lr
 344:	0000002c 	andeq	r0, r0, ip, lsr #32
 348:	8b040e42 	blhi	103c58 <cpsr_cp+0x1009d0>
 34c:	0b0d4201 	bleq	350b58 <cpsr_cp+0x34d8d0>
 350:	420d0d4e 	andmi	r0, sp, #4992	@ 0x1380
  taskId = Kernel_task_create(f);
 354:	00000ecb 	andeq	r0, r0, fp, asr #29
 358:	0000001c 	andeq	r0, r0, ip, lsl r0
 35c:	00000328 	andeq	r0, r0, r8, lsr #6
  if (taskId == NOT_ENOUGH_TASK_NUM) {
 360:	00000e60 	andeq	r0, r0, r0, ror #28
 364:	0000002c 	andeq	r0, r0, ip, lsr #32
 368:	8b040e42 	blhi	103c78 <cpsr_cp+0x1009f0>
    debug_printf("Task%u creation fail\n", t_id);
 36c:	0b0d4201 	bleq	350b78 <cpsr_cp+0x34d8f0>
 370:	420d0d4e 	andmi	r0, sp, #4992	@ 0x1380
 374:	00000ecb 	andeq	r0, r0, fp, asr #29
 378:	0000001c 	andeq	r0, r0, ip, lsl r0
}
 37c:	00000328 	andeq	r0, r0, r8, lsr #6
 380:	00000e8c 	andeq	r0, r0, ip, lsl #29
 384:	0000002c 	andeq	r0, r0, ip, lsr #32
static void Test_critical_section(uint32_t p, uint32_t taskId) {
 388:	8b040e42 	blhi	103c98 <cpsr_cp+0x100a10>
 38c:	0b0d4201 	bleq	350b98 <cpsr_cp+0x34d910>
 390:	420d0d4e 	andmi	r0, sp, #4992	@ 0x1380
 394:	00000ecb 	andeq	r0, r0, fp, asr #29
 398:	0000001c 	andeq	r0, r0, ip, lsl r0
  Kernel_lock_mutex();
 39c:	00000328 	andeq	r0, r0, r8, lsr #6
  debug_printf("User Task #%u Send=%u\n", taskId, p);
 3a0:	00000eb8 			@ <UNDEFINED> instruction: 0x00000eb8
 3a4:	0000002c 	andeq	r0, r0, ip, lsr #32
 3a8:	8b040e42 	blhi	103cb8 <cpsr_cp+0x100a30>
 3ac:	0b0d4201 	bleq	350bb8 <cpsr_cp+0x34d930>
 3b0:	420d0d4e 	andmi	r0, sp, #4992	@ 0x1380
  shared_value = p;
 3b4:	00000ecb 	andeq	r0, r0, fp, asr #29
 3b8:	0000000c 	andeq	r0, r0, ip
 3bc:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 3c0:	7c020001 	stcvc	0, cr0, [r2], {1}
  Kernel_yield();
 3c4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  delay(1000);
 3c8:	0000001c 	andeq	r0, r0, ip, lsl r0
 3cc:	000003b8 			@ <UNDEFINED> instruction: 0x000003b8
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
 3d0:	00000ee4 	andeq	r0, r0, r4, ror #29
 3d4:	00000060 	andeq	r0, r0, r0, rrx
 3d8:	8b080e42 	blhi	203ce8 <cpsr_cp+0x200a60>
 3dc:	42018e02 	andmi	r8, r1, #2, 28
 3e0:	6a040b0c 	bvs	103018 <cpsr_cp+0xffd90>
 3e4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3e8:	00000034 	andeq	r0, r0, r4, lsr r0
 3ec:	000003b8 			@ <UNDEFINED> instruction: 0x000003b8
  Kernel_unlock_mutex();
 3f0:	00000f44 	andeq	r0, r0, r4, asr #30
}
 3f4:	00000050 	andeq	r0, r0, r0, asr r0
 3f8:	80100e42 	andshi	r0, r0, r2, asr #28
 3fc:	82038104 	andhi	r8, r3, #4, 2
void User_task0(void) {
 400:	42018302 	andmi	r8, r1, #134217728	@ 0x8000000
 404:	068b180e 	streq	r1, [fp], lr, lsl #16
 408:	0c42058e 	cfstr64eq	mvdx0, [r2], {142}	@ 0x8e
  uint32_t local = 0;
 40c:	0c5c140b 	cfldrdeq	mvd1, [ip], {11}
 410:	ce42180d 	cdpgt	8, 4, cr1, cr2, cr13, {0}
  debug_printf("User Task #0 SP=0x%x\n", &local);
 414:	42100ecb 	andsmi	r0, r0, #3248	@ 0xcb0
 418:	c0c1c2c3 	sbcgt	ip, r1, r3, asr #5
 41c:	0000000e 	andeq	r0, r0, lr
 420:	00000020 	andeq	r0, r0, r0, lsr #32
 424:	000003b8 			@ <UNDEFINED> instruction: 0x000003b8
  uint8_t cmdBufIdx = 0;
 428:	00000f94 	muleq	r0, r4, pc	@ <UNPREDICTABLE>
 42c:	00000280 	andeq	r0, r0, r0, lsl #5
  uint8_t uartch = 0;
 430:	8b080e42 	blhi	203d40 <cpsr_cp+0x200ab8>
 434:	42018e02 	andmi	r8, r1, #2, 28
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
 438:	03040b0c 	movweq	r0, #19212	@ 0x4b0c
 43c:	0d0c013a 	stfeqs	f0, [ip, #-232]	@ 0xffffff18
 440:	00000008 	andeq	r0, r0, r8
    switch(handle_event) {
 444:	0000001c 	andeq	r0, r0, ip, lsl r0
 448:	000003b8 			@ <UNDEFINED> instruction: 0x000003b8
 44c:	00001214 	andeq	r1, r0, r4, lsl r2
 450:	00000108 	andeq	r0, r0, r8, lsl #2
 454:	8b080e42 	blhi	203d64 <cpsr_cp+0x200adc>
 458:	42018e02 	andmi	r8, r1, #2, 28
 45c:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);
 460:	080d0c7e 	stmdaeq	sp, {r1, r2, r3, r4, r5, r6, sl, fp}
 464:	0000000c 	andeq	r0, r0, ip
 468:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 46c:	7c020001 	stcvc	0, cr0, [r2], {1}
 470:	000d0c0e 	andeq	r0, sp, lr, lsl #24
      if (uartch == '\r') {
 474:	0000001c 	andeq	r0, r0, ip, lsl r0
 478:	00000464 	andeq	r0, r0, r4, ror #8
 47c:	00001324 	andeq	r1, r0, r4, lsr #6
        cmdBuf[cmdBufIdx] = '\0';
 480:	0000004c 	andeq	r0, r0, ip, asr #32
 484:	8b080e42 	blhi	203d94 <cpsr_cp+0x200b0c>
 488:	42018e02 	andmi	r8, r1, #2, 28
 48c:	60040b0c 	andvs	r0, r4, ip, lsl #22
 490:	00080d0c 	andeq	r0, r8, ip, lsl #26
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
 494:	0000000c 	andeq	r0, r0, ip
 498:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 49c:	7c020001 	stcvc	0, cr0, [r2], {1}
 4a0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a8:	00000494 	muleq	r0, r4, r4
 4ac:	00001370 	andeq	r1, r0, r0, ror r3
 4b0:	00000028 	andeq	r0, r0, r8, lsr #32
 4b4:	8b040e42 	blhi	103dc4 <cpsr_cp+0x100b3c>
 4b8:	0b0d4201 	bleq	350cc4 <cpsr_cp+0x34da3c>
            Kernel_yield();
 4bc:	420d0d4c 	andmi	r0, sp, #76, 26	@ 0x1300
 4c0:	00000ecb 	andeq	r0, r0, fp, asr #29
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
 4c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c8:	00000494 	muleq	r0, r4, r4
 4cc:	00001398 	muleq	r0, r8, r3
 4d0:	00000040 	andeq	r0, r0, r0, asr #32
 4d4:	8b040e42 	blhi	103de4 <cpsr_cp+0x100b5c>
 4d8:	0b0d4201 	bleq	350ce4 <cpsr_cp+0x34da5c>
 4dc:	420d0d58 	andmi	r0, sp, #88, 26	@ 0x1600
 4e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 4e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 4e8:	00000494 	muleq	r0, r4, r4
 4ec:	000013d8 	ldrdeq	r1, [r0], -r8
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
 4f0:	00000044 	andeq	r0, r0, r4, asr #32
 4f4:	8b040e42 	blhi	103e04 <cpsr_cp+0x100b7c>
 4f8:	0b0d4201 	bleq	350d04 <cpsr_cp+0x34da7c>
 4fc:	420d0d5a 	andmi	r0, sp, #5760	@ 0x1680
 500:	00000ecb 	andeq	r0, r0, fp, asr #29
            Kernel_yield();
 504:	0000001c 	andeq	r0, r0, ip, lsl r0
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
 508:	00000494 	muleq	r0, r4, r4
            break;
 50c:	0000141c 	andeq	r1, r0, ip, lsl r4
        Kernel_send_events(KernelEventFlag_CmdIn);
 510:	0000004c 	andeq	r0, r0, ip, asr #32
 514:	8b080e42 	blhi	203e24 <cpsr_cp+0x200b9c>
        cmdBufIdx = 0;
 518:	42018e02 	andmi	r8, r1, #2, 28
 51c:	60040b0c 	andvs	r0, r4, ip, lsl #22
      break;
 520:	00080d0c 	andeq	r0, r8, ip, lsl #26
        cmdBuf[cmdBufIdx] = uartch;
 524:	0000000c 	andeq	r0, r0, ip
 528:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 52c:	7c020001 	stcvc	0, cr0, [r2], {1}
 530:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 534:	00000018 	andeq	r0, r0, r8, lsl r0
        cmdBufIdx = (cmdBufIdx + 1) % 16;
 538:	00000524 	andeq	r0, r0, r4, lsr #10
 53c:	00001468 	andeq	r1, r0, r8, ror #8
 540:	00000014 	andeq	r0, r0, r4, lsl r0
 544:	8b080e42 	blhi	203e54 <cpsr_cp+0x200bcc>
 548:	42018e02 	andmi	r8, r1, #2, 28
 54c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 550:	00000018 	andeq	r0, r0, r8, lsl r0
 554:	00000524 	andeq	r0, r0, r4, lsr #10
      break;
 558:	0000147c 	andeq	r1, r0, ip, ror r4
      Test_critical_section(5, 0);
 55c:	00000014 	andeq	r0, r0, r4, lsl r0
 560:	8b080e42 	blhi	203e70 <cpsr_cp+0x200be8>
 564:	42018e02 	andmi	r8, r1, #2, 28
      break;
 568:	00040b0c 	andeq	r0, r4, ip, lsl #22
    Kernel_yield();
 56c:	0000001c 	andeq	r0, r0, ip, lsl r0
  while(true) {
 570:	00000524 	andeq	r0, r0, r4, lsr #10
void User_task1(void) {
 574:	00001490 	muleq	r0, r0, r4
 578:	00000088 	andeq	r0, r0, r8, lsl #1
 57c:	8b080e42 	blhi	203e8c <cpsr_cp+0x200c04>
  uint32_t local = 0;
 580:	42018e02 	andmi	r8, r1, #2, 28
 584:	7e040b0c 	vmlavc.f64	d0, d4, d12
  debug_printf("User Task #1 SP=0x%x\n", &local);
 588:	00080d0c 	andeq	r0, r8, ip, lsl #26
 58c:	0000001c 	andeq	r0, r0, ip, lsl r0
 590:	00000524 	andeq	r0, r0, r4, lsr #10
 594:	00001518 	andeq	r1, r0, r8, lsl r5
 598:	0000009c 	muleq	r0, ip, r0
  uint8_t cmdlen = 0;
 59c:	8b080e42 	blhi	203eac <cpsr_cp+0x200c24>
 5a0:	42018e02 	andmi	r8, r1, #2, 28
  uint8_t cmd[16] = {0, };
 5a4:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 5a8:	080d0c48 	stmdaeq	sp, {r3, r6, sl, fp}
 5ac:	0000001c 	andeq	r0, r0, ip, lsl r0
 5b0:	00000524 	andeq	r0, r0, r4, lsr #10
 5b4:	000015b4 			@ <UNDEFINED> instruction: 0x000015b4
 5b8:	000000d8 	ldrdeq	r0, [r0], -r8
 5bc:	8b080e42 	blhi	203ecc <cpsr_cp+0x200c44>
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
 5c0:	42018e02 	andmi	r8, r1, #2, 28
 5c4:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 5c8:	080d0c66 	stmdaeq	sp, {r1, r2, r5, r6, sl, fp}
    switch(handle_event) {
 5cc:	0000001c 	andeq	r0, r0, ip, lsl r0
 5d0:	00000524 	andeq	r0, r0, r4, lsr #10
 5d4:	0000168c 	andeq	r1, r0, ip, lsl #13
 5d8:	00000094 	muleq	r0, r4, r0
 5dc:	8b080e42 	blhi	203eec <cpsr_cp+0x200c64>
 5e0:	42018e02 	andmi	r8, r1, #2, 28
 5e4:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
 5e8:	080d0c44 	stmdaeq	sp, {r2, r6, sl, fp}
 5ec:	00000018 	andeq	r0, r0, r8, lsl r0
 5f0:	00000524 	andeq	r0, r0, r4, lsr #10
 5f4:	00001720 	andeq	r1, r0, r0, lsr #14
 5f8:	00000034 	andeq	r0, r0, r4, lsr r0
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
 5fc:	8b080e42 	blhi	203f0c <cpsr_cp+0x200c84>
 600:	42018e02 	andmi	r8, r1, #2, 28
 604:	00040b0c 	andeq	r0, r4, ip, lsl #22
 608:	00000018 	andeq	r0, r0, r8, lsl r0
 60c:	00000524 	andeq	r0, r0, r4, lsr #10
 610:	00001754 	andeq	r1, r0, r4, asr r7
      cmd[cmdlen] = 0;
 614:	00000014 	andeq	r0, r0, r4, lsl r0
 618:	8b080e42 	blhi	203f28 <cpsr_cp+0x200ca0>
 61c:	42018e02 	andmi	r8, r1, #2, 28
 620:	00040b0c 	andeq	r0, r4, ip, lsl #22
 624:	0000001c 	andeq	r0, r0, ip, lsl r0
      debug_printf("\nRecv Cmd: %s\n", cmd);
 628:	00000524 	andeq	r0, r0, r4, lsr #10
 62c:	00001768 	andeq	r1, r0, r8, ror #14
 630:	00000048 	andeq	r0, r0, r8, asr #32
 634:	8b080e42 	blhi	203f44 <cpsr_cp+0x200cbc>
 638:	42018e02 	andmi	r8, r1, #2, 28
      break;
 63c:	5e040b0c 	vmlapl.f64	d0, d4, d12
      Kernel_unlock_sem();
 640:	00080d0c 	andeq	r0, r8, ip, lsl #26
      break;
 644:	0000001c 	andeq	r0, r0, ip, lsl r0
    Kernel_yield();
 648:	00000524 	andeq	r0, r0, r4, lsr #10
  while(true) {
 64c:	000017b0 			@ <UNDEFINED> instruction: 0x000017b0
void User_task2(void) {
 650:	00000040 	andeq	r0, r0, r0, asr #32
 654:	8b080e42 	blhi	203f64 <cpsr_cp+0x200cdc>
 658:	42018e02 	andmi	r8, r1, #2, 28
  uint32_t local = 0;
 65c:	5a040b0c 	bpl	103294 <cpsr_cp+0x10000c>
 660:	00080d0c 	andeq	r0, r8, ip, lsl #26
  debug_printf("User Task #2 SP=0x%x\n", &local);
 664:	0000000c 	andeq	r0, r0, ip
 668:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 66c:	7c020001 	stcvc	0, cr0, [r2], {1}
 670:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 674:	0000001c 	andeq	r0, r0, ip, lsl r0
    Test_critical_section(3, 2);
 678:	00000664 	andeq	r0, r0, r4, ror #12
 67c:	000017f0 	strdeq	r1, [r0], -r0
 680:	00000088 	andeq	r0, r0, r8, lsl #1
    Kernel_yield();
 684:	8b040e42 	blhi	103f94 <cpsr_cp+0x100d0c>
    Test_critical_section(3, 2);
 688:	0b0d4201 	bleq	350e94 <cpsr_cp+0x34dc0c>
 68c:	420d0d7c 	andmi	r0, sp, #124, 26	@ 0x1f00
 690:	00000ecb 	andeq	r0, r0, fp, asr #29
 694:	0000001c 	andeq	r0, r0, ip, lsl r0
 698:	00000664 	andeq	r0, r0, r4, ror #12
 69c:	00001878 	andeq	r1, r0, r8, ror r8
 6a0:	00000088 	andeq	r0, r0, r8, lsl #1
 6a4:	8b040e42 	blhi	103fb4 <cpsr_cp+0x100d2c>
 6a8:	0b0d4201 	bleq	350eb4 <cpsr_cp+0x34dc2c>
 6ac:	420d0d7c 	andmi	r0, sp, #124, 26	@ 0x1f00
 6b0:	00000ecb 	andeq	r0, r0, fp, asr #29
 6b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 6b8:	00000664 	andeq	r0, r0, r4, ror #12
 6bc:	00001900 	andeq	r1, r0, r0, lsl #18
 6c0:	00000090 	muleq	r0, r0, r0
 6c4:	8b040e42 	blhi	103fd4 <cpsr_cp+0x100d4c>
 6c8:	0b0d4201 	bleq	350ed4 <cpsr_cp+0x34dc4c>
 6cc:	0d0d4002 	stceq	0, cr4, [sp, #-8]
 6d0:	000ecb42 	andeq	ip, lr, r2, asr #22
 6d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 6d8:	00000664 	andeq	r0, r0, r4, ror #12
 6dc:	00001990 	muleq	r0, r0, r9
 6e0:	00000134 	andeq	r0, r0, r4, lsr r1
 6e4:	8b080e42 	blhi	203ff4 <cpsr_cp+0x200d6c>
 6e8:	42018e02 	andmi	r8, r1, #2, 28
 6ec:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 6f0:	080d0c94 	stmdaeq	sp, {r2, r4, r7, sl, fp}
 6f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 6f8:	00000664 	andeq	r0, r0, r4, ror #12
 6fc:	00001ac4 	andeq	r1, r0, r4, asr #21
 700:	0000011c 	andeq	r0, r0, ip, lsl r1
 704:	8b080e42 	blhi	204014 <cpsr_cp+0x200d8c>
 708:	42018e02 	andmi	r8, r1, #2, 28
 70c:	02040b0c 	andeq	r0, r4, #12, 22	@ 0x3000
 710:	080d0c88 	stmdaeq	sp, {r3, r7, sl, fp}
 714:	0000000c 	andeq	r0, r0, ip
 718:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 71c:	7c020001 	stcvc	0, cr0, [r2], {1}
 720:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 724:	0000001c 	andeq	r0, r0, ip, lsl r0
 728:	00000714 	andeq	r0, r0, r4, lsl r7
 72c:	00001be0 	andeq	r1, r0, r0, ror #23
 730:	00000054 	andeq	r0, r0, r4, asr r0
void Hal_interrupt_init(void) {
 734:	8b040e42 	blhi	104044 <cpsr_cp+0x100dbc>
 738:	0b0d4201 	bleq	350f44 <cpsr_cp+0x34dcbc>
 73c:	420d0d62 	andmi	r0, sp, #6272	@ 0x1880
  GicCpu->cpucontrol.bits.Enable = 1;
 740:	00000ecb 	andeq	r0, r0, fp, asr #29
 744:	0000001c 	andeq	r0, r0, ip, lsl r0
 748:	00000714 	andeq	r0, r0, r4, lsl r7
 74c:	00001c34 	andeq	r1, r0, r4, lsr ip
 750:	00000054 	andeq	r0, r0, r4, asr r0
 754:	8b040e42 	blhi	104064 <cpsr_cp+0x100ddc>
  GicCpu->prioritymask.bits.Prioritymask = GIC_PRIORITY_MASK_NONE;
 758:	0b0d4201 	bleq	350f64 <cpsr_cp+0x34dcdc>
 75c:	420d0d62 	andmi	r0, sp, #6272	@ 0x1880
 760:	00000ecb 	andeq	r0, r0, fp, asr #29
 764:	0000001c 	andeq	r0, r0, ip, lsl r0
 768:	00000714 	andeq	r0, r0, r4, lsl r7
 76c:	00001c88 	andeq	r1, r0, r8, lsl #25
  GicDist->distributorctrl.bits.Enable = 1;
 770:	0000006c 	andeq	r0, r0, ip, rrx
 774:	8b040e42 	blhi	104084 <cpsr_cp+0x100dfc>
 778:	0b0d4201 	bleq	350f84 <cpsr_cp+0x34dcfc>
 77c:	420d0d6e 	andmi	r0, sp, #7040	@ 0x1b80
 780:	00000ecb 	andeq	r0, r0, fp, asr #29
 784:	0000001c 	andeq	r0, r0, ip, lsl r0
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
 788:	00000714 	andeq	r0, r0, r4, lsl r7
 78c:	00001cf4 	strdeq	r1, [r0], -r4
 790:	00000038 	andeq	r0, r0, r8, lsr r0
    sHandlers[i] = NULL;
 794:	8b040e42 	blhi	1040a4 <cpsr_cp+0x100e1c>
 798:	0b0d4201 	bleq	350fa4 <cpsr_cp+0x34dd1c>
 79c:	420d0d54 	andmi	r0, sp, #84, 26	@ 0x1500
 7a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 7a4:	0000001c 	andeq	r0, r0, ip, lsl r0
  for (uint32_t i = 0; i < INTERRUPT_HANDLER_NUM; ++i) {
 7a8:	00000714 	andeq	r0, r0, r4, lsl r7
 7ac:	00001d2c 	andeq	r1, r0, ip, lsr #26
 7b0:	00000060 	andeq	r0, r0, r0, rrx
 7b4:	8b040e42 	blhi	1040c4 <cpsr_cp+0x100e3c>
 7b8:	0b0d4201 	bleq	350fc4 <cpsr_cp+0x34dd3c>
 7bc:	420d0d68 	andmi	r0, sp, #104, 26	@ 0x1a00
  enable_irq();
 7c0:	00000ecb 	andeq	r0, r0, fp, asr #29
}
 7c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 7c8:	00000714 	andeq	r0, r0, r4, lsl r7
 7cc:	00001d8c 	andeq	r1, r0, ip, lsl #27
void Hal_interrupt_enable(uint32_t interrupt_num) {
 7d0:	00000054 	andeq	r0, r0, r4, asr r0
 7d4:	8b040e42 	blhi	1040e4 <cpsr_cp+0x100e5c>
 7d8:	0b0d4201 	bleq	350fe4 <cpsr_cp+0x34dd5c>
 7dc:	420d0d62 	andmi	r0, sp, #6272	@ 0x1880
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
 7e0:	00000ecb 	andeq	r0, r0, fp, asr #29
 7e4:	0000000c 	andeq	r0, r0, ip
 7e8:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
 7ec:	7c020001 	stcvc	0, cr0, [r2], {1}
 7f0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 7f4:	0000001c 	andeq	r0, r0, ip, lsl r0
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
 7f8:	000007e4 	andeq	r0, r0, r4, ror #15
 7fc:	00001de0 	andeq	r1, r0, r0, ror #27
 800:	00000114 	andeq	r0, r0, r4, lsl r1
  if (bit_num < GIC_IRQ_START) {
 804:	8b040e42 	blhi	104114 <cpsr_cp+0x100e8c>
 808:	0b0d4201 	bleq	351014 <cpsr_cp+0x34dd8c>
 80c:	0d0d8202 	sfmeq	f0, 1, [sp, #-8]
    SET_BIT(GicDist->setenable1, bit_num);
 810:	000ecb42 	andeq	ip, lr, r2, asr #22
 814:	0000001c 	andeq	r0, r0, ip, lsl r0
 818:	000007e4 	andeq	r0, r0, r4, ror #15
 81c:	00001ef4 	strdeq	r1, [r0], -r4
 820:	00000094 	muleq	r0, r4, r0
 824:	8b040e42 	blhi	104134 <cpsr_cp+0x100eac>
 828:	0b0d4201 	bleq	351034 <cpsr_cp+0x34ddac>
 82c:	0d0d4202 	sfmeq	f4, 4, [sp, #-8]
 830:	000ecb42 	andeq	ip, lr, r2, asr #22
 834:	00000018 	andeq	r0, r0, r8, lsl r0
 838:	000007e4 	andeq	r0, r0, r4, ror #15
 83c:	00001f88 	andeq	r1, r0, r8, lsl #31
 840:	00000050 	andeq	r0, r0, r0, asr r0
 844:	8b080e42 	blhi	204154 <cpsr_cp+0x200ecc>
    bit_num -= GIC_IRQ_START;
 848:	42018e02 	andmi	r8, r1, #2, 28
 84c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 850:	0000001c 	andeq	r0, r0, ip, lsl r0
    SET_BIT(GicDist->setenable2, bit_num);
 854:	000007e4 	andeq	r0, r0, r4, ror #15
 858:	00001fd8 	ldrdeq	r1, [r0], -r8
 85c:	0000005c 	andeq	r0, r0, ip, asr r0
 860:	8b040e42 	blhi	104170 <cpsr_cp+0x100ee8>
 864:	0b0d4201 	bleq	351070 <cpsr_cp+0x34dde8>
 868:	420d0d66 	andmi	r0, sp, #6528	@ 0x1980
 86c:	00000ecb 	andeq	r0, r0, fp, asr #29
 870:	0000001c 	andeq	r0, r0, ip, lsl r0
 874:	000007e4 	andeq	r0, r0, r4, ror #15
 878:	00002034 	andeq	r2, r0, r4, lsr r0
 87c:	00000024 	andeq	r0, r0, r4, lsr #32
 880:	8b040e42 	blhi	104190 <cpsr_cp+0x100f08>
 884:	0b0d4201 	bleq	351090 <cpsr_cp+0x34de08>
 888:	420d0d4a 	andmi	r0, sp, #4736	@ 0x1280
    return;
 88c:	00000ecb 	andeq	r0, r0, fp, asr #29
}
 890:	00000018 	andeq	r0, r0, r8, lsl r0
 894:	000007e4 	andeq	r0, r0, r4, ror #15
 898:	00002058 	andeq	r2, r0, r8, asr r0
void Hal_interrupt_disable(uint32_t interrupt_num) {
 89c:	00000080 	andeq	r0, r0, r0, lsl #1
 8a0:	8b080e42 	blhi	2041b0 <cpsr_cp+0x200f28>
 8a4:	42018e02 	andmi	r8, r1, #2, 28
 8a8:	00040b0c 	andeq	r0, r4, ip, lsl #22
  if ((interrupt_num < GIC_IRQ_START) || (GIC_IRQ_END < interrupt_num)) {
 8ac:	0000000c 	andeq	r0, r0, ip
 8b0:	000007e4 	andeq	r0, r0, r4, ror #15
 8b4:	000020d8 	ldrdeq	r2, [r0], -r8
 8b8:	0000003c 	andeq	r0, r0, ip, lsr r0
 8bc:	0000000c 	andeq	r0, r0, ip
 8c0:	ffffffff 			@ <UNDEFINED> instruction: 0xffffffff
  uint32_t bit_num = interrupt_num - GIC_IRQ_START;
 8c4:	7c010001 	stcvc	0, cr0, [r1], {1}
 8c8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 8cc:	0000000c 	andeq	r0, r0, ip
  if (bit_num < GIC_IRQ_START) {
 8d0:	000008bc 			@ <UNDEFINED> instruction: 0x000008bc
 8d4:	00002120 	andeq	r2, r0, r0, lsr #2
 8d8:	000000f4 	strdeq	r0, [r0], -r4

Disassembly of section .debug_rnglists:

00000000 <.debug_rnglists>:
    LDR PC, reset_handler_addr
   0:	00000013 	andeq	r0, r0, r3, lsl r0
    LDR PC, undef_handler_addr
   4:	00040005 	andeq	r0, r4, r5
    LDR PC, svc_handler_addr
   8:	00000000 	andeq	r0, r0, r0
    LDR PC, pfch_abt_handler_addr
   c:	b4068c04 	strlt	r8, [r6], #-3076	@ 0xfffff3fc
    LDR PC, data_abt_handler_addr
  10:	06b80406 	ldrteq	r0, [r8], r6, lsl #8
    B .
  14:	Address 0x14 is out of bounds.

