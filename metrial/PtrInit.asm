;
;you can add and sub immediate
;
		.MODEL SMALL
		.STACK 100h
		.DATA
ptr1 DB ?
Bn1 DB 10,13,'$'
toPrint DB  '[BX+1] = $'
zero DB '1'
numbers DB '2345$'
		.CODE
start:
		MOV AX,@DATA
		MOV DS,AX
		
		MOV BX,OFFSET ptr1
		MOV BYTE PTR [BX],'6'
		MOV DL,[BX]
		MOV AH,2h
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET Bn1
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET toPrint
		INT 21h
		
		MOV AH,2h
		MOV DL,[BX+1]
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET Bn1
		INT 21h
		
								;testing [OFF - immediate]
		MOV SI,OFFSET numbers
		MOV DL,[SI-1]
		MOV AH,2h
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET Bn1
		INT 21h
		
								;testing swap ptr1 with numbers[3]
		XCHG [SI+3],BX			;BX = &ptr1 &&
		MOV DL,BL
		MOV AH,2h
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET Bn1
		INT 21h
		
								;testing [label + immediate]
		MOV AH,2h
		MOV DL,numbers[2]
		INT 21h
		
		MOV AH,2h
		MOV DL,[numbers + 2 ]	;even if labels are immediate theyy arent count  [] and you can add immediate offset like in the example
		INT 21h
		
		MOV AH,9h
		MOV DX, OFFSET Bn1
		INT 21h
		
		MOV AH,4Ch
		INT 21h
		END start
		