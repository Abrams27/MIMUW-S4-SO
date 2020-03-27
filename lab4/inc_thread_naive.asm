global inc_thread

section .bss

alignb 4
spin_lock resd 1 ; 1 raz 32 bity

section .text

align 8
inc_thread:
    mov     rsi, [rdi]      ; value
    mov     ecx, [rdi + 8]  ; count

    mov     rdx, spin_lock  ; W rdx jest adres blokady.
    mov     edi, 1          ; W edi jest wartość zamknietej blokady.
    jmp     count_test

    mov     rdx, spin_lock
    jmp     count_test
count_loop:
busy_wait:
    xor     eax, eax        ; W eax jest wartość otwartej blokady.
    lock \
    cmpxchg [rdx], edi      ; Jeśli blokada otwarta, zamknij ją.
    jne     busy_wait       ; Skocz, gdy blokada była zamknięta.

    inc     dword [rsi]     ; ++*value

    mov     [rdx], eax      ; Otwórz blokadę.
count_test:
    sub     ecx, 1          ; --count
    jge     count_loop      ; skok, gdy count >= 0
    xor     eax, eax        ; return NULL
    ret