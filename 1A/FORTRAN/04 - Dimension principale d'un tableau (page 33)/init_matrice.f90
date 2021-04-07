      program init_matrice

        implicit none

        integer, dimension(4,4) :: A
        integer :: i,j

        ! je souhaite initialiser la matrice 3x3

        call init_mat(A, 3, 3)

        do j = 1,3
          do i = 1,3
            write(*,*) i, j, A(i,j)
          enddo
        enddo

      end program init_matrice

      subroutine init_mat(A, n, m)

        implicit none
        integer, intent(in) :: n, m
        integer, dimension(n,m), intent(out) :: A
        integer :: valeur
        integer :: i,j

        valeur = 0
        do j = 1,m
          do i = 1,n
            valeur = valeur + 1
            A(i,j)= valeur
          enddo
        enddo

      end subroutine init_mat

      subroutine init_mat_correct(A, lda, n, m)

        implicit none
        integer, intent(in) :: lda, n, m
        integer, dimension(lda,m), intent(out) :: A
        integer :: valeur
        integer :: i,j

        valeur = 0
        do j = 1,m
          do i = 1,n
            valeur = valeur + 1
            A(i,j)= valeur
          enddo
        enddo

      end subroutine init_mat_correct

        ! solution
        ! call init_mat_correct(A, 4, 3, 3)
 
