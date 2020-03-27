global inc_thread

section .bss

alignb 4
spin_lock resd 1 ; 1 raz 32 bity

section .text

align 8
inc_thread:
    mov     rsi, [rdi]      ; value
    mov     ecx, [rdi + 8]  ; count

    mov     rdx, spin_lock
    jmp     count_test
count_loop:
    mov     eax, 1
busy_wait:
    xchg    [rdx], eax      ; Jeśli blokada otwarta, zamknij ją.
    test    eax, eax        ; Sprawdź, czy blokada była otwarta.
    jnz     busy_wait       ; Skocz, gdy blokada była zamknięta.

    inc     dword [rsi]     ; ++*value

    mov     [rdx], eax      ; Otwórz blokadę.
count_test:
    sub     ecx, 1          ; --count
    jge     count_loop      ; skok, gdy count >= 0
    xor     eax, eax        ; return NULL
    ret