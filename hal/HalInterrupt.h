#ifndef HAL_HALINTERRUPT_H_
#define HAL_HALINTERRUPT_H_

#define INTERRUPT_HANDLER_NUM   255

// InterHdlr_fptr: 매개변수를 받지 않고, 반환값이 없는 함수 주소를 가리킴.
typedef void (*InterHdlr_fptr)(void);

void Hal_interrupt_init(void);
void Hal_interrupt_enable(uint32_t interrupt_num);
void Hal_interrupt_disable(uint32_t interrupt_num);
void Hal_interrupt_register_handler(InterHdlr_fptr handler, uint32_t interrupt_num);
void Hal_interrupt_run_handler(void);

#endif /* HAL_HALINTERRUPT_H_ */
