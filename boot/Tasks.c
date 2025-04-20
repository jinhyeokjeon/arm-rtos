#include "stdint.h"
#include "stdbool.h"
#include "Tasks.h"
#include "stdio.h"
#include "stdlib.h"
#include "Kernel.h"

void add_task(KernelTaskFunc_t f, uint32_t t_id) {
  uint32_t taskId;

  taskId = Kernel_task_create(f);
  if (taskId == NOT_ENOUGH_TASK_NUM) {
    debug_printf("Task%u creation fail\n", t_id);
  }
}

void User_task0(void) {
  uint32_t local = 0;
  debug_printf("User Task #0 SP=0x%x\n", &local);

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
    switch(handle_event) {
    case KernelEventFlag_UartIn:
      debug_printf("\nEvent handled by Task0\n");
      break;
    case KernelEventFlag_CmdOut:
      debug_printf("\nCmdOut Event by Task0\n");
      break;
    }
    Kernel_yield();
  }
}
void User_task1(void) {
  uint32_t local = 0;
  debug_printf("User Task #1 SP=0x%x\n", &local);
  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn);
    switch(handle_event) {
    case KernelEventFlag_CmdIn:
      debug_printf("\nEvent handled by Task1\n");
      break;
    }
    Kernel_yield();
  }
}
void User_task2(void) {
  uint32_t local = 0;
  debug_printf("User Task #2 SP=0x%x\n", &local);
  while(true) {
    Kernel_yield();
  }
}