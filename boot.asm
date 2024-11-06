; boot.asm
section .multiboot
    magic:      dd 0x1BADB002
    flags:      dd 0
    checksum:   dd -(0x1BADB002 + 0)

section .text
global _start
_start:
    ; Устанавливаем стек и передаем управление ядру
    call kernel_main
    cli
    hlt
