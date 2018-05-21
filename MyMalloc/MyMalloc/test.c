//
//  test.c
//  MyMalloc
//
//  Created by Xifei Ni on 29/4/18.
//  Copyright © 2018 Cecilia Ni. All rights reserved.
//

#include <stdio.h>
int main(void)
{
   pid_t id;  int stat;
   if ((id = fork()) != 0) {
      printf("A = %d\n", id);
      wait(&stat);
      return 1;
   }
   else {
      printf("B = %d\n", getppid());
      return 0;
   }
}
