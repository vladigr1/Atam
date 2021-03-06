		.MODEL SMALL
		.STACK 100h
		.DATA 
	I DW ?
	J DW ?
	COUNT DW ?
		.CODE
		.386
	_position_sort PROC NEAR
		PUBLIC _position_sort
		PUSH BP
		MOV BP,SP 
		PUSH SI
		PUSH DI
		MOV BX,[BP+4]
		mov EDI,0
		MOV DI,[BP+8]
		MOV I,0
		JMP CHECK_LOOP1
START_LOOP1:
		MOV COUNT,0 
		MOV J,0
		MOV SI,[BP+4]
		JMP CHECK_LOOP2
START_LOOP2:
		MOV EAX,[SI]
		CMP EAX,[BX]
		JL START_IF
		JNE END_IF
		MOV AX,J 
		CMP AX,I
		JNL END_IF 
START_IF:
		INC COUNT
END_IF:
		INC J 
		ADD SI,4
CHECK_LOOP2:
		MOV AX,[BP+6]
		CMP J,AX 
		JB START_LOOP2
		
		MOV ECX,0
		MOV CX,COUNT 
		SHL ECX,2
		MOV EAX,[BX]
		MOV [EDI+ECX],EAX
		
		INC I 
		ADD BX,4 
CHECK_LOOP1:
		MOV AX,[BP+6]
		CMP I,AX 
		JB START_LOOP1
		
		POP DI
		POP SI 
		POP BP
		RET 
	_position_sort ENDP
		END
		
		
		