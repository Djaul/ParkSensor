
            AREA        sdata, DATA, READONLY
            THUMB
PWIDTH     	DCB     	"\nDistance(mm): "
			DCB			0x0D
			DCB			0x04			


TIMER1_RIS			EQU 0x4003101C ; Timer Interrupt Status
TIMER1_ICR			EQU 0x40031024 ; Timer Interrupt Clear

TIMER1_TAR			EQU	0x40031048 ; Timer register
	
;GPIO Registers
GPIO_PORTB_DATA		EQU 0x40005040 ; Access PB4
GPIO_PORTB_DIR 		EQU 0x40005400 ; Port Direction




TIMER2_ICR			EQU 0x40032024 ; Timer Interrupt Clear
PORTA_DATA 			EQU 0x400043FC	
					
					AREA 	my_handler_for_timer, CODE, READONLY
					THUMB
					EXPORT 	TIMER2A_HANDLER
					
					EXTERN	ADC_INIT
					EXTERN	printdigit
					EXTERN 	TRANSMIT

					
					EXTERN		CONVRT
					EXTERN		DELAY100
					EXTERN		OutStr
					
					EXTERN		ULTRASOUND_INITS					
					
					EXTERN		BREAKING_MODE
					
					EXTERN		UPDATE_THRESHOLD_BAR

TIMER2A_HANDLER 	PROC
					
					PUSH {LR}

					LDR R1,=TIMER2_ICR ;clear interrupt flag
					MOV R0,#0x01
					STR R0,[R1]






					LDR		R0,=0x20000500
					LDR		R1, [R0]
					



;***************************************************************************************
;***********************ADC PART********************************************************
;***************************************************************************************
					

					PUSH {LR,R0-R12}
					
					BL	ADC_INIT
					
					LDR R4, =0x20004010 	
					LDR R7,[R4]
					
					MOV	R0, #3
					MUL	R7, R0			;r7 = 0 to 999
					
					LDR	R0,=0x20000400
					STR	R7,[R0]
			
					
					MOV		R6, R7			;R6 Has Copy of Number	
					
					
					LDR		R1,=0x20000550
					LDR		R0, [R1]
					CMP		R0, #1								
					BNE		firsttime
					
					
					LDR R1,=PORTA_DATA
					LDR	R0,[R1]
					BIC	R0,#0x40				
					STR	R0,[R1]
					
					MOV	R5, #0xA5
					BL	TRANSMIT
					MOV	R5, #0X42
					BL	TRANSMIT

					LDR R1,=PORTA_DATA
					LDR	R0,[R1]
					ORR	R0,#0x40				
					STR	R0,[R1]						

					LDR			R0,=0X20000670	;has ADC VALUE SET BY THRESH MODE
					STR			R7, [R0]
					
					MOV			R10, #100
					UDIV		R7, R10		;most sign. digit PRINT
					
					LDR			R0,=0X20000730
					STR			R7, [R0]

					BL			printdigit
					
					
					MUL			R7, R10			;KALAN*100
					SUB			R7, R6, R7
					
					MOV			R6, R7			;R6 Has Copy of Number	
					
					MOV			R10, #10
					UDIV		R7, R10		;SECOND DIGIT PRINT
					BL			printdigit
					
					MUL			R7, R10			;KALAN*10
					SUB			R7, R6, R7
					
					MOV			R6, R7			;R6 Has Copy of Number	

					MOV			R10, #1
					UDIV		R7, R10		;last DIGIT PRINT
					
					
					BL			printdigit

					BL	CLEARBOX
					
					BL	UPDATE_THRESHOLD_BAR

					B			skipfirsttime
					
					
firsttime			;first time entering after the initialization of program(threshold value not adjusted by user yet)

					LDR		R1,=0x20000700
					LDR		R0, [R1]
					CMP		R0, #1	
					BNE		notprint
					
					LDR		R1,=0x20000700
					MOV		R0, #0
					STR		R0, [R1]		
					
					
					LDR R1,=PORTA_DATA
					LDR	R0,[R1]
					BIC	R0,#0x40				
					STR	R0,[R1]
					
					MOV	R5, #0xA5
					BL	TRANSMIT
					MOV	R5, #0X42
					BL	TRANSMIT

					LDR R1,=PORTA_DATA
					LDR	R0,[R1]
					ORR	R0,#0x40				
					STR	R0,[R1]						

					
					LDR	R0,=0x20000670	;THIS ADDRESS SAVES SET THRESHOLD VALUE ( INITIALLY 0 ) 
					LDR	R7,[R0]					
					MOV			R6, R7			;R6 Has Copy of Number	
					
					MOV			R10, #100
					UDIV		R7, R10		;most significant digit PRINT
					LDR			R0,=0X20000730
					STR			R7, [R0]
					
					BL			printdigit
					
					
					MUL			R7, R10			;KALAN*100
					SUB			R7, R6, R7
					
					MOV			R6, R7			;R6 Has Copy of Number	
					
					MOV			R10, #10
					UDIV		R7, R10		;SECOND DIGIT PRINT
					BL			printdigit
					
					MUL			R7, R10			;KALAN*10
					SUB			R7, R6, R7
					
					MOV			R6, R7			;R6 Has Copy of Number	

					MOV			R10, #1
					UDIV		R7, R10		;last DIGIT PRINT
					
					BL			printdigit
					
					
					;UPDATE THRESHOLD BAR VISUAL
					BL	CLEARBOX

					BL	UPDATE_THRESHOLD_BAR
					
					
notprint

skipfirsttime

notthreshmod					
				
					
					
					
					
					
					POP {LR,R0-R12}
;***************************************************************************************
;***************************************************************************************
;***************************************************************************************

			


;PROGRESS BAR OVERWRITE					
			
			
			
			


			PUSH {LR,R0-R12}
			
			
			LDR R1, =0x20000550 	
			LDR R0,[R1]				;1 if in threshold setting mode
			
			CMP	R0, #1
			BLEQ.W	threshmode		;in threshold setting mode, don't display the bar
			
			
			LDR R4, =0x20004040 	;MOST SIGNIFICANT DIGIT OF MEASURED DISTANCE USED FOR UPDATING UI BAR
			LDR R7,[R4]
			
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x97
			BL	TRANSMIT
			MOV	R5, #0X44
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	

			
			
			MOV		R5, #2_01111100			;Progress Bar Reset Before Update
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT			
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT				
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT		
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT			
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT				
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT		
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT			
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT				
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT				
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT
			MOV		R5, #2_01000100	
			BL		TRANSMIT					
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
			
			
			
			LTORG
			
			
			
			

			
			
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x97
			BL	TRANSMIT
			MOV	R5, #0X44
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	
			
			;PROGRESS BAR UPDATES ACCORDING TO MEASURED DISTANCE
			CMP		R7, #0		;0 - 99 mm 
			BEQ.W		P0
			
			CMP		R7, #1		;100 - 199 mm 
			BEQ.W	P1
			
			CMP		R7, #2		;200 - 299 mm 
			BEQ.W		P2
			
			CMP		R7, #3		;300 - 399 mm 
			BEQ.W		P3
			
			CMP		R7, #4		;400 - 499 mm 
			BEQ.W		P4
			
			CMP		R7, #5		;500 - 599 mm 
			BEQ.W		P5
			
			CMP		R7, #6		;600 - 699 mm 
			BEQ.W		P6
			
			CMP		R7, #7		;700 - 799 mm 
			BEQ.W		P7
			
			CMP		R7, #8		;800 - 899 mm 
			BEQ.W		P8
			
			CMP		R7, #9		;900 - 999 mm 
			BEQ.W		P9
									
			
			B		noprint
			

gofull				

P9			MOV		R5, #2_01111100			;P0
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P8			MOV		R5, #2_01111100			;P1
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P7			MOV		R5, #2_01111100			;P2
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P6			MOV		R5, #2_01111100			;P3
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P5			MOV		R5, #2_01111100			;P4
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P4			MOV		R5, #2_01111100			;P5
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P3			MOV		R5, #2_01111100			;P6
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P2			MOV		R5, #2_01111100			;P7
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P1			MOV		R5, #2_01111100			;P8
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			
P0			MOV		R5, #2_01111100			;P9
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_01111100		
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT			

noprint


threshmode	


			POP {LR,R0-R12}



			POP {LR}
			BX LR
			ENDP
						
						
						
						
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;	CLEAR Y = CLEAR THRESHOLD BAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLEARBOX	PUSH{R0, R1, R2, LR}
			MOV	R6, #0X45
		
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
						
						
						
						
						
					ALIGN
					END	
