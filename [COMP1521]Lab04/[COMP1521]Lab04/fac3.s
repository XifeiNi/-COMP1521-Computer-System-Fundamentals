# COMP1521 18s2 Week 04 Lab
# Compute factorials, recursive function


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
# Registers used:
# $a0 - initially n.
# $t0 - parameter n.
# $t1 - fib (n - 1).
# $t2 - fib (n - 2).
   # set up stack frame
   sw    $fp, -4($sp)       # push $fp onto stack
   la    $fp, -4($sp)       # set up $fp foqwqw sa vr this function
   sw    $ra, -4($fp)       # save return address
   sw    $t0, -8($fp)       # save $t0 to use as ... int n;
   sw    $t1, -12($fp)      # recursively fac(n-1)
   sw    $t2, -16($fp)      # recursively store n
   addi  $sp, $sp, -20      # reset $sp to last pushed item
## ... get n from caller ...
   move  $t0, $a0
   # code for fac()
   ble   $t0, 1, base      # if n <= 1, return 1

   move  $t2, $t0          # preseve n
   sub   $a0, $t0, 1
   jal   fac
   move  $t1, $v0

   mul   $v0, $t2, $t1
   b     fac_return

## base case goes here
base:
   li    $v0, 1
## ... code for fac() goes here ...

   # clean up stack frame
fac_return:
   lw    $t2, -16($fp)      # restore $s0 value
   lw    $t1, -12($fp)      # restore $t1 value
   lw    $t0, -8($fp)       # restore $t0 value
   lw    $ra, -4($fp)       # restore $ra for return
   la    $sp, 4($fp)        # restore $sp (remove stack frame)
   lw    $fp, ($fp)         # restore $fp (remove stack frame)
   jr    $ra                # return

## ... code for epilogue goes here ...
