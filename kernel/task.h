#ifndef KERNEL_TASK_H_
#define KERNEL_TASK_H_

#include "MemoryMap.h"
#include "stdint.h"

#define NOT_ENOUGH_TASK_NUM 0xFFFFFFFF
#define USR_TASK_STACK_SIZE 0x100000
#define MAX_TASK_NUM (TASK_STACK_SIZE / USR_TASK_STACK_SIZE)

typedef struct KernelTaskContext_t {
  uint32_t spsr;
  uint32_t r0_r12[13];
  uint32_t pc;
} KernelTaskContext_t;

typedef struct KernelTcb_t {
  uint32_t sp;
  uint8_t* stack_base;
} KernelTcb_t;

typedef void (*KernelTaskFunc_t)(void);

void Kernel_task_init(void);
uint32_t Kernel_task_create(KernelTaskFunc_t startFunc);
void Kernel_task_scheduling(void);
void Kernel_task_start(void);

static KernelTcb_t* Scheduler_round_robin(void);
static __attribute__ ((naked)) void Kernel_task_context_switching(void);

#endif