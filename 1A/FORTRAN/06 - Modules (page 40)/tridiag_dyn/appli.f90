program validation

  use mat_tridiag
  type(tridiag) :: m1, m2, m3
  logical :: code

  integer :: i

  call create(m1, 10)
  call create(m2, 10)

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

  call somme(m1, m2, m3, code)

  if(code) then
    call affiche(m3)
  else
    print *, "erreur de dimension"
  end if

end program validation


