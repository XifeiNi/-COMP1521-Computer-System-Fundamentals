// COMP1521 18s1 Assignment 2
// myHeap test: init Heap and dump

#include <stdio.h>
#include <stdlib.h>
#include "myHeap.h"

int main(int argc, char *argv[])
{
   if (argc < 2) {
      printf("Usage: %s Size\n", argv[0]);
      exit(1);
   }
   if (initHeap(atoi(argv[1])) < 0) {
      printf("Can't init heap of size %d\n", atoi(argv[1]));
      exit(1);
   }
   dumpHeap();
   return 0;
}
