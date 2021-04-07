#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */

int main () {
    fork (); printf("fork 1 : processus %d, de pere %d\n", getpid(), getppid());
    fork (); printf("fork 2 : processus %d, de pere %d\n", getpid(), getppid());
    fork (); printf("fork 3 : processus %d, de pere %d\n", getpid(), getppid());
    sleep(180);
return EXIT_SUCCESS ;
}