// instruction segment
.text
.global main
main:
    mov x8, 222 // syscall number for memmap
    mov x0, 0 // let the kernel choose the address
    mov x1, 4 // allocate 4 bytes
    mov x2, 7 // read/write access
    mov x3, 0x22 // default flags
    mov x4, 0 // file descriptor (irrelevant for MAP_ANONYMOUS)
    mov x5, 0 // offset (irrelevant)
    svc 0 // make the syscall

    // the pointer is now in x0 do not lose it
    // we do so by copying it into x9 so we can use x0 for other purposes
    mov x9, x0
    
    // set the integer to 7
    mov w0, 7
    str w0, [x9]
    
    // it is not necessary to set a pointer since we already did above
    ldr w2, [x9]
    add w2, w2, 3
    str w2, [x9]

    mov x8, 215 // syscall number for munmap
    mov x0, x9 // address of the memory to deallocate
    mov x1, 16 // size of the region
    svc 0 // make the sys call

return:
    mov x0, 0
    ret
