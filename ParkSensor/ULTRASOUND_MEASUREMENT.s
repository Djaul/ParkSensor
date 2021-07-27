					AREA        sdata, DATA, READONLY
					THUMB
PWIDTH     			DCB     	"\nDistance(mm): "
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


					AREA 	ultrasoundmeas, CODE, READONLY
					THUMB
					EXPORT 	ULTRASOUND_MEASUREMENT
					
					EXTERN	printdigit
					EXTERN 	TRANSMIT

					
					EXTERN		CONVRT
					EXTERN		DELAY100
					EXTERN		OutStr


ULTRASOUND_MEASUREMENT	PROC



;***************************************************************************************
;***********************ULTRASOUND PART*************************************************
;***************************************************************************************
			PUSH {LR,R0-R12}		
			
loop		LDR R1, =TIMER1_RIS
			LDR R2, [R1]
			ANDS R2, #0x04 ; isolate CAERIS bit
			BEQ loop ; if no capture, then loop
			
			; clear interrupt flag
			LDR R0, =TIMER1_ICR 
			MOV	R1, #0x04
			STR R1, [R0]
			
			; take timer value
			LDR R6, =TIMER1_TAR	
			LDR	R6, [R6]
			LSR R6, #4
			
			LDR R0, =GPIO_PORTB_DATA
			LDR R0, [R0]
			CMP	R0, #0x10
			BNE	fall
rise	
			MOV R9, #1
			SUBS R8, #1
			BEQ	print
			MOV	R11, R6
			B   loop
fall	
			MOV R9, #2
			SUBS R8, #1
			BEQ	print			
			MOV	R12, R6
			B	loop
			
			
						
print		MOV	R8, #3
			CMP R9, #0
			BNE	continue

			LDR R0, =TIMER1_ICR 
			MOV	R1, #0x04
			STR R1, [R0]
			B	loop

			
continue	MOV	R0, #0xFFE
			CMP	R12, R0
			BEQ	finish
			
			CMP	R9, #2
			BEQ	negprint
			

			;PULSE WIDTH
			SUB	R7, R11, R12
			B	skip
negprint			
			SUB	R7, R11, R6
skip			
			MOV	R1, R7
			LDR R5, =PWIDTH
			BL	OutStr
			
			CMP	R7, #50
			BLT	noise
			
			MOV	R4, #17
			MUL	R7, R4
			MOV	R4, #100
			UDIV R7, R4
			
			BL CONVRT
			
			MOV	R1, #999 ;limit the maximum displayed distance to 999 mm
			CMP	R7, R1
			BLT	nochange ;if measured value is lower than 999mm, don't overwrite the value
			
			MOV	R7, R1
			
nochange			
			LDR			R8, =0x20004060	;result is loaded to this address
			STR			R7, [R8]
			
					
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0xA5
			BL	TRANSMIT
			MOV	R5, #0X41	;Arrange (x,y) coordinate to be written on the screen
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	
					
			MOV			R6, R7		;R6 Has Copy of Number	
			
			MOV			R10, #100
			UDIV		R7, R10		;Most Significant Digit PRINT
			LDR			R8, =0x20004040	;Most Significant Digit is loaded to this address
			STR			R7, [R8]
			BL			printdigit	;prints digit to screen
			

			
			MUL			R7, R10		;KALAN*100
			SUB			R7, R6, R7
			
			MOV			R6, R7		;R6 Has Copy of Number	
			
			
			MOV			R10, #10
			UDIV		R7, R10		;SECOND DIGIT PRINT
			BL			printdigit
			
			
								
			MUL			R7, R10		;KALAN*10
			SUB			R7, R6, R7
			
			MOV			R6, R7		;R6 Has Copy of Number	

			MOV			R10, #1
			UDIV		R7, R10		;Least Significant DIGIT PRINT
			
			BL			printdigit
					
noise			

finish
			MOV	R9, #0

			
delay		BL	DELAY100
			BL	DELAY100
			BL	DELAY100
			BL	DELAY100
			BL	DELAY100
			
			LDR R0, =TIMER1_ICR 
			MOV	R1, #0x04
			STR R1, [R0]					

			POP {LR,R0-R12}		
					
					
			BX	LR
			ENDP
			END
				
					
;***************************************************************************************
;***************************************************************************************
