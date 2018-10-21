		.MODEL SMALL
		.STACK 100h
		.DATA
	Xi DQ ?
	Xi1 DQ ?
	XMax DQ 0.0
	XMaxi DQ ?
		.CODE
		.386
		.387
	_find_discontinue_point PROC NEAR
		PUBLIC _find_discontinue_point
;double find_discontinue_point(	double *f)(double),	double x1,	double x2,	double h);
;								[BP+4]				[BP+6]		[BP+14]		[BP+22]
		PUSH BP
		MOV BP,SP
		FLD QWORD PTR [BP+6]
		FST Xi
		FADD QWORD PTR [BP+22]
		FSTP Xi1
		JMP LOOP1_Check
LOOP1:
		PUSH Xi1
		CALL WORD PTR [BP+4]
		ADD SP,8
		PUSH Xi
		CALL WORD PTR [BP+4]
		ADD SP,8
		FSUB
		FABS
		FLD XMax
		FCOMP 
		FSTSW AX
		SAHF
		JNB NotNewMax
		FST XMax
		FLD Xi1
		FADD Xi
		FLD1
		FLD1
		FADD
		FDIV
		FSTP XMaxi
NotNewMax:
		FSTP ST
		FLD Xi1
		FST Xi
		FADD QWORD PTR [BP+22]
		FSTP Xi1
LOOP1_Check:
		FLD QWORD PTR [BP+14]
		FCOMP Xi1
		FSTSW AX
		SAHF
		JA LOOP1
		
		FLD XMaxi
		POP BP
		RET
	_find_discontinue_point ENDP
	END