module mat_tridiag

  type tridiag
    real, dimension(10) :: diag, diagsup, diaginf
  end type tridiag

contains

  subroutine somme(a, b, c)

    implicit none

    type(tridiag), intent(in) :: a,b
    type(tridiag), intent(out) :: c

    c%diag = a%diag + b%diag
    c%diagsup = a%diagsup + b%diagsup
    c%diaginf = a%diaginf + b%diaginf
  end subroutine somme

  subroutine soustraction(a, b, c)

    implicit none

    type(tridiag), intent(in) :: a,b
    type(tridiag), intent(out) :: c

    c%diag = a%diag - b%diag
    c%diagsup = a%diagsup - b%diagsup
    c%diaginf = a%diaginf - b%diaginf

  end subroutine soustraction

  subroutine affiche(a)

    implicit none

    type(tridiag), intent(in) :: a

    integer :: i,j 

    do i = 1, 10
      do j = 1, i-2
        print *, 0.0
      enddo
      if(i /= 1) then
        print *, a%diaginf(i)
      end if
      print *, a%diag(i)
      if(i /= 10) then
        print *, a%diagsup(i)
      end if
      do j = i+2, 10
        print *, 0.0
      enddo
      print *, "------------------"
    enddo

  end subroutine affiche

end module mat_tridiag
