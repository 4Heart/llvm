; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=thumb-linux-androideabi -mcpu=arm1156t2-s -mattr=+thumb2 -verify-machineinstrs | FileCheck %s -check-prefix=THUMB
; RUN: llc < %s -mtriple=arm-linux-androideabi -mcpu=arm1156t2-s -verify-machineinstrs | FileCheck %s -check-prefix=ARM


; Just to prevent the alloca from being optimized away
declare void @dummy_use(ptr, i32)

define void @test_basic() #0 {
; THUMB-LABEL: test_basic:
; THUMB:       @ %bb.0:
; THUMB-NEXT:    push {r4, r5}
; THUMB-NEXT:    mrc p15, #0, r4, c13, c0, #3
; THUMB-NEXT:    mov r5, sp
; THUMB-NEXT:    ldr.w r4, [r4, #252]
; THUMB-NEXT:    cmp r4, r5
; THUMB-NEXT:    bls .LBB0_2
; THUMB-NEXT:  @ %bb.1:
; THUMB-NEXT:    mov r4, #48
; THUMB-NEXT:    mov r5, #0
; THUMB-NEXT:    push {lr}
; THUMB-NEXT:    bl __morestack
; THUMB-NEXT:    ldr lr, [sp], #4
; THUMB-NEXT:    pop {r4, r5}
; THUMB-NEXT:    bx lr
; THUMB-NEXT:  .LBB0_2:
; THUMB-NEXT:    pop {r4, r5}
; THUMB-NEXT:    .save {r7, lr}
; THUMB-NEXT:    push {r7, lr}
; THUMB-NEXT:    .pad #40
; THUMB-NEXT:    sub sp, #40
; THUMB-NEXT:    mov r0, sp
; THUMB-NEXT:    movs r1, #10
; THUMB-NEXT:    bl dummy_use
; THUMB-NEXT:    add sp, #40
; THUMB-NEXT:    pop {r7, pc}
;
; ARM-LABEL: test_basic:
; ARM:       @ %bb.0:
; ARM-NEXT:    push {r4, r5}
; ARM-NEXT:    mrc p15, #0, r4, c13, c0, #3
; ARM-NEXT:    mov r5, sp
; ARM-NEXT:    ldr r4, [r4, #252]
; ARM-NEXT:    cmp r4, r5
; ARM-NEXT:    bls .LBB0_2
; ARM-NEXT:  @ %bb.1:
; ARM-NEXT:    mov r4, #48
; ARM-NEXT:    mov r5, #0
; ARM-NEXT:    stmdb sp!, {lr}
; ARM-NEXT:    bl __morestack
; ARM-NEXT:    ldm sp!, {lr}
; ARM-NEXT:    pop {r4, r5}
; ARM-NEXT:    bx lr
; ARM-NEXT:  .LBB0_2:
; ARM-NEXT:    pop {r4, r5}
; ARM-NEXT:    .save {r11, lr}
; ARM-NEXT:    push {r11, lr}
; ARM-NEXT:    .pad #40
; ARM-NEXT:    sub sp, sp, #40
; ARM-NEXT:    mov r0, sp
; ARM-NEXT:    mov r1, #10
; ARM-NEXT:    bl dummy_use
; ARM-NEXT:    add sp, sp, #40
; ARM-NEXT:    pop {r11, pc}
  %mem = alloca i32, i32 10
  call void @dummy_use (ptr %mem, i32 10)
  ret void
}

define void @test_large() #0 {
        %mem = alloca i32, i32 10000
        call void @dummy_use (ptr %mem, i32 0)
        ret void

; THUMB-LABEL:   test_large:

; THUMB:         push    {r4, r5}
; THUMB-NEXT:    mov     r5, sp
; THUMB-NEXT:    movw    r4, #40192
; THUMB-NEXT:    sub     r5, r5, r4
; THUMB-NEXT:    mrc     p15, #0, r4, c13, c0, #3
; THUMB-NEXT:    ldr.w   r4, [r4, #252]
; THUMB-NEXT:    cmp     r4, r5
; THUMB-NEXT:    bls     .LBB1_2

; THUMB:         movw    r4, #40192
; THUMB-NEXT:    mov     r5, #0
; THUMB-NEXT:    push    {lr}
; THUMB-NEXT:    bl      __morestack
; THUMB-NEXT:    ldr     lr, [sp], #4
; THUMB-NEXT:    pop     {r4, r5}
; THUMB-NEXT:    bx      lr

; THUMB:         pop     {r4, r5}


; ARM-LABEL:   test_large:

; ARM:         push    {r4, r5}
; ARM-NEXT:    ldr     r4, .LCPI1_0
; ARM-NEXT:    sub     r5, sp, r4
; ARM-NEXT:    mrc     p15, #0, r4, c13, c0, #3
; ARM-NEXT:    ldr     r4, [r4, #252]
; ARM-NEXT:    cmp     r4, r5
; ARM-NEXT:    bls     .LBB1_2

; ARM:         ldr     r4, .LCPI1_0
; ARM-NEXT:    mov     r5, #0
; ARM-NEXT:    stmdb   sp!, {lr}
; ARM-NEXT:    bl      __morestack
; ARM-NEXT:    ldm     sp!, {lr}
; ARM-NEXT:    pop     {r4, r5}
; ARM-NEXT:    bx      lr

; ARM:         pop     {r4, r5}

; ARM:         .LCPI1_0:
; ARM-NEXT:    .long   40192

}

define fastcc void @test_fastcc_large() #0 {
        %mem = alloca i32, i32 10000
        call void @dummy_use (ptr %mem, i32 0)
        ret void

; THUMB-LABEL:   test_fastcc_large:

; THUMB:         push    {r4, r5}
; THUMB-NEXT:    mov     r5, sp
; THUMB-NEXT:    movw    r4, #40192
; THUMB-NEXT:    sub     r5, r5, r4
; THUMB-NEXT:    mrc     p15, #0, r4, c13, c0, #3
; THUMB-NEXT:    ldr.w   r4, [r4, #252]
; THUMB-NEXT:    cmp     r4, r5
; THUMB-NEXT:    bls     .LBB2_2

; THUMB:         movw    r4, #40192
; THUMB-NEXT:    mov     r5, #0
; THUMB-NEXT:    push    {lr}
; THUMB-NEXT:    bl      __morestack
; THUMB-NEXT:    ldr     lr, [sp], #4
; THUMB-NEXT:    pop     {r4, r5}
; THUMB-NEXT:    bx      lr

; THUMB:         pop     {r4, r5}

; ARM-LABEL:   test_fastcc_large:

; ARM:         push    {r4, r5}
; ARM-NEXT:    ldr     r4, .LCPI2_0
; ARM-NEXT:    sub     r5, sp, r4
; ARM-NEXT:    mrc     p15, #0, r4, c13, c0, #3
; ARM-NEXT:    ldr     r4, [r4, #252]
; ARM-NEXT:    cmp     r4, r5
; ARM-NEXT:    bls     .LBB2_2

; ARM:         ldr     r4, .LCPI2_0
; ARM-NEXT:    mov     r5, #0
; ARM-NEXT:    stmdb   sp!, {lr}
; ARM-NEXT:    bl      __morestack
; ARM-NEXT:    ldm     sp!, {lr}
; ARM-NEXT:    pop     {r4, r5}
; ARM-NEXT:    bx      lr

; ARM:         .LCPI2_0:
; ARM-NEXT:    .long   40192
}


declare void @panic() unnamed_addr

; We used to crash while compiling the following function.
; THUMB-LABEL: build_should_not_segfault:
; ARM-LABEL: build_should_not_segfault:
define void @build_should_not_segfault(i8 %x) unnamed_addr #0 {
start:
  %_0 = icmp ult i8 %x, 16
  %or.cond = select i1 undef, i1 true, i1 %_0
  br i1 %or.cond, label %bb1, label %bb2

bb1:
  ret void

bb2:
  call void @panic()
  unreachable
}

attributes #0 = { "split-stack" }
