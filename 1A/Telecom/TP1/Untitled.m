close all

% Durée symbole en nombre d’échantillons (Ts=Ns*Te)
Ns=4; 
Ts=2*Ns;

% Nombre de bits générés
nb_bits=1000; 

% Génération de l’information binaire
bits=randi([0,1],1,nb_bits);

% Mapping 4- aire à moyennenulle: 00->-3, 01->-1, 10->1, 11->3
Symboles = (2*bi2de(reshape(bits, 2, length(bits)/2).')-3).';

% Génération de la suite de Diracs pondérés par les symbols (suréchantillonnage)
dirac=kron(Symboles, [1 zeros(1,Ts-1)]);

% Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,2*Ns);
h=h/norm(h);
hr=h;

% Filtrage de mise en forme
x=filter(h,1,dirac);

% Affichage du signal généré
figure(1) ; clf
plot(x);
title('Signal généré')

% Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

% Affichage de la DSP du signal généré
figure(2);clf
plot(linspace(0,1,length(DSP_x)), DSP_x);
title('DSP')

% Tracé du signal en sortie du filtre de reception
sigma2=0;
b=sqrt(sigma2)*randn(1,nb_bits*Ts/2);
r=x+b;

z=filter(hr,1,r);
figure(3);clf
plot(z);

title('Signal en sortie du filtre de réception')

% Tracé du diagramme de l'oeil
oeil=reshape(z,Ts,nb_bits/2);
figure(4); clf
plot(oeil);
title("Diagramme de l'oeil")

% Tracé du signal avec bruit 
sigma2=Ns/2;
b=sqrt(sigma2)*randn(1,nb_bits*Ts/2);
r=x+b;

figure(5);clf
plot(r);
title('Signal avec bruit')

% Tracé du siganl en sortie du filtre avec bruit
z=filter(h,1,r);
figure(6);clf
plot(z);
title('Signal en sortie du filtre (avec bruit)')

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



