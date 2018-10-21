;the inter number system is usnign
;the stack has only word size memory
;	Latest 02.09.18
		.MODEL SMALL
		.STACK 100h
		.DATA
	DisplayVAR DB 'ENTER x:',13,10,'$'
	DisplayFail DB 13,10,'Bad input',13,10,'$'
	DisplayLarge DB 13,10,'Large input',13,10,'$'
	DisplayEqe DB ' = $'
	VarX DD 0
	VarY DD 0
	AmountX DW 0
	AmountY DW 0
	GcdResult DD ?
	Natrual_Result DD ?
	AmountN DW 0
		.CODE
		.386
		MOV AX,@DATA
		MOV DS,AX
		
		MOV AH,9h
		MOV DX,OFFSET DisplayVAR
		INT 21h
EnterX:
		MOV AH,1h
		INT 21h
		CMP AL,13
		JE Before_EnterY
		CMP AL,'0'			;	IF(al<=0 
		JNAE FailInput			
		CMP AL,'9'			;			&& al >=9)
		JNBE FailInput		;		ebx += al
		SUB AL,'0'
		MOV CL,AL
		MOV EAX,10
		MUL VarX
		JC FailInputLarge
		MOV EBX,EAX			;ebx is  TEMP
		ADD BL,CL			;THE RANGE AL IS 0-9
		JC FailInputLarge
		MOV VarX,EBX
		JMP EnterX

FailInput:
		MOV AH,9h
		MOV	DX,OFFSET DisplayFail
		INT 21h
		JMP Ending
		
FailInputLarge:
		MOV AH,9h
		MOV	DX,OFFSET DisplayLarge
		INT 21h
		JMP Ending		
		
Before_EnterY:
		MOV AH,9h
		MOV SI,OFFSET DisplayVAR
		MOV BYTE PTR [SI+6],'y'
		MOV DX,SI
		INT 21h
EnterY:
		MOV AH,1h
		INT 21h
		CMP AL,13
		JE Before_PrintingVarX
		CMP AL,'0'			;	IF(al<=0 
		JNAE FailInput			
		CMP AL,'9'			;			&& al >=9)
		JNBE FailInput		;		ebx += al
		SUB AL,'0'
		MOV CL,AL
		MOV EAX,10
		MUL VarY
		JC FailInputLarge
		MOV EBX,EAX			;ebx is  TEMP
		ADD BL,CL			;THE RANGE AL IS 0-9
		JC FailInputLarge
		MOV VarY,EBX
		JMP EnterY

Before_PrintingVarX:
		CMP VarY,0
		JE FailInput
		CMP VarX,0
		JNE PrintingVarX_NotZero
		MOV AH,2h
		MOV DL,'0'
		INT 21h
		JMP Before_PrintingVarY
PrintingVarX_NotZero:
		MOV EAX,VarX
		JMP Check_PrintingVarX
PrintingVarX:				
		XOR EDX,EDX			;while(VarX != 0)
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountX
Check_PrintingVarX:			;while(VarX != 0)TEST
		CMP EAX,0
		JNE PrintingVarX
;Before_Print_PrintingVarX
		MOV CX,AmountX
Print_PrintingVarX:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Print_PrintingVarX
		
Before_PrintingVarY:
		MOV AH,2h
		MOV DL,'/'			;printing divider sign
		INT 21h
		
		MOV EAX,VarY
		JMP Check_PrintingVarY
PrintingVarY:				
		XOR EDX,EDX			;while(VarY != 0)			
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountY
Check_PrintingVarY:			;while(VarY != 0) TEST
		CMP EAX,0
		JNE PrintingVarY
;Before_Print_PrintingVarY
		MOV CX,AmountY
Print_PrintingVarY:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Print_PrintingVarY
		
Before_Gcd:
		MOV EAX,VarX
		MOV EBX,VarY
		JMP Check_Gcd
Gcd:				;while(ebx != 0)
		XOR EDX,EDX
		DIV EBX
		MOV EAX,EDX
		XCHG EAX,EBX
Check_Gcd:
		CMP EBX,0
		JNE Gcd
		MOV GcdResult,EAX
		
		MOV AH,9h
		MOV DX,OFFSET DisplayEqe
		INT 21h
		CMP VarX,0
		JNE VarX_notzero
		MOV AH,2h
		MOV DL,'0'
		INT 21h
		JMP Ending
		
VarX_notzero:		
;Before_PrintResult
		XOR EDX,EDX
		MOV EAX,VarX
		MOV EBX,GcdResult
		DIV EBX
		MOV VarX,EAX
		XOR EDX,EDX
		MOV EAX,VarY
		MOV EBX,GcdResult
		DIV EBX
		MOV VarY,EAX
		
		MOV AmountX,0
		MOV AmountY,0
		
;Again_Before_PrintingVarX:
		MOV EAX,VarX
		JMP Again_Check_PrintingVarX
Again_PrintingVarX:				
		XOR EDX,EDX			;while(VarX != 0)
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountX
Again_Check_PrintingVarX:			;while(VarX != 0)TEST
		CMP EAX,0
		JNE Again_PrintingVarX
;Again_Before_Print_PrintingVarX
		MOV CX,AmountX
Again_Print_PrintingVarX:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Again_Print_PrintingVarX
		
		MOV AH,2h
		MOV DL,'/'			;printing divider sign
		INT 21h

;Again_Before_PrintingVarY
		MOV EAX,VarY
		JMP Again_Check_PrintingVarY
Again_PrintingVarY:				
		XOR EDX,EDX			;while(VarY != 0)			
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountY
Again_Check_PrintingVarY:			;while(VarY != 0) TEST
		CMP EAX,0
		JNE Again_PrintingVarY
;Again_Before_Print_PrintingVarY
		MOV CX,AmountY
Again_Print_PrintingVarY:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Again_Print_PrintingVarY

		MOV AH,9h
		MOV DX,OFFSET DisplayEqe
		INT 21h
		
;Again2_Before_PrintResult
		XOR EDX,EDX
		MOV EAX,VarX
		MOV EBX,VarY
		DIV EBX
		MOV Natrual_Result,EAX
		MOV VarX,EDX			;REMINDER to print in again2
		CMP EAX,0
		JNE Natural_notzeor
		MOV AH,2h
		MOV DL,'0'
		INT 21h
		JMP Again2_Before_PrintingVarX
Natural_notzeor:
		JMP Check_PrintNatural
PrintNatural:
		XOR EDX,EDX
		MOV EBX,10
		DIV EBX
		PUSH DX
		INC AmountN
Check_PrintNatural:
		CMP EAX,0
		JNE PrintNatural
		MOV CX,AmountN
Print_PrintNatural:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Print_PrintNatural
		
Again2_Before_PrintingVarX:
		MOV AH,2h
		MOV DL,' '
		INT 21h
		MOV AH,2h
		MOV DL,'+'
		INT 21h
		MOV AH,2h
		MOV DL,' '
		INT 21h
		
		MOV AmountX,0
		MOV AmountY,0
		
		CMP VarX,0
		JNE Again2_VarXnotzero
		MOV AH,2h
		MOV DL,'0'
		INT 21h
		JMP Again2_Before_PrintingVarY
Again2_VarXnotzero:
		MOV EAX,VarX
		JMP Again2_Check_PrintingVarX
Again2_PrintingVarX:				
		XOR EDX,EDX			;while(VarX != 0)
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountX
Again2_Check_PrintingVarX:			;while(VarX != 0)TEST
		CMP EAX,0
		JNE Again2_PrintingVarX
;Again2_Before_Print_PrintingVarX
		MOV CX,AmountX
Again2_Print_PrintingVarX:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Again2_Print_PrintingVarX

Again2_Before_PrintingVarY:
		MOV AH,2h
		MOV DL,'/'			;printing divider sign
		INT 21h
		
		MOV EAX,VarY
		JMP Again2_Check_PrintingVarY
Again2_PrintingVarY:				
		XOR EDX,EDX			;while(VarY != 0)			
		MOV EBX,10
		DIV EBX
		PUSH DX				;reminder is FROM 0-9
		INC AmountY
Again2_Check_PrintingVarY:			;while(VarY != 0) TEST
		CMP EAX,0
		JNE Again2_PrintingVarY
;Again_Before_Print_PrintingVarY
		MOV CX,AmountY
Again2_Print_PrintingVarY:
		MOV AH,2h
		POP DX
		ADD DL,'0'
		INT 21h
		LOOP Again2_Print_PrintingVarY		
		
Ending:
		MOV AH,4Ch
		INT 21h
		END