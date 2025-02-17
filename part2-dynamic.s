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

    // allocate memory
    mov x8, 222 // syscall number for memmap
    mov x0, 0 // clear 0 for pointer
    mov x1, 24 // get (sizeof(int) * 6) bytes
    mov x2, 7 // read/write access
    mov x3, 0x22 // deafult flags
    mov x4, 0 // file descriptor irrelevant
    mov x5, 0 // offset (irrelevant)
    svc 0 // make sys call

    mov x9, x0 // store pointer in x9

    ldr x6, =coyote

    ldr w0, [x6]
    ldr w1, [x6,4]
    ldr w2, [x6,8]
    ldr w3, [x6,12]
    ldr w4, [x6,16]
    ldr w5, [x6,20]


    str w0, [x9]
    str w1, [x9,4]
    str w2, [x9,8]
    str w3, [x9,12]
    str w4, [x9,16]
    str w5, [x9,20]


    // clear memory
cleanup:
    mov x8, 215 // syscall number for munmap
    mov x0, x9 // address of the memory to deallocate
    mov x1, 24 // number of bytes
    svc 0 // make the sys call


return:
    mov x0, 0
    ret
