close all 
clear all

%% Chaine de référence pour comparaison

%Durée symbole en nombre d'échantillons (Ts=NsTe)
Ns=4; 
%M (binaire)
M=2;
%temps de départ d'échantillonnage
t0=Ns;
%Eb_N0_dB
Eb_N0_dB = [-2:6];
%Nombre de bits générés
nb_bits=10000; 
%Génération de l'information binaire
bits=randi([0,1],1,nb_bits);
%Mapping binaire à moyenne nulle: 0->-1, 1->1
Symboles=2*bits-1;
%Générationde la suite de Diracs pondérés par les symboles (suréchantillonnage)
Diracs=[1 zeros(1,Ns-1)];
Suite_diracs=kron(Symboles,Diracs); 
%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns);
%Filtre de reception, à changer en fonction des exos
hr=h;
%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);

%Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
%Calcul de la DSP du signal par périodogramme
DSP_x2=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

%Implantation de la chaine de bruit et TEB
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        x=filter(h,1,Suite_diracs);
        Sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_dB(i)/10)); % ajout du bruit
        bruit=sqrt(Sigma2)*randn(1,nb_bits*Ns);
        signal_recu=x+bruit;
        signal_recu_filtre=filter(hr,1,signal_recu);
        signal_recu_filtre_echant=signal_recu_filtre(t0:Ns:end);
        symboles_estimes=sign(signal_recu_filtre_echant);
        bits_estimes=(symboles_estimes+1)/2;
        nb_erreurs=nb_erreurs+sum(bits_estimes~=bits);
        cpt=cpt+1;
    end
    TEB(i)=nb_erreurs/(cpt*nb_bits);
end

%% Deuxieme chaine : impact du choix de filtre de reception

%Filtre de reception
hr=ones(1,Ns);
hr(Ns/2+1:end)=0;
%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);
%Calcul de la DSP du signal par périodogramme
DSP_x2=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;

%Génaration du bruit
Sigma2=0; %sigma2 d'abord fixé à 0
bruit=sqrt(Sigma2)*randn(1,nb_bits*Ns);
signal_recu=x+bruit; %signal emis + bruit

%Passage du signal recu dans le filtre de reception
signal_recu_filtre = filter(hr,1,signal_recu);
figure(1); plot(signal_recu_filtre)
axis([0 nb_bits-1 -5 5]);
title('Chaine de transmission : Signal reçu filtré sans echantillonnage')

%Echantilonnage
z=signal_recu_filtre(t0:Ns:end);  %signal reçu echantillonné

%Diagramme de l'oeil  Changer Ns (mettre à 40) pour voir les changements
y=filter(h,1,Suite_diracs);
s_oeil = filter(hr,1,y);
z_oeil=reshape(s_oeil, Ns, nb_bits);
figure(2); plot(z_oeil)
title('Chaine de transmission : Diagramme de l oeil en sortie du filtre')

%Implantation de la chaine de bruit et TEB
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        x=filter(h,1,Suite_diracs);
        Sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_dB(i)/10)); % ajout du bruit
        bruit=sqrt(Sigma2)*randn(1,nb_bits*Ns);
        Signal_recu=x+bruit;
        signal_recu_filtre=filter(hr,1,Signal_recu);
        signal_recu_filtre_echant=signal_recu_filtre(t0:Ns:end);
        symboles_estimes=sign(signal_recu_filtre_echant);
        bits_estimes=(symboles_estimes+1)/2;
        nb_erreurs=nb_erreurs+sum(bits_estimes~=bits);
        cpt=cpt+1;
    end
    TEB2(i)=nb_erreurs/(cpt*nb_bits);
end

%Calcul de TEB théorique
TEB_theo=1-normcdf(sqrt(10.^(Eb_N0_dB/10)));
%Affichage des courbes
figure(3); hold on 
plot(Eb_N0_dB,10*log10(TEB2),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Chaine de transmission : Courbes des TEB théorique et numérique')
legend('TEB simulé','TEB théorique')

% Comparaison TEB de la chaine de transmission et de la chaine de référence
figure(4); hold on
plot(Eb_N0_dB,10*log10(TEB),'r')
plot(Eb_N0_dB,10*log10(TEB2),'b')
title('Courbes TEB')
legend('chaine de référence','chaine de transmission')

% Comparaion des efficacités spectrales de la chaine de transmission et de
% la chaine de référence pour un meme signal binaire.
figure(5);
subplot(2,1,1);
semilogy(linspace(0,1,length(DSP_x)), DSP_x,'r');
title('DSP de la chaîne de référence')
subplot(2,1,2);
semilogy(linspace(0,1,length(DSP_x2)), DSP_x2,'b');
title('DSP de la chaîne de transmission')