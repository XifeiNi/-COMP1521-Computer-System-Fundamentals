# COMP1521 18s2 Week 04 Lab
# Compute factorials, iterative function


### Global data

   .data
eol:
.asciiz "\n"
msg1:
   .asciiz "n  = "
msg2:
   .asciiz "n! = "


### main() function
   .text
   .globl main
main:
   #  set up stack frame
   sw    $fp, -4($sp)       # push $fp onto stack
   la    $fp, -4($sp)       # set up $fp for this function
   sw    $ra, -4($fp)       # save return address
   sw    $s0, -8($fp)       # save $s0 to use as ... int n;
   addi  $sp, $sp, -12      # reset $sp to last pushed item

   #  code for main()
   li    $s0, 0             # n = 0;
   
   la    $a0, msg1
   li    $v0, 4
   syscall                  # printf("n  = ");

## ... rest of code for main() goes here ...
   li    $v0, 5
   syscall
   move  $s0, $v0           # load scanf, n = user input

   la    $a0, msg2
   li    $v0, 4
   syscall                  # printf("n!  = ");

   move    $a0, $s0
   jal   fac

##  print the return result of fac function in main ...
   move    $a0, $v0
   li      $v0, 1
   syscall
 
   la    $a0, eol
   li    $v0, 4
   syscall                  # printf("\n");

   

   # clean up stack frame
   lw    $s0, -8($fp)       # restore $s0 value
   lw    $ra, -4($fp)       # restore $ra for return
   la    $sp, 4($fp)        # restore $sp (remove stack frame)
   lw    $fp, ($fp)          # restore $fp (remove stack frame)

   li    $v0, 0
   jr    $ra                # return 0

# fac() function

fac:
   # setup stack frame
   sw    $fp, -4($sp)       # push $fp onto stack
   la    $fp, -4($sp)       # set up $fp for this function
   sw    $ra, -4($fp)       # save return address
   sw    $t0, -8($fp)       # save $t0 to use as ... int n;
   sw    $t1, -12($fp)      # save $t1 to use as ... fac return
   sw    $s0, -16($fp)
   addi  $sp, $sp, -20      # reset $sp to last pushed item
## ... code for prologue goes here ...
# save s0 to a0
   move  $s0, $a0
   # code for fac()
   li    $t0, 1            # i = 1
   li    $t1, 1            # return fac value

main_for_loop:
   bgt   $t0,$s0,main_end_loop   # condition to end loop, 
   mul   $t1,$t1,$t0
   addi  $t0,$t0,1
   j     main_for_loop

main_end_loop:
   move  $v0, $t1

   # clean up stack frame
   lw    $s0, -16($fp)      # restore $s0 value
   lw    $t1, -12($fp)      # restore $t1 value
   lw    $t0, -8($fp)       # restore $t0 value
   lw    $ra, -4($fp)       # restore $ra for return
   la    $sp, 4($fp)        # restore $sp (remove stack frame)
   lw    $fp, ($fp)         # restore $fp (remove stack frame)
   jr    $ra                # return
## ... code for epilogue goes here ...
