#include "stdio.h"
#include "stdint.h"
#include "stdarg.h"
#include "HalUart.h"

#define PRINTF_BUF_LEN 1024

static char printf_buf[PRINTF_BUF_LEN];

uint32_t putstr(const char* s) {
  uint32_t c = 0;
  while(*s) {
    Hal_uart_put_char(*s++);
    ++c;
  }
  return c;
}

uint32_t debug_printf(const char* format, ...) { 
  va_list args; // 가변 인자를 가리킬 수 있는 참조자 선언
  va_start(args, format); // va_start(참조자, 가변인자 이전에 위치한 마지막 고정인자). 참조자가 가변인자를 실제로 참조할 수 있게 함
  vsprintf(printf_buf, format, args);
  va_end(args); // 메모리 해제

  return putstr(printf_buf);
}

uint32_t vsprintf(char* buf, const char* format, va_list arg) {
  uint32_t c = 0;

  char ch;
  char* str;
  uint32_t uint;
  uint32_t hex;

  for (uint32_t i = 0; format[i]; ++i) {
    if (format[i] == '%') {
      ++i;
      switch(format[i]) {
      case 'c':
        ch = (char)va_arg(arg, int32_t);
        buf[c++] = ch;
        break;
      case 's':
        str = (char*)va_arg(arg, char*);
        if (str == NULL) {
          str = "(null)";
        }
        while (*str) {
          buf[c++] = (*str++);
        }
        break;
      case 'u':
        uint = (uint32_t)va_arg(arg, uint32_t);
        c += utoa(&buf[c], uint, utoa_dec);
        break;
      case 'x':
        hex = (uint32_t)va_arg(arg, uint32_t);
        c += utoa(&buf[c], hex, utoa_hex);
        break;
      }
    }
    else {
      buf[c++] = format[i];
    }

    if (c >= PRINTF_BUF_LEN) {
        buf[0] = '\0';
        return 0;
      }
  }

  buf[c] = '\0';
  return c;
}

uint32_t utoa(char* buf, uint32_t val, utoa_t base) {
  uint32_t c = 0;
  int32_t idx = 0;
  char tmp[11];

  do {
    uint32_t t = val % (uint32_t)base;
    if (t >= 10) {
      t += 'A' - 10 - '0';
    }
    tmp[idx++] = (t + '0');
    val /= base;
  } while(val);

  // reverse
  --idx; // idx를 부호 있는 정수형으로 선언한 이유
  while (idx >= 0) {
    buf[c++] = tmp[idx--];
  }

  return c;
}