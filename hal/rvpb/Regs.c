#include "stdint.h"
#include "Uart.h"

// volatile: 레지스터 값이 외부에서 변경될 수 있으므로 컴파일러가 값을 캐싱하거나 최적화하지 않도록 함.
// 즉 Uart 변수 값은 항상 레지스터에서 직접 읽어옴.
volatile PL011_t* Uart = (PL011_t*)UART_BASE_ADDRESS0;