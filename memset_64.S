	;; parameters RDI, RSI, RDX
	SECTION .text
	GLOBAL memset
memset:
	XOR	rcx, rcx
_memset_loop:
	CMP	rdx, rcx
	JE	_memset_end
	MOV	BYTE [rdi + rcx], sil
	INC	rcx
	JMP	_memset_loop
_memset_end:
	MOV	rax, rdi
	RET
