
; GPIO Registers
RCGCGPIO 		EQU 0x400FE608 ; GPIO clock register
;PORT A base address EQU 0x40004000
PORTA_DEN 		EQU 0x4000451C ; Digital Enable
PORTA_PCTL		EQU 0x4000452C ; Alternate function select
PORTA_AFSEL 	EQU 0x40004420 ; Enable Alt functions
PORTA_AMSEL 	EQU 0x40004528 ; Enable analog
PORTA_DIR		EQU	0x40004400	;Set direction
PORTA_DATA 		EQU 0x400043FC
;PORT E base address EQU 0x40024000
PORTE_DEN 		EQU 0x4002451C ; Digital Enable
PORTE_PCTL		EQU 0x4002452C ; Alternate function select
PORTE_AFSEL 	EQU 0x40024420 ; Enable Alt functions
PORTE_AMSEL 	EQU 0x40024528 ; Enable analog
PORTE_DIR		EQU	0x40024400	;Set direction

; ADC Registers
RCGCADC 		EQU 0x400FE638 ; ADC clock register
;ADC0 base address EQU 0x40038000
ADC0_ACTSS 		EQU 0x40038000 ; Sample sequencer (ADC0 base address)
ADC0_RIS 		EQU 0x40038004 ; Interrupt status
ADC0_IM 		EQU 0x40038008 ; Interrupt select
ADC0_EMUX 		EQU 0x40038014 ; Trigger select
ADC0_PSSI 		EQU 0x40038028 ; Initiate sample
ADC0_SSMUX2 	EQU 0x40038080 ; Input channel select
ADC0_SSCTL2 	EQU 0x40038084 ; Sample sequence control
ADC0_SSFIFO2 	EQU 0x40038088 ; Channel 2 results
ADC0_PP 		EQU 0x40038FC4 ; Sample rate
ADC0_SSMUX3 	EQU 0x400380A0 ; Input channel select
ADC0_SSCTL3 	EQU 0x400380A4 ; Sample sequence control
ADC0_SSFIFO3 	EQU 0x400380A8 ; Channel 3 results	
ADC0_SSPRI 		EQU 0x40038020
;SSI REGISTERS	
RCGCSSI			EQU	0X400FE61C
SSICR0			EQU	0X40008000
SSICR1			EQU	0X40008004
SSICPSR			EQU	0X40008010

GPIO_PORTB_DIR 		EQU 0x40005400;GPIO direction register
GPIO_PORTB_AFSEL 	EQU 0x40005420;GPIO alternate function select
GPIO_PORTB_DEN 		EQU 0x4000551C;GPIO Digital enable regisgter
GPIO_PORTB_AMSEL 	EQU 0x40005528;
GPIO_PORTB_PCTL 	EQU 0x4000552C;pctl register for timer function selection 
IOB 				EQU 0x00
SYSCTL_RCGCGPIO 	EQU 0x400FE608;run clock gate for gpio					



;Nested Vector Interrupt Controller registers
NVIC_EN0_INT30		EQU 0x40000000 ; Interrupt 19 enable
NVIC_EN0			EQU 0xE000E100 ; IRQ 0 to 31 Set Enable Register
NVIC_PRI7			EQU 0xE000E41C ; IRQ 28 to 31 Priority Register




;PORT F base address EQU 0x40025000
PORTF_DEN 		EQU 0x4002551C ; Digital Enable
PORTF_PCTL		EQU 0x4002552C ; Alternate function select
PORTF_AFSEL 	EQU 0x40025420 ; Enable Alt functions
PORTF_AMSEL 	EQU 0x40025528 ; Enable analog
PORTF_DIR		EQU	0x40025400	;Set direction
PORTF_DATA 		EQU 0x400253FC
PORTF_LOCK		EQU	0X40025520
GPIO_LOCK_KEY	EQU	0x4C4F434B
GPIO_PORTF_CR_R	EQU	0x40025524
PORTF_PUR		EQU	0x40025510
GPIO_PORTF_IS	EQU	0X40025404
GPIO_PORTF_IBE	EQU	0X40025408
GPIO_PORTF_IEV	EQU	0X4002540C
GPIO_PORTF_IM	EQU	0X40025410
GPIO_PORTF_RIS	EQU	0X40025414	
GPIO_PORTF_ICR	EQU	0X4002541C
	
	
TIMER2_CTL		EQU 0x4003200C;TIMER0   (en/dis,fall/ris/both)	
	
	

			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	GPIO_INIT
			EXPORT	GPIOPortF_Handler
			
			EXTERN	THRESHOLD_MODE		
			EXTERN  DELAY100
			

GPIO_INIT	PROC
			LDR R1, =RCGCSSI 
			LDR R0, [R1]
			ORR R0, R0, #0x01 
			STR R0, [R1]
			NOP
			NOP
			NOP 
			NOP
			NOP
			
			LDR R1, =RCGCADC ; Turn on ADC clock
			LDR R0, [R1]
			ORR R0, R0, #0x01 ; set bit 0 to enable ADC0 clock
			STR R0, [R1]
			NOP
			NOP
			NOP ; Let clock stabilize
			NOP
			NOP
			
			LDR R1, =RCGCGPIO ; Turn on GPIO clock
			LDR R0, [R1]
			ORR R0, R0, #0x31 
			STR R0, [R1]
			NOP
			NOP
			NOP ; Let clock stabilize
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
;;;;;;;;;;	SSI INITS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;						
			LDR R1, =PORTA_DEN
			LDR R0, [R1]
			ORR R0, R0, #0xEC 
			STR R0, [R1]
			
			LDR R1, =PORTA_DIR
			MOV R0, #0XEC 
			STR R0, [R1]
			
			LDR	R1, =PORTA_DATA
			LDR	R0,[R1]
			ORR	R1,#0x80		
			STR	R1,[R0]
			
			LDR R1, =PORTA_AFSEL
			LDR R0, [R1]
			ORR R0, R0, #0x2C 
			STR R0, [R1]

			LDR R1, =PORTA_PCTL
			LDR R0, [R1]
			MOV32 R0, #0x00202200 
			STR R0, [R1]
	
			LDR R1, =SSICR1
			LDR R0, [R1]
			BIC	R0, R0, #0X06
			STR R0, [R1]
			
				
			LDR	R1, =SSICPSR
			MOV	R0, #6
			STR R0, [R1]
			
			LDR R1, =SSICR0
			MOV32 R0, #0XC7
			STR R0, [R1]

			LDR R1, =SSICR1
			LDR R0, [R1]
			ORR	R0, R0, #0X02
			STR R0, [R1]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
;;;;;;;;;;	TIMER GPIO PB0, 4, 6 INITIALIZE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

			LDR R1,=SYSCTL_RCGCGPIO
			LDR R0,[R1]
			ORR R0,#0x2;enable port B
			STR R0,[R1]
			NOP 
			NOP
			NOP
			
			LDR R1,=GPIO_PORTB_DIR
			LDR R0,[R1]
			BIC R0,#0xFF
			ORR R0,#0x01;set PB0 as OUTPUT , PB4 INPUT
			STR R0,[R1]
			
			LDR R1,=GPIO_PORTB_DEN
			LDR R0,[R1]
			BIC R0,#0xFF
			ORR R0,#0x51; digital enabled
			STR R0,[R1]
			
		; clear AMSEL to disable analog
			LDR R1, =GPIO_PORTB_AMSEL
			MOV R0, #0
			STR R0, [R1]			
			
			LDR R1, =GPIO_PORTB_AFSEL
			LDR R0,[R1]
			BIC R0,#0xFF
			ORR R0,#0x51 ;set the pin0, 4, 6 as alternative function
			STR R0,[R1]
			
			LDR R1,=GPIO_PORTB_PCTL
			LDR R0,[R1]
			BIC R0,#0xFF
			ORR R0,#0x00000007;for PB0,4,6: 7 means it is TIMER on the table!
			ORR R0,#0x00070000
			ORR R0,#0x07000000			
			STR R0,[R1]			
			
					
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
;;;;;;;;;;	GPIO PORT F FOR SWITCHES INITIALIZE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
			
			
			
			LDR R1 , =RCGCGPIO
			LDR R0 , [ R1 ]
			ORR R0 , R0 , #0x20;Port F clock enabled
			STR R0 , [ R1 ]
			NOP		;Wait for clock to stabilize
			NOP
			NOP
			LDR R1, =PORTF_LOCK
			LDR	R0, =GPIO_LOCK_KEY 
			STR	R0, [R1]
			LDR R1, =GPIO_PORTF_CR_R	;UNLOCK SWITCH
			ORR R0, #0x11
			STR R0, [R1]			

			STR R0 , [ R1 ]
			LDR R1 , =PORTF_AFSEL
			LDR R0 , [ R1 ]
			BIC R0 , #0x11
			STR R0 , [ R1 ]
			LDR R1 , =PORTF_DEN
			LDR R0 , [ R1 ]
			ORR R0 , #0x11
			STR R0 , [ R1 ]
			LDR R1 , =PORTF_PUR			;PULL UP
			LDR R0 , [ R1 ]
			ORR R0 , #0x11
			STR R0 , [ R1 ]

			LDR	R1, =GPIO_PORTF_IS
			LDR R2, =GPIO_PORTF_IBE
			LDR R3, =GPIO_PORTF_IEV
			LDR R4, =GPIO_PORTF_IM
			LDR R5, =GPIO_PORTF_ICR
			MOV R0, #0x00
			STR R0, [R1]
			STR R0, [R2]
			STR	R0, [R3]
			MOV	R0, #0x11
			STR R0, [R4]
			STR R0, [R5]	

			LDR R1, =NVIC_PRI7
			LDR R2, [R1]
			ORR R2, R2, #0x00800000 ;
			STR R2, [R1]
			LDR R1, =NVIC_EN0
			MOV R2, #0x40800000 ; set bit 19 to enable interrupt 19
			STR R2, [R1]


			BX	LR
			ENDP
			
GPIOPortF_Handler	PROC
			PUSH	{R0, R1, R2, R4, R5, LR}

			BL	DELAY100			;debouncing after GPIO Interrupt
			BL	DELAY100
			LDR	R1, =GPIO_PORTF_RIS
			LDR R0, [R1]
			
			MOV	R5, #0
			
			CMP	R0, #0x01
			BEQ	SW2press
			
			CMP	R0, #0x10
			BEQ	SW1press
			
SW2press			
			
			LDR	R1, =GPIO_PORTF_ICR
			MOV	R2, #0X11
			STR	R2, [R1]
						
			LDR		R1,=0x20000500
			MOV		R0, #0
			STR		R0, [R1]			;exit brake mode
			
			B		skipsw1
			
			
SW1press	
			
			LDR	R1, =GPIO_PORTF_ICR
			MOV	R2, #0X11
			STR	R2, [R1]

			LDR		R1,=0x20000550
			MOV		R0, #1
			STR		R0, [R1]			;enter threshold setting mode in first sw1 press		
			
			BL	THRESHOLD_MODE

skipsw1			
			
			POP	{R0, R1, R2, R4, R5, LR}
			BX	LR
			
			ENDP
			ALIGN
			END