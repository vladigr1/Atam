;function pointer may be reg or mem
;Summery: we can call  it has too have his address
;case: reg16 or mem16
		.MODEL SMALL
		.STACK 100h
		.DATA
	f_ptr DW ?
		.CODE
		
	NOT_AX PROC NEAR
		NOT AX
		RET
	NOT_AX ENDP
Start:	
		MOV AX,@DATA
		MOV DS,AX
		XOR AX,AX
		MOV CX,OFFSET NOT_AX
		MOV f_ptr,OFFSET NOT_AX
		
		CALL NOT_AX
		CALL CX
		CALL f_ptr
		
		MOV AH,4Ch
		INT 21h
		END Start
		