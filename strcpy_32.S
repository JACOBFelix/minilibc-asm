 	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcpy
strcpy:
	XOR	ecx, ecx
	CMP	esi, 0
	JE	_strcpy_final
	CMP	edi, 0
	JE	_strcpy_final
_strcpy_loop:
	CMP	BYTE [esi + ecx], BYTE 0
	JE	_strcpy_final
	MOV	al, BYTE [esi + ecx]
	MOV	BYTE [edi + ecx], al
	INC	ecx
	JMP	_strcpy_loop
_strcpy_final:
	MOV	[edi + ecx], BYTE 0
_strcpy_end:
	MOV	eax, edi
	RET

 	;; 3 arguments, RDI, RSI, RDX
	SECTION	.text
	GLOBAL	strncpy
strncpy:
	XOR	ecx, ecx
	CMP	esi, 0
	JE	_strncpy_final
	CMP	edi, 0
	JE	_strncpy_final
_strncpy_loop:
	CMP	edx, 0
	JE	_strncpy_end
	CMP	BYTE [esi + ecx], BYTE 0
	JE	_strncpy_final
	MOV	al, BYTE [esi + ecx]
	MOV	BYTE [edi + ecx], al
	INC	ecx
	DEC	edx
	JMP	_strncpy_loop
_strncpy_final:
	MOV	[edi + ecx], BYTE 0
_strncpy_end:
	MOV	eax, edi
	RET
