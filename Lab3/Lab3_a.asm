;UNSIGN	
		.MODEL SMALL
		.STACK 100h
		.DATA
	ARR1 DB 44,44,44,44,44
	MONI DB 0,0,0,0,0
	TEN DB 10
	TWO DB 2
	LEFTOVER DB ?
	Display1 DB ' even numbers were found',13,10,'DIGIT SHOWS MOST: $'
	Display2 DB ,13,10,'The digit is show: $'
	Display3 DB ' Times',13,10,'$'

		.CODE
		MOV AX,@DATA
		MOV DS,AX

		MOV CX,0
		MOV BX, OFFSET ARR1
Loop1:							; for (cx =0; cx <= 4; cx++) MOVE TO NEXT NUM IN ARR
		MOV AL,BYTE PTR [BX]
Loop2:							;while(LEFTOVER) FINDING DIGIT
		CBW
		IDIV TEN
		MOV LEFTOVER,AL			;SAVE AL
		MOV AL,AH
		CBW
		CMP AX,0
		JGE NotNegative
		NEG AX
NotNegative:
		IDIV TWO
		CMP AH,0			;IF (AH > 0)
		JNE Condi1	
		MOV SI,OFFSET MONI
		ADD SI,AX
		INC BYTE PTR[SI]
Condi1:
		MOV AL,LEFTOVER
		CMP AL,0
		JNE Loop2
		INC BX				;SET BX POINT TO THE NEXT IN ARR1				
		INC CX
		CMP CX,4
		JBE Loop1

		MOV BX,OFFSET MONI	;COUNT HOW MANY THEIR ARE
		MOV CX, 0
		XOR AX,AX

Loop3:						;FOR(CX = 1; CX <= 5; CX++) COUNT AMOUNT
		ADD AL,[BX]
		INC BX
		INC CX
		CMP CX,4
		JBE Loop3


		DIV TEN				;PRINT AMOUNT NUMBER
		CMP AH,0
		JNE CondiPRINT
		MOV LEFTOVER,AH
		MOV AH,2h
		MOV DL,AL
		ADD DL,'0'
		INT 21h
		MOV AH,LEFTOVER
CondiPRINT:		
		MOV DL,AH
		ADD DL,'0'
		MOV AH,2h
		INT 21h

		MOV AH,9h
		MOV DX,OFFSET Display1
		INT 21h

		MOV CX,1
		MOV SI, OFFSET MONI 
		INC SI
		MOV BX, OFFSET MONI	;BX WILL BE THE ADRESS OF MAX
Loop5:						;FOR(CX =1; CX< 4; CX++) MAX
		MOV AH,[SI]
		CMP AH,[BX]		;IF(SI > BX)
		JBE Condi2
		MOV BX,SI
Condi2:
		INC CX
		INC SI
		CMP CX,5
		JB Loop5

		MOV SI,OFFSET MONI
		SUB BX,SI			;arr1[bx] = max
		MOV AL,2
		MUL BX
		ADD AL,'0'
		MOV AH,2h
		MOV DL,AL
		INT 21h

		MOV AH,9h
		MOV DX,OFFSET Display2
		INT 21h

		MOV SI, OFFSET MONI
		ADD SI,BX
		XOR AX,AX
		MOV AL,[SI]			;PRINT AMOUNT digit
		DIV TEN				
		CMP AH,0
		JNE CondiPRINT2
		MOV LEFTOVER,AH
		MOV AH,2h
		MOV DL,AL
		ADD DL,'0'
		INT 21h
		MOV AH,LEFTOVER
CondiPRINT2:		
		MOV DL,AH
		ADD DL,'0'
		MOV AH,2h
		INT 21h

		MOV AH,9h
		MOV DX,OFFSET Display3
		INT 21h

		MOV AH,4Ch
		INT 21h
		END


			