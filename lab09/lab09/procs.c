// COMP1521 17s2 Lab08 ... processes competing for a resource
 
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>

#define MAXLINE BUFSIZ

void copyInput(char *name,pid_t self, pid_t child);

int main(void)
{
   struct sigaction act;
   memset (&act, 0, sizeof(act));
   setsid();
   pid_t parent = getpid();
   pid_t child;
   pid_t gchild;
   if ((child =fork()) != 0) {
      setsid();
      printf("[PAR (%d, %d)]\n", parent, child);
      //stop mychild here
      kill(getpid(),SIGSTOP);
      copyInput("Parent",getpid(),child);
      
   }
   else if ((gchild =fork()) != 0) {
      setsid();
      child = getpid();
      printf("[CHL (%d, %d)]\n", child, gchild);

      signal(SIGINT,SIG_IGN);
      kill(getpid(),SIGSTOP);
      copyInput("Child",getpid(),gchild);
      
   }
   else {
      setsid();
      printf("[GCH (%d, %d)]\n", gchild, parent);
      ///grandchild is still here hasnt execetuded the stop itself yet
      
      kill(getpid(), SIGSTOP);
      copyInput("Grand-child",getpid(),parent);
   }
   return 0;
}

void copyInput(char *name,pid_t self, pid_t child)
{
   pid_t mypid = getpid();
   char  line[MAXLINE];
   printf("%s (%d) ready\n", name, mypid);
   while (fgets(line, MAXLINE, stdin) != NULL) {
      printf("%s: %s", name, line);
      kill(child,SIGCONT);
      sleep(random()%3);
      kill(self, SIGSTOP);
   }
   printf("%s quitting\n", name);
   return;
}
