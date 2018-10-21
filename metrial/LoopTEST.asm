;Loop, loope and loopnz are similar assembly code but has some differences
		.MODEL SMALL
		.STACK 100h
		.DATA
		.CODE
		MOV AX,@DATA
		MOV DS ,AX
		
		MOV CX,3
LoopTest:
		LOOP LoopTest		;loop only if cx != 0 (cx-- , cx != 0)
		
		MOV CX,3
LoopETest:					
		CMP AX,AX			
		LOOPE LoopETest		;loop only if zf == 0 && cx != 0 (cx-- , cx != 0)
		
		MOV CX,3
LoopNZTest:
		CMP AX,@DATA				
		LOOPNZ LoopNZTest	;loop only if zf != 0 && cx != 0 (cx-- , cx != 0)
		
		MOV AH,4Ch
		INT 21h
		END