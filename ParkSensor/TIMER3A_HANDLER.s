
TIMER3_ICR			EQU 0x40033024 ; Timer Interrupt Clear


GPIO_PORTD_DATA 	EQU 0x400073FC ;GPIO data


					
					AREA 	motor_handler, CODE, READONLY
					THUMB
					EXPORT 	TIMER3A_HANDLER
					

					
TIMER3A_HANDLER 	PROC
					
					PUSH {LR}
					
					LDR R1,=TIMER3_ICR ;clear interrupt flag
					MOV R0,#0x01
					STR R0,[R1]
					
					
					LDR R1 , =GPIO_PORTD_DATA
					LDR R0 , [R1]

clockwise				
					MOV	R2 , R0	;There are 4 possibilities for motor in1,in2,in3,in4. R2 data is checked to see the present state.
					AND	R2 , #2_00001111
					
					CMP	R2 , #2_00000000
					BEQ	one					
					CMP	R2 , #2_00000001
					BEQ	one
					
					CMP	R2 , #2_00000010
					BEQ two
					CMP	R2 , #2_00000100
					BEQ	three
					CMP	R2 , #2_00001000
					BEQ four

					B	finish
					
one					
					AND	R0 , #2_11110000
					ORR	R0 , #2_00000010
					STR R0 , [R1]

					B	finish
					
					
two				
					AND	R0 , #2_11110000
					ORR	R0 , #2_00000100
					STR R0 , [R1]

					B	finish
					
three			
					AND	R0 , #2_11110000
					ORR	R0 , #2_00001000
					STR R0 , [R1]

					B	finish
					
four			
					AND	R0 , #2_11110000
					ORR	R0 , #2_00000001
					STR R0 , [R1]

					B	finish

					
					
					

finish						
					
					
					POP {LR}


					BX LR
					ENDP
					ALIGN
					END	
