
program pointeurs

integer, target :: m, n
integer, pointer :: p, q
integer :: retour

n = 5
m = 98
p => n
print *, "*p contient", p
q => m
print *, "*q contient", q
m = m + p
print *, "*q contient", q
p = 4
print *, "*p contient", p
p = q
print *, "*p contient", p

allocate(q, stat = retour)
q = 10
print *, "*q contient", q
deallocate(q)
if(associated(q)) then
  print *, "*q contient", q
else
  print *, "plus rien"
end if

end program pointeurs
