PORTA_DATA 	EQU 0x400043FC	
	
			AREA 	routines, CODE, READONLY
			THUMB
			EXTERN  TRANSMIT
			EXPORT 	DISPLAY
				
				
				
DISPLAY		PROC
	
			PUSH 	{LR}
;******************************************************			
;********************* Meas :      mm *****************	
;******************************************************			
;******************************************************	
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x85
			BL	TRANSMIT
			MOV	R5, #0X41
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	
			
			
			MOV		R5, #2_11111111			;M
			BL		TRANSMIT
			MOV		R5, #2_00000110
			BL		TRANSMIT
			MOV		R5, #2_00011100
			BL		TRANSMIT
			MOV		R5, #2_00000110
			BL		TRANSMIT
			MOV		R5, #2_11111111
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
				
			MOV		R5, #2_00000000			;a
			BL		TRANSMIT
			MOV		R5, #2_01100100
			BL		TRANSMIT	
			MOV		R5, #2_10010100
			BL		TRANSMIT
			MOV		R5, #2_10010100
			BL		TRANSMIT
			MOV		R5, #2_01111100
			BL		TRANSMIT			
			
			MOV		R5, #2_00000000			;s
			BL		TRANSMIT
			MOV		R5, #2_01001100
			BL		TRANSMIT	
			MOV		R5, #2_10010010
			BL		TRANSMIT
			MOV		R5, #2_10010010
			BL		TRANSMIT
			MOV		R5, #2_01100100
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
			MOV	R5, #0X41
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
			
			LTORG						
			
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
			
			MOV		R5, #2_00000000			;N
			BL		TRANSMIT
			MOV		R5, #2_11111110	
			BL		TRANSMIT
			MOV		R5, #2_00011100	
			BL		TRANSMIT
			MOV		R5, #2_01110000	
			BL		TRANSMIT
			MOV		R5, #2_11111110	
			BL		TRANSMIT						
			
			MOV		R5, #2_00000000			;o
			BL		TRANSMIT
			MOV		R5, #2_01100000	
			BL		TRANSMIT
			MOV		R5, #2_10010000
			BL		TRANSMIT
			MOV		R5, #2_10010000
			BL		TRANSMIT
			MOV		R5, #2_01100000	
			BL		TRANSMIT						
						
			MOV		R5, #2_00000000			;r
			BL		TRANSMIT
			MOV		R5, #2_11111000
			BL		TRANSMIT	
			MOV		R5, #2_00010000
			BL		TRANSMIT
			MOV		R5, #2_00001000
			BL		TRANSMIT
			MOV		R5, #2_00000000
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
			
			MOV		R5, #2_00000000			;a
			BL		TRANSMIT
			MOV		R5, #2_01100100
			BL		TRANSMIT	
			MOV		R5, #2_10010100
			BL		TRANSMIT
			MOV		R5, #2_10010100
			BL		TRANSMIT
			MOV		R5, #2_01111100
			BL		TRANSMIT						
			
			MOV		R5, #2_00000000			;l
			BL		TRANSMIT
			MOV		R5, #2_01111110
			BL		TRANSMIT	
			MOV		R5, #2_10000000
			BL		TRANSMIT
			MOV		R5, #2_01000000
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
			
			LTORG
			
			MOV		R5, #2_00000000			;O
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT
			MOV		R5, #2_10000010	
			BL		TRANSMIT
			MOV		R5, #2_10000010	
			BL		TRANSMIT
			MOV		R5, #2_01111100	
			BL		TRANSMIT						
			
			MOV		R5, #2_00000000			;P
			BL		TRANSMIT
			MOV		R5, #2_11111110	
			BL		TRANSMIT
			MOV		R5, #2_00010010	
			BL		TRANSMIT
			MOV		R5, #2_00010010	
			BL		TRANSMIT
			MOV		R5, #2_00011100	
			BL		TRANSMIT						
			
			MOV		R5, #2_00000000			; .
			BL		TRANSMIT
			MOV		R5, #2_11000000	
			BL		TRANSMIT
			MOV		R5, #2_11000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT
			MOV		R5, #2_00000000	
			BL		TRANSMIT						
						
;******************************************************			
;********************* Car Logo ***********************	
;******************************************************			
;******************************************************				
			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			BIC	R0,#0x40				
			STR	R0,[R1]
			
			MOV	R5, #0x85
			BL	TRANSMIT
			MOV	R5, #0X44
			BL	TRANSMIT

			LDR R1,=PORTA_DATA
			LDR	R0,[R1]
			ORR	R0,#0x40				
			STR	R0,[R1]	

			
			MOV		R5, #2_00000000			;CAR Logo
			BL		TRANSMIT
			MOV		R5, #2_01111000	
			BL		TRANSMIT
			MOV		R5, #2_01001100	
			BL		TRANSMIT
			MOV		R5, #2_11100100	
			BL		TRANSMIT
			MOV		R5, #2_11100010
			BL		TRANSMIT			
			MOV		R5, #2_01000010
			BL		TRANSMIT
			MOV		R5, #2_01000010
			BL		TRANSMIT
			MOV		R5, #2_11100010
			BL		TRANSMIT
			MOV		R5, #2_11100100
			BL		TRANSMIT			
			MOV		R5, #2_01001100
			BL		TRANSMIT
			MOV		R5, #2_01111000
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT
			MOV		R5, #2_01100110
			BL		TRANSMIT			
			MOV		R5, #2_00011000
			BL		TRANSMIT			
			MOV		R5, #2_11000011
			BL		TRANSMIT
			MOV		R5, #2_01111110
			BL		TRANSMIT
			MOV		R5, #2_00011000
			BL		TRANSMIT
			MOV		R5, #2_00000000
			BL		TRANSMIT				
			
;******************************************************			
;*****************  EMPTY PROGRESS BAR  ***************
;*****************____||___________********************	
;*****************|   ||:::::::::::|*******************			
;*****************|   ||:::::::::::|*******************	
;******************----------------********************				
;****************** 0 1 234567 8 9 ********************		
			
			MOV		R5, #2_01111100		  ;Progress Bar
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

;******************************************************			
;********************* 0123..9 ************************	
;******************************************************			
;******************************************************	



			
			POP		{LR}
			BX 		LR
			
			ENDP
			END