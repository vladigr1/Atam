		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		.386
		
	_init2dim PROC NEAR
		PUBLIC _init2dim
		EXTRN _malloc :NEAR
		
		PUSH BP
		MOV BP,SP
		PUSH SI
		MOV AX,[BP+4]
		SHL AX,1
		PUSH AX
		CALL _malloc
		ADD SP,2
		MOV SI,AX
		PUSH AX				;SAVE RESULT
		MOV CX,[BP+4]
		INC CX
		JMP CHECK_LOOP
START_LOOP:
		MOV AX,[BP+6]
		SHL AX,2
		PUSH CX
		PUSH AX
		CALL _malloc
		ADD SP,2
		POP CX
		MOV [SI],AX
		ADD SI,2
CHECK_LOOP:
		LOOP START_LOOP
		
		POP AX
		POP SI
		POP BP
	_init2dim ENDP
	
	_set2dim PROC NEAR
		PUBLIC _set2dim
		
		PUSH BP
		MOV BP,SP
		PUSH SI
		MOV SI,[BP+4]
		MOV BX,[BP+10]
		SHL BX,1
		MOV SI,[SI+BX]
		MOV BX,[BP+12]
		SHL BX,2
		MOV EAX,[BP+6]
		MOV [SI+BX],EAX
		POP SI
		POP BP
		RET
	_set2dim ENDP
		
	_get2dim PROC NEAR
		PUBLIC _get2dim
		PUSH BP
		MOV BP,SP
		PUSH SI
		MOV SI,[BP+4]
		MOV BX,[BP+6]
		SHL BX,1
		MOV SI,[SI+BX]
		MOV BX,[BP+8]
		SHL BX,2
		MOV AX,[SI+BX]
		MOV DX,[SI+BX+2]
		POP SI
		POP BP
		RET
	_get2dim ENDP
		END