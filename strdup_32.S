	;; 1 argument RDI
	SECTION	.text
	GLOBAL strdup
	EXTERN strlen
	EXTERN malloc
	EXTERN memcpy
strdup:
	PUSH	edi		; edi
	CALL	strlen WRT ..plt
	INC	eax		; size with \0
	PUSH	eax		; edi, eax
	MOV	edi, eax
	CALL	malloc WRT ..plt
	CMP	eax, 0
	JE	_strdup_end_failure
	MOV	edi, eax	; edi = allocated memory
	POP	edx		; size with \0
	POP	esi		; esi is the original argument 1
	CALL	memcpy WRT ..plt
_strdup_end:
	RET
_strdup_end_failure:
	POP	eax
	POP	eax
	XOR	eax, eax
	RET
