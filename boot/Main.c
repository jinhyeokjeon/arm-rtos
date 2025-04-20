#include "stdio.h"
#include "stdint.h"
#include "stdbool.h"
#include "HalUart.h"
#include "HalGic.h"
#include "HalTimer.h"
#include "Uart.h"
#include "stdlib.h"
#include "task.h"
#include "Kernel.h"

static void Hw_init(void);
static void Printf_test(void);
static void Timer_test(void);

void User_task0(void);
void User_task1(void);
void User_task2(void);

static void Kernel_init(void);

void main(void) {
  Hw_init();

  uint32_t i = 100;
  while(i--) {
    Hal_uart_put_char('N');
  }
  Hal_uart_put_char('\n');

  putstr("Hello World!\n");

  Printf_test();

  Kernel_init();
  Kernel_start();
}

static void Kernel_init(void) {
  uint32_t taskId;

  Kernel_task_init();

  taskId = Kernel_task_create(User_task0);
  if (taskId == NOT_ENOUGH_TASK_NUM) {
    putstr("Task0 creation fail\n");
  }

  taskId = Kernel_task_create(User_task1);
  if (taskId == NOT_ENOUGH_TASK_NUM) {
    putstr("Task0 creation fail\n");
  }

  taskId = Kernel_task_create(User_task2);
  if (taskId == NOT_ENOUGH_TASK_NUM) {
    putstr("Task0 creation fail\n");
  }
}

void User_task0(void) {
  uint32_t local = 0;
  while(true) {
    debug_printf("User Task #0 SP=0x%x\n", &local);
    delay(1000);
    Kernel_yield();
  }
}
void User_task1(void) {
  uint32_t local = 0;
  while(true) {
    debug_printf("User Task #1 SP=0x%x\n", &local);
    delay(1000);
    Kernel_yield();
  }
}
void User_task2(void) {
  uint32_t local = 0;
  while(true) {
    debug_printf("User Task #2 SP=0x%x\n", &local);
    delay(1000);
    Kernel_yield();
  }
}

static void Hw_init(void){
  Hal_interrupt_init();
  Hal_uart_init();
  Hal_timer_init();
}

static void Printf_test(void) {
  char* str = "printf pointer test";
  char* nullptr = 0;
  uint32_t i = 5;

  debug_printf("%s\n", "Hello printf");
  debug_printf("output string pointer: %s\n", str);
  debug_printf("%s is null pointer, %u number\n", nullptr, 10);
  debug_printf("%u = 5\n", i);
  debug_printf("dec=%u hex=%x\n", 0xff, 0xff);
  debug_printf("print zero %u\n", 0);

  debug_printf("SYSCTRL0: %u\n", *((uint32_t*)0x10001000));
}