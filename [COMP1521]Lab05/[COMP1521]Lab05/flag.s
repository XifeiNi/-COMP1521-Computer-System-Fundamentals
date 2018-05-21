	.data
nrows:	 .word 6
ncols:	 .word 12
flag:	 .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	 .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	 .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	 .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	 .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	 .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'


	.text
flagfunc:
	lw  $s2,nrows	#s2 is nrows
	lw  $s3,ncols	#s3 is ncols
	li  $s0,0 	# row = 0
rloop:
	beq $s2,$s0,end_rloop
	li  $s1,0	# col = 0
cloop:
	beq $s1,$s3,end_cloop
	mul $t0,$s0,$s3	# row * ncols
	add $t0,$t0,$s1 # convert [row][col] to byte offset
	lb  $a0,flag($t0)
	li  $v0,11	#printf(%c)
	syscall
	addi $s1,$s1,1	#col++
	j    cloop
end_cloop:
	li   $a0,'\n'
	li   $v0,11	# printf("\n")
	syscall
	addi #s0,$s0,1	# row++
	j    rloop
end_rloop:
	