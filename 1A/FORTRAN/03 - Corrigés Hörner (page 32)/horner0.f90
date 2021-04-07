  program test_horner
    implicit none
    ! Evaluation d’un polynome de degré n en un point x
    !
    ! Degré du polynome
    integer :: n
    ! Coefficients du polynôme
    real, allocatable, dimension(:) :: coef
    ! Valeur de l’inconnue
    real :: x
    ! Valeur finale du polynôme au point x
    real p
    ! Indice de boucle
    integer :: i
    ! Retour du allocate
    integer :: retour
    ! fonction horner
    real :: horner

    ! lecture du n
    n = -1
    do while (n<0)
      write(*,*) 'Entrez le degré du polynome'
      read(*,*) n
    end do
    ! n >= 0

    ! Allocation du tableau des coefficients
    allocate(coef(n+1), stat = retour)

    if(retour.ne.0) stop

    ! Lecture des coefficients du polynôme
    do i = 1, n+1
      write(*,*) 'Entrez le coefficient de degré ', i-1, ' : '
      read(*,*) coef(i)
    end do

    ! Contrôle
    write(*,*) 'Liste des coefficients du polynôme'
    write(*,*) coef

    ! Entrée de l’inconnue
    write(*,*) 'Entrez l''inconnue'
    read(*,*) x

    ! Schéma de Horner

    p = horner(coef, n, x)

    ! Affichage du resultat
    write(*,*) 'valeur du polynôme = ', p, ' en ', x

  end program test_horner

  real function horner(a, n, x)

    implicit none
    real, intent(in), dimension(0:n) :: a
    integer, intent(in) :: n
    real, intent(in) :: x

    integer :: i

    horner = a(n)
    do i = n-1, 0, -1
      horner = horner*x + a(i)
    end do
    return

  end function horner
