#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>

long usecs (){
  struct timeval t;

  gettimeofday(&t,NULL);
  return t.tv_sec*1000000+t.tv_usec;
}

double dnorm2_seq(double *x, int n);
double dnorm2_par_red(double *x, int n);
double dnorm2_par_nored(double *x, int n);


int main(int argc, char *argv[]){

  int n, i;
  double *x;
  double n2_seq, n2_par_red, n2_par_nored;
  long    t_start,t_end;

  
  if(argc!=2){
    printf("Wrong number of arguments.\n Usage:\n\n\
./main n \n\n where n is the size of the vector x whose 2-norm has to be computed.\n");
    return 1;
  }

  
  sscanf(argv[1],"%d",&n);

  
  x = (double*)malloc(sizeof(double)*n);

  for(i=0; i<n; i++)
    x[i] = ((double) rand() / (RAND_MAX));


  printf("\n================== Sequential version ==================\n");
  t_start = usecs();
  n2_seq       = dnorm2_seq(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_seq);

  printf("\n\n=========== Parallel version with reduction  ===========\n");
  t_start = usecs();
  n2_par_red   = dnorm2_par_red(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par_red);


  printf("\n========== Parallel version without reduction ==========\n");
  t_start = usecs();
  n2_par_nored = dnorm2_par_nored(x, n);
  t_end = usecs();
  printf("Time (msec.) : %7.1f\n",(t_end-t_start)/1e3);
  printf("Computed norm is: %10.3lf\n",n2_par_nored);


  printf("\n\n");
  if(fabs(n2_seq-n2_par_red)/n2_seq > 1e-10) {
    printf("The parallel version with reduction is numerically wrong! \n");
  } else {
    printf("The parallel version with reduction is numerically okay!\n");
  }
  
  if(fabs(n2_seq-n2_par_nored)/n2_seq > 1e-10) {
    printf("The parallel version without reduction is numerically wrong!\n");
  } else {
    printf("The parallel version without reduction is numerically okay!\n");
  }
  
  return 0;

}



double dnorm2_seq(double *x, int n){
  int i;
  double res;

  res = 0.0;

  for(i=0; i<n; i++)
    res += x[i]*x[i];

  return sqrt(res);
  
}

double dnorm2_par_red(double *x, int n){
  int i;
  double res;

  res = 0.0;
  #pragma omp parallel for reduction(+:res)
  for(i=0; i<n; i++)
    res += x[i]*x[i];
  return sqrt(res);
  
}

double dnorm2_par_nored(double *x, int n){
  int i, iam;
  double res;

  res = 0.0;
#pragma omp parallel
{
  double my_res = 0.0;
  #pragma omp for nowait
  for(i=0; i<n; i++){
    my_res += x[i]*x[i];
  }

  #pragma omp atomic
  res+=my_res;
}
  return sqrt(res);
}

// on remarque qu'avec la reduction, le temps d'éxecution est nb_threads 
// fois plus rapide qu'en sequentiel. Le calcul est séparé en nb_threads calculs.
// Le temps est evidemment le meme pour la fonction sans la reduction.