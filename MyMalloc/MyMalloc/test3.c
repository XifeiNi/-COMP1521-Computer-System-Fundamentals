// COMP1521 18s1 Assignment 2
// myHeap test: read malloc/free ops and do them

#include <stdio.h>
#include <stdlib.h>
#include "myHeap.h"

#define MAXLINE 100

void dumpVars();

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

   // array of 26 pointer variables
   void *vars[26];
   for (int i = 0; i < 26; i++) vars[i] = NULL;

   // read malloc/free commands and carry them out
   char line[MAXLINE];  char var;  int size;
   while (fgets(line, MAXLINE, stdin) != NULL) {
      if (sscanf(line, "%c = malloc %d\n", &var, &size) == 2) {
         if ('a' <= var && var <= 'z')
            vars[var-'a'] = myMalloc(size);
         else
            printf("Invalid variable %c\n", var);
      }
      else if (sscanf(line, "free %c", &var) == 1) {
         if ('a' <= var && var <= 'z') {
            myFree(vars[var-'a']);
            vars[var-'a'] = NULL;
         }
         else
            printf("Invalid variable %c\n", var);
      }
      else {
         printf("Bad command: %s\n", line);
      }
      dumpVars(vars);
      dumpHeap();
   }
   dumpHeap();
   return 0;
}

// prints allocated variables
// may be helpful for debugging
void dumpVars(void **vars)
{
   int onRow = 0;
   for (int i = 0; i < 26; i++) {
      if (vars[i] == NULL) continue;
      printf("[%c] +%05d ", 'a'+i, heapOffset(vars[i]));
      onRow++;
      if (onRow == 5) {
         printf("\n");
         onRow = 0;
      }
   }
   if (onRow != 0) printf("\n");
}
