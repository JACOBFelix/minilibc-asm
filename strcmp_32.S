	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcmp
strcmp:
	PUSH	ebx
	XOR	ecx, ecx
	XOR	eax, eax
_strcmp_loop:
	MOV	al, BYTE [esi + ecx]
	CMP	BYTE [edi + ecx], al
	JNE 	_strcmp_final
	CMP	al, BYTE 0
	JE 	_strcmp_final
	INC 	ecx
	JMP 	_strcmp_loop
_strcmp_final:
	XOR	edx, edx
	MOV	dl, BYTE [edi + ecx]
	SUB	eax, edx
	NEG	eax
	;; JMP	_strcmp_end
_strcmp_end:
	POP	ebx
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
	PUSH	ebx
	XOR	ecx, ecx
	XOR	eax, eax
	XOR	ebx, ebx
_strcasecmp_loop:
	MOV	al, BYTE [edi + ecx]
	CALL	_lowercase
	MOV	bl, al
	MOV	al, BYTE [esi + ecx]
	CALL	_lowercase
	CMP	bl, al
	JNE 	_strcasecmp_final
	CMP	al, BYTE 0
	JE 	_strcasecmp_final
	INC 	ecx
	JMP 	_strcasecmp_loop
_strcasecmp_end_ok:
	XOR	eax, eax
	JMP	_strcasecmp_end
_strcasecmp_final:
	XOR	edx, edx
	MOV	dl, BYTE [edi + ecx]
	SUB	eax, edx
	NEG	eax
	;; JMP	_strcasecmp_end
_strcasecmp_end:
	POP	ebx
	RET

	;; 3 arguments, RDI, RSI, RDX
	SECTION	.text
	GLOBAL	strncmp
strncmp:
	PUSH	ebx
	XOR	ecx, ecx
	XOR	eax, eax
	XOR	ebx, ebx
_strncmp_loop:
	CMP	edx, ecx
	JE	_strncmp_end_zero
	MOV	al, BYTE [edi + ecx]
	MOV	bl, BYTE [esi + ecx]
	CMP	al, bl
	JNE 	_strncmp_end
	CMP	al, BYTE 0
	JE 	_strncmp_end
	INC 	ecx
	JMP 	_strncmp_loop
_strncmp_end:
	SUB	eax, ebx
	POP	ebx
	RET
_strncmp_end_zero:
	XOR	eax, eax
	POP	ebx
	RET
