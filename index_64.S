	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	index
	GLOBAL	strchr
strchr:
index:
	XOR	rcx, rcx
_index_loop:
	CMP	sil, BYTE [rdi + rcx]
	JE	_index_end_found
	CMP	[rdi + rcx], BYTE 0
	JE	_index_end_notfound
	INC	rcx
	JMP	_index_loop
_index_end_notfound:
	XOR	rax, rax
	RET
_index_end_found:
	MOV	rax, rdi
	ADD	rax, rcx
	RET

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	rindex
rindex:
	XOR	rcx, rcx
	MOV	rdx, -1
_rindex_loop:
	CMP	sil, BYTE [rdi + rcx]
	JE	_rindex_save
	JMP	_rindex_next
_rindex_save:
	MOV	rdx, rcx
_rindex_next:
	CMP	[rdi + rcx], BYTE 0
	JE	_rindex_final
	INC	rcx
	JMP	_rindex_loop
_rindex_final:
	MOV	rax, rdi
	CMP	rdx, -1
	JE	_rindex_end_notfound
	;; JMP	_rindex_end
_rindex_end:
	ADD	rax, rdx
	RET
_rindex_end_notfound:
	XOR	rax, rax
	RET
