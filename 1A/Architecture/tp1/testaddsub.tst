set a[31..0] 00000000000000000000000000000000
set b[31..0] 00000000000000000000000000000000
set addsub 0
check s[31..0] 00000000000000000000000000000000
check C 0
check V 0

set a[31..0] 01111111111111111111111111111111
set b[31..0] 00000000000000000000000000000001
set addsub 0
check s[31..0] 10000000000000000000000000000000
check C 0
check V 1

set a[31..0] 11111111111111111111111111111111
set b[31..0] 10000000000000000000000000000000
set addsub 0
check s[31..0] 01111111111111111111111111111111
check C 1
check V 1

set a[31..0] 01111111111111111111111111111111
set b[31..0] 10000000000000000000000000000000
set addsub 0
check s[31..0] 11111111111111111111111111111111
check C 0
check V 0

set a[31..0] 11111111111111111111111111111111
set b[31..0] 01111111111111111111111111111111
set addsub 0
check s[31..0] 01111111111111111111111111111110
check C 1
check V 0

