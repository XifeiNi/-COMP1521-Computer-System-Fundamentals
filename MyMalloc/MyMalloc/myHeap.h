// COMP1521 18s1 Assignment 2
// Interface to heap management system

// initialise heap
int initHeap(int size);

// clean heap
void freeHeap();

// allocate a chunk of memory
void *myMalloc(int size);

// free a chunk of memory
void myFree(void *block);

// dump contents of heap (for testing/debugging)
void dumpHeap();

// convert pointer to offset in heapMem
int  heapOffset(void *);
