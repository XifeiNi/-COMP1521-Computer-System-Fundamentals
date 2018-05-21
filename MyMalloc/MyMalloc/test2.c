// COMP1521 18s1 Assignment 2
// myHeap test: sorted list implementation

#include <stdio.h>
#include <stdlib.h>
#include "myHeap.h"

typedef struct _node {
   int data;
   struct _node *next;
} Node;

typedef Node *List;

List insert(List, int);
void showList(List);
void freeList(List);

int main(int argc, char *argv[])
{
   initHeap(10000);
   List list = NULL;
   for (int i = 0; i < 100; i++) {
      list = insert(list, rand()%100);
      printf("L = ");
      showList(list);
      dumpHeap();
   }
   freeList(list);
   printf("After freeList ...\n");
   dumpHeap();
   freeHeap();
   return 0;
}

List insert(List L, int n)
{
   Node *new = myMalloc(sizeof(Node));
   new->data = n;
   Node *prev = NULL;
   Node *curr = L;
   while (curr != NULL) {
      if (n < curr->data) break;
      prev = curr;
      curr = curr->next;
   }
   if (prev == NULL)  { // new front
      new->next = curr;
      return new;
   }
   else {  // insert in middle
      new->next = prev->next;
      prev->next = new;
      return L;
   }
}

void showList(List L)
{
   while (L != NULL) {
      printf("%d", L->data);
      if (L->next != NULL) printf("->");
      L = L->next;
   }
   printf("\n");
}

void freeList(List L)
{
   if (L != NULL) {
      freeList(L->next);
      myFree(L);
   }
}

