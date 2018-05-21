// COMP1521 18s1 Week 02 Lab
// Add two numbers (numbers can be LARGE)

#include <stdio.h>
#include "BigNum.h"
#include <ctype.h>
#include <stdlib.h>
int main(int argc, char **argv)
{
    BigNum num1;  // first input number
    BigNum num2;  // second input number
    BigNum mul;   // num1 * num2
    if (argc < 3) {
        printf("Usage: %s Num1 Num2\n", argv[0]);
        return 1;
    }
    
    // Initialise BigNum objects
    initBigNum(&num1, 20);
    initBigNum(&num2, 20);
    initBigNum(&mul,  20);
    // Extract values from cmd line args
    if (!scanBigNum(argv[1], &num1)) {
        printf("First number invalid\n");
        return 1;
    }
    if (!scanBigNum(argv[2], &num2)) {
        printf("Second number invalid\n");
        return 1;
    }
    
    multiplyBigNums(num1, num2, &mul);
    printf("Multiplying  \t"); showBigNum(num1);
    printf("\nand\t\t"); showBigNum(num2);
    printf("\nis\t\t"); showBigNum(mul);
    printf("\n");
    free(mul.bytes);
    free(num1.bytes);
    free(num2.bytes);
    return 0;
    
}


