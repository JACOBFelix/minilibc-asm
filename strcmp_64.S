	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcmp
strcmp:
	PUSH	rbx
	XOR	rcx, rcx
	XOR	rax, rax
_strcmp_loop:
	MOV	al, BYTE [rsi + rcx]
	CMP	BYTE [rdi + rcx], al
	JNE 	_strcmp_final
	CMP	al, BYTE 0
	JE 	_strcmp_final
	INC 	rcx
	JMP 	_strcmp_loop
_strcmp_final:
	XOR	rdx, rdx
	MOV	dl, BYTE [rdi + rcx]
	SUB	eax, edx
	NEG	eax
	;; JMP	_strcmp_end
_strcmp_end:
	POP	rbx
	RET

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcasecmp
_lowercase:
	CMP	al, BYTE 'A'
	JL	_lowercase_end
	CMP	al, BYTE 'Z'
	JG	_lowercase_end
	XOR	al, 32		; remove the bit 32 = add 32
	;; JMP	_lowercase_end
_lowercase_end:
	RET
strcasecmp:
	PUSH	rbx
	XOR	rcx, rcx
	XOR	rax, rax
	XOR	rbx, rbx
_strcasecmp_loop:
	MOV	al, BYTE [rdi + rcx]
	CALL	_lowercase
	MOV	bl, al
	MOV	al, BYTE [rsi + rcx]
	CALL	_lowercase
	CMP	bl, al
	JNE 	_strcasecmp_final
	CMP	al, BYTE 0
	JE 	_strcasecmp_final
	INC 	rcx
	JMP 	_strcasecmp_loop
_strcasecmp_end_ok:
	XOR	rax, rax
	JMP	_strcasecmp_end
_strcasecmp_final:
	XOR	rdx, rdx
	MOV	dl, BYTE [rdi + rcx]
	SUB	eax, edx
	NEG	eax
	;; JMP	_strcasecmp_end
_strcasecmp_end:
	POP	rbx
	RET

	;; 3 arguments, RDI, RSI, RDX
	SECTION	.text
	GLOBAL	strncmp
strncmp:
	PUSH	rbx
	XOR	rcx, rcx
	XOR	rax, rax
	XOR	rbx, rbx
_strncmp_loop:
	CMP	rdx, rcx
	JE	_strncmp_end_zero
	MOV	al, BYTE [rdi + rcx]
	MOV	bl, BYTE [rsi + rcx]
	CMP	al, bl
	JNE 	_strncmp_end
	CMP	al, BYTE 0
	JE 	_strncmp_end
	INC 	rcx
	JMP 	_strncmp_loop
_strncmp_end:
	SUB	eax, ebx
	POP	rbx
	RET
_strncmp_end_zero:
	XOR	rax, rax
	POP	rbx
	RET
