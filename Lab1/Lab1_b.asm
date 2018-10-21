    .MODEL SMALL
    .STACK 100h
    .DATA
		DisplayAStart DB 'Please enter 3 letters for string A space and 3 letters for string B',13,10,'$'
		DisplayFalse DB 13,10,'False',13,10,'$'
		DisplayTrue DB 13,10,'True',13,10,'$'
		chA1 DB ?
		chA2 DB ?
		chA3 DB ?
     .CODE
Begin:
     MOV AX,@DATA     
     MOV DS,AX  
	       
     MOV AH,9h     
     MOV DX,OFFSET DisplayAStart
     INT 21h               

	 MOV AH,1h
	 INT 21h
	 MOV chA1,AL

	 MOV AH,1h
	 INT 21h
	 MOV chA2,AL

	 MOV AH,1h
	 INT 21h
	 MOV chA3,AL

	 MOV AH,1h
	 INT 21h
	 CMP AL,' '
	 JE StringB
	 JMP IfFalse
					
StringB:
	 MOV AH,1h
	 INT 21h

	 CMP AL,chA1				;AL = B1
	 JE EnterchB2

	 CMP AL,chA2
	 JE B1eqA2

	 CMP AL,chA3
	 JE B1eqA3

	 JMP IfFalse				;fail to find 

B1eqA2:
	MOV BH,chA1
	MOV chA1,AL					;AL == chA2 == B1
	MOV chA2,BH
	JMP EnterchB2

B1eqA3:
	MOV BH,chA1
	MOV chA1,AL					;AL == chA2 == B1
	MOV chA3,BH
	JMP EnterchB2

EnterchB2:
	MOV AH,1h
	INT 21h

	CMP AL,chA2
	JE EnterchB3

	CMP AL,chA3
	
B2eqA3:
	MOV BH,chA2
	MOV chA2,AL					;AL == chA2 == B1
	MOV chA3,BH
	JMP EnterchB3

EnterchB3:
	MOV AH,1h
	INT 21h
	CMP AL,chA3
	JE IfTrue
	JMP IfFalse
IfTrue:
	MOV DX,OFFSET DisplayTrue
	JMP DisplayResult
IfFalse:
	MOV DX,OFFSET DisplayFalse
DisplayResult:
	MOV AH,9h
	INT 21h

    MOV AH,4Ch       
    INT 21h       
    END Begin 
  


   


