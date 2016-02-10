	;; parameter RDI
	SECTION	.text
	GLOBAL	strlen
strlen:
	XOR	rax, rax
_strlen_loop:
	CMP	[rdi + rax], BYTE 0
	JE	_strlen_end
	INC	rax
	JMP	_strlen_loop
_strlen_end:
	RET

	;; parameter RDI, RSI
	SECTION	.text
	GLOBAL	strnlen
strnlen:
	XOR	rax, rax
_strnlen_loop:
	CMP	rsi, 0
	JE	_strnlen_end
	CMP	[rdi + rax], BYTE 0
	JE	_strlen_end
	INC	rax
	DEC	rsi
	JMP	_strlen_loop
_strnlen_end:
	RET
