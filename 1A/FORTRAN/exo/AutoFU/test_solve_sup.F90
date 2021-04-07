program test_solve

    implicit none

    integer :: i, j, ierr, n
    double precision, dimension (:,:), allocatable :: U
    double precision, dimension (:), allocatable :: x, b
    double precision :: backward_error
    real :: time_begin, time_end

    write(*,*)
    write(*,*) 'Choose the size n :'
    read(*,*) n
    write(*,*)

    ! Initialization: U is lower triangular
    write(*,*) 'Initialization ...'
    write(*,*)

    allocate(U(n,n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate U(n,n) with n =', n
        write(*,*)
        goto 999
    end if

    allocate(x(n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate x(n) with n =', n
        write(*,*)
        goto 999
    end if

    allocate(b(n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate b(n) with n =', n
        write(*,*)
        goto 999
    end if

    U = 0.D0
    do i = 1, n
        U(i,i) = n + 1.D0
        do j = i+1, n
            U(i,j) = 1.D0
        end do
    end do
    b = 1.D0

    ! Left-looking triangular solve of Ux = b
    write(*,*) 'Solving with a left-looking method ...'

    call cpu_time(time_begin)
    call left_looking_solve(U,x,b,n)
    call cpu_time(time_end)

    ! affichage de l'erreur et du temps
    write(*,*) 'Time of operation was ', time_end - time_begin, ' seconds'
    write(*,*) 'The left method error is :', backward_error(U,x,b,n)
    write(*,*) '-----------------------------------------'
    
    ! Left-looking_croissant triangular solve of Ux = b
    write(*,*) 'Solving with a left-looking_croissant method ...'

    call cpu_time(time_begin)
    call left_looking_solve_croissant(U,x,b,n)
    call cpu_time(time_end)

    ! affichage de l'erreur et du temps
    write(*,*) 'Time of operation was ', time_end - time_begin, ' seconds'
    write(*,*) 'The left method "croissant" error is :', backward_error(U,x,b,n)
    write(*,*) '-----------------------------------------'

    ! Right-looking triangular solve of Ux = b
    write(*,*) 'Solving with a right-looking method ...'

    call cpu_time(time_begin)
    call right_looking_solve(U,x,b,n)
    call cpu_time(time_end)

    !affichage de l'erreur et du temps
    write(*,*) 'Time of operation was ', time_end - time_begin, ' seconds'
    write(*,*) 'The right method error is :', backward_error(U,x,b,n)

999 if(allocated(U)) deallocate(U)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)



end program test_solve

subroutine left_looking_solve(U,x,b,n)
    implicit none
    
    ! déclaration des variables 
    double precision, intent(in), dimension(n,n) :: U
    double precision, intent(in), dimension(n) :: b
    integer, intent(in) :: n
    integer :: i,j
    double precision, intent(out), dimension(n) :: x

    ! préconditions : 
        ! - U est initialisée et aucun terme de sa diagonale n'est nul
        ! - n>0
    ! postcondition : x contient la solution de Ux=b

    ! début de l'implantation
    x=b

    for1 : do j=n,1
        for2 : do i=n, j+1   ! ordre décroissant
            x(j)=x(j)-U(j,i)*x(i)
        end do for2
        x(j)=x(j)/U(j,j)
    end do for1
end subroutine left_looking_solve

! Ordre croissant
subroutine left_looking_solve_croissant(U,x,b,n)
        implicit none
        
        ! déclaration des variables 
        double precision, intent(in), dimension(n,n) :: U
        double precision, intent(in), dimension(n) :: b
        integer, intent(in) :: n
        integer :: i,j
        double precision, intent(out), dimension(n) :: x
    
        ! préconditions : 
            ! - U est initialisée et aucun terme de sa diagonale n'est nul
            ! - n>0
        ! postcondition : x contient la solution de Ux=b
    
        ! début de l'implantation
        x=b
    
        for1 : do j=n,1
            for2 : do i=j+1, n   ! ordre croissant (question subsidiaire)
                x(j)=x(j)-U(j,i)*x(i)
            end do for2
            x(j)=x(j)/U(j,j)
        end do for1

end subroutine left_looking_solve_croissant

subroutine right_looking_solve(U,x,b,n)

    implicit none
    
    ! déclaration des variables 
    double precision, intent(in), dimension(n,n) :: U
    double precision, intent(in), dimension(n) :: b
    integer, intent(in) :: n
    integer :: i,j
    double precision, intent(out), dimension(n) :: x

    ! préconditions : 
        ! - U est initialisée et aucun terme de sa diagonale n'est nul
        ! - n>0
    ! postcondition : x contient la solution de Ux=b

    ! début de l'implantation
    x=b
    for1 : do j=n,1
        x(j)=x(j)/U(j,j)
        for2 : do i=1,j-1 
            x(i)=x(i)-U(i,j)*x(j)
        end do for2
    end do for1

end subroutine right_looking_solve

! Calcul de l'erreur inverse 
double precision function backward_error(U,x,b,n)

    implicit none 

    ! déclaration des variables 
    double precision, intent(in), dimension(n,n) :: U
    double precision, intent(in), dimension(n) :: b
    integer, intent(in) :: n
    integer :: i
    double precision, intent(in), dimension(n) :: x
    double precision :: norme_b, norme_Uxb
    double precision, dimension(n) :: vecteur_Uxb

    ! précondition : 
        ! - n>0

    ! début de l'implantation
    vecteur_Uxb = matmul(U,x)-b ! calcul de la matric Ux-b
    norme_Uxb=0 ! initialisation
    for1 : do i=1,n
        norme_Uxb=sqrt(norme_Uxb**2+vecteur_Uxb(i)**2) ! calcul de la norme2 de Ux-b
        norme_b=sqrt(norme_b**2 + b(i)**2) ! calcul de la norme2 de b
    end do for1
    backward_error=norme_Uxb/norme_b ! calcul de l'erreur
    return 
end function backward_error


