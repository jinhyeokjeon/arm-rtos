
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
  34:	000000b8 	strheq	r0, [r0], -r8

00000038 <fiq_handler_addr>:
  38:	000000b8 	strheq	r0, [r0], -r8

0000003c <vector_end>:
    irq_handler_addr:      .word dummy_handler
    fiq_handler_addr:      .word dummy_handler
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
  b4:	eb000006 	bl	d4 <main>

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

000000d4 <main>:
#include "stdint.h"

void main(void) {
  d4:	e52db004 	push	{fp}		@ (str fp, [sp, #-4]!)
  d8:	e28db000 	add	fp, sp, #0
  dc:	e24dd00c 	sub	sp, sp, #12
  uint32_t* dummyAddr = (uint32_t*)(1024*1024*100);
  e0:	e3a03519 	mov	r3, #104857600	@ 0x6400000
  e4:	e50b3008 	str	r3, [fp, #-8]
  *dummyAddr = sizeof(long);
  e8:	e51b3008 	ldr	r3, [fp, #-8]
  ec:	e3a02004 	mov	r2, #4
  f0:	e5832000 	str	r2, [r3]
  f4:	e320f000 	nop	{0}
  f8:	e28bd000 	add	sp, fp, #0
  fc:	e49db004 	pop	{fp}		@ (ldr fp, [sp], #4)
 100:	e12fff1e 	bx	lr

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
  24:	1a011803 	bne	46038 <main+0x45f64>
  28:	44012201 	strmi	r2, [r1], #-513	@ 0xfffffdff
  2c:	Address 0x2c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
    LDR PC, reset_handler_addr
   0:	3a434347 	bcc	10d0d24 <main+0x10d0c50>
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
   c:	fb010102 	blx	4041e <main+0x4034a>
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
  78:	00540101 	subseq	r0, r4, r1, lsl #2
    BIC r1, r0, #0x1F
  7c:	00030000 	andeq	r0, r3, r0
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	00000036 	andeq	r0, r0, r6, lsr r0
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
  98:	6e690074 	mcrvs	0, 3, r0, cr9, cr4, {3}
    LDR sp, =UND_STACK_TOP
  9c:	64756c63 	ldrbtvs	r6, [r5], #-3171	@ 0xfffff39d
    MRS r0, cpsr
  a0:	4d000065 	stcmi	0, cr0, [r0, #-404]	@ 0xfffffe6c
    BIC r1, r0, #0x1F
  a4:	2e6e6961 	vnmulcs.f16	s13, s28, s3	@ <UNPREDICTABLE>
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	00010063 	andeq	r0, r1, r3, rrx
    MSR cpsr, r1
  ac:	64747300 	ldrbtvs	r7, [r4], #-768	@ 0xfffffd00
    LDR sp, =USRSYS_STACK_TOP
  b0:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
    BL main
  b4:	00020068 	andeq	r0, r2, r8, rrx
    B .
  b8:	11050000 	mrsne	r0, (UNDEF: 5)
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  bc:	d4020500 	strle	r0, [r2], #-1280	@ 0xfffffb00
    LDR sp, =IRQ_STACK_TOP
  c0:	14000000 	strne	r0, [r0], #-0
    LDR sp, =FIQ_STACK_TOP
  c4:	05670d05 	strbeq	r0, [r7, #-3333]!	@ 0xfffff2fb
    LDR sp, =ABT_STACK_TOP
  c8:	01054b0e 	tsteq	r5, lr, lsl #22
    LDR sp, =UND_STACK_TOP
  cc:	00080267 	andeq	r0, r8, r7, ror #4
    LDR sp, =USRSYS_STACK_TOP
  d0:	Address 0xd0 is out of bounds.


Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
    LDR PC, reset_handler_addr
   0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	@ ffffff4c <main+0xfffffe78>
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
	...

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
  24:	00009380 	andeq	r9, r0, r0, lsl #7
  28:	01000500 	tsteq	r0, r0, lsl #10
  2c:	00001404 	andeq	r1, r0, r4, lsl #8
  30:	00a10200 	adceq	r0, r1, r0, lsl #4
  34:	6a1d0000 	bvs	74003c <main+0x73ff68>
  38:	0d000000 	stceq	0, cr0, [r0, #-0]
    MRS r0, cpsr @ move PSR to Register
  3c:	d4000000 	strle	r0, [r0], #-0
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	30000000 	andcc	r0, r0, r0
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	7a000000 	bvc	4c <vector_end+0x10>
    MSR cpsr, r1 @ 동작 모드 변경
  48:	01000000 	mrseq	r0, (UNDEF: 0)
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	00500601 	subseq	r0, r0, r1, lsl #12
    MRS r0, cpsr
  50:	02010000 	andeq	r0, r1, #0
    BIC r1, r0, #0x1F
  54:	00009705 	andeq	r9, r0, r5, lsl #14
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	05040300 	streq	r0, [r4, #-768]	@ 0xfffffd00
    MSR cpsr, r1
  5c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    LDR sp, =IRQ_STACK_TOP
  60:	76050801 	strvc	r0, [r5], -r1, lsl #16
    MRS r0, cpsr
  64:	01000000 	mrseq	r0, (UNDEF: 0)
    BIC r1, r0, #0x1F
  68:	004e0801 	subeq	r0, lr, r1, lsl #16
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	02010000 	andeq	r0, r1, #0
    MSR cpsr, r1
  70:	00008407 	andeq	r8, r0, r7, lsl #8
    LDR sp, =FIQ_STACK_TOP
  74:	00610400 	rsbeq	r0, r1, r0, lsl #8
    MRS r0, cpsr
  78:	1a020000 	bne	80080 <main+0x7ffac>
    BIC r1, r0, #0x1F
  7c:	00005c17 	andeq	r5, r0, r7, lsl ip
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	07040100 	streq	r0, [r4, -r0, lsl #2]
    MSR cpsr, r1
  84:	00000041 	andeq	r0, r0, r1, asr #32
    LDR sp, =ABT_STACK_TOP
  88:	37070801 	strcc	r0, [r7, -r1, lsl #16]
    MRS r0, cpsr
  8c:	05000000 	streq	r0, [r0, #-0]
    BIC r1, r0, #0x1F
  90:	0000005c 	andeq	r0, r0, ip, asr r0
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	d4060301 	strle	r0, [r6], #-769	@ 0xfffffcff
    MSR cpsr, r1
  98:	30000000 	andcc	r0, r0, r0
    LDR sp, =UND_STACK_TOP
  9c:	01000000 	mrseq	r0, (UNDEF: 0)
    MRS r0, cpsr
  a0:	0000909c 	muleq	r0, ip, r0
    BIC r1, r0, #0x1F
  a4:	002d0600 	eoreq	r0, sp, r0, lsl #12
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	04010000 	streq	r0, [r1], #-0
    MSR cpsr, r1
  ac:	0000900d 	andeq	r9, r0, sp
    LDR sp, =USRSYS_STACK_TOP
  b0:	74910200 	ldrvc	r0, [r1], #512	@ 0x200
    BL main
  b4:	50040700 	andpl	r0, r4, r0, lsl #14
    B .
  b8:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
    LDR PC, reset_handler_addr
   0:	10001101 	andne	r1, r0, r1, lsl #2
    LDR PC, undef_handler_addr
   4:	12011117 	andne	r1, r1, #-1073741819	@ 0xc0000005
    LDR PC, svc_handler_addr
   8:	1b0e030f 	blne	380c4c <main+0x380b78>
    LDR PC, pfch_abt_handler_addr
   c:	130e250e 	movwne	r2, #58638	@ 0xe50e
    LDR PC, data_abt_handler_addr
  10:	00000005 	andeq	r0, r0, r5
    B .
  14:	0b002401 	bleq	9020 <main+0x8f4c>
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
  3c:	00160400 	andseq	r0, r6, r0, lsl #8
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	0b3a0e03 	bleq	e83854 <main+0xe83780>
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	0b390b3b 	bleq	e42d38 <main+0xe42c64>
    MSR cpsr, r1 @ 동작 모드 변경
  48:	00001349 	andeq	r1, r0, r9, asr #6
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	3f012e05 	svccc	0x00012e05
    MRS r0, cpsr
  50:	3a0e0319 	bcc	380cbc <main+0x380be8>
    BIC r1, r0, #0x1F
  54:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	1119270b 	tstne	r9, fp, lsl #14
    MSR cpsr, r1
  5c:	40061201 	andmi	r1, r6, r1, lsl #4
    LDR sp, =IRQ_STACK_TOP
  60:	01197a18 	tsteq	r9, r8, lsl sl
    MRS r0, cpsr
  64:	06000013 			@ <UNDEFINED> instruction: 0x06000013
    BIC r1, r0, #0x1F
  68:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	0b3b0b3a 	bleq	ec2d5c <main+0xec2c88>
    MSR cpsr, r1
  70:	13490b39 	movtne	r0, #39737	@ 0x9b39
    LDR sp, =FIQ_STACK_TOP
  74:	00001802 	andeq	r1, r0, r2, lsl #16
    MRS r0, cpsr
  78:	0b000f07 	bleq	3c9c <main+0x3bc8>
    BIC r1, r0, #0x1F
  7c:	0013490b 	andseq	r4, r3, fp, lsl #18
	...

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
  34:	00000030 	andeq	r0, r0, r0, lsr r0
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
  10:	6a2f656d 	bvs	bd95cc <main+0xbd94f8>
    B .
  14:	79686e69 	stmdbvc	r8!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
    LDR PC, irq_handler_addr
  18:	2f6b6f65 	svccs	0x006b6f65
    LDR PC, fiq_handler_addr
  1c:	736f7472 	cmnvc	pc, #1912602624	@ 0x72000000
  20:	554e4700 	strbpl	r4, [lr, #-1792]	@ 0xfffff900
  24:	20534120 	subscs	r4, r3, r0, lsr #2
  28:	30342e32 	eorscc	r2, r4, r2, lsr lr
  2c:	6d756400 	cfldrdvs	mvd6, [r5, #-0]
  30:	6441796d 	strbvs	r7, [r1], #-2413	@ 0xfffff693
  34:	6c007264 	sfmvs	f7, 4, [r0], {100}	@ 0x64
  38:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    MRS r0, cpsr @ move PSR to Register
  3c:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
    BIC r1, r0, #0x1F @ r0에서 하위 5비트 클리어 후 r1에 저장
  40:	736e7520 	cmnvc	lr, #32, 10	@ 0x8000000
    ORR r1, r1, #ARM_MODE_BIT_SVC @ r1과 동작모드 비트 or하여 r1에 저장
  44:	656e6769 	strbvs	r6, [lr, #-1897]!	@ 0xfffff897
    MSR cpsr, r1 @ 동작 모드 변경
  48:	6e692064 	cdpvs	0, 6, cr2, cr9, cr4, {3}
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  4c:	6e750074 	mrcvs	0, 3, r0, cr5, cr4, {3}
    MRS r0, cpsr
  50:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
    BIC r1, r0, #0x1F
  54:	63206465 			@ <UNDEFINED> instruction: 0x63206465
    ORR r1, r1, #ARM_MODE_BIT_IRQ
  58:	00726168 	rsbseq	r6, r2, r8, ror #2
    MSR cpsr, r1
  5c:	6e69616d 	powvsez	f6, f1, #5.0
    LDR sp, =IRQ_STACK_TOP
  60:	6e697500 	cdpvs	5, 6, cr7, cr9, cr0, {0}
    MRS r0, cpsr
  64:	5f323374 	svcpl	0x00323374
    BIC r1, r0, #0x1F
  68:	6f620074 	svcvs	0x00620074
    ORR r1, r1, #ARM_MODE_BIT_FIQ
  6c:	4d2f746f 	cfstrsmi	mvf7, [pc, #-444]!	@ fffffeb8 <main+0xfffffde4>
    MSR cpsr, r1
  70:	2e6e6961 	vnmulcs.f16	s13, s28, s3	@ <UNPREDICTABLE>
    LDR sp, =FIQ_STACK_TOP
  74:	6f6c0063 	svcvs	0x006c0063
    MRS r0, cpsr
  78:	6c20676e 	stcvs	7, cr6, [r0], #-440	@ 0xfffffe48
    BIC r1, r0, #0x1F
  7c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
    ORR r1, r1, #ARM_MODE_BIT_ABT
  80:	00746e69 	rsbseq	r6, r4, r9, ror #28
    MSR cpsr, r1
  84:	726f6873 	rsbvc	r6, pc, #7536640	@ 0x730000
    LDR sp, =ABT_STACK_TOP
  88:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
    MRS r0, cpsr
  8c:	6e676973 			@ <UNDEFINED> instruction: 0x6e676973
    BIC r1, r0, #0x1F
  90:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
    ORR r1, r1, #ARM_MODE_BIT_UND
  94:	7300746e 	movwvc	r7, #1134	@ 0x46e
    MSR cpsr, r1
  98:	74726f68 	ldrbtvc	r6, [r2], #-3944	@ 0xfffff098
    LDR sp, =UND_STACK_TOP
  9c:	746e6920 	strbtvc	r6, [lr], #-2336	@ 0xfffff6e0
    MRS r0, cpsr
  a0:	554e4700 	strbpl	r4, [lr, #-1792]	@ 0xfffff900
    BIC r1, r0, #0x1F
  a4:	37314320 	ldrcc	r4, [r1, -r0, lsr #6]!
    ORR r1, r1, #ARM_MODE_BIT_SYS
  a8:	2e323120 	rsfcssp	f3, f2, f0
    MSR cpsr, r1
  ac:	20312e32 	eorscs	r2, r1, r2, lsr lr
    LDR sp, =USRSYS_STACK_TOP
  b0:	32323032 	eorscc	r3, r2, #50	@ 0x32
    BL main
  b4:	35303231 	ldrcc	r3, [r0, #-561]!	@ 0xfffffdcf
    B .
  b8:	616d2d20 	cmnvs	sp, r0, lsr #26
    LDR sp, =SVC_STACK_TOP @ 해당 동작 모드의 스택 주소 초기화
  bc:	2d206d72 	stccs	13, cr6, [r0, #-456]!	@ 0xfffffe38
    LDR sp, =IRQ_STACK_TOP
  c0:	7570636d 	ldrbvc	r6, [r0, #-877]!	@ 0xfffffc93
    LDR sp, =FIQ_STACK_TOP
  c4:	726f633d 	rsbvc	r6, pc, #-201326592	@ 0xf4000000
    LDR sp, =ABT_STACK_TOP
  c8:	2d786574 	cfldr64cs	mvdx6, [r8, #-464]!	@ 0xfffffe30
    LDR sp, =UND_STACK_TOP
  cc:	2d203861 	stccs	8, cr3, [r0, #-388]!	@ 0xfffffe7c
    LDR sp, =USRSYS_STACK_TOP
  d0:	6f6c666d 	svcvs	0x006c666d
void main(void) {
  d4:	612d7461 			@ <UNDEFINED> instruction: 0x612d7461
  d8:	733d6962 	teqvc	sp, #1605632	@ 0x188000
  dc:	2074666f 	rsbscs	r6, r4, pc, ror #12
  uint32_t* dummyAddr = (uint32_t*)(1024*1024*100);
  e0:	72616d2d 	rsbvc	r6, r1, #2880	@ 0xb40
  e4:	613d6863 	teqvs	sp, r3, ror #16
  *dummyAddr = sizeof(long);
  e8:	37766d72 			@ <UNDEFINED> instruction: 0x37766d72
  ec:	732b612d 			@ <UNDEFINED> instruction: 0x732b612d
  f0:	2d206365 	stccs	3, cr6, [r0, #-404]!	@ 0xfffffe6c
  f4:	Address 0xf4 is out of bounds.


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
  10:	0000001c 	andeq	r0, r0, ip, lsl r0
    B .
  14:	00000000 	andeq	r0, r0, r0
    LDR PC, irq_handler_addr
  18:	000000d4 	ldrdeq	r0, [r0], -r4
    LDR PC, fiq_handler_addr
  1c:	00000030 	andeq	r0, r0, r0, lsr r0
  20:	8b040e42 	blhi	103930 <main+0x10385c>
  24:	0b0d4201 	bleq	350830 <main+0x35075c>
  28:	420d0d50 	andmi	r0, sp, #80, 26	@ 0x1400
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
