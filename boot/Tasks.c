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

  uint8_t cmdBuf[16];
  uint8_t cmdBufIdx = 0;
  uint8_t uartch = 0;

  while(true) {
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_UartIn);
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
    KernelEventFlag_t handle_event = Kernel_wait_events(KernelEventFlag_CmdIn);
    switch(handle_event) {
    case KernelEventFlag_CmdIn:
      Kernel_recv_msg(KernelMsgQ_Task1, &cmdlen, 1);
      Kernel_recv_msg(KernelMsgQ_Task1, cmd, cmdlen);
      cmd[cmdlen] = 0;
      debug_printf("\nRecv Cmd: %s\n", cmd);
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