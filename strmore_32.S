%macro strpbrk.pushdata 0
	PUSH	edi
	PUSH	esi
	PUSH	ecx
	PUSH	eax
%endmacro
%macro strpbrk.popdata 0
	POP	eax
	POP	ecx
	POP	esi
	POP	edi
%endmacro
%macro INITZ 1
	XOR	%1, %1
%endmacro

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strpbrk
	EXTERN	index
strpbrk:
	INITZ	ecx
	INITZ	eax
_strpbrk_loop:
	CMP	BYTE [esi + ecx], BYTE 0	; test end of the tests
	JE	_strpbrk_final
	strpbrk.pushdata
	MOV	esi, [esi + ecx]	 	; argument 2 'x'
	CALL	index WRT ..plt
_strpbrk_calc:
	MOV	edx, eax			; save the result in edx
	strpbrk.popdata
	INC	ecx		; i++
	CMP	eax, BYTE 0	; if we didn't found a result before, cpy it in eax
	JE	_strpbrk_save
	CMP	edx, eax	; if the result is lt the old result, save it
	JL	_strpbrk_save
	JMP	_strpbrk_loop
_strpbrk_save:
	MOV	eax, edx
	JMP	_strpbrk_loop
_strpbrk_final:
_strpbrk_end:
	RET

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strcspn
	EXTERN	index
	EXTERN	strlen
strcspn:
	PUSH	edi
	PUSH	esi
	CALL	strpbrk
	POP	esi
	POP	edi
	CMP	eax, 0
	JE	_strcspn_end_none
	SUB	eax, edi
	JMP	_strcspn_end
_strcspn_end_none:
	CALL	strlen WRT ..plt
_strcspn_end:
	RET
