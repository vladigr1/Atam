		
		.MODEL SMALL
		.STACK 100h
		.DATA
		
		NEG1 DB -23
		NEG2 DW -128
		NEG3 DD -275
		pos1 DW 5
		pos2 DW 7
		.CODE
		
startMain:
		MOV AX,NEG2
		CMP AX,pos2
		JB endMain
		 
		MOV AX,@DATA
		MOV DS,AX
		MOV AL,NEG1
		CBW
		MOV AX,NEG2
		CWD
.386
		MOV EAX,NEG3
		CDQ
		
endMain:
		MOV AH,4Ch
		INT 21h
		END startMain