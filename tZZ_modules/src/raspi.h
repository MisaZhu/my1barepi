/*----------------------------------------------------------------------------*/
#ifndef __RASPI_H
#define __RASPI_H
/*----------------------------------------------------------------------------*/
/* on VideoCore memory map, it is 0x7e000000 (BCM2835 @PiV1) */
#ifdef RASPI2
#define PMAP_BASE 0x3F000000
#else
#define PMAP_BASE 0x20000000
#endif
#define GPIO_OFFSET 0x00200000
#define TIMER_OFFSET 0x0000B400
#define TIMER_SYS_OFFSET 0x00003000
#define INTR_OFFSET 0x0000B200
#define AUX_OFFSET 0x00215000
#define UART_OFFSET 0x00215040
#define MAILBOX_OFFSET 0x0000B880
/*----------------------------------------------------------------------------*/
#endif
/*----------------------------------------------------------------------------*/