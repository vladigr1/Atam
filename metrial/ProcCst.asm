		.MODEL SMALL
		.STACK 100h
		.DATA
	i DW 5
		.CODE
		
		ProTest PROC NEAR
		MOV AX,0
		RET
		ENDP
		
start:
		MOV AX,@DATA
		MOV DS,AX
		MOV AX,WORD PTR i
		
		CALL ProTest
		CALL NEAR PTR ProTest
		CALL FAR PTR ProTest
		
		MOV AH,4Ch
		INT 21h
		END start
		