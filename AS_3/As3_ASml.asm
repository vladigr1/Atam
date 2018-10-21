;
;	The value in arr is sign
;	PTR 2 BYTE

		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		.386
		
	_is_dep PROC NEAR
		PUBLIC _is_dep
;int is_dep(int n, 		long int arr1[],
;			[BP+4]		[BP+6]
;			long int arr2[], 	long int arr3[], 
;			[BP+8]				[BP+10]
;
;			long int a, long int b, int *indx_ptr)
;			[BP+14]		[BP+18]		[BP+20]		MSD
;			[BP+12]		[BP+16]				
;				
;{
;	int i;
;		CX
;	long int result;							//we only use for the Assembly
;	[BP-2]		MSD
;	[BP-4]
;
;	for (i = 0; i <n; ++i){
;		if(a*arr1[i] + b*arr2[i] != arr3[i]) {		//result = a*arr1[i]//in case
;				[SI]		[DI]	[BX]			//EDX = b*arr2[i]	//OF even add
;													//EDX += result 	//cant corrupt
;													//and needed to cmp
;			*indx_ptr = i;
;			return 0;
;		}
;	}
;	return 1;
;}
		PUSH BP
		MOV BP,SP
		SUB SP,4					;long int result
		PUSH SI
		PUSH DI
		
		
		MOV CX,0
		MOV SI,[BP+6]
		MOV DI,[BP+8]
		MOV BX,[BP+10]
		JMP is_dep_CheckCondi
is_dep_StartLoop:		
		MOV EAX,[SI]
		MOV EDX,[BP+12]
		IMUL EDX
		MOV [BP-4],EAX
		MOV AX,0					;if result is long long int
		JO is_dep_ret0				;
		MOV EAX,[DI]
		MOV EDX,[BP+16]
		IMUL EDX
		MOV EDX,EAX
		MOV AX,0					;if result is long long int
		JO is_dep_ret0				;
		ADD EDX,[BP-4]
		JO is_dep_ret0				;if result is long long int and AX preset 0
		CMP EDX,[BX]
		JNE is_dep_ret0				;if(a*arr1[i] + b*arr2[i] != arr3[i]) and AX preset 0
		ADD SI,4
		ADD DI,4
		ADD BX,4
		INC CX
is_dep_CheckCondi:
		CMP CX,[BP+4]				;indexes are ensign
		JB is_dep_StartLoop
		
		
		MOV AX,1
		JMP is_dep_End	
is_dep_ret0:
		MOV AX,0
		MOV BX,[BP+20]
		MOV [BX],CX
is_dep_End:
		POP DI
		POP SI
		MOV SP,BP
		POP BP
		RET
	_is_dep ENDP
	END
	
