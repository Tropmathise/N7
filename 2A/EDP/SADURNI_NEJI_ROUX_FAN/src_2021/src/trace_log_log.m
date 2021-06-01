function trace_log_log(nbmax)
%TRACE_LOG Summary of this function goes here
%   fonction traçant l'évolution de l'écart entre la solution exacte et
%   approchée
    ecart=zeros(2,nbmax-2);
    for i=3:nbmax
        [coordinates,~] = maillage_carre(i);
        [u_h,~]=elliptic_f(0,i);
        h=1/length(u_h);
        ecart(1,i-2)=h*norm(u_exact(coordinates)-u_h);
        ecart(2,i-2)=h;
    end
    %loglog((ecart(2,:),(ecart(1,:))
    plot(log10(ecart(2,:)),log10(ecart(1,:)));
end

