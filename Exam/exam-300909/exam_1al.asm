		.MODEL LARGE
		.STACK 100h
		.DATA
		.CODE
		.386
	_find_value PROC FAR
		PUBLIC _find_value
		PUSH BP
		MOV BP,SP
		PUSH ES
		MOV BX,[BP+6]
		MOV ES,[BP+8]
		MOV CX,[BP+10]
		INC CX
		JMP CHECK_LOOP
START_LOOP:
		MOV EAX,ES:[BX]
		CMP EAX,[BP+12]
		JNE NOT_EQ
		MOV AX,BX
		MOV DX,ES
		JMP ENDING
NOT_EQ:
		ADD BX,4
CHECK_LOOP:
		LOOP START_LOOP
		
		MOV DX,ES
		MOV AX,[BP+6]
ENDING:
		POP ES
		POP BP
		RET
	_find_value ENDP
		END