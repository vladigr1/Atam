		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		.386
		.387
		
	_vector_length PROC NEAR
		PUBLIC _vector_length
		PUSH BP 
		MOV BP,SP 
		MOV BX,[BP+4]
		MOV CX,[BP+6]
		FLDZ
		JCXZ END_LOOP
START_LOOP:
		FLD DWORD PTR [BX]	; 
		FMUL ST,ST 
		FADD
		ADD BX,4 			;
		LOOP START_LOOP
END_LOOP:
		FSQRT
		POP BP 
		RET 
	_vector_length ENDP
		END
		
		
		