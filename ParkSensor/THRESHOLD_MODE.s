PORTA_DATA 		EQU 0x400043FC	
GPIO_PORTF_RIS	EQU	0X40025414	
GPIO_PORTF_ICR	EQU	0X4002541C
TIMER2_CTL		EQU 0x4003200C;TIMER2   (en/dis,fall/ris/both)



	
	
			AREA 	breaking, CODE, READONLY
			THUMB
			EXTERN  TRANSMIT
				
			EXTERN	GPIOPortF_Handler
			EXTERN	UPDATE_THRESHOLD_BAR
			EXTERN  DISPLAY
				
			EXPORT 	THRESHOLD_MODE
				
				
				
THRESHOLD_MODE	PROC
	
			PUSH 	{LR}

			MOV		R12, #0
			
			BL		CLEAR
			
			
loop		
			BL	CLEARLAST
			
			LDR	R1, =GPIO_PORTF_RIS
			LDR R0, [R1]
			CMP	R0, #0x10
			BEQ.W	SW1pressagain		;when sw1 pressed again exit this mode
			
			
			LDR	R1, =GPIO_PORTF_ICR
			MOV	R2, #0X11
			STR	R2, [R1]
			
			
			
			CMP	R12,#0
			BNE.W	nothing
			
			MOV	R12, #1
			
;******************************************************			
;********************* Thre :     mm ******************	
;******************************************************			
;******************************************************				
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x85
			BL	TRANSMIT
			MOV	R5, #0X42
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]				
			
			
			MOV		R5, #2_00000010			;T
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT
			MOV		R5, #2_11111110
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT			

			MOV		R5, #2_00000000			;h
			BL		TRANSMIT
			MOV		R5, #2_11111110
			BL		TRANSMIT	
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_11100000
			BL		TRANSMIT
				
			MOV		R5, #2_00000000			;r
			BL		TRANSMIT
			MOV		R5, #2_11111000
			BL		TRANSMIT	
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_00001000
			BL		TRANSMIT
			MOV		R5, #2_00011000
			BL		TRANSMIT			
			
			MOV		R5, #2_00000000			;e
			BL		TRANSMIT
			MOV		R5, #2_01110000
			BL		TRANSMIT	
			MOV		R5, #2_10101000
			BL		TRANSMIT
			MOV		R5, #2_10101000
			BL		TRANSMIT
			MOV		R5, #2_10011000
			BL		TRANSMIT	
						
			MOV		R5, #2_00000000			;
			BL		TRANSMIT			
			MOV		R5, #2_00000000			;
			BL		TRANSMIT			
			MOV		R5, #2_01101100			;
			BL		TRANSMIT			
			MOV		R5, #2_01101100			; :
			BL		TRANSMIT							
			MOV		R5, #2_00000000			;
			BL		TRANSMIT			
			MOV		R5, #2_00000000			;
			BL		TRANSMIT				


			
			
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x85 + 55
			BL	TRANSMIT
			MOV	R5, #0X42
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	
			
			
			MOV		R5, #2_11110000			;m
			BL		TRANSMIT
			MOV		R5, #2_00010000	
			BL		TRANSMIT
			MOV		R5, #2_01110000	
			BL		TRANSMIT
			MOV		R5, #2_00010000	
			BL		TRANSMIT
			MOV		R5, #2_11100000	
			BL		TRANSMIT			
			
			MOV		R5, #2_11110000			;m
			BL		TRANSMIT
			MOV		R5, #2_00010000	
			BL		TRANSMIT
			MOV		R5, #2_01110000	
			BL		TRANSMIT
			MOV		R5, #2_00010000	
			BL		TRANSMIT
			MOV		R5, #2_11100000	
			BL		TRANSMIT			
			
						
			
			
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
			MOV	R5, #0X43
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
	

			
			MOV		R5, #2_00000010			;T
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT
			MOV		R5, #2_11111110
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT			

			MOV		R5, #2_00000000			;h
			BL		TRANSMIT
			MOV		R5, #2_11111110
			BL		TRANSMIT	
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_11100000
			BL		TRANSMIT
				
			MOV		R5, #2_00000000			;r
			BL		TRANSMIT
			MOV		R5, #2_11111000
			BL		TRANSMIT	
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_00001000
			BL		TRANSMIT
			MOV		R5, #2_00011000
			BL		TRANSMIT			
			
			MOV		R5, #2_00000000			;e
			BL		TRANSMIT
			MOV		R5, #2_01110000
			BL		TRANSMIT	
			MOV		R5, #2_10101000
			BL		TRANSMIT
			MOV		R5, #2_10101000
			BL		TRANSMIT
			MOV		R5, #2_10011000
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
			
						
			MOV		R5, #2_11111110			;D
			BL		TRANSMIT
			MOV		R5, #2_10000010	
			BL		TRANSMIT
			MOV		R5, #2_10000010	
			BL		TRANSMIT
			MOV		R5, #2_01111100
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT					
			
						
			MOV		R5, #2_01100010			;J
			BL		TRANSMIT
			MOV		R5, #2_10000010
			BL		TRANSMIT
			MOV		R5, #2_01111110	
			BL		TRANSMIT
			MOV		R5, #2_00000010
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT					
			
										
			
			
			
nothing		



			B		loop	

SW1pressagain			
			
			
			
			
			
			
			LDR	R1, =GPIO_PORTF_ICR
			MOV	R2, #0X11
			STR	R2, [R1]
			
			
			
			LDR		R1,=0x20000550
			MOV		R0, #0
			STR		R0, [R1]			;exit thresh mode			
			
			
			
			BL		DISPLAY
			
			BL		UPDATE_THRESHOLD_BAR
			
			POP		{LR}
			BX 		LR



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;	CLEAR WHOLE SCREEN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLEAR		PUSH	{R0,R1,LR}
			MOV		R0,#0
			MOV		R1, #503
LOOPCL		MOV		R5, #0X0
			BL		TRANSMIT
			ADD		R0, #1
			CMP		R0,R1
			BNE		LOOPCL
			POP		{R0,R1,LR}
			BX		LR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					


		
						
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;	this clears 1 row before last one
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLEARLAST	PUSH{R0, R1, R2, LR}
			MOV	R6, #0X46
		
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0X86
			BL	TRANSMIT
			MOV	R5, R6
			BL	TRANSMIT
			
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]
	
			MOV	R2, #0X86
LOOP_C		MOV		R5, #0X0
			BL		TRANSMIT
			ADD	R2, #1
			CMP	R2, #0XCA
			BNE	LOOP_C

			

			POP{R0, R1, R2, LR}
			BX	LR
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;						
						
						








			ENDP
			END