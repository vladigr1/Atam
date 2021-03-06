		.MODEL LARGE
		.STACK 100h
		.DATA 
	CARRY DB ?
	INTARR1 DB ?
	INTARR2 DB ?
	I DB ?
	TEN DB 10
		.CODE
		.386
	_string_add PROC FAR
		PUBLIC _string_add
		PUSH BP
		MOV BP,SP
		PUSH SI 
		PUSH DI 
		PUSH ES 
		PUSH FS 
		PUSH GS
		MOV CARRY,0
		MOV AX,[BP+18]
		DEC AX
		MOV I,Al
		MOV BX,[BP+10] 
		MOV SI,[BP+14]
		MOV DI,[BP+6]
		MOV ES,[BP+12]
		MOV FS,[BP+16]
		MOV GS,[BP+8]
		ADD BX,AX 
		ADD SI,AX 
		ADD DI,AX 
		JMP CHECK_LOOP
START_LOOP:
		MOV AH,ES:[BX]
		SUB AH,'0'
		MOV INTARR1,AH 
		MOV AL,FS:[SI]
		SUB AL,'0'
		MOV INTARR2,AL 
		ADD AL,INTARR1 
		ADD AL,CARRY 
		MOV AH,0 
		DIV TEN
		MOV CARRY,AL 
		ADD AH,'0'
		MOV GS:[DI],AH 
		DEC BX 
		DEC SI 
		DEC DI 
		DEC I 
CHECK_LOOP:
		CMP I,0 
		JGE START_LOOP
		
		POP GS 
		POP FS 
		POP ES
		POP DI
		POP SI 
		POP BP 
		RET 
	_string_add ENDP
		END