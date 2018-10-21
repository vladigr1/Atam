;
;
;note:
;*for the future type first msd then lsd because this is how you push it (dx,ax)
		.MODEL SMALL
		.STACK 100h
		.DATA 
		DisplayGetPN DB 'Please enter number:',13,10,'$'
		k DW ?
		n DW ?
		Ten DW 10
		.CODE
		

	_getPNum PROC NEAR
		PUBLIC _getPNum
;long getPNum()
;{
;print(request)
;	LONG RESULT = 0 
;		DX = [BP - 2]MSD	= EAX = [BP - 4]
;		AX = [BP - 4] 
;while(SCAN(&AL) && AL!= 13){
;	int temp;
;		[BP - 6]
;	Result*=10;
;	AX = temp;
;	RESULT+=AX ;
;}		
		PUSH BP
		MOV BP,SP
		SUB SP,6
		MOV AH,9h
		MOV DX,OFFSET DisplayGetPN
		INT 21h
		
		XOR AX,AX
		MOV [BP - 2],AX
		MOV [BP - 4],AX				;RESULT = 0
		JMP GetNumStart_CheckCondition
		
GetNumStart:
		XOR AH,AH
		SUB AL,'0'
		MOV [BP - 6],AX
		MOV AX,[BP - 4]
		MUL Ten
		ADD AX,[BP-6]
		ADC DX,0
		MOV [BP - 4],AX
		MOV AX,[BP-2]
		MOV [BP-2],DX
		MUL Ten
		ADD [BP- 2],AX
GetNumStart_CheckCondition:	
		MOV AH,1h
		INT 21h
		CMP AL,13
		JNE GetNumStart
		
		MOV DX,[BP-2]
		MOV AX,[BP-4]
		ADD SP,6
		POP BP
		RET
	_getPNum ENDP

	_isPowTwo PROC NEAR
		PUBLIC _isPowTwo
;int isPowTwo(long x)
;{
;				AX = [BP + 4]
;				DX = [BP + 6] MSD
;	if(x==1 || !(x & ( x - 1)) )
;			return 1;
;	else
;			return 0;
;}(ADD SP,4)
		PUSH BP
		MOV BP,SP
		MOV AX,[BP + 4]
		MOV DX,[BP + 6]
		
;		CMP DX,0			;you dont have too beacuse  1 & 0 = 0
;		JNE xNotZero
;		CMP AX,1
;		JNE xNotZero
;		JMP Return1
;xNotZero:	
		CMP DX,0
		JE DXeqZero
		DEC DX
		AND DX,[BP+6]
		CMP DX,0
		JNE Return0
		CMP AX,0
		JE Return1
		JMP Return0
DXeqZero:
		DEC AX
		AND AX,[BP+4]
		CMP AX,0
		JE Return1
Return0:
		MOV AX,0
		JMP EndFunc
Return1:
		MOV AX,1
EndFunc:
		POP BP
		RET
	_isPowTwo ENDP
		
	_getPowTwo PROC NEAR
		PUBLIC _getPowTwo
;int getPowTwo(long x)
;			AX = [BP + 4]
;			DX = [BP + 6] MSD
;{
;	int n = 0
;		[BP -2]
;	while(AX){
;		Ax >> 1; //shift left
;		n++;
;	}
;	return n-1
;}(ADD SP,4)
	
		PUSH BP
		MOV BP,SP
		SUB SP,2
		MOV AX,[BP+4]
		MOV DX,[BP+6]
		CMP DX,0
		JE DXeq0
		MOV WORD PTR [BP-2],16
		MOV AX,DX
		JMP AXneq0_CheckCondi
DXeq0:
		MOV WORD PTR [BP-2],0
		JMP AXneq0_CheckCondi
AXneq0:
		SHR AX,1
		INC WORD PTR [BP-2]
AXneq0_CheckCondi:
		CMP AX,0
		JNE AXneq0
		MOV AX,[BP-2]
		DEC AX
		ADD SP,2
		POP BP
		RET
	_getPowTwo ENDP
	
	_getDiv PROC NEAR
		PUBLIC _getDiv
;long getDiv(long x,	 int k)
;			AX=[BP+4]	[BP+8]
;			DX=[BP+6] MSD
;{
;	if(x % k == 0) return x/k
;	return 0
;}(ADD SP,6)
		PUSH BP
		MOV BP,SP
		MOV AX,[BP+4]
		MOV DX,[BP+6]
		MOV CX,[BP+8]				;May need push (used for watch)
		CMP CX,1
		JE getDiv_END
		DIV CX
		CMP DX,0
		JE getDiv_END			;the func return long even if the highest value it can be is int but lucky DX =0 
		XOR AX,AX
		XOR DX,DX 
getDiv_END:
		POP BP
		RET
	_getDiv ENDP

	_prothNumber PROC NEAR 
		PUBLIC _prothNumber
;int prothNumber(long x,	 int *k, 	int *n)
;				AX = [BP+4]		[BP+8]		[BP+10]
;				DX = [BP+6]MSD
;{
;	long x1 = x - 1, 	DivRes;		//DivRes is long because if k=1
;		DX = [BP-2] 	[BP-6]	MSD
;		AX = [BP-4]		[BP-8]		
;	int k1 = -1, 	PowRes;
;		[BP-10]		[BP-12]
;	do{
;		k1 += 2;
;		DivRes = getDiv(x1, k1);
;		if ((long)k1 >= DivRes) return 0;
;		if(DivRes){
;			if(isPowTwo(DivRes)){
;				PowRes = getPowTwo(DivRes);
;				*k = k1
;				*n = PowRes
;				return 1
;		}
;	}while(TRUE);
;}(ADD SP,8)
		PUSH BP
		MOV BP,SP
		SUB SP,12
		
		MOV AX,[BP+4]
		MOV DX,[BP+6]
		SUB AX,1
		SBB DX,0
		MOV [BP-4],AX 
		MOV [BP-2],DX
		MOV WORD PTR [BP-10],-1			;ADD can work we number system
prothNumber_S_DoWhile:
		ADD WORD PTR [BP-10],2
		PUSH WORD PTR [BP-10]
		PUSH WORD PTR [BP-2]
		PUSH WORD PTR [BP-4]
		CALL _getDiv
		ADD SP,6
		MOV [BP-8],AX 
		MOV [BP-6],DX 										
		CMP DX,0						
		JNE DivResIsLong					
		CMP [BP-10],AX					;
		MOV AX,0						;IF((long)k1 >= DivRes) return 0;
		JAE prothNumber_E_DoWhile		;
DivResIsLong:	
		MOV AX,[BP-8]						;I have to MOV back DivRes to reg because return 0
		MOV DX,[BP-6]
		CMP DX,0						;
		JNE DivResIsLongIfDiv			;
		CMP AX,0						;if(DivRes){
		JE prothNumber_S_DoWhile		;
DivResIsLongIfDiv:
		PUSH WORD PTR [BP-6]
		PUSH WORD PTR [BP-8]
		CALL _IsPowTwo
		ADD SP,4					
		CMP AX,0						;if(isPowTwo(DivRes){
		JE prothNumber_S_DoWhile		;
		PUSH WORD PTR [BP-6]
		PUSH WORD PTR [BP-8] 
		CALL _getPowTwo
		ADD SP,4
		MOV WORD PTR [BP-12],AX
		MOV AX,[BP-10]
		MOV BX,[BP+8]						;May Need to push it (save it) but in the current course its good enough
		MOV [BX],AX
		MOV AX,[BP-12]
		MOV BX,[BP+10]
		MOV [BX],AX
		MOV AX,1						;}
	
prothNumber_E_DoWhile:
		ADD SP,12
		POP BP
		RET
	_prothNumber ENDP
	
;int prothNumber(long x,	 int *k, 	int *n)
Start_main:
		MOV AX,@DATA
		MOV DS,AX
		MOV DX,0
		MOV AX,193
		MOV BX,OFFSET k
		MOV CX,OFFSET n
		PUSH CX
		PUSH BX
		PUSH DX
		PUSH AX
		CALL _prothNumber
		ADD SP,8
		MOV AH,4Ch
		INT 21h
		END Start_main