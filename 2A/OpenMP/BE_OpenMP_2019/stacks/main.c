#include "aux.h"
#include <omp.h>

void stacks_seq(stack_t *stacks, int n);
void stacks_par_critical(stack_t *stacks, int n);
void stacks_par_atomic(stack_t *stacks, int n);
void stacks_par_locks(stack_t *stacks, int n);


int main(int argc, char **argv){

  stack_t *stacks;
  int      i, j, n;
  long     t_start, t_end, save;

  
  if ( argc == 2 ) {
    n = atoi(argv[1]);    /* the number of stacks */
  } else {
    printf("Usage:\n\n ./main n\n\nwhere n is the number of stacks.\n");
    return 1;
  }

  printf("\n");
  
  init_stacks(&stacks, n);
  t_start = usecs();
  stacks_seq(stacks, n);
  t_end = usecs();
  printf("Sequential  version.       --------  time : %8.2f msec.     ",((double)t_end-t_start)/1000.0);
  check_result(stacks, n);
  free_stacks(&stacks, n);

  init_stacks(&stacks, n);
  t_start = usecs();
  stacks_par_critical(stacks, n);
  t_end = usecs();
  printf("Critical    version.       --------  time : %8.2f msec.     ",((double)t_end-t_start)/1000.0);
  check_result(stacks, n);
  free_stacks(&stacks, n);

  init_stacks(&stacks, n);
  t_start = usecs();
  stacks_par_atomic(stacks, n);
  t_end = usecs();
  printf("Atomic      version.       --------  time : %8.2f msec.     ",((double)t_end-t_start)/1000.0);
  check_result(stacks, n);
  free_stacks(&stacks, n);

  init_stacks(&stacks, n);
  t_start = usecs();
  stacks_par_locks(stacks, n);
  t_end = usecs();
  printf("Locks       version.       --------  time : %8.2f msec.     ",((double)t_end-t_start)/1000.0);
  check_result(stacks, n);
  free_stacks(&stacks, n);

  return 0;
  
}


void stacks_seq(stack_t *stacks, int n){

  int s;
  
  
  for(;;){

    /* Get the stack number s */
    s = get_random_stack();

    if(s==-1) break;
    
    /* Push some value on stack s */
    stacks[s].elems[stacks[s].cnt++] = process();

  }
  
}



void stacks_par_critical(stack_t *stacks, int n){

  int s;

  /* ajout pour be */
  int tmp;
  
  #pragma omp parallel private(s,tmp)
  {
  for(;;){

    /* Get the stack number s */
    s = get_random_stack();

    if(s==-1) break;
    
    /* Push some value on stack s */
    tmp=process(); /* on enleve process de la section critique car bcp de temps dedans THREAD SAFE */
    #pragma omp critical
    {
    stacks[s].elems[stacks[s].cnt++] = tmp;
    }
  }
  }
}




void stacks_par_atomic(stack_t *stacks, int n){

  int s;

  int tmp;

  #pragma omp parallel private(s,tmp)
  {
  
  for(;;){

    /* Get the stack number s */
    s = get_random_stack();

    if(s==-1) break;
    #pragma omp atomic capture
    {
    tmp=stacks[s].cnt++;
    }
    /* Push some value on stack s */
    stacks[s].elems[tmp] = process();
  }
  }
}



void stacks_par_locks(stack_t *stacks, int n){

  int s;
  omp_lock_t *lock;
  lock =(lock*)malloc(1000*sizeof(lock));
  for (i=0; i<1000;i++)
    omp_init_lock(i+lock);

  #pragma omp parallel private(s)
  {
  
  for(;;){

    /* Get the stack number s */
    s = get_random_stack();

    if(s==-1) break;
    
    /* Push some value on stack s */
    tmp=process();
    omp_set_lock(lock+s);
    stacks[s].elems[stacks[s].cnt++] = tmp;
    omp_unset_lock(lock+s);
  }
 

}
