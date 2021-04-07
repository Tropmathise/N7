function C_estime = estimation_1(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_0)
distance=sqrt((x_donnees_bruitees-C_tests(:,1)).^2+(y_donnees_bruitees-C_tests(:,2)).^2)
A=sum((distance'-R_0).^2)
[m,ind]=min(A)
C_estime=C_tests(ind,:)


