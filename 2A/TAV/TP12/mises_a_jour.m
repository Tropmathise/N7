function [A_new,D_abs_new] = mises_a_jour(A,D_abs,S_abs)

    A_new= A.*(D_abs'*S_abs)./(D_abs'*D_abs*A+eps);
    D_abs_new=D_abs.*(S_abs*A')./(D_abs*(A*A')+eps);

end 