	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strstr
	EXTERN	strncmp
	EXTERN	strlen
strstr:
	PUSH	rdi
	MOV	rdi, rsi
	CALL	strlen WRT ..plt
	MOV	rdx, rax
	MOV	rsi, rdi
	POP	rdi
_strstr_loop:
	PUSH	rdx
	CALL	strncmp WRT ..plt
	POP	rdx
	CMP	rax, 0
	JE	_strstr_end
	CMP	BYTE [rdi], BYTE 0
	JE	_strstr_end_null
	INC	rdi
	JMP	_strstr_loop
_strstr_end:
	MOV	rax, rdi
	RET
_strstr_end_null:
	MOV	rax, 0
	RET
