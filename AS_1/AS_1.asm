       ;Working with unsign number with 386
	   ;Didn`t check input
        .MODEL SMALL
        .STACK 250h
        .DATA
        n DB ?
        N1 DD ?
        Sqrt DD ?
        Temp DD ?
        LaunchS DB 'enter number 01-99with leading zeor if necessary: $'
        ResultPr1 DB 10, 13, 'sqrt($'
        ResultPr2 DB ') = $'
        .CODE
Start:
        MOV AX,@DATA
        MOV DS,AX
        MOV AH,9h               ;enter input
        MOV DX,OFFSET LaunchS
        INT 21h
        MOV AH,1h
        INT 21h
        SUB AL,'0'
        MOV BL, 10
        MUL BL
        MOV n,AL
        MOV AH,1h
        INT 21h
        SUB AL,'0'
        ADD n,AL
.386
        MOV BL,n
        MOV EAX,10000
        MUL EBX
        MOV N1,EAX


        MOV AL,81               ;setting Sqrt (cant be negative number)
        CMP n,AL
        MOV Sqrt,900
        JA iteration

        MOV AL,64
        CMP n,AL
        MOV Sqrt,800
        JAE iteration

        MOV AL,49
        CMP n,AL
        MOV Sqrt,700
        JAE iteration

        MOV AL,36
        CMP n,AL
        MOV Sqrt,600
        JAE iteration

        MOV AL,25
        CMP n,AL
        MOV Sqrt,500
        JAE iteration

        MOV AL,16
        CMP n,AL
        MOV Sqrt,400
        JAE iteration

        MOV AL,9
        CMP n,AL
        MOV Sqrt,300
        JAE iteration

        MOV AL,4
        CMP n,AL
        MOV Sqrt,200
        JAE iteration

        MOV Sqrt,100


iteration:              ;calculate Sqrt
        MOV CX,0
        JMP check_loop1
loop1:
        MOV EDX,0
        MOV EAX,N1
        DIV Sqrt
        ADD EAX,Sqrt
        MOV EDX,0
        MOV EBX,2
        DIV EBX
        MOV Sqrt,EAX
        INC CX
check_loop1:
        CMP CX,3
        JNE loop1


        MOV AH,9h                   ;setting result print
        MOV DX, OFFSET ResultPr1
        INT 21h
        XOR AH,AH
        MOV AL,n 
        MOV BL,10
        DIV BL
        ADD AL,'0'
        ADD AH,'0'
        MOV DL,AL
        MOV DH,AH
        MOV AH,2h 
        INT 21h
        MOV DL,DH
        MOV AH,2h 
        INT 21h
        MOV AH,9h 
        MOV DX, OFFSET ResultPr2
        INT 21h


        XOR EDX,EDX         ;print result number
        MOV EAX,Sqrt
        MOV EBX,100 
        DIV EBX
        MOV Temp,EDX
        MOV DL,AL
        ADD DL,'0'
        MOV AH,2h 
        INT 21h
        MOV DL,'.'      ;AH is still 2
        INT 21h 
        XOR EDX,EDX
        MOV EAX,Temp
        MOV EBX,10
        DIV EBX
        MOV Temp,EDX
        MOV DL,AL
        ADD DL,'0'
        MOV AH,2h 
        INT 21h
        MOV EDX,Temp
        ADD DL,'0'
        MOV AH,2h 
        INT 21h

        MOV AH,4Ch
        INT 21h
        END Start

