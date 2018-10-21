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
	?debug	S "mainswpt.c"
	?debug	C E92E80454D0A6D61696E737770742E63
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
_DATA	segment word public 'DATA'
_global_call	label	word
	db	0
	db	0
	db	14
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	long int intswap(int *a, int *b,long int c)
   ;	
	assume	cs:_TEXT
_intswap	proc	near
	push	bp
	mov	bp,sp
	sub	sp,2
   ;	
   ;	{
   ;		int temp = *a;
   ;	
	mov	bx,word ptr [bp+4]
	mov	ax,word ptr [bx]
	mov	word ptr [bp-2],ax
   ;	
   ;		static int called=14;
   ;		called++;
   ;	
	inc	word ptr DGROUP:d@w+2
   ;	
   ;		*a = *b;
   ;	
	mov	bx,word ptr [bp+6]
	mov	ax,word ptr [bx]
	mov	bx,word ptr [bp+4]
	mov	word ptr [bx],ax
   ;	
   ;		*b = temp;
   ;	
	mov	bx,word ptr [bp+6]
	mov	ax,word ptr [bp-2]
	mov	word ptr [bx],ax
   ;	
   ;		return c--;
   ;	
	mov	ax,word ptr [bp+8]
	mov	dx,word ptr [bp+10]
	sub	word ptr [bp+8],1
	sbb	word ptr [bp+10],0
	jmp	short @1@58
@1@58:
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
_intswap	endp
_TEXT	ends
_DATA	segment word public 'DATA'
	db	0
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int main()
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,8
   ;	
   ;	{
   ;		int a =5,b =7;
   ;	
	mov	word ptr [bp-2],5
	mov	word ptr [bp-4],7
   ;	
   ;		long int c =8;
   ;	
	mov	word ptr [bp-6],0
	mov	word ptr [bp-8],8
   ;	
   ;		static int prcalled = 0;
   ;		c = intswap(&a, &b,c);
   ;	
	push	word ptr [bp-6]
	push	word ptr [bp-8]
	lea	ax,word ptr [bp-4]
	push	ax
	lea	ax,word ptr [bp-2]
	push	ax
	call	near ptr _intswap
	add	sp,8
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
   ;	
   ;		prcalled++;
   ;	
	inc	word ptr DGROUP:d@w+4
   ;	
   ;		global_call++;
   ;	
	inc	word ptr DGROUP:_global_call
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
	public	_intswap
	public	_global_call
_s@	equ	s@
	end
