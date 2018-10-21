		.MODEL SMALL
		.STACK 100h
		.DATA
	I DD ?
	COUNT DW ?
	N DD ?
		.CODE
		.386
	_unsigned_decompose_number32 PROC NEAR
		PUBLIC _unsigned_decompose_number32
		PUSH BP
		MOV BP,SP
		MOV EAX,[BP+4]
		MOV N,EAX 
		MOV COUNT,0
		MOV I,2
		JMP CHECK_LOOP1
START_LOOP1:
		MOV EDX,0
		MOV EAX,N 
		DIV I
		CMP EDX,0
		JNE HAS_REM
		INC COUNT 
HAS_REM:
		CMP EAX,I
		JBE END_LOOP1
		INC I
CHECK_LOOP1:
		MOV EAX,I 
		CMP EAX,N 
		JB START_LOOP1 
END_LOOP1:
		MOV AX,COUNT 
		POP BP 
		RET
	_unsigned_decompose_number32 ENDP
	
	_signed_decompose_number32 PROC NEAR
		PUBLIC _signed_decompose_number32 
		PUSH BP 
		MOV BP,SP 
		MOV EAX,[BP+4] 
		CMP EAX,0 
		JNL ZERO_ANDABOVE
		NEG EAX 
ZERO_ANDABOVE:
		PUSH EAX 
		CALL _unsigned_decompose_number32
		ADD SP,4 
		POP BP 
		RET 
	_signed_decompose_number32 ENDP
		END 