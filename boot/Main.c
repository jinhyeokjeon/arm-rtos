#include "stdio.h"
#include "stdint.h"
#include "stdbool.h"
#include "HalUart.h"
#include "HalGic.h"
#include "HalTimer.h"
#include "Uart.h"
#include "stdlib.h"
#include "task.h"

static void Hw_init(void);
static void Printf_test(void);
static void Timer_test(void);

void User_task0(void);
void User_task1(void);
void User_task2(void);

static void Kernel_init(void) {
  uint32_t taskId;

  Kernel_task_init();

  void (*f[3])(void) = { User_task0, User_task1, User_task2 };

  for(uint32_t idx = 0; idx < 3; ++idx) {
    taskId = Kernel_task_create(f[idx]);
    if(NOT_ENOUGH_TASK_NUM == taskId) {
      debug_printf("Task%u creation fail\n", idx);
    }
  }
}

void main(void) {
  Hw_init();

  uint32_t i = 100;
  while(i--) {
    Hal_uart_put_char('N');
  }
  Hal_uart_put_char('\n');

  putstr("Hello World!\n");

  Printf_test();

  // Timer_test();

  i = 10;
  while(i--) {
    uint8_t ch = Hal_uart_get_char();
    Hal_uart_put_char(ch);
  }
  Hal_uart_put_char('\n');
}

void User_task0(void) {
  // debug_printf("User Task #0\n");
  while(true);
}
void User_task1(void) {
  debug_printf("User Task #1\n");
  while(true);
}
void User_task2(void) {
  debug_printf("User Task #2\n");
  while(true);
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