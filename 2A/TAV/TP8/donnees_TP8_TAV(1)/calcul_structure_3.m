function u_barre_new = calcul_structure_3(u_barre,u,Dx,Dy,Phi,epsilon,mu_prime,gamma)
    [nbl,nbc] = size(u);    
    ux_barre=Dx*u_barre(:);
    uy_barre=Dy*u_barre(:);
    uxx_barre=-Dx'*Dx*u_barre(:);
    uyy_barre=-Dy'*Dy*u_barre(:);
    uxy_barre=-Dx'*Dy*u_barre(:);
    
    div=(uxx_barre.*(uy_barre.^2+epsilon)+uyy_barre.*(ux_barre.^2+epsilon)-2.*ux_barre.*uy_barre.*uxy_barre)./((ux_barre.^2+uy_barre.^2+epsilon).^(3/2));
    div=reshape(div,[nbl,nbc]);
    
    TF_u_barre=fftshift(fft2(u_barre));
    TF_u=fftshift(fft2(u));
    TF_m1=real(ifft2(ifftshift(Phi.*(TF_u_barre-TF_u))));
    
    u_barre_new=u_barre-gamma*(TF_m1-mu_prime*div);
end

