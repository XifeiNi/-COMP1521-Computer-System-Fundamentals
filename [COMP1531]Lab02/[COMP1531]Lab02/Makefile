# COMP1521 18s1 Lab02 Makefile

CC=gcc
CFLAGS=-Wall -Werror -g

add : add.o BigNum.o
	$(CC) -o add add.o BigNum.o

add.o : add.c BigNum.h
BigNum.o : BigNum.c BigNum.h

bits : bits.c

clean :
	rm -f core bits add add.o BigNum.o

