	.text
	.file	"test.cpp"
	.globl	_Z3sumPii                       # -- Begin function _Z3sumPii
	.p2align	4, 0x90
	.type	_Z3sumPii,@function
_Z3sumPii:                              # @_Z3sumPii
	.cfi_startproc
# %bb.0:
	testl	%esi, %esi
	jle	.LBB0_1
# %bb.3:
	movl	%esi, %ecx
	xorl	%edx, %edx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	addl	(%rdi,%rdx,4), %eax
	incq	%rdx
	cmpq	%rdx, %rcx
	jne	.LBB0_4
# %bb.2:
	retq
.LBB0_1:
	xorl	%eax, %eax
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
	movabsq	$4294967297, %rax               # imm = 0x100000001
	movq	%rax, -40(%rsp)
	movl	$1, %eax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	addl	-40(%rsp,%rcx,4), %eax
	movl	%eax, -32(%rsp,%rcx,4)
	incq	%rcx
	cmpq	$8, %rcx
	jne	.LBB1_1
# %bb.2:
	xorl	%eax, %eax
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
