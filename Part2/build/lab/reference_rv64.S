/* Handwritten RISC-V 64 assembly for reference.sy.
 * Uses RV64IM integer instructions and the standard RISC-V ELF psABI.
 * Assemble/link with an RV64 Linux GCC toolchain (normally lp64d ABI).
 * The SysY runtime exports getint, putint and putch.
 */

    .text
    .align 2
    .globl calc
    .type calc, @function
calc:
    /* a0 = pointer to a[0], a1 = signed int n.
       Leaf function: no saved registers or stack frame are needed.
       t0 = i, t1 = ans, t2 = element address,
       t3 = a[i], t4/t5 = scratch. */
    li      t0, 0
    li      t1, 0
.Lcalc_cond:
    bge     t0, a1, .Lcalc_end     /* while (i < n) */
    slli    t2, t0, 2              /* byte offset = i * sizeof(int) */
    add     t2, a0, t2
    lw      t3, 0(t2)              /* signed 32-bit a[i] */
    andi    t4, t3, 1
    bnez    t4, .Lcalc_odd         /* srem(a[i],2) != 0 */

.Lcalc_even:
    li      t5, 2
    divw    t4, t3, t5             /* signed int32 division, toward zero */
    slliw   t4, t4, 2              /* int32 result *= 4 */
    addw    t1, t1, t4             /* int32 ans += result */
    j       .Lcalc_next

.Lcalc_odd:
    subw    t1, t1, t3             /* int32 ans -= a[i] */

.Lcalc_next:
    addiw   t0, t0, 1              /* int32 i++ */
    j       .Lcalc_cond

.Lcalc_end:
    mv      a0, t1                 /* return signed int32 ans */
    ret
    .size calc, .-calc

    .align 2
    .globl main
    .type main, @function
main:
    /* The stack must be 16-byte aligned at every call.
       0..19(sp): int a[5]; 40..47(sp): saved return address. */
    addi    sp, sp, -48
    sd      ra, 40(sp)

    li      t0, 1
    sw      t0, 0(sp)
    li      t0, 2
    sw      t0, 4(sp)
    li      t0, 3
    sw      t0, 8(sp)
    li      t0, 4
    sw      t0, 12(sp)
    li      t0, 5
    sw      t0, 16(sp)

    call    getint                    /* a0 = n */
    addiw   a0, a0, 0               /* maintain signed 32-bit int */

    bge     a0, zero, .Lcheck_upper  /* if (n < 0) n = 0 */
    li      a0, 0
.Lcheck_upper:
    li      t0, 5
    bge     t0, a0, .Ln_ready       /* if (n > 5) n = 5 */
    li      a0, 5
.Ln_ready:
    mv      a1, a0                   /* calc's second argument: n */
    mv      a0, sp                   /* calc's first argument: &a[0] */
    call    calc                     /* a0 = answer */

    call    putint                   /* putint(answer) */
    li      a0, 10
    call    putch                    /* putch('\n') */

    li      a0, 0                    /* return 0 from main */
    ld      ra, 40(sp)
    addi    sp, sp, 48
    ret
    .size main, .-main

    .section .note.GNU-stack,"",@progbits
