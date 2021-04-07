program tribulle

! déclaration des constantes et des variables

implicit none

integer, parameter :: n = 10

integer:: i, j
real:: aux

real, dimension(n):: t
data t/0.7, 0.3, 0.4, 1.9, 0.2, 0.1, 0.5, 0.6, 0.7, 0.9/

do i = 1, n-1
  do j = 1, n-i
    if(t(j+1) < t(j)) then
      aux = t(j+1)
      t(j+1) = t(j)
      t(j) = aux
    end if
    ! t(j) <= t(j+1)
  end do
  ! tableau t(n-i+1:n) trié
end do
! tableau t(1:n) trié

print *, 'tri croissant', t

end program tribulle
