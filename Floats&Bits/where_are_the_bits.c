// where_are_the_bits.c ... determine bit-field order
// COMP1521 Lab 03 Exercise
// Written by ...

#include <stdio.h>
#include <stdlib.h>

struct _bit_fields {
   unsigned int a : 4,
                b : 8,
                c : 20;
};
union _bit{
    unsigned int first;
    struct _bit_fields second;
};
int main(void)
{
    union _bit y;
    y.first = 1;
    
    printf("y.second.a: %x\n",y.second.a);
    printf("y.second.b: %x\n",y.second.b);
    printf("y.second.c: %x\n",y.second.c);
   
   return 0;
}
