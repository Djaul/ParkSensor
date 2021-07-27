
RELOAD_VALUE 		EQU 0XFFFF; reload value is set such that nearly every 8 ms 1 step occurs(prescaler is 1) for stepper motor
SYSCTL_RCGCTIMER 	EQU 0x400FE604 ; GPTM Gate Control
; 16/32 Timer Registers
TIMER3_CFG			EQU 0x40033000;;for A and B 16bit/32bit selection,0x04 =16bit
TIMER3_TAMR			EQU 0x40033004;SET FUNC OF TIMER,;[1:0] 1=oneshot,2=periodic,3=capture
;[2]=0 edge count,1=edge time , [4]=0 count down,1=up
TIMER3_CTL			EQU 0x4003300C;TIMER3   (en/dis,fall/ris/both)
TIMER3_IMR			EQU 0x40033018

TIMER3_TAILR		EQU 0x40033028 ; Timer interval;
;in 16bit,value for count up or down .(if down, up to this number)
TIMER3_TAPR			EQU 0x40033038 ;presecalar
	

;Nested Vector Interrupt Controller registers

NVIC_EN1			EQU 0xE000E104 ; IRQ Set Enable Register
NVIC_PRI8			EQU 0xE000E420 ; IRQ Priority Register
	

					AREA init_timer3 , CODE, READONLY
					THUMB
					EXPORT INIT_TIMER3


INIT_TIMER3 		PROC

					LDR R1,=SYSCTL_RCGCTIMER ;clock for timer
					LDR R0,[R1]
					ORR R0,#0x08
					STR R0,[R1]
					NOP
					NOP
					NOP
					
					LDR R1,=TIMER3_CTL;disable timer first
					LDR R0,[R1]
					BIC R0,#0x01
					STR R0,[R1]
					
					LDR R1,=TIMER3_CFG;
					LDR R0,[R1]
					ORR R0,#0x4 ;select 16-bit MODE
					STR R0,[R1]
					
					LDR R1,=TIMER3_TAMR;
					LDR R0,[R1]
					ORR R0,#0x2 ;periodic mode, down count 
					STR R0,[R1]
					
					LDR R1,=TIMER3_TAILR;RELOAD VALUE
					LDR R2,=RELOAD_VALUE
					STR R2,[R1] ; load reload value
					
					
					LDR R1,=TIMER3_TAPR;one prescale
					MOV R2,#0x01
					STR R2,[R1]
					
					LDR R1, =TIMER3_IMR ;enable timeout interrupt
					MOV R2, #0x01
					STR R2, [R1]
							
					
;INTERRUPT PRIORITY SET UP

					LDR R1,=NVIC_PRI8
					LDR R2,[R1]
					AND R2,#0x0FFFFFFF ;clear  priority
					ORR R2,#0x20000000 ;set priority as 2
					STR R2,[R1]
					
					
					LDR R1,=NVIC_EN1
					LDR R0,[R1]
					ORR R0,#0x00000008; SET bit to 1 to enable interrupt
					STR R0,[R1]
					
					
					LDR R1,=TIMER3_CTL
					LDR R3,[R1]
					ORR R3,#0x03; enable timer
					STR R3,[R1]

					BX LR
					ENDP
					