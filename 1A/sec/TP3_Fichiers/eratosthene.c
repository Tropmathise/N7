#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
#include <time.h>

int main (int argc, char **argv)
{
    int max;
    int pid;
    int p[2];
    int argv1len;
    
    if (argc != 2) {
        fprintf (stderr, "%s <maxval>\n", argv[0]);
        exit (1);
    }

    argv1len = strlen (argv[1]);
    max = atoi (argv[1]);
    if (max < 2) {
        fprintf (stderr, "%s: illegal value for max\n", argv[0]);
        exit (1);
    }
    
    return 0;
}