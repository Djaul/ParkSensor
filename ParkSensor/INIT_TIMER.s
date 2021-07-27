STCTRL 		EQU 0xE000E010;control register
STRELOAD	EQU 0xE000E014;reload register
STCURRENT	EQU	0xE000E018;current register 24 bit
LOAD_VAL	EQU 0x00002EE0
SHP_SYSPRI3 EQU 0xE000ED20
			
			AREA    timer_init, READONLY, CODE
			THUMB
			EXPORT  INIT_TIMER	; Make available for other subroutines
			EXTERN 	__main

INIT_TIMER  PROC

			LDR R1,=STCTRL
			LDR R0,[R1]
			MOV R0,#0  ;disable first with bit clear instruction
			STR R0, [R1]
			
			LDR R1,=STRELOAD
			LDR R0,=LOAD_VAL ; load the reload value
			STR R0,[R1]
			
			LDR R1,=STCURRENT
			LDR R0,=LOAD_VAL ; load the reload value
			STR R0,[R1]
			
			
			; now set the priority level
			LDR R1 , =SHP_SYSPRI3
			MOV R0 , #0x40000000
			STR R0 , [R1]
						
			LDR R1 , =STCTRL
			MOV R0 , #0x03
			STR R0 , [R1]

			
			
			BX LR
			ENDP
			END
				
				
