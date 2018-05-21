// BigNum.h ... LARGE positive integer values

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include "BigNum.h"
static void reverse(BigNum *res);
static void reverseString(char *arr);
static int validNum(BigNum n);
static int whichNumIsBigger(BigNum n, BigNum m);
static BigNum multiplyOneDigit(BigNum n, Byte d, int numOfZero);
static BigNum copyRe(BigNum n);
// Initialise a BigNum to N bytes, all zero
void initBigNum(BigNum *n, int Nbytes)
{
    n->bytes = malloc((Nbytes+1)*sizeof(Byte));
    for(int i = 0; i < Nbytes; i++) {
        n->bytes[i] = 0;
    }
    n->nbytes = Nbytes;
    return;
}
void subtractBigNums(BigNum n, BigNum m, BigNum *res) {
    if(!whichNumIsBigger(n, m)){
        for(int i = 0; i < res->nbytes; i++) {
            res->bytes[i] = 0;
        }
        return;
    }\
    
    int relloc = (m.nbytes >= n.nbytes) ? m.nbytes : n.nbytes;
    res->bytes = (Byte*)realloc(res->bytes, relloc);
    res->nbytes = relloc;
    // assume n > m if m > n:
    if(whichNumIsBigger(n, m) == 2) {
        BigNum temp = n;
        n = m;
        m = temp;
       // return;
    }
    int carry = 0;
    int iter = n.nbytes - 1;
    int iter2 = m.nbytes - 1;
    while(iter != 0 && iter2 != 0) {
        if(carry == 0) {
            if(n.bytes[iter] < m.bytes[iter2]) {
                res->bytes[iter] = 10 + n.bytes[iter] - m.bytes[iter2];
                carry = 1;
            } else {
                res->bytes[iter] = n.bytes[iter] - m.bytes[iter2];
            }
        } else {
            if(n.bytes[iter] < m.bytes[iter2] + 1) {
                res->bytes[iter] = 9 + n.bytes[iter] - m.bytes[iter2];
                // carry = 1;
            } else {
                res->bytes[iter] = n.bytes[iter] - m.bytes[iter2] - 1;
                carry = 0;
            }
        }
        iter--;
        iter2--;
    }
    while(iter != 0) {
        if(carry == 0) {
            res->bytes[iter] = n.bytes[iter];
        } else {
            if(n.bytes[iter] <  1) {
                res->bytes[iter] = 9 + n.bytes[iter];
                // carry = 1;
            } else {
                res->bytes[iter] = n.bytes[iter] - 1;
                carry = 0;
            }
        }
        iter--;
    }
   
    return;
    
}
void multiplyBigNums(BigNum n, BigNum m, BigNum *res) {
    // realloc res in case of insufficient memory
    if(n.nbytes + m.nbytes > res->nbytes) {
        res->bytes = (Byte*)realloc(res->bytes, n.nbytes + m.nbytes);
        res->nbytes = n.nbytes + m.nbytes;
    }
    // set res all to zero
    for(int i = 0; i < res->nbytes; i++) {
        res->bytes[i] = 0;
    }
    for(int i = 1; i <= validNum(m); i++){
        BigNum mul = multiplyOneDigit(n, m.bytes[m.nbytes - i], i-1);
        BigNum copy = copyRe(*res);
        addBigNums(copy, mul, res);
        free(mul.bytes);
        free(copy.bytes);
    }
}

static BigNum copyRe(BigNum n) {
    BigNum res;
    initBigNum(&res, n.nbytes);
    for(int i = 0; i < n.nbytes; i++){
        res.bytes[i] = n.bytes[i];
    }
    return res;
}
// returned bigNum must be properly allocated, assuming caller calls free
// i know this will increase space complexity
// but i am not smart enough to handle a complex nested while loop
// XD
static BigNum multiplyOneDigit(BigNum n, Byte d, int numOfZero) {
    BigNum res;
    initBigNum(&res, n.nbytes+ 1 + numOfZero);
    int count = n.nbytes - 1;
    int start = res.nbytes - numOfZero - 1;
    int carry = 0;
    while(start) {
        res.bytes[start] = n.bytes[count]*d + carry;
        if(res.bytes[start] >= 10) {
            res.bytes[start] = (n.bytes[count]*d + carry)%10;
            carry = (n.bytes[count]*d + carry)/10;
        } else {
            carry = 0;
        }
        
        start--;
        count--;
        
    }
    return res;
}
// Add two BigNums and store result in a third BigNum
void addBigNums(BigNum n, BigNum m, BigNum *res)
{
    int carry = 0;
    int nbytes = n.nbytes - 1;
    int mbytes = m.nbytes - 1;
    int index = 0;
    int relloc = (m.nbytes >= n.nbytes) ? m.nbytes : n.nbytes;
    res->bytes = (Byte*)realloc(res->bytes, relloc + 1);
    res->nbytes = relloc + 1;
    for(int i = 0; i < res->nbytes; i++) {
        res->bytes[i] = 0;
    }
    while(nbytes != 0 && mbytes!= 0) {
        if (index > res->nbytes) {
            res->nbytes = index;
            res->bytes = (Byte*)realloc(res->bytes, index);
        }
        if(carry == 0) {
            res->bytes[index] = m.bytes[mbytes] + n.bytes[nbytes];
            if(res->bytes[index] >= 10) {
                res->bytes[index] = res->bytes[index]%10;
                carry = 1;
            }
        } else {
            res->bytes[index] = m.bytes[mbytes] + n.bytes[nbytes] + 1;
            carry = 0;
            if(res->bytes[index] >= 10) {
                res->bytes[index] = res->bytes[index]%10;
                carry = 1;
            }
        }
        
        nbytes--;
        mbytes--;
        index++;
    }
    if(carry == 1) {
        // printf("here\n");
        res->nbytes = index + 1;
        res->bytes = (Byte*)realloc(res->bytes, index +1);
        res->bytes[index] = 1;
    }
    if (nbytes == 0 && mbytes + 2 != 0) {
        while(nbytes == 0 && mbytes != 0) {
            if(carry == 0) {
                res->bytes[index] = m.bytes[mbytes];
                if(res->bytes[index] >= 10) {
                    res->bytes[index] = res->bytes[index]%10;
                    carry = 1;
                }
            } else {
                res->bytes[index] = m.bytes[mbytes] + 1;
                carry = 0;
                if(res->bytes[index] >= 10) {
                    res->bytes[index] = res->bytes[index]%10;
                    carry = 1;
                }
            }
            
            mbytes--;
            index++;
        }
    }
    if (nbytes != 0 && mbytes == 0) {
        while (nbytes + 2 > 0 && mbytes == 0){
            if(carry == 0) {
               // printf("1st if\n");
                res->bytes[index] = n.bytes[nbytes];
                if(res->bytes[index] >= 10) {
                    res->bytes[index] = res->bytes[index]%10;
                    carry = 1;
                }
            } else {
                res->bytes[index] =  n.bytes[nbytes] - carry;
                carry = 0;
                if(res->bytes[index] >= 10) {
                    res->bytes[index] = res->bytes[index]%10;
                    carry = 1;
                }
            }
            
            nbytes--;
            index++;
        }
    }
    reverse(res);
    return;
    
}

static void reverse(BigNum *res) {
    int temp;
    int start = 0;
    int end = res->nbytes - 1;
    while (start < end)
    {
        temp = res->bytes[start];
        res->bytes[start] = res->bytes[end];
        res->bytes[end] = temp;
        start++;
        end--;
    }
}

static void reverseString(char *arr) {
    char temp;
    int start = 0;
    int end = (int)strlen(arr) - 1;
    while (start < end)
    {
        temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

// Set the value of a BigNum from a string of digits
// Returns 1 if it *was* a string of digits, 0 otherwise
int scanBigNum(char *s, BigNum *n)
{
    for(int i = 0; s[i] != '\0'; i++) {
        if (!isdigit(s[i]) && s[i] != ' '){
            return 0;
        }
    }
    if ((int)strlen(s) >= n->nbytes) {
        n->bytes = (Byte*)realloc(n->bytes, (int)strlen(s) + 1);
        n->nbytes = (int)strlen(s) + 1;
    }
    int index = 0;
    reverseString(s);
    for(int i = 0; s[i] != '\0'; i++) {
        if(s[i] != ' '&& s[i] != '-') {
            n->bytes[index] = s[i] - '0';
            index++;
        }
        if(s[i] == '-') {
            n->bytes[index] = '-';
            index++;
        }
    }
    reverse(n);
    return 1;
}


// Display a BigNum in decimal format
void showBigNum(BigNum n)
{
    int isValidZero = 0;
    for(int i = 0; i < n.nbytes; i++){
        if(n.bytes[i] == 0 && isValidZero == 0) {
            continue;
        } else {
            printf("%d",n.bytes[i]);
            isValidZero = 1;
        }
    }
    if(isValidZero == 0) {
        printf("0");
    }
    return;
}

static int validNum(BigNum n) {
    int isValidZero = 0;
    int res = 0;
    for(int i = 0; i < n.nbytes; i++){
        if(n.bytes[i] == 0 && isValidZero == 0) {
            continue;
        } else {
            isValidZero = 1;
            res++;
        }
    }
    return res;
}

static int whichNumIsBigger(BigNum n, BigNum m) {
    if(validNum(n) > validNum(m)) {
        return 1;
    } else if (validNum(n) < validNum(m)){
        return 2;
    }
    // printf("valid number: %d",validNum(n));
    for (int i = 0; i < validNum(n); i++){
        if(n.bytes[n.nbytes - validNum(n) + i] > m.bytes[m.nbytes - validNum(m)] + i) {
           // printf("beep boop\n");
            return 1;
        } else if (n.bytes[n.nbytes - validNum(n) + i] < m.bytes[m.nbytes - validNum(m) + i]) {
            //printf("beep boop beep boop\n");
            return 2;
        }
    }
    return 0;
}
