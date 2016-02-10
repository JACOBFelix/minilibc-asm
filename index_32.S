	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	index
	GLOBAL	strchr
strchr:
index:
	XOR	ecx, ecx
_index_loop:
	MOV	eax, esi
	CMP	al, BYTE [edi + ecx]
	JE	_index_end_found
	CMP	[edi + ecx], BYTE 0
	JE	_index_end_notfound
	INC	ecx
	JMP	_index_loop
_index_end_notfound:
	XOR	eax, eax
	RET
_index_end_found:
	MOV	eax, edi
	ADD	eax, ecx
	RET

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	rindex
rindex:
	XOR	ecx, ecx
	MOV	edx, -1
_rindex_loop:
	MOV	eax, esi
	CMP	al, BYTE [edi + ecx]
	JE	_rindex_save
	JMP	_rindex_next
_rindex_save:
	MOV	edx, ecx
_rindex_next:
	CMP	[edi + ecx], BYTE 0
	JE	_rindex_final
	INC	ecx
	JMP	_rindex_loop
_rindex_final:
	MOV	eax, edi
	CMP	edx, -1
	JE	_rindex_end_notfound
	;; JMP	_rindex_end
_rindex_end:
	ADD	eax, edx
	RET
_rindex_end_notfound:
	XOR	eax, eax
	RET
