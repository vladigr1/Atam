		.MODEL SMALL
		.STACK 100h
		.DATA
	TEN DQ 10.0
	INTCHAR DW  ?
	DisplayOverflow DB 'OVERFLOW',13,10,'$'
		.CODE
		
	_convert PROC NEAR
		PUBLIC _convert
		PUSH BP
		MOV BP,SP
		MOV BX,[BP+4]
		FLDZ
		MOV CX,15
START_LOOP:	
		MOV AX,0
		MOV AL,[BX]
		CMP AL,0
		JE ENDING
		FMUL TEN
		SUB AL,'0'
		MOV INTCHAR,AX
		FILD INTCHAR
		FADD
		INC BX
		LOOP START_LOOP
		
		MOV AH,9h
		MOV DX,OFFSET DisplayOverflow
		INT 21h
		
		FSTP ST
		FLDZ
ENDING:
		POP BP
		RET
	_convert ENDP
		END
	