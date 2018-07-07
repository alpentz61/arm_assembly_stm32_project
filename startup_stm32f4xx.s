;Author: Andrew Pentz
;Date: 7/7/2018
;
;Description: This is the minimal assembly file which can be used to turn on 
;the LEDs on the STM32F407G-DISC1 Board
;
;Note: Currently this file only starts up in DEBUG mode, indicating other 
;functionality is necessary before it will start up as soon as its plugged in to power

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION .text:CODE
        PUBWEAK __iar_program_start

__iar_program_start

        ;Store the RCC Base address in R0
        MOV R0, #0x40000000
        ORR R0, R0, #0x00020000
        ORR R0, R0, #0x00003800

        ;Set RCC_AHB1ENR bit 3 to enable the GPIOD peripheral clock
        MOV R2, #0x00000008
        ADD R1, R0, #0x30
        STR R2, [R1]

        ;Store GPI0D_Base address in R0
        MOV R0, #0x40000000
        ORR R0, R0, #0x00020000
        ORR R0, R0, #0x00000C00
        
        ;Set GPIOD MODER bits so that pins 12 through 15 are output
        MOV R2, #0x55000000
        MOV R1, R0
        STR R2, [R1]
        
        ;Leave GPIOD OTYPER bits 0 so that pins 12 through 15 are push pull

        ;Set GPIOD OSPEEDR bits so that pins 12 through 15 run at very high speed (100 MHz)
        MOV R2, #0xff000000
        ADD R1, R0, #8
        STR R2, [R1]
        
        ;Leave GPIOD PUPDR bits 0 so that pins 12 through 15 have no pull up or pull down

        ;Set GPIOD BSRR bits to turn on the LEDS on pins 12 through 15
        MOV R2, #0x0000f000
        ADD R1, R0, #0x18
        STR R2, [R1]
        
loop    cmp R0, R1
        b loop


        END
/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
