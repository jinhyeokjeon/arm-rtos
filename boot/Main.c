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
#include "Tasks.h"

static void Hw_init(void);
static void Kernel_init(void);
static void Printf_test(void);
static void Timer_test(void);

void main(void) {
  Hw_init();
  Kernel_init();

  uint32_t i = 100;
  while(i--) {
    Hal_uart_put_char('N');
  }
  Hal_uart_put_char('\n');

  putstr("Hello World!\n");

  Printf_test();

  Hal_interrupt_enable(UART_INTERRUPT0);
  Kernel_start();
}

static void Hw_init(void){
  Hal_interrupt_init();
  Hal_uart_init();
  Hal_timer_init();
}

static void Kernel_init(void) {
  Kernel_task_init();
  Kernel_event_flag_init();
  add_task(User_task0, 0);
  add_task(User_task1, 1);
  add_task(User_task2, 2);
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