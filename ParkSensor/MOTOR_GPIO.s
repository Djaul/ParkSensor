
SYSCTL_RCGCGPIO 	EQU 0x400FE608;run clock gate for gpio					
					

GPIO_PORTD_DIR 		EQU 0x40007400;GPIO direction register
GPIO_PORTD_AFSEL 	EQU 0x40007420;GPIO alternate function select
GPIO_PORTD_DEN 		EQU 0x4000751C;GPIO Digital enable regisgter
GPIO_PORTD_AMSEL 	EQU 0x40007528;
GPIO_PORTD_PCTL 	EQU 0x4000752C;pctl register for timer function selection 



					AREA motor_gpio , CODE, READONLY
					THUMB
					EXPORT MOTOR_GPIO
						
MOTOR_GPIO			  PROC

;---------------------------------GPIO INIT begin-------------------------------	

					LDR R1,=SYSCTL_RCGCGPIO
					LDR R0,[R1]
					ORR R0,#0x8;enable port d
					STR R0,[R1]
					NOP 
					NOP
					NOP
					
					LDR R1,=GPIO_PORTD_DIR
					LDR R0,[R1]
					ORR R0,#0x0F;set PD0123 as OUTPUT
					STR R0,[R1]
					
					LDR R1,=GPIO_PORTD_DEN
					LDR R0,[R1]
					;BIC R0,#0xFF
					ORR R0,#0x0F; digital enabled
					STR R0,[R1]
					
					LDR R1, =GPIO_PORTD_AFSEL
					LDR R0,[R1]
					BIC R0,#0xFF
					STR R0,[R1]



					BX LR
					ENDP
					END
;---------------------------------GPIO INIT END-------------------------------
