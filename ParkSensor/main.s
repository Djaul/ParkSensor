;Yavuz TACKIN 2261618 TERM PROJECT
;***********************************************************************
; PARK SENSOR:
;
; Initially, the threshold is set to 0. User can adjust by pressing sw1
;
;***********************************************************************
;***********************************************************************
; Pin Connections
;-----------------------
;- 5K POT MID PIN = PE3 (GND - PE3 - 3.3V)
;
;- LCD SCREEN (3.3 V)
;RST = PA7
;DC  = PA6
;CE  = PA3
;DIR = PA5
;CLK = PA2
;
;- Ultrasound Sensor (Vbus)
;Echo = PB4
;TRIG = PB6
;
;- Step Motor (Vbus)
;In1 = PD0
;In2 = PD1
;In3 = PD2
;In4 = PD3
;
;***************************************************************
;***************************************************************

PORTA_DATA 			EQU 0x400043FC
	
					AREA main , CODE, READONLY
					THUMB
										
					EXTERN LCD_INIT		;Display Related Subroutines
					EXTERN DISPLAY
					EXTERN TRANSMIT
		
					EXTERN INIT_TIMER2	;TIMER RELATED INITIALIZATIONS
					EXTERN TIMER2A_HANDLER					
					
					EXTERN TIMER3A_HANDLER
					EXTERN INIT_TIMER3
					
					EXTERN MOTOR_GPIO	;Step Motor Gpio Inits
					
					EXTERN ULTRASOUND_INITS
					EXTERN ULTRASOUND_MEASUREMENT
					EXTERN GPIOPortF_Handler
						
					EXTERN GPIO_INIT
					
					EXTERN BREAKING_MODE
					
					EXPORT __main




__main				PROC
					
					BL ULTRASOUND_INITS			;TRIGGER & ECHO PINS
					
					BL MOTOR_GPIO				;PORT D MOTOR GPIO INITS
					
					BL INIT_TIMER3
					BL INIT_TIMER2				;init all timers

					BL GPIO_INIT				;init SSI, PORT B and PORT F(switches) & PORT_F_HANDLER DECLARED HERE
					BL LCD_INIT					;init display


					LDR R1,=PORTA_DATA		
					LDR	R0,[R1]
					ORR	R0,#0x40				
					STR	R0,[R1]
					
					BL	CLEAR					;CLEAR DISPLAY (implementation is at the bottom of this file)
					
					BL	DISPLAY					;DISPLAY INITIAL SCREEN CONFIGURATION
					
					LDR	R0,=0x20000700
					MOV	R1, #1
					STR	R1,[R0]					
					
					LDR	R0,=0x20000670	;INITIAL THRESHOLD VALUE IS SET TO 0 BEFORE ADJUSTMENT
					MOV	R1, #0
					STR	R1,[R0]					
					
					
					
;Infinite Loop Starts Here	
					
fin					
				
					BL	ULTRASOUND_MEASUREMENT
					
;***************************CHECK TO ENTER BREAKING MODE************

					LDR R4, =0X20000670 	
					LDR R0,[R4]				;R0 HAS Threshold VALUE
					
					
					LDR R4, =0x20004060 	;R1 HAS DISTANCE VALUE
					LDR R1,[R4]				
					
					;if measured distance value is lower than the threshold, enter breaking mode
					CMP	R1,R0
					BLLT	BREAKING_MODE	

;*******************************************************************
							
					
					B	fin
;Ends Here					

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;	CLEAR SCREEN INITIALLY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLEAR				PUSH	{R0,R1,LR}
					MOV		R0,#0
					MOV		R1, #503
LOOPCL				MOV		R5, #0X0
					BL		TRANSMIT
					ADD		R0, #1
					CMP		R0,R1
					BNE		LOOPCL
					POP		{R0,R1,LR}
					BX		LR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					
					
					

					
					ALIGN
					ENDP
					END