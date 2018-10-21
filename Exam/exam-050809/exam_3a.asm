		.MODEL SMALL
		.STACK 100h
		.DATA
	X DD ?
	FX DD ?
	GX DD ?
		.CODE
		.386
		.387
		
;extern float steffensen(	float (*fun)(float),	float x0,	float eps);
;							[B+4]					[BP+6]		[BP+10]
	_steffensen PROC NEAR
		PUBLIC _steffensen
		PUSH BP
		MOV BP,SP
		FLD DWORD PTR [BP+6]
		FSTP X
START_LOOP:
		PUSH X
		CALL WORD PTR [BP+4]
		ADD SP,4
		FSTP FX
		FLD X
		FADD FX
		FSTP GX
		PUSH GX
		CALL WORD PTR [BP+4]
		ADD SP,4
		FSUB FX
		FDIV FX
		FSTP GX
		FLD X
		FLD FX
		FDIV GX
		FSUB
		FSTP X
CHECK_LOOP:
		FLD FX
		FABS
		FCOMP DWORD PTR [BP+10]
		FSTSW AX
		SAHF
		JA START_LOOP
		FLD X
		POP BP
		RET
	_steffensen ENDP
		END