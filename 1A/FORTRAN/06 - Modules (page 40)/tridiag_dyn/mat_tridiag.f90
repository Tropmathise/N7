module mat_tridiag

  type tridiag
    integer :: n
    real, allocatable, dimension(:) :: diag, diagsup, diaginf
  end type tridiag

contains

  subroutine create(a, n)

    implicit none

    integer, intent(in) :: n
    type(tridiag), intent(out) :: a

    a%n = n
    allocate(a%diag(n))
    allocate(a%diagsup(n))
    allocate(a%diaginf(n))

  end subroutine create

  subroutine somme(a, b, c, code)

    implicit none

    type(tridiag), intent(in) :: a,b
    type(tridiag), intent(out) :: c
    logical, intent(out) :: code

    if(a%n /= b%n) then
      code = .false.
      return
    else
      code = .true.
      call create(c, a%n)
      c%diag = a%diag + b%diag
      c%diagsup = a%diagsup + b%diagsup
      c%diaginf = a%diaginf + b%diaginf
    end if

  end subroutine somme

  subroutine affiche(a)

    implicit none

    type(tridiag), intent(in) :: a

    integer :: i,j 

    do i = 1, a%n
      print *, 'colonne ', i
      do j = 1, i-2
        print *, 0.0
      enddo
      if(i /= 1) then
        print *, a%diagsup(i)
      end if
      print *, a%diag(i)
      if(i /= a%n) then
        print *, a%diaginf(i)
      end if
      do j = i+2, 10
        print *, 0.0
      enddo
      print *, "------------------"
    enddo

  end subroutine affiche

end module mat_tridiag


