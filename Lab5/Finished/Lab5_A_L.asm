;sign because didnt mantion in the task 
;even if in the example is rand() return 0 - RAND_MAX
		.MODEL LARGE
		.STACK 100h
		.DATA
		.CODE
		

	_sum2Opt PROC FAR
	PUBLIC _sum2Opt
;int sum2Opt(		void ** arr,	int size,
;					[BP+8]			[BP+10]								MSD/SEG
;					[BP+6]
;					int(*cmpSum)(void *, void *, void *),	void *z )
;					[BP+14]									[BP+18]		MSD/SEG
;					[BP+12]									[BP+16]
;{
;	int i = 0, 	j = size - 1,	flag;
;	[BP-2]		[BP-4]			[BP-6]	
;	while (i < j){
;		flag = cmpSum(arr[i], arr[j], z);
;		if (!flag)
;			return 1;
;		if (flag > 0)
;			i++;
;		if (flag < 0)	//else
;			j--;
;	}
;    return 0;
;}(ADD SP,10]
;Comment i,j sign because special case
		PUSH BP
		MOV BP,SP
		SUB SP,6
		PUSH ES
		
		MOV WORD PTR [BP-2],0
		MOV AX,[BP+10]
		DEC AX
		MOV [BP-4],AX
		JMP sum2Opt_CheckCondi

		
sum2Opt_StLoop:
		PUSH DWORD PTR [BP+16]
		MOV BX,[BP+6]
		ADD BX,[BP-4]			;
		ADD BX,[BP-4]			;PTR IS DWORD SIZE VALUE
		ADD BX,[BP-4]			;
		ADD BX,[BP-4]			;
		MOV ES,[BP+8]
		PUSH DWORD PTR ES:[BX]
		MOV BX,[BP+6]
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;PTR IS DWORD SIZE VALUE
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;
		MOV ES,[BP+8]
		PUSH DWORD PTR ES:[BX]
		CALL DWORD PTR [BP+12]
		ADD SP,12
		MOV [BP-6],AX
		CMP WORD PTR [BP-6],0
		JE sum2Opt_Ret1			;
		JG sum2Opt_InCI			;Work with Unsign as example 
		DEC WORD PTR [BP-4]		
		JMP sum2Opt_CheckCondi
sum2Opt_InCI:
		INC WORD PTR [BP-2]
sum2Opt_CheckCondi:
		MOV AX,[BP-2]
		CMP AX,[BP-4]
		JL sum2Opt_StLoop		;Because if i = 0 for the inter arr their will never exit 
		
		MOV AX,0
		JMP sum2Opt_Endig
sum2Opt_Ret1:
		MOV AX,1
sum2Opt_Endig:
		POP ES
		MOV SP,BP
		POP BP
		RET
	_sum2Opt ENDP
	
	
	_sum3Opt PROC FAR
		PUBLIC _sum3Opt
;int sum3Opt(	void ** arr,	int size,
;				[BP+8]			[BP+10]
;				[BP+6]
;				int(*sumCmp2)(void ** arr, int size,
;						int(*cmpSum)(void *, void *, void *), void *z ),
;				[BP+14]
;				[BP+12]
;				int(*cmpSum)(void *, void *, void *),
;				[BP+18]
;				[BP+16]
;				void* (*sub)(void * a, void *b),	void *z )		
;				[BP+22]								[BP+26]
;				[BP+20]								[BP+24]
;{
;	int i;
;	[BP-2]
;    for (i = 1; i <= size - 2; i++)
;    {
;        if (sumCmp2(arr+i, size - i, cmpSum, sub(z, arr[i - 1])))
;            return 1;
;    }
;    return 0;
;}(ADD SP,14)
		PUSH BP
		MOV BP,SP
		SUB SP,2
		PUSH ES
		MOV WORD PTR [BP-2],1
		JMP sum3Opt_CheckCondi
		
sum3Opt_StartLoop:		
		MOV BX,[BP+6]
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;PTR IS DWORD SIZE VALUE
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;
		MOV ES,[BP+8]
		PUSH DWORD PTR ES:[BX-4]
		PUSH DWORD PTR [BP+24]
		CALL DWORD PTR [BP+20]
		ADD SP,8
		PUSH DX
		PUSH AX
		PUSH DWORD PTR [BP+16]
		MOV AX,[BP+10]
		SUB AX,[BP-2]
		PUSH AX
		MOV BX,[BP+6]
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;PTR IS DWORD SIZE VALUE
		ADD BX,[BP-2]			;
		ADD BX,[BP-2]			;
		PUSH WORD PTR [BP+8]
		PUSH BX
		CALL DWORD PTR [BP+12]
		ADD SP,14
		CMP AX,0
		JNE sum3Opt_Ret1
		INC WORD PTR [BP-2]
sum3Opt_CheckCondi:
		MOV AX,[BP+10]
		SUB AX,2
		CMP [BP-2],AX
		JBE sum3Opt_StartLoop		;we want to check the last ones
		
		MOV AX,0
		JMP sum3Opt_Ending
		
sum3Opt_Ret1:
		MOV AX,1
sum3Opt_Ending:
		POP ES
		MOV SP,BP
		POP BP
		RET
	_sum3Opt ENDP
		END