# COMP1521 18s1 Assignment 2

CC = gcc
CFLAGS = -Wall -Werror -std=c99 -g
BINS = test1 test2 test3

all : $(BINS)

test1 : test1.o myHeap.o
test2 : test2.o myHeap.o
test3 : test3.o myHeap.o

clean :
	rm -f $(BINS) *.o core
