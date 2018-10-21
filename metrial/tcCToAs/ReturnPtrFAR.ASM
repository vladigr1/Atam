	ifndef	??version
?debug	macro
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	S "return~1.c"
	?debug	C E901A82D4D0A72657475726E7E312E63
RETURN~1_TEXT	segment byte public 'CODE'
RETURN~1_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:RETURN~1_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
RETURN~1_TEXT	segment byte public 'CODE'
   ;	
   ;	int * f(int *num)
   ;	
	assume	cs:RETURN~1_TEXT
_f	proc	far
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;		return num;
   ;	
	mov	dx,word ptr [bp+8]
	mov	ax,word ptr [bp+6]
	jmp	short @1@58
@1@58:
   ;	
   ;	}
   ;	
	pop	bp
	ret	
_f	endp
   ;	
   ;	int main()
   ;	
	assume	cs:RETURN~1_TEXT
_main	proc	far
	push	bp
	mov	bp,sp
	sub	sp,6
   ;	
   ;	{
   ;		int n = 0,*pn;
   ;	
	mov	word ptr [bp-2],0
   ;	
   ;		pn = f(&n);
   ;	
	push	ss
	lea	ax,word ptr [bp-2]
	push	ax
	push	cs
	call	near ptr _f
	pop	cx
	pop	cx
	mov	word ptr [bp-4],dx
	mov	word ptr [bp-6],ax
   ;	
   ;		return 0;
   ;	
	xor	ax,ax
	jmp	short @2@58
@2@58:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_main	endp
	?debug	C E9
RETURN~1_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
RETURN~1_TEXT	segment byte public 'CODE'
RETURN~1_TEXT	ends
	public	_main
	public	_f
_s@	equ	s@
	end
