function [C_estime, R_estime]= estimation_2(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_tests)
distance=sqrt((x_donnees_bruitees-C_tests(:,1)).^2+(y_donnees_bruitees-C_tests(:,2)).^2)
A=sum((distance-R_tests)'.^2)
[m,ind]=min(A)
C_estime=C_tests(ind,:)
R_estime=R_tests(ind)

