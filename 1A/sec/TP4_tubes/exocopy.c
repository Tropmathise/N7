#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

int main(int argc, char **argv){
    char *source = argv[1];
    char *dest = argv[2];

    int fd = open(dest, O_CREAT| O_WRONLY | O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
    if (fd<0){
        printf("Error open");
        perror("Perror: ");
        exit(1);
    }
    dup2(fd,10);
    close(fd);
    execlp("cat","cat", source, NULL);
}