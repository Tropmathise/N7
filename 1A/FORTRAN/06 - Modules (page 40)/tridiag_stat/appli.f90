program validation

  use mat_tridiag
  type(tridiag) :: m1, m2, m3

  integer :: i

  do i = 1, 10
    m1%diag = 1.0
    m2%diag = 2.0
  enddo

  do i = 2, 10
    m1%diaginf = 1.0
    m2%diaginf = 2.0
  enddo

  do i = 1, 9
    m1%diagsup = 1.0
    m2%diagsup = 2.0
  enddo

  call somme(m1, m2, m3)
  call affiche(m3)

end program validation
