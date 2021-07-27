

			AREA 	printdgt, CODE, READONLY
			THUMB
			EXPORT 	printdigit
			
			EXTERN	TRANSMIT
					
					
printdigit	PROC
					
			PUSH {LR,R0-R12}	
			
			CMP			R7,#0
			BLEQ		N0
			
			CMP			R7,#1
			BLEQ		N1
			
			CMP			R7,#2
			BLEQ		N2
			
			CMP			R7,#3
			BLEQ		N3
			
			CMP			R7,#4
			BLEQ		N4
			
			CMP			R7,#5
			BLEQ		N5
			
			CMP			R7,#6
			BLEQ		N6
			
			CMP			R7,#7
			BLEQ		N7
				
			
			CMP			R7,#8
			BLEQ		N8
			
			CMP			R7,#9
			BLEQ		N9
			
			
			POP 	{LR,R0-R12}	
			BX		LR		;end
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	NUMBERS	0-9	BEGINNING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
N0			PUSH 	{LR}	
			MOV		R5, #0X3E
			BL		TRANSMIT
			MOV		R5, #0X51
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT			
			MOV		R5, #0X45
			BL		TRANSMIT
			MOV		R5, #0X3E
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N1			PUSH 	{LR}	
			MOV		R5, #0X0
			BL		TRANSMIT
			MOV		R5, #0X42
			BL		TRANSMIT
			MOV		R5, #0X7F
			BL		TRANSMIT			
			MOV		R5, #0X40
			BL		TRANSMIT
			MOV		R5, #0X0
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N2			PUSH 	{LR}	
			MOV		R5, #0X42
			BL		TRANSMIT
			MOV		R5, #0X61
			BL		TRANSMIT
			MOV		R5, #0X51
			BL		TRANSMIT			
			MOV		R5, #0X49
			BL		TRANSMIT
			MOV		R5, #0X46
			BL		TRANSMIT			
			POP		{LR}
			BX		LR
	
N3			PUSH 	{LR}	
			MOV		R5, #0X21
			BL		TRANSMIT
			MOV		R5, #0X41
			BL		TRANSMIT
			MOV		R5, #0X45
			BL		TRANSMIT			
			MOV		R5, #0X4B
			BL		TRANSMIT
			MOV		R5, #0X31
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N4			PUSH 	{LR}	
			MOV		R5, #0X18
			BL		TRANSMIT
			MOV		R5, #0X14
			BL		TRANSMIT
			MOV		R5, #0X12
			BL		TRANSMIT			
			MOV		R5, #0X7F
			BL		TRANSMIT
			MOV		R5, #0X10
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N5			PUSH 	{LR}	
			MOV		R5, #0X27
			BL		TRANSMIT
			MOV		R5, #0X45
			BL		TRANSMIT
			MOV		R5, #0X45
			BL		TRANSMIT			
			MOV		R5, #0X45
			BL		TRANSMIT
			MOV		R5, #0X39
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N6			PUSH 	{LR}	
			MOV		R5, #0X3C
			BL		TRANSMIT
			MOV		R5, #0X4A
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT			
			MOV		R5, #0X49
			BL		TRANSMIT
			MOV		R5, #0X30
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N7			PUSH 	{LR}	
			MOV		R5, #0X1
			BL		TRANSMIT
			MOV		R5, #0X71
			BL		TRANSMIT
			MOV		R5, #0X9
			BL		TRANSMIT			
			MOV		R5, #0X5
			BL		TRANSMIT
			MOV		R5, #0X3
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N8			PUSH 	{LR}	
			MOV		R5, #0X36
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT			
			MOV		R5, #0X49
			BL		TRANSMIT
			MOV		R5, #0X36
			BL		TRANSMIT			
			POP		{LR}
			BX		LR

N9			PUSH 	{LR}	
			MOV		R5, #0X6
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT
			MOV		R5, #0X49
			BL		TRANSMIT			
			MOV		R5, #0X29
			BL		TRANSMIT
			MOV		R5, #0X1E
			BL		TRANSMIT			
			POP		{LR}
			BX		LR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;	NUMBERS	0-9	FINISH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

			ENDP
			ALIGN                       ; make sure the end of this section is aligned
			END                         ; end of file					