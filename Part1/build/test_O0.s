	.text
	.file	"test.cpp"
	.globl	_Z3sumPii                       # -- Begin function _Z3sumPii
	.p2align	4, 0x90
	.type	_Z3sumPii,@function
_Z3sumPii:                              # @_Z3sumPii
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB0_4
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	addl	-16(%rbp), %eax
	movl	%eax, -16(%rbp)
# %bb.3:                                #   in Loop: Header=BB0_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB0_1
.LBB0_4:
	movl	-16(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	_Z3sumPii, .Lfunc_end0-_Z3sumPii
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$0, -4(%rbp)
	movl	$1, -48(%rbp)
	movl	$1, -44(%rbp)
	movl	$2, -52(%rbp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$10, -52(%rbp)
	jge	.LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movl	-52(%rbp), %eax
	subl	$1, %eax
	cltq
	movl	-48(%rbp,%rax,4), %ecx
	movl	-52(%rbp), %eax
	subl	$2, %eax
	cltq
	addl	-48(%rbp,%rax,4), %ecx
	movslq	-52(%rbp), %rax
	movl	%ecx, -48(%rbp,%rax,4)
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB1_1
.LBB1_4:
	movl	$0, -56(%rbp)
	leaq	-48(%rbp), %rdi
	movl	$10, %esi
	callq	_Z3sumPii
	addl	-56(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %edi
	movl	$10, %esi
	callq	_Z1fii
	movl	%eax, -56(%rbp)
	movl	-4(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	.text._Z1fii,"axG",@progbits,_Z1fii,comdat
	.weak	_Z1fii                          # -- Begin function _Z1fii
	.p2align	4, 0x90
	.type	_Z1fii,@function
_Z1fii:                                 # @_Z1fii
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	$1007, %ecx                     # imm = 0x3EF
	cltd
	idivl	%ecx
	movl	%edx, -4(%rbp)
	movl	-4(%rbp), %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_Z1fii, .Lfunc_end2-_Z1fii
	.cfi_endproc
                                        # -- End function
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym _Z3sumPii
	.addrsig_sym _Z1fii
