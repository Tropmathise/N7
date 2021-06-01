function u_kp1 = debruitage(u0,u_k,lambda,Dx,Dy,epsilon)
    [nb,~]=size(u_k);
    W_k = 1./sqrt((Dx*u_k).^2+(Dy*u_k).^2 +epsilon);
    %W_k = 1./sqrt((Dx*u_k+Dy*u_k).^2 +epsilon);
    W_k = spdiags(W_k,0,nb,nb);
    div = -Dx'*W_k*Dx-Dy'*W_k*Dy;
    A=speye(nb)-lambda*div;
    u_kp1=A\u0;
end