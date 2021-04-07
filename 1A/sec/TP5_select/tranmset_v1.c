
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
    int param, ret;

    if ( argc != 2 ) {         /* bon nombre de parametres ? */
      param = -1;
    } else {
        ret = sscanf(argv[1], "%d", &param);
        if ( ret != 1 )       /* valeur numerique ? */
          param = -1;
    }

    write(1, &param, sizeof(int));
    exit(0);
}