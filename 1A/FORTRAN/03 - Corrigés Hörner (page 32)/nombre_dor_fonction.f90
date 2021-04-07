program nb_or

! d�claration des constantes et des variables
implicit none

real:: epsilon

real:: nombre_dor_exact, nombre_dor

! type des fonctions utilis�es
real:: lim_fibonacci

! d�but des instructions
! lecture du epsilon au clavier
print *, 'donnez le epsilon'
read *, epsilon
nombre_dor_exact = (1.+sqrt(5.))/2.
nombre_dor = lim_fibonacci(epsilon)

! affichage des r�sultats � l'�cran
print *,'Limite de la suite de Fibonacci :', nombre_dor
print *,'Nombre d''or', nombre_dor_exact
print *, 'Racine de x**2 - x - 1', nombre_dor**2 - nombre_dor - 1

end program nb_or

! fonction qui calcule la limite de la suite de Fibonacci avec
! une pr�cision de eps
function lim_fibonacci(eps)

implicit none

!d�finition du type de la fonction
real:: lim_fibonacci

! d�claration des param�tres
real, intent(in) :: eps

!d�claration des variables locales 
real:: fib, fib_1, fib_2
real:: nombre_dor, nombre_dor_prec
logical:: convergence

! d�but des instructions
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

! pour retourner le r�sultat
lim_fibonacci = nombre_dor

end function lim_fibonacci

