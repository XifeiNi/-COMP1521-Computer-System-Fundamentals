# COMP1521 18s2 Week 04 Lab
# Compute factorials, no functions


### Global data

.data
msg1:
.asciiz "n  = "
msg2:
.asciiz "n! = "
eol:
.asciiz "\n"

### main() function
.text
.globl main

main:
   # set up stack frame
   sw    $fp, -4($sp)       # push $fp onto stack
   la    $fp, -4($sp)       # set up $fp for this function
   sw    $ra, -4($fp)       # save return address
   sw    $s0, -8($fp)       # save $s0 to use as ... int n;
   sw    $s1, -12($fp)      # save $s1 to use as ... int i;
   sw    $s2, -16($fp)      # save $s2 to use as ... int fac;
   sw    $s3, -20($fp)      # save $t0 to use as the upper 32 bits from the product register
   sw    $s4, -24($fp)      # save $t1 to use as the lower 32 bits from the product register
   sw    $t2, -28($fp)      # for the damn printf function call
   sw    $t3, -32($fp)      # for the dame printf again
   addi  $sp, $sp, -28      # reset $sp to last pushed item

   # code for main()
   li    $s0, 0             # n = 0;

   la    $a0, msg1
   li    $v0, 4
   syscall                  # printf("n  = ");

   ## ... rest of code for main() goes here ...
   li    $v0, 5
   syscall
   move  $s0, $v0           # load scanf


   li    $s1, 1             # i = 1
   li    $s2, 1


## .. here goes our for loop
main_for_loop:
   bgt   $s1,$s0,main_end_loop   # condition to end loop
   multu  $s2,$s1
   mfhi  $s3               # load the upper 32 bits from the product register
   mflo  $s4               # load the lower 32 bits from the product register
   addi  $s1,$s1,1
   j     main_for_loop

main_end_loop:
   la    $a0, msg2
   li    $v0, 4
   syscall                  # printf("n!  = ");

   move  $t2, $s3
   jal   print_binary

   move  $t2, $s4
   jal   print_binary

   la    $a0, eol
   li    $v0, 4
   syscall                  # printf("\n");

   # clean up stack frame
   lw    $s2, -16($fp)      # restore $s2 value
   lw    $s1, -12($fp)      # restore $s1 value
   lw    $s0, -8($fp)       # restore $s0 value
   lw    $ra, -4($fp)       # restore $ra for return
   la    $sp, 4($fp)        # restore $sp (remove stack frame)
   lw    $fp, ($fp)         # restore $fp (remove stack frame)

   li    $v0, 0
   jr    $ra                # return 0

print_binary:
   li    $t3, 32
   li    $v0, 1
print_bit:
   subu $t3, $t3, 1
   srlv  $a0, $t2, $t3
   andi  $a0, $a0, 1
   syscall
   bgtz  $t3, print_bit
   jr    $ra

