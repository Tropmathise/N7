program tribulle

  ! déclaration des constantes et des variables

  implicit none

  integer::n
  parameter(n = 10)

  integer:: etape, i
  real:: temp
  logical :: tri_termine

  real, dimension(n):: v
  data v/0.7, 0.3, 0.4, 0.9, 0.2, 0.1, 0.5, 0.6, 0.7, 0.9/

  etape = 0
  tri_termine = .false.

  do while(.not.tri_termine)
    tri_termine = .true.
    do i = 2, n - etape
      if(v(i-1) > v(i)) then
        tri_termine = .false.
        temp = v(i-1)
        v(i-1) = v(i)
        v(i) = temp
      end if
    end do
    etape = etape + 1
  end do

  print *, 'tri croissant', v

end program tribulle
