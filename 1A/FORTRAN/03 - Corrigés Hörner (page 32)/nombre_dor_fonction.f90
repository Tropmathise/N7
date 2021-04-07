program nb_or

! déclaration des constantes et des variables
implicit none

real:: epsilon

real:: nombre_dor_exact, nombre_dor

! type des fonctions utilisées
real:: lim_fibonacci

! début des instructions
! lecture du epsilon au clavier
print *, 'donnez le epsilon'
read *, epsilon
nombre_dor_exact = (1.+sqrt(5.))/2.
nombre_dor = lim_fibonacci(epsilon)

! affichage des résultats à l'écran
print *,'Limite de la suite de Fibonacci :', nombre_dor
print *,'Nombre d''or', nombre_dor_exact
print *, 'Racine de x**2 - x - 1', nombre_dor**2 - nombre_dor - 1

end program nb_or

! fonction qui calcule la limite de la suite de Fibonacci avec
! une précision de eps
function lim_fibonacci(eps)

implicit none

!définition du type de la fonction
real:: lim_fibonacci

! déclaration des paramètres
real, intent(in) :: eps

!déclaration des variables locales 
real:: fib, fib_1, fib_2
real:: nombre_dor, nombre_dor_prec
logical:: convergence

! début des instructions
fib_2 = 1.
fib_1 = 1.
convergence = .false.
nombre_dor = fib_1/fib_2

do while (.not.convergence)
  fib = fib_1 + fib_2
  nombre_dor_prec = nombre_dor
  nombre_dor = fib / fib_1
  fib_2 = fib_1
  fib_1 = fib
  convergence = abs((nombre_dor_prec - nombre_dor)/nombre_dor_prec) < eps
end do

! pour retourner le résultat
lim_fibonacci = nombre_dor

end function lim_fibonacci

