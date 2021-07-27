
	;EQU PART
	
; ADC Registers
RCGCADC 		EQU 		0x400FE638 		; ADC clock register
; ADC0 base address EQU 0x40038000
ADC0_ACTSS 		EQU 		0x40038000 		; Sample sequencer (ADC0 base address)
ADC0_RIS 		EQU			0x40038004 		; Interrupt status
ADC0_IM 		EQU			0x40038008 		; Interrupt select
ADC0_EMUX 		EQU			0x40038014 		; Trigger select
ADC0_PSSI 		EQU			0x40038028 		; Initiate sample
ADC0_SSMUX3 	EQU			0x400380A0 		; Input channel select
ADC0_SSCTL3 	EQU			0x400380A4 		; Sample sequence control
ADC0_SSFIFO3 	EQU 		0x400380A8 		; Channel 3 results
ADC0_PC 		EQU 		0x40038FC4 		; Sample rate
ADC0_ISC		EQU			0x4003800C		; Interrupt Status and Clear 
; GPIO Registers
RCGCGPIO 		EQU 		0x400FE608		; GPIO clock register
;PORT E base address EQU 0x40024000
PORTE_DEN 		EQU 		0x4002451C		; Digital Enable
PORTE_PCTL 		EQU 		0x4002452C		; Alternate function select
PORTE_AFSEL 	EQU 		0x40024420		; Enable Alt functions
PORTE_AMSEL 	EQU 		0x40024528		; Enable analog

PORTA_DATA 		EQU 0x400043FC
	


			AREA    adcinit, READONLY, CODE
			THUMB
			EXPORT  ADC_INIT	



ADC_INIT	PROC
	
			
			
			LDR 		R1, =RCGCADC 		; Turn on ADC clock
			LDR			R0, [R1]
			ORR 		R0, R0, #0x01 		; set bit 0 to enable ADC0 clock
			STR 		R0, [R1]
			NOP
			NOP
			NOP 							; Let clock stabilize
			LDR 		R1, =RCGCGPIO 		; Turn on GPIO clock
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x10 		; set bit 4 to enable port E clock 
			STR 		R0, [R1]
			NOP
			NOP
			NOP 							; Let clock stabilize
			; Setup GPIO to make PE3 input for ADC0
			; Enable alternate functions
			LDR 		R1, =PORTE_AFSEL
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x08 		; set bit 3 to enable alt functions on PE3
			STR 		R0, [R1]
			; PCTL does not have to be configured
			; since ADC0 is automatically selected when
			; port pin is set to analog.
			; Disable digital on PE3
			LDR 		R1, =PORTE_DEN
			LDR 		R0, [R1]
			BIC 		R0, R0, #0x08 		; clear bit 3 to disable digital on PE3
			STR 		R0, [R1]
			; Enable analog on PE3
			LDR 		R1, =PORTE_AMSEL
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x08 		; set bit 3 to enable analog on PE3
			STR 		R0, [R1]
			; Disable sequencer while ADC setup
			LDR 		R1, =ADC0_ACTSS
			LDR 		R0, [R1]
			BIC 		R0, R0, #0x08 		; clear bit 3 to disable SS3
			STR 		R0, [R1]
			; Select trigger source
			LDR 		R1, =ADC0_EMUX
			LDR 		R0, [R1]
			BIC 		R0, R0, #0xF000 	; clear bits 15:12 to select SOFTWARE
			STR 		R0, [R1] 			; trigger
			; Select input channel
			LDR 		R1, =ADC0_SSMUX3
			LDR 		R0, [R1]
			BIC 		R0, R0, #0x000F		; clear bits 3:0 to select AIN0
			STR 		R0, [R1]
			; Config sample sequence
			LDR 		R1, =ADC0_SSCTL3
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x06 		; set bits 2:1 (IE0, END0)
			STR 		R0, [R1]
			; Set sample rate
			LDR 		R1, =ADC0_PC
			LDR 		R0, [R1] 
			ORR 		R0, R0, #0x01 		; set bits 3:0 to 0x1 for 125k sps
			STR 		R0, [R1]
			; Done with setup, enable sequencer
			LDR 		R1, =ADC0_ACTSS
			LDR 		R0, [R1]
			ORR 		R0, R0, #0x08 		; set bit 3 to enable seq 3
			STR 		R0, [R1] 			; sampling enabled but not initiated yet
			; start sampling routine
			
			
			
			
			LDR 		R2, =ADC0_PSSI 		; init
			LDR 		R0, [R2]
			ORR 		R0, R0, #0x08 		; SS3
			STR 		R0, [R2]
			
			LDR 		R3, =ADC0_RIS 		; interrupt 
loop 		LDR 		R0, [R3]
			ANDS 		R0, R0, #8 
			BEQ 		loop
			
			
			LDR 		R4, =ADC0_SSFIFO3 	
			LDR 		R7,[R4]

			
			MOV			R0, #1050		;instead of mapping 3.3V to 0V mapped to narrower range due to the microcontroller output not being 3.3V but threshold range is limited to 0 and 999 still
			MOV			R1, #10000
			MUL			R7, R0
			UDIV		R7, R1
;this small adjustment is made since the development board can't handle the drawn current from stepper motor and outputs 3.0 V instead of 3.3V despite a linear regulator
			SUB			R7, #80			
			CMP			R7, #0
			BLT			settozero
			
			LDR			R8, =333
			CMP			R7, R8
			BHI			setto333
back			
			LDR			R8, =0x20004010	;result is loaded to this address
			STR			R7, [R8]
			
			
			LDR 		R10,	=ADC0_ISC
			MOV 		R0, #8
			STR 		R0, [R10] 			; clear 
			
			
			BX LR
			ENDP
			
settozero				
			MOV	R7, #0
			B	back
setto333	
			LDR	R7, =333
			B	back
			
			END