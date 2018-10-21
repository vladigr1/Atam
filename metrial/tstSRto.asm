		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		MOV AX,@DATA 
		MOV DS,AX 
		;MOV ES,DS 	;cant work like this
		MOV AX,ES
		MOV AH,4Ch
		INT 21h
		END