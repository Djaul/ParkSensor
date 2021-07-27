RELOAD_VALUE 		EQU 0XFFFF; reload value
SYSCTL_RCGCTIMER 	EQU 0x400FE604 ; GPTM Gate Control
; 16/32 Timer Registers
TIMER2_CFG			EQU 0x40032000;;for A and B 16bit/32bit selection,0x04 =16bit
TIMER2_TAMR			EQU 0x40032004;Timer Function;[1:0] 1=oneshot,2=periodic,3=capture
;[2]=0 edge count,1=edge time , [4]=0 count down,1=up
TIMER2_CTL			EQU 0x4003200C;en/dis,fall/ris/both
TIMER2_IMR			EQU 0x40032018

TIMER2_TAILR		EQU 0x40032028 ; Timer interval;
;in 16bit,value for count up or down .(if down, up to this number)
TIMER2_TAPR			EQU 0x40032038 ;presecalar
	

;Nested Vector Interrupt Controller registers
NVIC_EN0			EQU 0xE000E100 ; IRQ 0 to 31 Set Enable Register
NVIC_PRI5			EQU 0xE000E414 ; PRI 4 --> IRQ 16 to 19 Priority Register & PRI 5 LATER
	
;***********************
; Timer 0 registers

;pwm timer
TIMER0_CFG			EQU 0x40030000
TIMER0_TAMR			EQU 0x40030004
TIMER0_CTL			EQU 0x4003000C
TIMER0_RIS			EQU 0x4003001C ; Timer Interrupt Status
TIMER0_ICR			EQU 0x40030024 ; Timer Interrupt Clear
TIMER0_TAILR		EQU 0x40030028 ; Timer Interval
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
TIMER1_TAMATCHR		EQU 0x40031030 ; Match Register
TIMER1_TAPR			EQU 0x40031038
TIMER1_TAR			EQU	0x40031048 ; Timer register

;System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control

					AREA init_timer2 , CODE, READONLY
					THUMB
					EXPORT INIT_TIMER2
					
;**********************TIMER2 INIT*********************
INIT_TIMER2 PROC

		LDR R1,=SYSCTL_RCGCTIMER ;clock for timer
		LDR R0,[R1]
		ORR R0,#0x04
		STR R0,[R1]
		NOP
		NOP
		NOP
		
		LDR R1,=TIMER2_CTL;disable timer first
		LDR R0,[R1]
		BIC R0,#0x01
		STR R0,[R1]
		
		LDR R1,=TIMER2_CFG;
		LDR R0,[R1]
		ORR R0,#0x4 ;select 16-bit MODE
		STR R0,[R1]
		
		LDR R1,=TIMER2_TAMR;
		LDR R0,[R1]
		ORR R0,#0x2 ;periodic mode, down count 
		STR R0,[R1]
		
		LDR R1,=TIMER2_TAILR;RELOAD VALUE
		LDR R2,=RELOAD_VALUE
		STR R2,[R1] ; load reload value
		
		
		LDR R1,=TIMER2_TAPR;prescalar is select to 15 so the clock is 1 Mhz now
		MOV R2,#0x4F
		STR R2,[R1]
		
		LDR R1, =TIMER2_IMR ;enable timeout interrupt
		MOV R2, #0x01
		STR R2, [R1]
				
		
;INTERRUPT PRIORITY SET UP

		LDR R1,=NVIC_PRI5
		LDR R2,[R1]
		
		ORR R2,#0x20000000 ;set priority#19 as 1
		STR R2,[R1]
		
		
		;LDR R1,=NVIC_EN0
		;LDR R0,[R1]
		;ORR R0,#0x00800000; SET bit 23 to 1 for enable interrupt #23
		;STR R0,[R1]
		
		
		LDR R1,=TIMER2_CTL
		LDR R3,[R1]
		ORR R3,#0x03; enable timer
		STR R3,[R1]
		
		
		BX LR
		ENDP
		END
			