function u_kp1 = inpainting(u0,u_k,lambda,Dx,Dy,epsilon,XhiD)
    [nb,~]=size(u_k);
    W_prime=spdiags(XhiD,0,nb,nb);
    W_k = 1./sqrt((Dx*u_k).^2+(Dy*u_k).^2 +epsilon);
    W_k = spdiags(W_k,0,nb,nb);
    div = -Dx'*W_k*Dx-Dy'*W_k*Dy;
    A=W_prime-lambda*div;
    b=W_prime*u0;
    u_kp1=A\b;
end