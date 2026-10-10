	.text
	.file	"Fib.cpp"
                                        # Start of file scope inline assembly
	.globl	_ZSt21ios_base_library_initv

                                        # End of file scope inline assembly
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	_ZSt3cin@GOTPCREL(%rip), %rdi
	leaq	4(%rsp), %rsi
	callq	_ZNSirsERi@PLT
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	xorl	%esi, %esi
	callq	_ZNSolsEi@PLT
	movq	(%rax), %rcx
	movq	-24(%rcx), %rcx
	movq	240(%rax,%rcx), %rbx
	testq	%rbx, %rbx
	je	.LBB0_16
# %bb.1:
	cmpb	$0, 56(%rbx)
	je	.LBB0_3
# %bb.2:
	movzbl	67(%rbx), %ecx
	jmp	.LBB0_4
.LBB0_3:
	movq	%rbx, %rdi
	movq	%rax, %r14
	callq	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movl	$10, %esi
	callq	*48(%rax)
	movl	%eax, %ecx
	movq	%r14, %rax
.LBB0_4:
	movsbl	%cl, %esi
	movq	%rax, %rdi
	callq	_ZNSo3putEc@PLT
	movq	%rax, %rdi
	callq	_ZNSo5flushEv@PLT
	movq	_ZSt4cout@GOTPCREL(%rip), %rdi
	movl	$1, %esi
	callq	_ZNSolsEi@PLT
	movq	(%rax), %rcx
	movq	-24(%rcx), %rcx
	movq	240(%rax,%rcx), %rbx
	testq	%rbx, %rbx
	je	.LBB0_16
# %bb.5:
	cmpb	$0, 56(%rbx)
	je	.LBB0_7
# %bb.6:
	movzbl	67(%rbx), %ecx
	jmp	.LBB0_8
.LBB0_7:
	movq	%rbx, %rdi
	movq	%rax, %r14
	callq	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movl	$10, %esi
	callq	*48(%rax)
	movl	%eax, %ecx
	movq	%r14, %rax
.LBB0_8:
	movsbl	%cl, %esi
	movq	%rax, %rdi
	callq	_ZNSo3putEc@PLT
	movq	%rax, %rdi
	callq	_ZNSo5flushEv@PLT
	cmpl	$2, 4(%rsp)
	jl	.LBB0_15
# %bb.9:
	movl	$1, %r15d
	xorl	%eax, %eax
	movq	_ZSt4cout@GOTPCREL(%rip), %rbx
	movl	$1, %r12d
	jmp	.LBB0_10
	.p2align	4, 0x90
.LBB0_13:                               #   in Loop: Header=BB0_10 Depth=1
	movq	%r14, %rdi
	movq	%rax, %r13
	callq	_ZNKSt5ctypeIcE13_M_widen_initEv@PLT
	movq	(%r14), %rax
	movq	%r14, %rdi
	movl	$10, %esi
	callq	*48(%rax)
	movl	%eax, %ecx
	movq	%r13, %rax
.LBB0_14:                               #   in Loop: Header=BB0_10 Depth=1
	movsbl	%cl, %esi
	movq	%rax, %rdi
	callq	_ZNSo3putEc@PLT
	movq	%rax, %rdi
	callq	_ZNSo5flushEv@PLT
	incl	%r15d
	movl	%r12d, %eax
	movl	%ebp, %r12d
	cmpl	4(%rsp), %r15d
	jge	.LBB0_15
.LBB0_10:                               # =>This Inner Loop Header: Depth=1
	movl	%eax, %ebp
	addl	%r12d, %ebp
	movq	%rbx, %rdi
	movl	%ebp, %esi
	callq	_ZNSolsEi@PLT
	movq	(%rax), %rcx
	movq	-24(%rcx), %rcx
	movq	240(%rax,%rcx), %r14
	testq	%r14, %r14
	je	.LBB0_16
# %bb.11:                               #   in Loop: Header=BB0_10 Depth=1
	cmpb	$0, 56(%r14)
	je	.LBB0_13
# %bb.12:                               #   in Loop: Header=BB0_10 Depth=1
	movzbl	67(%r14), %ecx
	jmp	.LBB0_14
.LBB0_15:
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB0_16:
	.cfi_def_cfa_offset 64
	callq	_ZSt16__throw_bad_castv@PLT
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _ZSt3cin
	.addrsig_sym _ZSt4cout
