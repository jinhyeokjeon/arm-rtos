#include "stdint.h"
#include "stdbool.h"

#include "ARMv7AR.h"
#include "task.h"

static KernelTcb_t sTask_list[MAX_TASK_NUM];
static uint32_t sAllocated_tcb_index;

static uint32_t sCurrent_tcb_index;
static KernelTcb_t* sCurrent_tcb;
static KernelTcb_t* sNext_tcb;

static uint32_t cpsr_cp;
void Kernel_task_init(void) {
  sAllocated_tcb_index = 0;
  sCurrent_tcb_index = 0;

  __asm__ ("MRS r0, cpsr");
  __asm__ ("LDR r1, =cpsr_cp");
  __asm__ ("STR r0, [r1]");

  for (uint32_t i = 0; i < MAX_TASK_NUM; ++i) {
    sTask_list[i].stack_base = (uint8_t*)(TASK_STACK_START + (i * USR_TASK_STACK_SIZE));
    sTask_list[i].sp = (uint32_t)sTask_list[i].stack_base + USR_TASK_STACK_SIZE - 4;

    sTask_list[i].sp -= sizeof(KernelTaskContext_t);
    KernelTaskContext_t* ctx = (KernelTaskContext_t*)sTask_list[i].sp;
    ctx->spsr = cpsr_cp;
  }
}

uint32_t Kernel_task_create(KernelTaskFunc_t startFunc) {
  KernelTcb_t* new_tcb = &sTask_list[sAllocated_tcb_index++];

  if (sAllocated_tcb_index > MAX_TASK_NUM) {
    return NOT_ENOUGH_TASK_NUM;
  }

  KernelTaskContext_t* ctx = (KernelTaskContext_t*)new_tcb->sp;
  ctx->pc = (uint32_t)startFunc;

  return (sAllocated_tcb_index - 1);
}

void Kernel_task_scheduling(void) {
  sCurrent_tcb = &sTask_list[sCurrent_tcb_index];
  sNext_tcb = Scheduler_round_robin();

  Kernel_task_context_switching();
}

void Kernel_task_start(void) {
  sNext_tcb = &sTask_list[sCurrent_tcb_index];
  __asm__ ("LDR r0, =sNext_tcb");
  __asm__ ("LDR r0, [r0]");
  __asm__ ("LDMIA r0!, {sp}");

  __asm__ ("POP {r0}");
  __asm__ ("MSR cpsr, r0");
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}"); // 쓰레기 값들로 채워짐
  __asm__ ("POP {pc}"); // 태스크 함수의 위치로 점프
}

static KernelTcb_t* Scheduler_round_robin(void) {
  ++sCurrent_tcb_index;
  sCurrent_tcb_index %= sAllocated_tcb_index;

  return &sTask_list[sCurrent_tcb_index];
}

static __attribute__ ((naked)) void Kernel_task_context_switching(void) {
  // 1. Save context

  // save current task context into the current task stack
  __asm__ ("PUSH {lr}");
  __asm__ ("PUSH {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
  __asm__ ("MRS r0, cpsr");
  __asm__ ("PUSH {r0}");
  // save current task stack pointer into the current TCB
  __asm__ ("LDR r0, =sCurrent_tcb");
  __asm__ ("LDR r0, [r0]");
  __asm__ ("STMIA r0!, {sp}");

  // 2. Restore context

  // restore next task stack pointer from the next TCB
  __asm__ ("LDR r0, =sNext_tcb");
  __asm__ ("LDR r0, [r0]");
  __asm__ ("LDMIA r0!, {sp}");
  // restore next task context from the next task stack
  __asm__ ("POP {r0}");
  __asm__ ("MSR cpsr, r0");
  __asm__ ("POP {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12}");
  __asm__ ("POP {pc}");
}