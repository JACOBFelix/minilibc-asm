	;; parameter RDI
	SECTION	.text
	GLOBAL	strlen
strlen:
	XOR	eax, eax
_strlen_loop:
	CMP	[edi + eax], BYTE 0
	JE	_strlen_end
	INC	eax
	JMP	_strlen_loop
_strlen_end:
	RET
