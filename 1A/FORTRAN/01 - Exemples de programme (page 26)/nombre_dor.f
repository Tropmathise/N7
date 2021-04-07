C23456789012345678901234567890123456789012345678901234567890123456789012
      program nb_or
 

C déclarations des constantes et des variables
      implicit none
  
      real epsilon
      parameter(epsilon=1.e-5)

      real fib, fib_1, fib_2
      real nombre_dor, nombre_dor_prec
      real nombre_dor_exact
      logical convergence

C début des instructions

      fib_2 = 1.
      fib_1 = 1.

      nombre_dor = fib_1/fib_2
      convergence = .false.

 10   if(convergence) goto 20

      fib = fib_1 + fib_2
      nombre_dor_prec = nombre_dor
      nombre_dor = fib / fib_1
      fib_2 = fib_1
      fib_1 = fib
      convergence = (abs((nombre_dor_prec 
     &      - nombre_dor)/nombre_dor_prec) .lt. epsilon)
      goto 10

 20   nombre_dor_exact = (1.+sqrt(5.))/2.

C affichage des résultats à l'écran
      write (*,*) 'Limite de la suite de Fibonacci :', nombre_dor
      write (*,*) 'Nombre d''or', nombre_dor_exact
      write (*,*) 'Racine de x**2 - x - 1',
     c            nombre_dor**2 - nombre_dor - 1

      end
