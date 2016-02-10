%macro strpbrk.pushdata 0
	PUSH	rdi
	PUSH	rsi
	PUSH	rcx
	PUSH	rax
%endmacro
%macro strpbrk.popdata 0
	POP	rax
	POP	rcx
	POP	rsi
	POP	rdi
%endmacro
%macro INITZ 1
	XOR	%1, %1
%endmacro

	;; 2 arguments, RDI, RSI
	SECTION	.text
	GLOBAL	strpbrk
	EXTERN	index
strpbrk:
	INITZ	rcx
	INITZ	rax
_strpbrk_loop:
	CMP	BYTE [rsi + rcx], BYTE 0	; test end of the tests
	JE	_strpbrk_final
	strpbrk.pushdata
	MOV	rsi, [rsi + rcx]	 	; argument 2 'x'
	CALL	index WRT ..plt
_strpbrk_calc:
	MOV	rdx, rax			; save the result in rdx
	strpbrk.popdata
	INC	rcx		; i++
	CMP	rax, BYTE 0	; if we didn't found a result before, cpy it in rax
	JE	_strpbrk_save
	CMP	rdx, rax	; if the result is lt the old result, save it
	JL	_strpbrk_save
	JMP	_strpbrk_loop
_strpbrk_save:
	MOV	rax, rdx
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
	PUSH	rdi
	PUSH	rsi
	CALL	strpbrk
	POP	rsi
	POP	rdi
	CMP	rax, 0
	JE	_strcspn_end_none
	SUB	rax, rdi
	JMP	_strcspn_end
_strcspn_end_none:
	CALL	strlen WRT ..plt
_strcspn_end:
	RET
