	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi0:
	.cfi_def_cfa_offset 16
Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi2:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$0, -4(%rbp)
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpl	$4, -8(%rbp)
	jge	LBB0_2
## BB#1:
	xorl	%eax, %eax
	movl	%eax, %esi
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdi
	callq	_giveUp
LBB0_2:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdi
	callq	_intValue
	movl	%eax, -28(%rbp)
	cmpl	$4, -28(%rbp)
	jl	LBB0_4
## BB#3:
	cmpl	$40, -28(%rbp)
	jl	LBB0_5
LBB0_4:
	leaq	L_.str(%rip), %rsi
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	callq	_giveUp
LBB0_5:
	movq	-16(%rbp), %rax
	movq	16(%rax), %rdi
	callq	_intValue
	movl	%eax, -32(%rbp)
	cmpl	$0, -32(%rbp)
	jl	LBB0_7
## BB#6:
	cmpl	$100, -32(%rbp)
	jl	LBB0_8
LBB0_7:
	leaq	L_.str.1(%rip), %rsi
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	callq	_giveUp
LBB0_8:
	movq	-16(%rbp), %rax
	movq	24(%rax), %rdi
	callq	_intValue
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jge	LBB0_10
## BB#9:
	leaq	L_.str.2(%rip), %rsi
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	callq	_giveUp
LBB0_10:
	movl	-36(%rbp), %edi
	callq	_seedRand
	movl	$20, %edi
	movl	$2, %eax
	movl	-28(%rbp), %ecx
	movl	%eax, -44(%rbp)         ## 4-byte Spill
	movl	%ecx, %eax
	cltd
	movl	-44(%rbp), %ecx         ## 4-byte Reload
	idivl	%ecx
	subl	%eax, %edi
	movl	%edi, -20(%rbp)
	movl	$10, -24(%rbp)
	movl	-20(%rbp), %edi
	movl	-24(%rbp), %esi
	movl	-28(%rbp), %eax
	movl	%eax, %edx
	callq	_initWorm
	movl	$0, -40(%rbp)
LBB0_11:                                ## =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	LBB0_16
## BB#12:                               ##   in Loop: Header=BB0_11 Depth=1
	callq	_clearGrid
	movl	-28(%rbp), %edi
	callq	_addWormToGrid
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	leaq	L_.str.4(%rip), %rdi
	movl	-40(%rbp), %esi
	movl	%eax, -48(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	movl	%eax, -52(%rbp)         ## 4-byte Spill
	callq	_drawGrid
	movl	-28(%rbp), %edi
	callq	_moveWorm
	cmpl	$0, %eax
	jne	LBB0_14
## BB#13:
	leaq	L_.str.5(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -56(%rbp)         ## 4-byte Spill
	jmp	LBB0_16
LBB0_14:                                ##   in Loop: Header=BB0_11 Depth=1
	movl	$1, %edi
	callq	_delay
## BB#15:                               ##   in Loop: Header=BB0_11 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -40(%rbp)
	jmp	LBB0_11
LBB0_16:
	xorl	%edi, %edi
	callq	_exit
	.cfi_endproc

	.globl	_giveUp
	.p2align	4, 0x90
_giveUp:                                ## @giveUp
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi3:
	.cfi_def_cfa_offset 16
Lcfi4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi5:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	LBB1_2
## BB#1:
	leaq	L_.str.8(%rip), %rdi
	movq	-16(%rbp), %rsi
	movb	$0, %al
	callq	_printf
	movl	%eax, -20(%rbp)         ## 4-byte Spill
LBB1_2:
	leaq	L_.str.9(%rip), %rdi
	movq	-8(%rbp), %rsi
	movb	$0, %al
	callq	_printf
	movl	$1, %edi
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	callq	_exit
	.cfi_endproc

	.globl	_intValue
	.p2align	4, 0x90
_intValue:                              ## @intValue
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi6:
	.cfi_def_cfa_offset 16
Lcfi7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi8:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -28(%rbp)
	movq	-16(%rbp), %rdi
	movq	%rdi, -24(%rbp)
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movsbl	(%rax), %ecx
	cmpl	$0, %ecx
	je	LBB2_9
## BB#2:                                ##   in Loop: Header=BB2_1 Depth=1
	movq	-24(%rbp), %rax
	movsbl	(%rax), %ecx
	cmpl	$32, %ecx
	jne	LBB2_4
## BB#3:                                ##   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_8
LBB2_4:                                 ##   in Loop: Header=BB2_1 Depth=1
	movq	-24(%rbp), %rax
	movsbl	(%rax), %ecx
	cmpl	$48, %ecx
	jl	LBB2_6
## BB#5:                                ##   in Loop: Header=BB2_1 Depth=1
	movq	-24(%rbp), %rax
	movsbl	(%rax), %ecx
	cmpl	$57, %ecx
	jle	LBB2_7
LBB2_6:
	movl	$-1, -4(%rbp)
	jmp	LBB2_10
LBB2_7:                                 ##   in Loop: Header=BB2_1 Depth=1
	imull	$10, -28(%rbp), %eax
	movq	-24(%rbp), %rcx
	movsbl	(%rcx), %edx
	subl	$48, %edx
	addl	%edx, %eax
	movl	%eax, -28(%rbp)
LBB2_8:                                 ##   in Loop: Header=BB2_1 Depth=1
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	LBB2_1
LBB2_9:
	movl	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
LBB2_10:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_seedRand
	.p2align	4, 0x90
_seedRand:                              ## @seedRand
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi9:
	.cfi_def_cfa_offset 16
Lcfi10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi11:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	movl	%edi, _randSeed(%rip)
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_initWorm
	.p2align	4, 0x90
_initWorm:                              ## @initWorm
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi12:
	.cfi_def_cfa_offset 16
Lcfi13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi14:
	.cfi_def_cfa_register %rbp
	movq	_wormRow@GOTPCREL(%rip), %rax
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-4(%rbp), %edx
	addl	$1, %edx
	movl	%edx, -20(%rbp)
	movl	-4(%rbp), %edx
	movl	%edx, (%rcx)
	movl	-8(%rbp), %edx
	movl	%edx, (%rax)
	movl	$1, -16(%rbp)
LBB4_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	LBB4_6
## BB#2:                                ##   in Loop: Header=BB4_1 Depth=1
	cmpl	$40, -20(%rbp)
	jne	LBB4_4
## BB#3:
	jmp	LBB4_6
LBB4_4:                                 ##   in Loop: Header=BB4_1 Depth=1
	movq	_wormRow@GOTPCREL(%rip), %rax
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movl	-20(%rbp), %edx
	movl	%edx, %esi
	addl	$1, %esi
	movl	%esi, -20(%rbp)
	movslq	-16(%rbp), %rdi
	movl	%edx, (%rcx,%rdi,4)
	movl	-8(%rbp), %edx
	movslq	-16(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
## BB#5:                                ##   in Loop: Header=BB4_1 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	LBB4_1
LBB4_6:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_clearGrid
	.p2align	4, 0x90
_clearGrid:                             ## @clearGrid
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi15:
	.cfi_def_cfa_offset 16
Lcfi16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi17:
	.cfi_def_cfa_register %rbp
	movl	$0, -4(%rbp)
LBB5_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB5_3 Depth 2
	cmpl	$20, -4(%rbp)
	jge	LBB5_8
## BB#2:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	$0, -8(%rbp)
LBB5_3:                                 ##   Parent Loop BB5_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$40, -8(%rbp)
	jge	LBB5_6
## BB#4:                                ##   in Loop: Header=BB5_3 Depth=2
	movq	_grid@GOTPCREL(%rip), %rax
	movslq	-4(%rbp), %rcx
	imulq	$40, %rcx, %rcx
	addq	%rcx, %rax
	movslq	-8(%rbp), %rcx
	movb	$46, (%rax,%rcx)
## BB#5:                                ##   in Loop: Header=BB5_3 Depth=2
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_3
LBB5_6:                                 ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_7
LBB5_7:                                 ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	LBB5_1
LBB5_8:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_addWormToGrid
	.p2align	4, 0x90
_addWormToGrid:                         ## @addWormToGrid
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi18:
	.cfi_def_cfa_offset 16
Lcfi19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi20:
	.cfi_def_cfa_register %rbp
	movq	_grid@GOTPCREL(%rip), %rax
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movq	_wormRow@GOTPCREL(%rip), %rdx
	movl	%edi, -4(%rbp)
	movl	(%rdx), %edi
	movl	%edi, -8(%rbp)
	movl	(%rcx), %edi
	movl	%edi, -12(%rbp)
	movslq	-8(%rbp), %rcx
	imulq	$40, %rcx, %rcx
	addq	%rcx, %rax
	movslq	-12(%rbp), %rcx
	movb	$64, (%rax,%rcx)
	movl	$1, -16(%rbp)
LBB6_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB6_4
## BB#2:                                ##   in Loop: Header=BB6_1 Depth=1
	movq	_grid@GOTPCREL(%rip), %rax
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movq	_wormRow@GOTPCREL(%rip), %rdx
	movslq	-16(%rbp), %rsi
	movl	(%rdx,%rsi,4), %edi
	movl	%edi, -8(%rbp)
	movslq	-16(%rbp), %rdx
	movl	(%rcx,%rdx,4), %edi
	movl	%edi, -12(%rbp)
	movslq	-8(%rbp), %rcx
	imulq	$40, %rcx, %rcx
	addq	%rcx, %rax
	movslq	-12(%rbp), %rcx
	movb	$111, (%rax,%rcx)
## BB#3:                                ##   in Loop: Header=BB6_1 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	LBB6_1
LBB6_4:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_drawGrid
	.p2align	4, 0x90
_drawGrid:                              ## @drawGrid
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi21:
	.cfi_def_cfa_offset 16
Lcfi22:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi23:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
LBB7_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB7_3 Depth 2
	cmpl	$20, -4(%rbp)
	jge	LBB7_8
## BB#2:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	$0, -8(%rbp)
LBB7_3:                                 ##   Parent Loop BB7_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$40, -8(%rbp)
	jge	LBB7_6
## BB#4:                                ##   in Loop: Header=BB7_3 Depth=2
	leaq	L_.str.6(%rip), %rdi
	movq	_grid@GOTPCREL(%rip), %rax
	movslq	-4(%rbp), %rcx
	imulq	$40, %rcx, %rcx
	addq	%rcx, %rax
	movslq	-8(%rbp), %rcx
	movsbl	(%rax,%rcx), %esi
	movb	$0, %al
	callq	_printf
	movl	%eax, -12(%rbp)         ## 4-byte Spill
## BB#5:                                ##   in Loop: Header=BB7_3 Depth=2
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	LBB7_3
LBB7_6:                                 ##   in Loop: Header=BB7_1 Depth=1
	leaq	L_.str.7(%rip), %rdi
	movb	$0, %al
	callq	_printf
	movl	%eax, -16(%rbp)         ## 4-byte Spill
## BB#7:                                ##   in Loop: Header=BB7_1 Depth=1
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	LBB7_1
LBB7_8:
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_moveWorm
	.p2align	4, 0x90
_moveWorm:                              ## @moveWorm
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi24:
	.cfi_def_cfa_offset 16
Lcfi25:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi26:
	.cfi_def_cfa_register %rbp
	subq	$128, %rsp
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	%edi, -88(%rbp)
	movl	$0, -96(%rbp)
	movl	$-1, -108(%rbp)
LBB8_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB8_3 Depth 2
	cmpl	$1, -108(%rbp)
	jg	LBB8_11
## BB#2:                                ##   in Loop: Header=BB8_1 Depth=1
	movl	$-1, -112(%rbp)
LBB8_3:                                 ##   Parent Loop BB8_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$1, -112(%rbp)
	jg	LBB8_9
## BB#4:                                ##   in Loop: Header=BB8_3 Depth=2
	movq	_wormRow@GOTPCREL(%rip), %rax
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movl	(%rcx), %edx
	addl	-108(%rbp), %edx
	movl	%edx, -104(%rbp)
	movl	(%rax), %edx
	addl	-112(%rbp), %edx
	movl	%edx, -100(%rbp)
	movl	-104(%rbp), %edi
	movl	-100(%rbp), %esi
	callq	_onGrid
	cmpl	$0, %eax
	je	LBB8_7
## BB#5:                                ##   in Loop: Header=BB8_3 Depth=2
	movl	-104(%rbp), %edi
	movl	-100(%rbp), %esi
	movl	-88(%rbp), %edx
	callq	_overlaps
	cmpl	$0, %eax
	jne	LBB8_7
## BB#6:                                ##   in Loop: Header=BB8_3 Depth=2
	movl	-104(%rbp), %eax
	movslq	-96(%rbp), %rcx
	movl	%eax, -80(%rbp,%rcx,4)
	movl	-100(%rbp), %eax
	movslq	-96(%rbp), %rcx
	movl	%eax, -48(%rbp,%rcx,4)
	movl	-96(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -96(%rbp)
LBB8_7:                                 ##   in Loop: Header=BB8_3 Depth=2
	jmp	LBB8_8
LBB8_8:                                 ##   in Loop: Header=BB8_3 Depth=2
	movl	-112(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -112(%rbp)
	jmp	LBB8_3
LBB8_9:                                 ##   in Loop: Header=BB8_1 Depth=1
	jmp	LBB8_10
LBB8_10:                                ##   in Loop: Header=BB8_1 Depth=1
	movl	-108(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -108(%rbp)
	jmp	LBB8_1
LBB8_11:
	cmpl	$0, -96(%rbp)
	jne	LBB8_13
## BB#12:
	movl	$0, -84(%rbp)
	jmp	LBB8_18
LBB8_13:
	movl	-88(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -116(%rbp)
LBB8_14:                                ## =>This Inner Loop Header: Depth=1
	cmpl	$0, -116(%rbp)
	jle	LBB8_17
## BB#15:                               ##   in Loop: Header=BB8_14 Depth=1
	movq	_wormCol@GOTPCREL(%rip), %rax
	movq	_wormRow@GOTPCREL(%rip), %rcx
	movl	-116(%rbp), %edx
	subl	$1, %edx
	movslq	%edx, %rsi
	movl	(%rcx,%rsi,4), %edx
	movslq	-116(%rbp), %rsi
	movl	%edx, (%rcx,%rsi,4)
	movl	-116(%rbp), %edx
	subl	$1, %edx
	movslq	%edx, %rcx
	movl	(%rax,%rcx,4), %edx
	movslq	-116(%rbp), %rcx
	movl	%edx, (%rax,%rcx,4)
## BB#16:                               ##   in Loop: Header=BB8_14 Depth=1
	movl	-116(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -116(%rbp)
	jmp	LBB8_14
LBB8_17:
	movl	-96(%rbp), %edi
	callq	_randValue
	movq	_wormCol@GOTPCREL(%rip), %rcx
	movq	_wormRow@GOTPCREL(%rip), %rdx
	movl	%eax, -92(%rbp)
	movslq	-92(%rbp), %rsi
	movl	-48(%rbp,%rsi,4), %eax
	movl	%eax, (%rdx)
	movslq	-92(%rbp), %rdx
	movl	-80(%rbp,%rdx,4), %eax
	movl	%eax, (%rcx)
	movl	$1, -84(%rbp)
LBB8_18:
	movl	-84(%rbp), %eax
	movq	___stack_chk_guard@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	movq	-8(%rbp), %rdx
	cmpq	%rdx, %rcx
	movl	%eax, -120(%rbp)        ## 4-byte Spill
	jne	LBB8_20
## BB#19:
	movl	-120(%rbp), %eax        ## 4-byte Reload
	addq	$128, %rsp
	popq	%rbp
	retq
LBB8_20:
	callq	___stack_chk_fail
	.cfi_endproc

	.globl	_delay
	.p2align	4, 0x90
_delay:                                 ## @delay
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi27:
	.cfi_def_cfa_offset 16
Lcfi28:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi29:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	$3, -8(%rbp)
	movl	$0, -12(%rbp)
LBB9_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB9_3 Depth 2
                                        ##       Child Loop BB9_5 Depth 3
	movl	-12(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB9_12
## BB#2:                                ##   in Loop: Header=BB9_1 Depth=1
	movl	$0, -16(%rbp)
LBB9_3:                                 ##   Parent Loop BB9_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB9_5 Depth 3
	cmpl	$40000, -16(%rbp)       ## imm = 0x9C40
	jge	LBB9_10
## BB#4:                                ##   in Loop: Header=BB9_3 Depth=2
	movl	$0, -20(%rbp)
LBB9_5:                                 ##   Parent Loop BB9_1 Depth=1
                                        ##     Parent Loop BB9_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	cmpl	$1000, -20(%rbp)        ## imm = 0x3E8
	jge	LBB9_8
## BB#6:                                ##   in Loop: Header=BB9_5 Depth=3
	imull	$3, -8(%rbp), %eax
	movl	%eax, -8(%rbp)
## BB#7:                                ##   in Loop: Header=BB9_5 Depth=3
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	LBB9_5
LBB9_8:                                 ##   in Loop: Header=BB9_3 Depth=2
	jmp	LBB9_9
LBB9_9:                                 ##   in Loop: Header=BB9_3 Depth=2
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	LBB9_3
LBB9_10:                                ##   in Loop: Header=BB9_1 Depth=1
	jmp	LBB9_11
LBB9_11:                                ##   in Loop: Header=BB9_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	LBB9_1
LBB9_12:
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_onGrid
	.p2align	4, 0x90
_onGrid:                                ## @onGrid
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi30:
	.cfi_def_cfa_offset 16
Lcfi31:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi32:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	movb	%al, %cl
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$0, -4(%rbp)
	movb	%cl, -9(%rbp)           ## 1-byte Spill
	jl	LBB10_4
## BB#1:
	xorl	%eax, %eax
	movb	%al, %cl
	cmpl	$40, -4(%rbp)
	movb	%cl, -9(%rbp)           ## 1-byte Spill
	jge	LBB10_4
## BB#2:
	xorl	%eax, %eax
	movb	%al, %cl
	cmpl	$0, -8(%rbp)
	movb	%cl, -9(%rbp)           ## 1-byte Spill
	jl	LBB10_4
## BB#3:
	cmpl	$20, -8(%rbp)
	setl	%al
	movb	%al, -9(%rbp)           ## 1-byte Spill
LBB10_4:
	movb	-9(%rbp), %al           ## 1-byte Reload
	andb	$1, %al
	movzbl	%al, %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_overlaps
	.p2align	4, 0x90
_overlaps:                              ## @overlaps
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi33:
	.cfi_def_cfa_offset 16
Lcfi34:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi35:
	.cfi_def_cfa_register %rbp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	$0, -20(%rbp)
LBB11_1:                                ## =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	LBB11_7
## BB#2:                                ##   in Loop: Header=BB11_1 Depth=1
	movq	_wormCol@GOTPCREL(%rip), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	cmpl	-8(%rbp), %edx
	jne	LBB11_5
## BB#3:                                ##   in Loop: Header=BB11_1 Depth=1
	movq	_wormRow@GOTPCREL(%rip), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	cmpl	-12(%rbp), %edx
	jne	LBB11_5
## BB#4:
	movl	$1, -4(%rbp)
	jmp	LBB11_8
LBB11_5:                                ##   in Loop: Header=BB11_1 Depth=1
	jmp	LBB11_6
LBB11_6:                                ##   in Loop: Header=BB11_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	LBB11_1
LBB11_7:
	movl	$0, -4(%rbp)
LBB11_8:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_randValue
	.p2align	4, 0x90
_randValue:                             ## @randValue
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi36:
	.cfi_def_cfa_offset 16
Lcfi37:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi38:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	imull	$1103515245, _randSeed(%rip), %edi ## imm = 0x41C64E6D
	addl	$12345, %edi            ## imm = 0x3039
	andl	$2147483647, %edi       ## imm = 0x7FFFFFFF
	movl	%edi, _randSeed(%rip)
	movl	_randSeed(%rip), %eax
	cltd
	idivl	-4(%rbp)
	movl	%edx, %eax
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Invalid Length (4..20)"

L_.str.1:                               ## @.str.1
	.asciz	"Invalid # Moves (0..99)"

L_.str.2:                               ## @.str.2
	.asciz	"Invalid Rand Seed (0..Big)"

L_.str.3:                               ## @.str.3
	.asciz	"\033[H\033[2J"

L_.str.4:                               ## @.str.4
	.asciz	"Iteration %d\n"

L_.str.5:                               ## @.str.5
	.asciz	"Blocked!\n"

	.comm	_grid,800,4             ## @grid
L_.str.6:                               ## @.str.6
	.asciz	"%c"

L_.str.7:                               ## @.str.7
	.asciz	"\n"

	.comm	_wormCol,160,4          ## @wormCol
	.comm	_wormRow,160,4          ## @wormRow
L_.str.8:                               ## @.str.8
	.asciz	"%s\n"

L_.str.9:                               ## @.str.9
	.asciz	"Usage: %s Length #Moves Seed\n"

	.globl	_randSeed               ## @randSeed
.zerofill __DATA,__common,_randSeed,4,2

.subsections_via_symbols
