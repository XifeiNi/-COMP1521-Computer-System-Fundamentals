// make_a_float ... read in bit strings to build a float value
// COMP1521 Lab03 exercises
// Written by John Shepherd, August 2017
// Completed by ...

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <math.h>
typedef uint32_t Word;

struct _float {
   // define bit_fields for sign, exp and frac
   // obviously they need to be larger than 1-bit each
   // and may need to be defined in a different order
   unsigned int frac:23, exp:8, sign:1;
};
typedef struct _float Float32;

union _bits32 {
   float   fval;  // interpret the bits as a float
   Word    xval;  // interpret as a single 32-bit word
   Float32 bits;  // manipulate individual bits
};
typedef union _bits32 Union32;

void    checkArgs(int, char **);
Union32 getBits(char *, char *, char *);
char   *showBits(Word, char *);
int     justBits(char *, int);
//static int isNegative(char *sign);
void getExpBitField(Union32 *new, char *s);
void getFracBitField(Union32 *new, char *s);
int main(int argc, char **argv)
{
   union _bits32 u;
   char out[50];

   // here's a hint ...
   u.bits.sign = u.bits.exp = u.bits.frac = 0;

   // check command-line args (all strings of 0/1
   // kills program if args are bad
   checkArgs(argc, argv);

   // convert command-line args into components of
   // a Float32 inside a Union32, and return the union
   u = getBits(argv[1], argv[2], argv[3]);

   printf("bits : %s\n", showBits(u.xval,out));
   printf("float: %0.10f\n", u.fval);

   return 0;
}

// convert three bit-strings (already checked)
// into the components of a struct _float
Union32 getBits(char *sign, char *exp, char *frac)
{
   Union32 new;

   // this line is just to keep gcc happy
   // delete it when you have implemented the function
   // convert char *sign into a single bit in new.bits
    //unsigned int con_sign = sign[0];
    /*a dogdy alterative solution but it works
    new.bits.sign = sign[0] - '0';
   // convert char *exp into an 8-bit value in new.bits
    double con_exp = 0;
    for(int i = 0; i < 8; i++) {
        con_exp = con_exp + (exp[i] - '0')*pow(2,7-i);
    }
    int power = con_exp - 127;
    con_exp = pow(2, power);
    new.bits.exp = con_exp;
   // convert char *frac into a 23-bit value in new.bits
    float con_frac = 0.0;
    int index = 0;
    for(int i = -1; i >= -23; i--) {
        con_frac += ldexpf(frac[index] - '0', i);
        index++;
    }
    
    con_frac++;
    new.bits.frac = (float)con_frac;
    new.fval = isNegative(sign)*(con_frac)*(con_exp);
    if (fabsf(new.fval) < 0.00000000001) {
        new.xval = new.xval - 1;
    }*/
    
    new.bits.sign = sign[0] - '0';
    getExpBitField(&new, exp);
    getFracBitField(&new, frac);
    printf("exp1: %u\n",new.bits.exp);
    // printf("exp2: %u\n",getBitField(exp));
   return new;
}
void getExpBitField(Union32 *new, char *s) {
    unsigned int res = 0;
    res &= ~(0xff << 24); // blank it
    
    for (int i = 0;i < (int)strlen(s); i++) {
        res <<= 1;
        if (s[i] == '1') res^=1;
    }
    printf("u: %u\n",res);
    new->bits.exp = res;
    printf("this bitch better work: %u\n",new->bits.exp);
}
void getFracBitField(Union32 *new, char *s) {
    uint32_t res = 0;
    res &= ~(0xff << 24); // blank it
    
    for (int i = 0;i < (int)strlen(s); i++) {
        res <<= 1;
        if (s[i] == '1') res^=1;
    }
    new->bits.frac = res;
}
/*
static int isNegative(char *sign) {
    if(sign[0] - '0' == 1) {
        return -1;
    } else {
        return 1;
    }
}*/
// convert a 32-bit bit-stringin val into a sequence
// of '0' and '1' characters in an array buf
// assume that buf has size > 32
// return a pointer to buf
char *showBits(Word val, char *buf)
{
   // this line is just to keep gcc happy
   // delete it when you have implemented the function
    buf = malloc(35*sizeof(char));
    for(int i = 33; i >= 11; i--) {
        buf[i] = (val&1) + '0';
        val >>=1;
    }
    buf[10] = ' ';
    for(int i = 9; i >= 2; i--) {
        buf[i] = (val&1) + '0';
        val >>=1;
    }
    buf[1] = ' ';
    
    buf[0] = (val&1) + '0';
    
    // close off the array
    buf[34] = '\0';
    
    return buf;
}

// checks command-line args
// need at least 3, and all must be strings of 0/1
// never returns if it finds a problem
void checkArgs(int argc, char **argv)
{
   if (argc < 3) {
      printf("Usage: %s Sign Exp Frac\n", argv[0]);
      exit(1);
   }
   if (!justBits(argv[1],1)) {
      printf("%s: invalid Sign: %s\n", argv[0], argv[1]);
      exit(1);
   }
   if (!justBits(argv[2],8)) {
      printf("%s: invalid Exp: %s\n", argv[0], argv[2]);
      exit(1);
   }
   if (!justBits(argv[3],23)) {
      printf("%s: invalid Frac: %s\n", argv[0], argv[3]);
      exit(1);
   }
   return;
}

// check whether a string is all 0/1 and of a given length
int justBits(char *str, int len)
{
   if (strlen(str) != len) return 0;

   while (*str != '\0') {
      if (*str != '0' && *str != '1') return 0;
      str++;
   }
   return 1;
}
