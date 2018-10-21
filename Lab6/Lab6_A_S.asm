		.MODEL SMALL
		.STACK 100h
		.DATA
	;partition
	TempIntI DW ?
	TempIntJ DW ?
	DoublePivot DQ ?
	;quick sort
	startIndex DW ?
	endIndex DW ?
	pivotIndex DW ?
	
		.CODE
		.386
		.387
		
	swap PROC NEAR
;void swap(	double* a, 	double* b)
;			[BP+4]		[BP+6]
;{
;	double temp = *a;
;	*a = *b;
;	*b = *temp;
;}(ADD SP,4)
		PUSH BP
		MOV BP,SP
		PUSH SI
		
		MOV SI,[BP+4]
		MOV BX,[BP+6]
		FLD QWORD PTR [SI]
		FLD QWORD PTR [BX]
		FSTP QWORD PTR [SI]
		FSTP QWORD PTR [BX]
		POP SI
		POP BP
		RET
	swap ENDP
	
	partition PROC NEAR
		EXTRN _rand:NEAR
;int partition(double* arr,	int left,	int right) ;
;				[BP+4]		[BP+6]		[BP+8]
;{
;	unsigned i = left -1 ,j;
;	double pivot;
;	swap((arr + left + (rand()%(right - left +1)) ),arr+right);
;	pivot = arr[right]
;	for (j= left; j<=right-1;++j){
;		if(arr[j] <= pivot)  swap (arr + (++i), arr+j);
;	}
;	swap(arr + (++i),arr + right);
;	return i;
;}(ADD SP,6)
		PUSH BP
		MOV BP,SP
		MOV AX,[BP+6]
		MOV TempIntI,AX		;even if in the start I is negative value in the inter function it will run and give unsigned values
		DEC TempIntI		;that why I is unsigned
		
		MOV AX,[BP+8]		;cant overflow because overflowed values will exit the SEG
		SHL AX,3			;
		ADD AX,[BP+4]
		PUSH AX
		MOV BX,[BP+8]
		SUB BX,[BP+6]
		INC BX
		PUSH BX
		CALL _rand
		POP BX
		XOR DX,DX
		DIV BX			;unsigned because div is positive number and right is always bigger or equal left  
;		PUSH DX		;
;		MOV AH,2h	;
;		ADD DL,'0'	;
;		INT 21h		;Print index of pivot
;		MOV DL,13	;
;		INT 21h		;
;		MOV DL,10	;
;		INT 21h		;
;		POP DX		;
		SHL DX,3			;DX = (rand()%(right - left +1)*8 (*8 for mem skip)
		MOV AX,[BP+6]		
		SHL AX,3
		ADD AX,DX
		ADD AX,[BP+4]
		PUSH AX
		CALL swap
		ADD SP,4
		MOV BX,[BP+4]
		MOV AX,[BP+8]
		SHL AX,3
		ADD BX,AX
		FLD QWORD PTR[BX]
		FSTP DoublePivot
		
		MOV AX,[BP+6]
		MOV TempIntJ,AX
		JMP partition_Cond
partition_startFor:		
		MOV AX,TempIntJ
		SHL AX,3
		MOV BX,[BP+4]
		ADD BX,AX
		FLD QWORD PTR [BX]
		FCOMP DoublePivot
		FSTSW AX
		SAHF
		JNBE partition_ForEndIf
		PUSH BX 			;BX still has the address arr+j
		INC TempIntI
		MOV AX,TempIntI
		SHL AX,3
		MOV BX,[BP+4]
		ADD BX,AX
		PUSH BX
		CALL swap
		ADD SP,4
partition_ForEndIf:
		INC TempIntJ
partition_Cond:
		MOV AX,[BP+8]
		DEC AX
		CMP TempIntJ,AX
		JBE partition_startFor
		
		MOV AX,TempIntJ
		SHL AX,3
		MOV BX,[BP+4]
		ADD BX,AX
		PUSH BX
		INC TempIntI
		MOV AX,TempIntI
		SHL AX,3
		MOV BX,[BP+4]
		ADD BX,AX
		PUSH BX
		CALL swap
		ADD SP,4
		MOV AX,TempIntI
		POP BP
		RET
	partition ENDP
	
	_quickSort PROC NEAR
		PUBLIC _quickSort
;void quickSort(double* arr,	 int count)
;				[BP+4]			[BP+6]
;{
;	int startIndex = 0,endIndex = count -1,pivotIndex;
;	push(startIndex);				//we didn't really initiate stack and it function 
;	push(endIndex);					//we will use the system stack for that in the Assembly code
;	while(!emptyStack()){
;		endIndex= pop();
;		startIndex= pop();
;		pivotIndex = partition(arr,startIndex,endIndex);
;		if(pivotIndex - 1 > startIndex){
;			push(startIndex);
;			push(pivotIndex-1);
;		}
;		if(pivotIndex + 1 < endIndex){
;			push(pivotIndex+1);
;			push(endIndex);
;		}
;	}
;}
		PUSH BP
		MOV BP,SP
		MOV AX,[BP+6]
		DEC AX
		MOV endIndex,AX
		XOR AX,AX
		MOV startIndex,AX
		PUSH startIndex
		PUSH endIndex
		JMP quickSort_whileCond
quickSort_whileStart:
		POP WORD PTR endIndex
		POP WORD PTR startIndex
		PUSH WORD PTR endIndex
		PUSH WORD PTR startIndex
		PUSH WORD PTR [BP+4]
		CALL partition
		ADD SP,6
		MOV pivotIndex,AX
		DEC AX
		CMP AX,startIndex
		JNG quickSort_whileLeftIfEnd		;because of special case if pivotIndex == 0
		PUSH WORD PTR startIndex
		PUSH AX
quickSort_whileLeftIfEnd:
		ADD AX,2
		CMP AX,endIndex
		JNL quickSort_whileRightIfEnd
		PUSH AX
		PUSH WORD PTR endIndex
quickSort_whileRightIfEnd:
quickSort_whileCond:
		CMP BP,SP		;if empty we will have to pull BP which means BP == SP
		JNE quickSort_whileStart
		
		POP BP
		RET
	_quickSort ENDP
		END