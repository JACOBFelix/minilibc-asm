	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strstr
	EXTERN	strncmp
	EXTERN	strlen
strstr:
	PUSH	edi
	MOV	edi, esi
	CALL	strlen WRT ..plt
	MOV	edx, eax
	MOV	esi, edi
	POP	edi
_strstr_loop:
	PUSH	edx
	CALL	strncmp WRT ..plt
	POP	edx
	CMP	eax, 0
	JE	_strstr_end
	CMP	BYTE [edi], BYTE 0
	JE	_strstr_end_null
	INC	edi
	JMP	_strstr_loop
_strstr_end:
	MOV	eax, edi
	RET
_strstr_end_null:
	MOV	eax, 0
	RET
