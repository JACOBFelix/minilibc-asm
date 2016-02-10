	;; 3 parameters RDI, RSI, RDX
	SECTION .text
	GLOBAL memcpy
memcpy:
	PUSH	edi
_memcpy_loop:
	CMP	edx, 0
	JE	_memcpy_end
	MOV	cl, BYTE [esi]
	MOV	BYTE [edi], cl
	DEC	edx
	INC	edi
	INC	esi
	JMP	_memcpy_loop
_memcpy_end:
	POP	eax
	RET

	;; 3 parameters, RDI, RSI, RDX
	SECTION .text
	GLOBAL memmove
	EXTERN malloc
	EXTERN free
memmove:
	PUSH	edi		; dest
	PUSH	esi		; dest, src
	PUSH	edx		; dest, src, size
_memmove_alloc_pre:
	MOV	edi, edx
_memmove_alloc:
	CALL	malloc WRT ..plt
_memmove_save_pre:
	POP	edx		; dest, src
	POP	esi		; dest
	PUSH	edx		; dest, size
	PUSH	eax		; dest, size, alloc
	MOV	edi, eax
_memmove_save:
	CALL	memcpy
_memmove_save_check:
	CMP	eax, 0
	JE	_memmove_save_check_failed
_memmove_cpy_pre:
	POP	esi		; dest, size
	POP	edx		; dest
	POP	edi		; <empty>
	PUSH	edi		; dest
	PUSH	esi		; dest, alloc
	;; PUSH	edx		; dest, alloc, size
_memmove_cpy:
	CALL	memcpy
_memmove_free_pre:
	;; POP	edx		; dest, alloc
	POP	edi		; dest
_memmove_free:
	CALL	free WRT ..plt
_memmove_final:
	POP	eax		; <empty>
_memmove_end:
	RET
_memmove_save_check_failed:
	POP	eax
	POP	eax
	POP	eax
	XOR	eax, eax
	JMP	_memmove_end

;; memmove:
;; 	PUSH	edi
;; 	PUSH	esi
;; 	PUSH	edx		; dest, src, size
;; _memmove_alloc:
;; 	;; alloc tmp
;; 	MOV	edi, edx
;; 	CALL	malloc WRT ..plt
;; _memmove_save:
;; 	;; copy source to tmp
;; 	MOV	edi, eax
;; 	POP	edx
;; 	POP	esi
;; 	PUSH	edx
;; 	PUSH 	eax		; dest, size, tmp
;; 	CALL	memcpy
;; _memmove_copy:
;; 	;; copy tmp to dest
;; 	POP	esi
;; 	POP	edx
;; 	POP	edi
;; 	PUSH	edi		; tmp
;; 	CALL	memcpy
;; _memmove_free:
;; 	;; free
;; 	POP	edi
;; 	PUSH	eax		; dest
;; 	CALL	free WRT ..plt
;; 	;; finalisation
;; _memmove_final:
;; 	POP	eax
;; 	JMP	_memmove_end
;; _memmove_malloc_failed:
;; 	XOR	eax, eax
;; _memmove_end:
;; 	RET
