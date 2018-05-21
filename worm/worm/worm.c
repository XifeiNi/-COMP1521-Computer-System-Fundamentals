// COMP1521 18s1 Ass1 ... C solution

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

// constants

#define NCOLS 40
#define NROWS 20
#define MAX_LEN NCOLS
#define MAX_ITER 100
#define CLEAR "\033[H\033[2J"

// globals

int  wormCol[MAX_LEN];   // (col,row) coords of worm segments
int  wormRow[MAX_LEN];   // to simplify translation to MIPS, use
                         // pair of parallel arrays for (col,row)

char grid[NROWS][NCOLS]; // the grid, including worm chars

// functions (forward refs)

void giveUp(char *, char *);
void clearGrid(void);
void drawGrid(void);
void initWorm(int, int, int);
int  moveWorm(int);
void addWormToGrid(int);

// utilities
int  intValue(char *);
void seedRand(int);
int  randValue(int);
void delay(int);

// main function

int main(int argc, char **argv)
{
	int  startCol;  // initial X-coord of head (X = column)
	int  startRow;  // initial Y-coord of head (Y = row)
	int  length;    // # segments in worm (incl head)
	int  ntimes;    // # iterations
    int  seed;      // seed for random # generator

	if (argc < 4) giveUp(argv[0],NULL);
	length = intValue(argv[1]);
	if (length < 4 || length >= MAX_LEN)
		giveUp(argv[0], "Invalid Length (4..20)");
	ntimes = intValue(argv[2]);
	if (ntimes < 0 || ntimes >= MAX_ITER)
		giveUp(argv[0], "Invalid # Moves (0..99)");
	seed = intValue(argv[3]);
	if (seed < 0)
		giveUp(argv[0], "Invalid Rand Seed (0..Big)");
	seedRand(seed);

	// start worm roughly in middle of grid
	startCol = NCOLS/2 - length/2;
	startRow = NROWS/2;
	initWorm(startCol,startRow,length);
	for (int i = 0; i <= ntimes; i++) {
		clearGrid();
		addWormToGrid(length);
		printf(CLEAR);
		printf("Iteration %d\n",i);
		drawGrid();
#if 0
		for (int j = 0; j < length; j++)
			printf("(%d,%d) ",wormCol[j],wormRow[j]);
		printf("\n");
#endif
		if (!moveWorm(length)) {
			printf("Blocked!\n");
			break;
		}
		delay(1);
	}
	exit(EXIT_SUCCESS);
}

//clearGrid() ... set all grid[][] elements to '.'
void clearGrid()
{
	for (int row = 0; row < NROWS; row++) {
		for (int col = 0; col < NCOLS; col++) {
			grid[row][col] = '.';
		}
	}
}

// drawGrid() ... display grid[][] matrix, row-by-row
void drawGrid()
{
	for (int row = 0; row < NROWS; row++) {
		for (int col = 0; col < NCOLS; col++) {
			printf("%c",grid[row][col]);
		}
		printf("\n");
	}
}

// initWorm(col,row,len) ... set the wormCol[] and wormRow[]
//    arrays for a worm with head at (row,col) and body segements
//    on the same row and heading to the right (higher col values)
void initWorm(int col, int row, int len)
{
	int nsegs;
	int newCol = col+1;

	wormCol[0] = col; wormRow[0] = row;
	for (nsegs = 1; nsegs < len; nsegs++) {
		if (newCol == NCOLS) break;
		wormCol[nsegs] = newCol++;
      
		wormRow[nsegs] = row;
      
	}
}

// ongrid(col,row) ... checks whether (row,col)
//    is a valid coordinate for the grid[][] matrix
int onGrid(int col, int row)
{
	return (col >= 0 && col < NCOLS && row >= 0 && row < NROWS);
}

// overlaps(r,c,len) ... checks whether (row,col) holds a body segment
int overlaps(int col, int row, int len)
{  
	for (int i = 0; i < len; i++) {
		// on top of an existing segment
		if (wormCol[i] == col && wormRow[i] == row)
			return 1;
	}
	return 0;
}

// moveWorm() ... work out new location for head
//         and then move body segments to follow
int moveWorm(int len)
{
   int i; // index
	int n; // counter
	int row, col; // prospective rows and cols
	int possibleRow[8]; // (col,row) coords of possible places for segments
	int possibleCol[8];

	n = 0;
	for (int dx = -1; dx <= 1; dx++) {
		for (int dy = -1; dy <= 1; dy++) {
			col = wormCol[0] + dx;
			row = wormRow[0] + dy;

			if (onGrid(col,row) &&!overlaps(col,row,len)) { //&& !overlaps(col,row,len)
				possibleCol[n] = col;
				possibleRow[n] = row;
				n++;
			}
		}
	}
	if (n == 0) return 0;
	for (int i = len-1; i > 0; i--) {
		wormRow[i] = wormRow[i-1];

		wormCol[i] = wormCol[i-1];

      
	}
	i = randValue(n);

	wormRow[0] = possibleRow[i];
	wormCol[0] = possibleCol[i];
	return 1;
}

// addWormTogrid(N) ... add N worm segments to grid[][] matrix
//    0'th segment is head, located at (wormRow[0],wormCol[0])
//    i'th segment located at (wormRow[i],wormCol[i]), for i > 0
void addWormToGrid(int len)
{
	int row, col;
	row = wormRow[0];
	col = wormCol[0];
	grid[row][col] = '@';
	for (int i = 1; i < len; i++) {
		row = wormRow[i];
		col = wormCol[i];
    	grid[row][col] = 'o';	
	}
}

// Utility functions

// print error message and exit
void giveUp(char *progName, char *errmsg)
{
	if (errmsg != NULL) printf("%s\n",errmsg);
	printf("Usage: %s Length #Moves Seed\n", progName);
	exit(EXIT_FAILURE);
}

// convert string of digits to integer
int intValue(char *str)
{
	char *s;
	int val = 0;
	for (s = str; *s != '\0'; s++) {
		if (*s == ' ') continue; // ignore spaces
		if (*s < '0' || *s > '9') return -1;
		val = val*10 + (*s-'0');
	}
	return val;
}

// waste some time
#if 0
void delay(int n)
{
	double x = 3.14;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < 40000; j++)
			for (int k = 0; k < 1000; k++)
				x = x + 1.0;
	}
}
#else
void delay(int n)
{
	int x = 3;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < 40000; j++)
			for (int k = 0; k < 1000; k++)
				x = x * 3;
	}
}
#endif

// random number generator

#define MAX_RAND ((1U << 31) - 1)
int randSeed = 0;

// initial seed for random # generator
void seedRand(int seed)
{
	randSeed = seed;
}

// generate random value in range 0..n-1
int randValue(int n)
{
	randSeed = (randSeed * 1103515245 + 12345) & RAND_MAX;
	return randSeed % n;
}
