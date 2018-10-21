		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		
	_get_regs PROC NEAR
		PUBLIC  _get_regs
		PUSH BP
		MOV BP,SP
		MOV BX,[BP+4]
		MOV AX,[BP+2]
		MOV [BX],AX
		MOV BX,[BP+6]
		MOV AX,SP
		ADD AX,12
		MOV [BX],AX
		MOV BX,[BP+8]
		MOV [BX],CS
		MOV BX,[BP+10]
		MOV AX,[BP]
		MOV [BX],AX
		POP BP
		RET
	_get_regs ENDP
		END
		