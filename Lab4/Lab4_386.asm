		.MODEL SMALL
		.STACK 100h
		.DATA 
		DisplayGetPN DB 'Please enter number:',13,10,'$'
		Ten DD 10
		.CODE
		.386
;long getPNum();
	_getPNum PROC NEAR
		PUBLIC _getPNum
;print(request)
;	LONG RESULT = 0 
;		AX = [BP - 2]	= EAX = [BP - 4]
;		DX = [BP - 4] MSD
;while(SCAN(&AL) && AL!= 13){
;	PUSH AX
;		[BP - 6]
;	BX*=10
;	POP AX
;	bl+=AX 
;}		
		PUSH BP
		MOV BP,SP
		SUB SP,6
		MOV AH,9h
		MOV DX,OFFSET DisplayGetPN
		INT 21h
		
		XOR EAX,EAX
		MOV [BP - 4],EAX				;RESULT = 0
		JMP GetNumStart_CheckCondition
GetNumStart:
		XOR AH,AH
		SUB AL,'0'
		MOV [BP - 6],AX
		MOV EAX,[BP - 4]
		MUL Ten
		ADD AX,[BP - 6]
		MOV [BP-4],EAX
		
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
	
	
Start_main:
		MOV AX,@DATA
		MOV DS,AX
		CALL _getPNum
		MOV AH,4Ch
		INT 21h
		END Start_main