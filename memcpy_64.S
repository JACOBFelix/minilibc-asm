	;; 3 parameters RDI, RSI, RDX
	SECTION .text
	GLOBAL memcpy
memcpy:
	PUSH	rdi
_memcpy_loop:
	CMP	rdx, 0
	JE	_memcpy_end
	MOV	cl, BYTE [rsi]
	MOV	BYTE [rdi], cl
	DEC	rdx
	INC	rdi
	INC	rsi
	JMP	_memcpy_loop
_memcpy_end:
	POP	rax
	RET

	;; 3 parameters, RDI, RSI, RDX
	SECTION .text
	GLOBAL memmove
	EXTERN malloc
	EXTERN free
memmove:
	PUSH	rdi		; dest
	PUSH	rsi		; dest, src
	PUSH	rdx		; dest, src, size
_memmove_alloc_pre:
	MOV	rdi, rdx
_memmove_alloc:
	CALL	malloc WRT ..plt
_memmove_save_pre:
	POP	rdx		; dest, src
	POP	rsi		; dest
	PUSH	rdx		; dest, size
	PUSH	rax		; dest, size, alloc
	MOV	rdi, rax
_memmove_save:
	CALL	memcpy
_memmove_save_check:
	CMP	rax, 0
	JE	_memmove_save_check_failed
_memmove_cpy_pre:
	POP	rsi		; dest, size
	POP	rdx		; dest
	POP	rdi		; <empty>
	PUSH	rdi		; dest
	PUSH	rsi		; dest, alloc
	;; PUSH	rdx		; dest, alloc, size
_memmove_cpy:
	CALL	memcpy
_memmove_free_pre:
	;; POP	rdx		; dest, alloc
	POP	rdi		; dest
_memmove_free:
	CALL	free WRT ..plt
_memmove_final:
	POP	rax		; <empty>
_memmove_end:
	RET
_memmove_save_check_failed:
	POP	rax
	POP	rax
	POP	rax
	XOR	rax, rax
	JMP	_memmove_end

;; memmove:
;; 	PUSH	rdi
;; 	PUSH	rsi
;; 	PUSH	rdx		; dest, src, size
;; _memmove_alloc:
;; 	;; alloc tmp
;; 	MOV	rdi, rdx
;; 	CALL	malloc WRT ..plt
;; _memmove_save:
;; 	;; copy source to tmp
;; 	MOV	rdi, rax
;; 	POP	rdx
;; 	POP	rsi
;; 	PUSH	rdx
;; 	PUSH 	rax		; dest, size, tmp
;; 	CALL	memcpy
;; _memmove_copy:
;; 	;; copy tmp to dest
;; 	POP	rsi
;; 	POP	rdx
;; 	POP	rdi
;; 	PUSH	rdi		; tmp
;; 	CALL	memcpy
;; _memmove_free:
;; 	;; free
;; 	POP	rdi
;; 	PUSH	rax		; dest
;; 	CALL	free WRT ..plt
;; 	;; finalisation
;; _memmove_final:
;; 	POP	rax
;; 	JMP	_memmove_end
;; _memmove_malloc_failed:
;; 	XOR	rax, rax
;; _memmove_end:
;; 	RET
