ENTRY(vector_start) /* vector_start 주소에서 실행 시작 */
SECTIONS            /* 코드, 데이터, BSS 등이 어떻게 배치될 지 정함 */
{
  . = 0x0; /* '.': 현재 메모리 주소. 즉 이 섹션이 0x00000000 에 위치한다 */

  .text : /* text 섹션의 배치 순서 지정 */
  {
    *(vector_start)
    *(.text .rodata)
  }
  .data :
  {
    *(.data)
  }
  .bss :
  {
    *(.bss)
  }
}