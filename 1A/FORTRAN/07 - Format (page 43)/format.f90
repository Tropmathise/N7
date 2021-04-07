program exemples_format

  real :: x
  double precision :: y

  x = 1.0/ 11.0
  y = 100*DSQRT(DFLOAT(2))

  write(*, 100) x
  write(*, 110) y
  write(*, 120) y
  write(*, 130) y

100 format(E12.6)
110 format(D12.6)
120 format(F12.6)
130 format(EN20.6)

end program exemples_format
