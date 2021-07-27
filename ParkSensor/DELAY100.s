;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA        mysub, READONLY, CODE
			THUMB

exe			EQU	0x51616

			EXTERN      __main
			EXPORT  	DELAY100	; Make available


DELAY100	PROC
			
			PUSH{R1}
			
			
			LDR R1,=exe
loop		SUBS R1, #1
			BNE	loop
			
			POP{R1}
			
			BX LR
			
			ALIGN
			ENDP
			END