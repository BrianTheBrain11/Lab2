// read and write staic memory segment
.data
.global badger
badger:
    .word 7

.global eagle
eagle:
    .word 0

.global coyote
coyote:
    .word   0
    .word   2
    .word   4
    .word   6
    .word   8
    .word   10

.global fox
.comm fox, 200, 4

// read only static memory segment
.section .rodata
.global hello
hello:
    .asciz "Hello, world!\n"

// instruction segment
.text
.global main
main:
    mov x0, 0
    ret
