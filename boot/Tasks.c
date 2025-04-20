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

static uint32_t shared_value;
static void Test_critical_section(uint32_t p, uint32_t taskId) {
  //Kernel_lock_sem();
  Kernel_lock_mutex();
  debug_printf("User Task #%u Send=%u\n", taskId, p);
  shared_value = p;
  Kernel_yield();
  delay(1000);
  debug_printf("User Task #%u Shared Value=%u\n", taskId, shared_value);
  // Kernel_unlock_sem();
  Kernel_unlock_mutex();
}

void User_task0(void) {
  uint32_t local = 0;
  debug_printf("User Task #0 SP=0x%x\n", &local);

  uint8_t cmdBuf[16];
  uint8_t cmdBufIdx = 0;
  uint8_t uartch = 0;

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn | KernelEventFlag_CmdOut);
    switch(handle_event) {
    case KernelEventFlag_UartIn:
      Kernel_recv_msg(KernelMsgQ_Task0, &uartch, 1);

      if (uartch == '\r') {
        cmdBuf[cmdBufIdx] = '\0';
        
        while(true) {
          if(!Kernel_send_msg(KernelMsgQ_Task1, &cmdBufIdx, 1)) {
            Kernel_yield();
          }
          else if(!Kernel_send_msg(KernelMsgQ_Task1, cmdBuf, cmdBufIdx)) {
            uint8_t rollback;
            Kernel_recv_msg(KernelMsgQ_Task1, &rollback, 1);
            Kernel_yield();
          }
          else {
            break;
          }
        }

        Kernel_send_events(KernelEventFlag_CmdIn);
        cmdBufIdx = 0;
      }
      else {
        cmdBuf[cmdBufIdx] = uartch;
        cmdBufIdx = (cmdBufIdx + 1) % 16;
      }
      break;
    case KernelEventFlag_CmdOut:
      Test_critical_section(5, 0);
      break;
    }
    Kernel_yield();
  }
}
void User_task1(void) {
  uint32_t local = 0;
  debug_printf("User Task #1 SP=0x%x\n", &local);

  uint8_t cmdlen = 0;
  uint8_t cmd[16] = {0, };

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn | KernelEventFlag_Unlock);
    switch(handle_event) {
    case KernelEventFlag_CmdIn:
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
      cmd[cmdlen] = 0;
      debug_printf("\nRecv Cmd: %s\n", cmd);
      break;
    case KernelEventFlag_Unlock:
      Kernel_unlock_sem();
      break;
    }
    Kernel_yield();
  }
}
void User_task2(void) {
  uint32_t local = 0;
  debug_printf("User Task #2 SP=0x%x\n", &local);
  while(true) {
    Test_critical_section(3, 2);
    Kernel_yield();
  }
}