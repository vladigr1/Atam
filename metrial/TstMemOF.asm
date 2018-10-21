;
;Summery: working with memory will not corrupt the next memory when OF
;cases: direct and with pointer
		.MODEL SMALL
		.STACK 100h
		.DATA
	b1 DB 0	
	b2 DB 255
	b3 DB 0
		.CODE
		MOV AX,@DATA
		MOV DS,AX
;		ADD b2,2			;knows that its sized is a bit and when overflowing doesn't corrupt other memories
		MOV BX,OFFSET B2
		ADD BYTE PTR [BX],2
		MOV AH,4Ch
		INT 21h
		END