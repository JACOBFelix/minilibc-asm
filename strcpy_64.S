 	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcpy
strcpy:
	XOR	rcx, rcx
	CMP	rsi, 0
	JE	_strcpy_final
	CMP	rdi, 0
	JE	_strcpy_final
_strcpy_loop:
	CMP	BYTE [rsi + rcx], BYTE 0
	JE	_strcpy_final
	MOV	al, BYTE [rsi + rcx]
	MOV	BYTE [rdi + rcx], al
	INC	rcx
	JMP	_strcpy_loop
_strcpy_final:
	MOV	[rdi + rcx], BYTE 0
_strcpy_end:
	MOV	rax, rdi
	RET

 	;; 3 arguments, RDI, RSI, RDX
	SECTION	.text
	GLOBAL	strncpy
strncpy:
	XOR	rcx, rcx
	CMP	rsi, 0
	JE	_strncpy_final
	CMP	rdi, 0
	JE	_strncpy_final
_strncpy_loop:
	CMP	rdx, 0
	JE	_strncpy_end
	CMP	BYTE [rsi + rcx], BYTE 0
	JE	_strncpy_final
	MOV	al, BYTE [rsi + rcx]
	MOV	BYTE [rdi + rcx], al
	INC	rcx
	DEC	rdx
	JMP	_strncpy_loop
_strncpy_final:
	MOV	[rdi + rcx], BYTE 0
_strncpy_end:
	MOV	rax, rdi
	RET
