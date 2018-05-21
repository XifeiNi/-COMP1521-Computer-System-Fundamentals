// COMP1521 18s1 Assignment 2
// Implementation of heap management system

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "myHeap.h"

// minimum total space for heap
#define MIN_HEAP  4096
// minimum amount of space for a free Chunk (excludes Header)
#define MIN_CHUNK 32

#define ALLOC     0x55555555
#define FREE      0xAAAAAAAA

typedef unsigned int uint;   // counters, bit-strings, ...

typedef void *Addr;          // addresses

typedef struct {             // headers for Chunks
   uint  status;             // status (ALLOC or FREE)
   uint  size;               // #bytes, including header
} Header;

static Addr  heapMem;        // space allocated for Heap
static int   heapSize;       // number of bytes in heapMem
static Addr *freeList;       // array of pointers to free chunks
static int   freeElems;      // number of elements in freeList[]
static int   nFree;          // number of free chunks
static void mergeTwoAddress(void *b1, void *b2);

// helper functions go here
static Addr smallestFreeChunk(int size);
static int roundUp(int size);
static int rounduptofour(int size);
// static void *newAlloc(Addr base, int size);
static int bs(Addr key, int low, int high, Addr freeList[]);
static void deleteSorted(Addr key);
static void insertSorted(Addr key);
static void mergeAdjacent(void);
// initialise heap
int initHeap(int size)
{
   // allocates (using malloc()) a region of memory of size N bytes.
   Header *chunk = calloc(roundUp(size), sizeof(*chunk));
   if (chunk == NULL) { // error msg
      fprintf(stderr, "Fatal: failed to allocate %d bytes.\n", roundUp(size));
      exit(-1);
   }
   // sets the private variable heapMem to point
   // to the first byte of the calloc'd region,
   heapMem = chunk;
   heapSize = roundUp(size);
   // number of bytes in heapMem is size
   chunk->size = roundUp(size);
   chunk->status = FREE;
   // allocates a freeList array, of size N/MIN_CHUNK,
   size_t arraySiz = roundUp(size)/MIN_CHUNK;
   freeList = malloc(arraySiz*sizeof(int));
   if(freeList == NULL) {
      fprintf(stderr, "Fatal: failed to allocate %zu bytes.\n", arraySiz);
      exit(-1);
   }
   // sets the first item in this array to
   // the single free-space chunk.
   freeList[0] = chunk;
   nFree = 1;
   freeElems = (int)arraySiz;
   return 0;
}
static void insertSorted(Addr key) {
   int i;
   for (i = nFree -1; (i >= 0 && freeList[i] > key); i--)
      freeList[i+1] = freeList[i];
   freeList[i+1] = key;
   // increment elements in free list
   nFree++;
}

static void deleteSorted(Addr key) {
   // find the position of element to be deleted
   int pos = bs(key, 0, nFree, freeList);
   if(pos == -1){
      printf("element not found\n");
      return;
   }
   // Deleting Elements
   int i;
   for (i = pos; i < nFree - 1; i++){
      freeList[i] = freeList[i+1];
   }
   nFree--;
}
// do a binary search, and return index.
static int bs(Addr key, int low, int high, Addr freeList[]){
   if(high < low)
      return -1;
   int mid = (low + high)/2;
   if(key == freeList[mid])
      return mid;
   if (key > freeList[mid])
      return bs(key, mid+1,high, freeList);
   return bs(key, low, mid-1, freeList);
}
static int roundUp(int size) {
   // If N is less than the minimum heap size (4096),
   // then N is set to the minimum heap size.
   if (size < MIN_HEAP) {
      return MIN_HEAP;
   }
   int reminder = size%4;
   if(reminder == 0) return size;
   // size should be rounded up to the nearest multiple of 4
   return size + 4 - size%4;
}
// clean heap
void freeHeap()
{
   free(heapMem);
   free(freeList);
}
static int rounduptofour(int size) {
   int remainder = size%4;
   if (remainder == 0) return size;
   return size + 4 - remainder;
}
// allocate a chunk of memory
void *myMalloc(int size)
{
   if(size < 1)
      return NULL;
  // size += sizeof(Header);
   Header *alloc = smallestFreeChunk(rounduptofour(size));
   uint uppersize = alloc->size;
   Header *p = (Header*)alloc;
  // p = p + sizeof(Header);
   
   if(uppersize < rounduptofour(size) + MIN_CHUNK) {
      p->status = ALLOC;
      p->size = rounduptofour(size);
      deleteSorted(p);
     
   } else {
      if (p->status == FREE) {
         deleteSorted(p);
      }
      p->status = ALLOC;
      p->size = rounduptofour(size)+sizeof(Header);
      // upper chunk is a new free chunk
     Addr newFree = (Addr)alloc + p->size;
      Header *chunk = (Header*)newFree;
      chunk->status = FREE;
      chunk->size = uppersize - p->size;
      insertSorted(chunk);
      //newFree(p + sizeof(Header), alloc->size - sizeof(Header) - p->size);
   }
   alloc++;
   return alloc;
}
// find the smallest free chunk that is larger
// than N+ HeaderSize
static Addr smallestFreeChunk(int size){
   Addr curr = freeList[0];
   Header *chunk = (Header *)curr;
   Addr endHeap = (Addr)((char*)heapMem + heapSize);
   uint smallest = chunk->size;
   Addr returnAddr = chunk;
   while (curr < endHeap) {
      chunk = (Header *)curr;
      if (chunk->status == FREE && chunk->size > size + sizeof(*chunk)) {
         if (chunk->size <= smallest) {
            // update smallest
            smallest = chunk->size;
            returnAddr = chunk;
         }
      }
      curr = (Addr)((char *)curr + chunk->size);
   }
   
   return chunk;
}
// free a chunk of memory
void myFree(void *block)
{
   Header*chunk = (Header*)block;
   chunk--;
   // or if the argument is an address somewhere in the middle of an allocated block
   if(chunk->status != ALLOC){
      fprintf(stderr, "Attempt to free unallocated chunk\n");
      exit(1);
   }
   chunk->status = FREE;
   insertSorted(chunk);
   mergeAdjacent();
}
static void mergeAdjacent(){
   Addr curr = freeList[0];
   Header *chunk = (Header *)curr;
   for (int i = 0; i < nFree; i++) {
      chunk = (Header*)curr;
      while ((Addr)((char*)chunk + chunk->size) == freeList[i+1]){
         mergeTwoAddress(freeList[i], freeList[i+1]);
         deleteSorted(freeList[i+1]);
      }
      curr = freeList[i++];
   }
   
}
// merge two thingy
static void mergeTwoAddress(void *b1, void *b2) {
   Header *m1 = (Header *)b1;
   Header *m2 = (Header *)b2;
   m1->size += m2->size;
}
// convert pointer to offset in heapMem
int  heapOffset(void *p)
{
   Addr heapTop = (Addr)((char *)heapMem + heapSize);
   if (p == NULL || p < heapMem || p >= heapTop)
      return -1;
   else
      return (int)(p - heapMem);
}

// dump contents of heap (for testing/debugging)
void dumpHeap()
{
   Addr    curr;
   Header *chunk;
   Addr    endHeap = (Addr)((char *)heapMem + heapSize);
   int     onRow = 0;
   
   curr = heapMem;
   while (curr < endHeap) {
      char stat;
      chunk = (Header *)curr;
      switch (chunk->status) {
         case FREE:  stat = 'F'; break;
         case ALLOC: stat = 'A'; break;
         default:    fprintf(stderr,"Corrupted heap %08x\n",chunk->status); exit(1); break;
      }
      printf("+%05d (%c,%5d) ", heapOffset(curr), stat, chunk->size);
      onRow++;
      if (onRow%5 == 0) printf("\n");
      curr = (Addr)((char *)curr + chunk->size);
   }
   if (onRow > 0) printf("\n");
}

