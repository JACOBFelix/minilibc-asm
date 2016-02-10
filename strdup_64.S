	;; 1 argument RDI
	SECTION	.text
	GLOBAL strdup
	EXTERN strlen
	EXTERN malloc
	EXTERN memcpy
strdup:
	PUSH	rdi		; rdi
	CALL	strlen WRT ..plt
	INC	rax		; size with \0
	PUSH	rax		; rdi, rax
	MOV	rdi, rax
	CALL	malloc WRT ..plt
	CMP	rax, 0
	JE	_strdup_end_failure
	MOV	rdi, rax	; rdi = allocated memory
	POP	rdx		; size with \0
	POP	rsi		; rsi is the original argument 1
	CALL	memcpy WRT ..plt
_strdup_end:
	RET
_strdup_end_failure:
	POP	rax
	POP	rax
	XOR	rax, rax
	RET
