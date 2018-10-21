;
; the inter program is with unsigned number
;
		.MODEL SMALL
		.STACK 100h
		.DATA
	Moni DB 256 DUP(0)
	SizeSt DW 0				;easier to add with bp
	LeftStack DB 0
	MulResult DW ?			;Mul result is DW
	Disply1 DB 'Please enter a string:',13,10,'$'
	DisplayNoInput DB 13,10,'Didnt enter any CH',13,10,'$'
	Display3CH DB 13,10,'You enter the same char more then 3 times',13,10,'$'
	DisplayFail DB 13,10,'The input is NOT an euqual symetirc charcters ascii code multi, havinf each charcter apearing at most 3 times',13,10,'$'
	DisplaySucceed DB 13,10,'The input is an euqual symetirc charcters ascii code multi, havinf each charcter apearing at most 3 times',13,10,'$'
		.CODE
		MOV AX,@DATA
		MOV DS,AX
		
		MOV AH,9h
		MOV DX,OFFSET Disply1
		INT 21h
InputCH:
		MOV AH,1h
		INT 21h
		CMP AL,13
		JE PressedEnter
		MOV BX,OFFSET MONI
		ADD BL,AL
		INC BYTE PTR [BX]
		CMP BYTE PTR [BX],3
		JA MoreThen3CH
		XOR AH,AH
		PUSH AX					;we have to push DW but we calculating DB
		INC SizeSt
		JMP InputCH
		
MoreThen3CH:
		MOV AH,9h
		MOV DX,OFFSET Display3CH
		INT 21h
		JMP Ending

NoInput:		
		JMP PrintSucceed
PressedEnter:
		CMP SizeSt,0
		JE NoInput
		MOV BP,SP
		ADD BP,SizeSt			;bp = bp + 2*SizeSt
		ADD BP,SizeSt			;[bp] = first CH
		DEC BP					;to get the first CH you must point to start point of sp -2
		DEC BP
		POP AX
		MOV BX, WORD PTR [BP]
		MUL BL
		MOV MulResult,AX
		DEC SizeSt				;SizeSt is showing how much CH left to check (ADD BP)
		CMP SizeSt,2
		JE CheckMulSucceedEven
		CMP SizeSt,1
		JE CheckMulSucceed2Size
		JB CheckMulSucceedEven
		DEC SizeSt				;because we check 2 CH we drop 2
		INC LeftStack
CheckMul:

		MOV BP,SP
		ADD BP,SizeSt			;bp = bp + 2*SizeSt
		ADD BP,SizeSt			;[bp] = first CH
		DEC BP					;to get the first CH you must point to start point of sp -2
		DEC BP
		POP AX
		MOV BX, WORD PTR [BP]
		MUL BL		
		CMP AX,MulResult
		JNE CheckMulFail
		DEC SizeSt				;SizeSt is showing how much CH left to check (ADD BP)
		DEC SizeSt				;because we check 2 CH we drop 2
		INC LeftStack
		CMP SizeSt,2
		JB CheckMulSucceedEven
		JMP CheckMul
		
CheckMulFail:					;dont forget to pop size pop leftstack
		CMP SizeSt,0
		JE CheckMulFail_LeftStack
		POP AX
		DEC SizeSt
		JMP CheckMulFail
CheckMulFail_LeftStack:
		CMP LeftStack,0
		JE CheckMulFail_Print
		POP AX
		DEC LeftStack			;DEC will triger the ZF
		JNE CheckMulFail_LeftStack
CheckMulFail_Print:
		MOV AH,9h
		MOV DX,OFFSET DisplayFail
		INT 21h
		JMP Ending

CheckMulSucceed2Size:
		POP AX
		DEC SizeSt
CheckMulSucceedEven:			;if the size of string is even their is no middle CH
		CMP SizeSt,0			;thier is a possiblity that sizest will be 2 so we rather check even 
		JE PrintSucceed
;CheckMulSucceed UNEven	
		POP BX
		MOV AL,BL
		MUL BL
		CMP AX,MulResult
		JNE CheckMulFail
PrintSucceed:
		CMP SizeSt,0
		JE PrintSucceed_LeftStack
		POP AX
		DEC SizeSt				;DEC will triger the ZF
		JMP PrintSucceed
PrintSucceed_LeftStack:
		CMP LeftStack,0
		JE  PrintSucceed_Print
		POP AX
		DEC LeftStack			;DEC will triger the ZF
		JMP PrintSucceed_LeftStack
PrintSucceed_Print:
		MOV AH,9h
		MOV DX,OFFSET DisplaySucceed
		INT 21h
Ending:
		MOV AH,4Ch
		INT 21h
		END