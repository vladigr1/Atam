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
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int * f(int *num)
   ;	
	assume	cs:_TEXT
_f	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;		return num;
   ;	
	mov	ax,word ptr [bp+4]
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
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
   ;	
   ;	{
   ;		int n = 0,*pn;
   ;	
	mov	word ptr [bp-2],0
   ;	
   ;		pn = f(&n);
   ;	
	lea	ax,word ptr [bp-2]
	push	ax
	call	near ptr _f
	pop	cx
	mov	word ptr [bp-4],ax
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
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_main
	public	_f
_s@	equ	s@
	end
