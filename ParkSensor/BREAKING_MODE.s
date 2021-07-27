PORTA_DATA 		EQU 0x400043FC	
GPIO_PORTF_RIS	EQU	0X40025414	
GPIO_PORTF_ICR	EQU	0X4002541C
TIMER2_CTL		EQU 0x4003200C;TIMER2   (en/dis,fall/ris/both)
	
TIMER3_CTL		EQU 0x4003300C;TIMER3   (en/dis,fall/ris/both)
	
			AREA 	breaking, CODE, READONLY
			THUMB
			EXTERN  TRANSMIT
				
			EXTERN	GPIOPortF_Handler
				
			EXTERN  DISPLAY
			EXTERN  DELAY100
			
			EXPORT 	BREAKING_MODE
				
				
				
BREAKING_MODE	PROC
	
			PUSH 	{LR}

			
			
			BL	CLEAR
			
			
;******************************************************			
;********************* --> ****************************	
;******************************************************			
;******************************************************				
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x85
			BL	TRANSMIT
			MOV	R5, #0X43					;Arranged x,y coordinates
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	

			
			MOV		R5, #2_00000000			;
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT			

			MOV		R5, #2_00000000			;
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT			

			MOV		R5, #2_00001000			;-->
			BL		TRANSMIT
			MOV		R5, #2_00001000	
			BL		TRANSMIT
			MOV		R5, #2_00101010	
			BL		TRANSMIT
			MOV		R5, #2_00011100	
			BL		TRANSMIT
			MOV		R5, #2_00001000	
			BL		TRANSMIT			
		
			MOV		R5, #2_00000000			;
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT			
	
			MOV		R5, #2_00000000			;
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT								
			
			MOV		R5, #2_11111111			;B
			BL		TRANSMIT
			MOV		R5, #2_10010001	
			BL		TRANSMIT
			MOV		R5, #2_10011010	
			BL		TRANSMIT
			MOV		R5, #2_01101100	
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT						
			
			MOV		R5, #2_11111111			;R
			BL		TRANSMIT
			MOV		R5, #2_00010001
			BL		TRANSMIT
			MOV		R5, #2_00011010
			BL		TRANSMIT
			MOV		R5, #2_11101100
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT						
						
			MOV		R5, #2_11111111			;E
			BL		TRANSMIT
			MOV		R5, #2_10001001
			BL		TRANSMIT	
			MOV		R5, #2_10001001
			BL		TRANSMIT
			MOV		R5, #2_10001001
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT			
			
			MOV		R5, #2_11110000			;A
			BL		TRANSMIT
			MOV		R5, #2_00101000	
			BL		TRANSMIT
			MOV		R5, #2_00100100	
			BL		TRANSMIT
			MOV		R5, #2_11111000
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT					
			
			MOV		R5, #2_11111110			;K
			BL		TRANSMIT
			MOV		R5, #2_00010000
			BL		TRANSMIT	
			MOV		R5, #2_00101000
			BL		TRANSMIT
			MOV		R5, #2_11100110
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT						
			
			MOV		R5, #2_00000000			;I
			BL		TRANSMIT
			MOV		R5, #2_10000010
			BL		TRANSMIT	
			MOV		R5, #2_11111110
			BL		TRANSMIT
			MOV		R5, #2_10000010
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT	
			
			MOV		R5, #2_11111110			;N
			BL		TRANSMIT
			MOV		R5, #2_00001110	
			BL		TRANSMIT
			MOV		R5, #2_00110000	
			BL		TRANSMIT
			MOV		R5, #2_11111110	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT	
			
			LTORG
			
			MOV		R5, #2_01111100			;G
			BL		TRANSMIT
			MOV		R5, #2_10000010	
			BL		TRANSMIT
			MOV		R5, #2_10100010	
			BL		TRANSMIT
			MOV		R5, #2_01101100
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT						



			
			LDR R1,=TIMER3_CTL;disable timer3 to disable motor
			LDR R0,[R1]
			BIC R0,#0x01
			STR R0,[R1]
							
			
			;wait for button press sw2
			;if button pressed, reset display and go back to normal operation
			
			LDR		R1,=0x20000500
			MOV		R0, #1
			STR		R0, [R1]
			
			
			LDR R1,=TIMER2_CTL
			LDR R3,[R1]
			BIC R3,#0x01; disable timer2 at breaking mode to not display ADC value etc
			STR R3,[R1]
			
wait		;wait here until sw2 press	
			LDR		R0,=0x20000500
			LDR		R1, [R0]
			
			CMP		R1, #1
			BNE		gotoend
			
			
			B		wait


gotoend
			BL	DELAY100
			BL	DELAY100
			BL	DELAY100
			
			LDR R1,=TIMER2_CTL
			LDR R3,[R1]
			ORR R3,#0x01; enable timer to display ADC value etc. in normal operation
			STR R3,[R1]



			LDR R1,=TIMER3_CTL;enable timer to enable motor
			LDR R0,[R1]
			ORR R0,#0x01
			STR R0,[R1]
							
							
							
			
			BL		CLEAR
			
			BL		DISPLAY

			LDR		R1,=0x20000700
			MOV		R0, #1
			STR		R0, [R1]		
					
					

			POP		{LR}
			BX 		LR



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;	CLEAR SCREEN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLEAR		PUSH	{R0,R1,LR}
			MOV		R0,#0
			MOV		R1, #503
clr			MOV		R5, #0X0
			BL		TRANSMIT
			ADD		R0, #1
			CMP		R0,R1
			BNE		clr
			POP		{R0,R1,LR}
			BX		LR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					



			ENDP
			END