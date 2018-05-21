# Makefile for COMP1521 Practice Prac Exam

CC=gcc
CFLAGS=-std=c99 -Wall -Werror -g

stu : stu.o Students.o

stu.o : stu.c Students.h
Students.o : Students.c Students.h

clean :
rm -f stu stu.o Students.o
