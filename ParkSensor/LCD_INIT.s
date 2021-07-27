PORTA_DATA 	EQU 0x400043FC			
			
			AREA 	lcdinit, CODE, READONLY
			THUMB
			
			EXTERN 	DELAY100
			EXTERN 	TRANSMIT
			
			EXPORT 	LCD_INIT
			
LCD_INIT	PROC
			PUSH	{LR}
			
			LDR 	R1,=PORTA_DATA
			LDR		R0, [R1]
			BIC 	R0,#0x80
			STR 	R0,[R1]
			BL		DELAY100	;100ms delay for reset
			LDR		R0, [R1]
			ORR		R0, #0X80
			STR		R0, [R1]
			LDR		R0, [R1]
			BIC		R0, #0X40
			STR		R0, [R1]
			
			MOV		R5, #0X21
			BL		TRANSMIT	
			MOV		R5, #0XC0
			BL		TRANSMIT
			MOV		R5, #0x04			
			BL 		TRANSMIT
			MOV		R5, #0x13			
			BL 		TRANSMIT
			MOV		R5, #0X20
			BL		TRANSMIT
			MOV		R5, #0XC
			BL		TRANSMIT

			POP		{LR}
			BX		LR
			ENDP
			ALIGN				
			END