	;; parameters RDI, RSI, RDX
	SECTION .text
	GLOBAL memset
memset:
	XOR	ecx, ecx
_memset_loop:
	CMP	edx, ecx
	JE	_memset_end
	MOV	eax, esi
	MOV	BYTE [edi + ecx], al
	INC	ecx
	JMP	_memset_loop
_memset_end:
	MOV	eax, edi
	RET
