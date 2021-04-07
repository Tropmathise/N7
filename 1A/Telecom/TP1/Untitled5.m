close all
clear;

% Tracé du TEB et TES
nb_bits=10000;
Ns=10;
Ts=2*Ns;
t0=Ts;
Eb_N0_dB=(-2:6);
dirac=[1 zeros(1,Ts-1)];

h=ones(1,Ts);
h=h/norm(h);
hr=h;

bits=randi([0,1],1,nb_bits);
Symboles = (2*bi2de(reshape(bits, 2, length(bits)/2).')-3).';

suite=kron(Symboles,dirac);
x=filter(h,1,suite);

for i=1:length(Eb_N0_dB)
    nb_erreur_symb=0;
    nb_erreur_bit=0;
    compteur=0;
    while nb_erreur_bit<100
        sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_dB(i)/10));
        bruit=sqrt(sigma2)*randn(1,nb_bits*Ts/2);
        signal_recu=x+bruit;
        z=filter(hr,1,signal_recu);
        z_ech=(z(t0:Ts:end));
        symb_est = 3*(z_ech>2) + 1*((0<z_ech)&(z_ech<2)) - 1*((-2<z_ech)&(z_ech<0)) -3*(z_ech<-2);
        nb_erreur_symb=nb_erreur_symb+sum(symb_est~=Symboles);
        bits_est= reshape(de2bi((symb_est + 3)/2).',1,length(bits));
        compteur=compteur+1;
        nb_erreur_bit=nb_erreur_bit+sum(bits_est~=bits);
    end
    TEB(i)=nb_erreur_bit/(compteur*nb_bits);
    TES(i)=nb_erreur_symb/(compteur*nb_bits/2);
end

% TES
figure(7); hold on;
TES_th=1.5*(1-normcdf(sqrt((4/5)*10.^(Eb_N0_dB/10))));
plot(Eb_N0_dB,10*log10(TES))
plot(Eb_N0_dB,10*log10(TES_th),'r')
title('TES')

% TEB
figure(8); hold on;
TEB_th=TES_th/2;
plot(Eb_N0_dB,10*log10(TEB))
plot(Eb_N0_dB,10*log10(TEB_th),'r')
title('TEB')



