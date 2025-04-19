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
    irq_handler_addr:      .word Irq_Handler
    fiq_handler_addr:      .word Fiq_Handler
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

    BL main

  dummy_handler:
    B .
.end
