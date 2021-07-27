					AREA        sdata, DATA, READONLY
					THUMB


;===================
; Timer 0 registers
;===================
;pwm timer
TIMER0_CFG			EQU 0x40030000
TIMER0_TAMR			EQU 0x40030004
TIMER0_CTL			EQU 0x4003000C
TIMER0_RIS			EQU 0x4003001C ; Timer Interrupt Status
TIMER0_ICR			EQU 0x40030024 ; Timer Interrupt Clear
TIMER0_TAILR		EQU 0x40030028 ; Timer interval
TIMER0_TAMATCHR 	EQU 0x40030030 ; Match Register
TIMER0_TAPR			EQU 0x40030038
TIMER0_TAR			EQU	0x40030048 ; Timer register
		
TIMER1_CFG			EQU 0x40031000
TIMER1_TAMR			EQU 0x40031004
TIMER1_CTL			EQU 0x4003100C
TIMER1_IMR			EQU 0x40031018
TIMER1_RIS			EQU 0x4003101C ; Timer Interrupt Status
TIMER1_ICR			EQU 0x40031024 ; Timer Interrupt Clear
TIMER1_TAILR		EQU 0x40031028 ; Timer interval
TIMER1_TAMATCHR		EQU 0x40031030	; Match Register
TIMER1_TAPR			EQU 0x40031038
TIMER1_TAR			EQU	0x40031048 ; Timer register
	
;GPIO Registers
GPIO_PORTB_DATA		EQU 0x40005040 ; Access PB4
GPIO_PORTB_DIR 		EQU 0x40005400 ; Port Direction
GPIO_PORTB_AFSEL	EQU 0x40005420 ; Alt Function enable
GPIO_PORTB_DEN 		EQU 0x4000551C ; Digital Enable
GPIO_PORTB_AMSEL 	EQU 0x40005528 ; Analog enable
GPIO_PORTB_PCTL 	EQU 0x4000552C ; Alternate Functions

;System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCTIMER 	EQU 0x400FE604 ; GPTM Gate Control

			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	ULTRASOUND_INITS

;---------------------------------------------------					
ULTRASOUND_INITS	PROC


			LDR R1, =SYSCTL_RCGCGPIO ; start GPIO clock
			LDR R0, [R1]
			ORR R0, R0, #0x02 ; set bit 2 for port B
			STR R0, [R1]
			NOP ; allow clock to settle
			NOP
			NOP
			LDR R1, =GPIO_PORTB_DIR ; set direction of PB4
			LDR R0, [R1]
			BIC R0, #0x10 			; clear bit 4 for INPUT
			STR R0, [R1]
			
			LDR R1, =GPIO_PORTB_AFSEL ; enable port function
			LDR R0, [R1]
			ORR R0, #0x50		; set bit4 for alternate fuction on PB4
			STR R0, [R1]
			; Set bits 27:24 of PCTL to 7 to enable TIMER1A on PB4
			LDR R1, =GPIO_PORTB_PCTL
			LDR R0, [R1]
			ORR R0, R0, #0x00070000
			ORR R0, R0, #0x07000000
			STR R0, [R1]
		; clear AMSEL to disable analog
			LDR R1, =GPIO_PORTB_AMSEL
			MOV R0, #0
			STR R0, [R1]
			
			LDR R1, =GPIO_PORTB_DEN ; enable port digital
			LDR R0, [R1]
			ORR R0, R0, #0x50
			STR R0, [R1]





		;====================
		; Configure TIMER0-A
		;====================
		
			LDR R1, =SYSCTL_RCGCTIMER ; Start Timer0
			LDR R2, [R1]
			ORR R2, R2, #0x01
			STR R2, [R1]
			NOP ; allow clock to settle
			NOP
			NOP
			LDR R1, =TIMER0_CTL ; disable timer during setup LDR R2, [R1]
			LDR R2, [R1]
			BIC R2, R2, #0x01
			STR R2, [R1]
			LDR R1, =TIMER0_CFG ; set 16 bit mode
			LDR R2, [R1]
			ORR R2, #0x04
			STR R2, [R1]
			LDR R1, =TIMER0_TAMR
			LDR R2, [R1]
			ORR R2, #0xA ; set to pwm
			STR R2, [R1]
			
			LDR R1, =TIMER0_CTL ; pwml set
			LDR R2, [R1]
			ORR R2, R2, #0x40
			STR R2, [R1]
	;1 prescaler
			LDR R1, =TIMER0_TAPR
			LDR R2, [R1]
			ORR R2, #1
			STR R2, [R1] 
	;
			LDR R1, =TIMER0_TAILR ; initialize match clocks
			LDR R2, [R1]
			LDR R2, =19200
			STR R2, [R1]
	;for dc	
			LDR R1, =TIMER0_TAMATCHR 
			LDR R2, [R1]
			LDR R2, =1600 ; high
			STR R2, [R1]

			LDR R1, =TIMER0_CTL
			LDR R2, [R1]
			ORR R2, R2, #0x01 ; set bit0 to enable
			STR R2, [R1] ; and bit 1 to stall on debug





			LDR R1, =SYSCTL_RCGCTIMER ; Start Timer1
			LDR R2, [R1]
			ORR R2, R2, #0x02
			STR R2, [R1]
			NOP ; allow clock to settle
			NOP
			NOP
			
			LDR R1, =TIMER1_CTL ; disable timer during setup
			LDR R2, [R1]
			BIC R2, R2, #0x01
			STR R2, [R1]
		; set to 16bit Timer Mode
			LDR R1, =TIMER1_CFG
			MOV R2, #0x04 ; set bits 2:0 to 0x04 for 16bit timer
			STR R2, [R1]
		; set to EDGE TIME, count DOWN
			LDR R1, =TIMER1_TAMR
			MOV R2, #0x1F 
			STR R2, [R1]
		; set edge detection to both
			LDR R1, =TIMER1_CTL
			LDR R2, [R1]
			ORR R2, R2, #0x0E ; set bits 3:2 to 0x03
			STR R2, [R1]
			
			LDR R1, =TIMER1_TAPR
			MOV R2, #15 ; divide clock by 16 to
			STR R2, [R1] ; get 1us clocks
			; set start value
			LDR R1, =TIMER1_TAILR
			LDR R2, =0xFFFF
			STR R2, [R1]
		
			LDR R1, =TIMER1_IMR ; disable timeout interrupt
			MOV R2, #0x00
			STR R2, [R1]

			; Enable timer
			LDR R1, =TIMER1_CTL
			LDR R2, [R1]
			ORR R2, R2, #0x0F ; set bit0 to enable, bit 1 to stall on debug 
			STR R2, [R1] ; and bit2:3 to trigger on BOTH EDGES
			MOV	R8, #3
			
			
			
			BX	LR
			ENDP
			END