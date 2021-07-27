PORTA_DATA 	EQU 0x400043FC	
	
			AREA 	updthreshbar, CODE, READONLY
			THUMB
			EXTERN  TRANSMIT
			EXPORT 	UPDATE_THRESHOLD_BAR
				
				
				
UPDATE_THRESHOLD_BAR	PROC
	
			PUSH 	{LR}
;******************************************************			
;********************* thresh update bar : ************	
;******************************************************			
;******************************************************	

			LDR R1, =0x20000550 	
			LDR R0,[R1]
			
			CMP	R0, #1				;1 if in threshold setting mode
			BLEQ.W	threshmode

			LDR R0, =0X20000730		;get ADC most sign. digit to R7
			LDR R1, [R0]
				
			CMP	R1, #0				;arrange where to place "T" symbol to show the arranged threshold at the UI bar
			BEQ	go0
			
				
			CMP	R1, #1
			BEQ	go1
			
				
			CMP	R1, #2
			BEQ	go2
			
				
			CMP	R1, #3
			BEQ	go3
			
				
			CMP	R1, #4
			BEQ	go4
			
				
			CMP	R1, #5
			BEQ	go5
			
				
			CMP	R1, #6
			BEQ	go6
			
				
			CMP	R1, #7
			BEQ	go7
			
				
			CMP	R1, #8
			BEQ	go8
			
				
			CMP	R1, #9
			BEQ	go9
			
	
go0						
			MOV	R5, #0x97			
			
			B	golast
			
	
go1						
			MOV	R5, #0x97 + 5		
			
			B	golast
				
	
go2						
			MOV	R5, #0x97 + 10			
			
			B	golast
				
	
go3						
			MOV	R5, #0x97 + 15			
			
			B	golast
				
	
go4						
			MOV	R5, #0x97 + 20			
			
			B	golast
				
	
go5						
			MOV	R5, #0x97 + 25			
			
			B	golast
				
	
go6						
			MOV	R5, #0x97 + 30			
			
			B	golast
				
	
go7						
			MOV	R5, #0x97 + 35			
			
			B	golast
				
	
go8						
			MOV	R5, #0x97 + 40			
			
			B	golast
				
	
go9						
			MOV	R5, #0x97 + 45			
			
			B	golast
				
	

			
			
golast

			LTORG
			
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			;MOV	R5, #0x97
			BL	TRANSMIT
			MOV	R5, #0X45
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	
	
			MOV		R5, #2_11111110	;T
			BL		TRANSMIT
			MOV		R5, #2_11111010
			BL		TRANSMIT
			MOV		R5, #2_11000010
			BL		TRANSMIT			
			MOV		R5, #2_11111010
			BL		TRANSMIT
			MOV		R5, #2_11111110
			BL		TRANSMIT			
			
threshmode

			POP	{LR}
			BX	LR
			ENDP
			END