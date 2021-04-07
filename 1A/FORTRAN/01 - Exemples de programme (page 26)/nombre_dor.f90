program nb_or

  ! déclarations des constantes et des variables

  ! implicit none => pour être obligé de déclarer toutes les variables
  implicit none

  ! une constante
  real, parameter :: epsilon = 1.e-10

  ! des variables scalaires réelles
  real :: fib, fib_1, fib_2
  real :: nombre_dor, nombre_dor_prec
  real :: nombre_dor_exact

  ! un booléen
  logical:: convergence

  ! début des instructions

  ! initialisations

  fib_2 = 1.
  fib_1 = 1.

  convergence = .false.

  nombre_dor = fib_1/fib_2

  ! calculs

  do while (.not.convergence)
    nombre_dor_prec = nombre_dor
    fib = fib_1 + fib_2
    nombre_dor = fib / fib_1
    fib_2 = fib_1
    fib_1 = fib
    convergence = abs((nombre_dor_prec - nombre_dor)/nombre_dor_prec) < epsilon
  end do
  ! post condition : |nombre_dor_prec - nombre_dor|/|nombre_dor_prec| < epsilon

  ! post-traitements

  nombre_dor_exact = (1.+sqrt(5.))/2.

  ! affichage des résultats à l'écran
  print *,'Limite de la suite de Fibonacci :', nombre_dor
  print *,'Nombre d''or', nombre_dor_exact
  print *, 'Racine de x**2 - x - 1', nombre_dor**2 - nombre_dor - 1

end program nb_or
