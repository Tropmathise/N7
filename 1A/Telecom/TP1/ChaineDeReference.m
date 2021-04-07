close all 
clear all

%% Chaine de référence

%Durée symbole en nombre d'échantillons (Ts=NsTe)
Ns=4; 
%M (binaire)
M=2;
%temps de départ d'échantillonnage
t0=Ns;
%Eb_N0_dB
Eb_N0_dB = [-2:6];
%Nombre de bits générés
nb_bits=1000; 
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

%Implantation de la chaine de bruit et TEB
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        Sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_dB(i)/10)); 
        bruit=sqrt(Sigma2)*randn(1,nb_bits*Ns);
        signal_recu=x+bruit;
        signal_recu_filtre=filter(hr,1,signal_recu); %Passage du signal recu dans le filtre de reception
        signal_recu_filtre_echant=signal_recu_filtre(t0:Ns:end);
        symboles_estimes=sign(signal_recu_filtre_echant);
        bits_estimes=(symboles_estimes+1)/2;
        nb_erreurs=nb_erreurs+sum(bits_estimes~=bits);
        cpt=cpt+1;
    end
    TEB(i)=nb_erreurs/(cpt*nb_bits);
end

%Affichage du signal généré
figure(1) ; plot(x); 
axis([0 nb_bits-1 -1.5 1.5]);
title('Chaine de référence : Signal émis')
%Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
%Affichage de la DSP du signal généré
figure(2); plot(linspace(0,1,length(DSP_x)), DSP_x);
title('Chaine de référence : DSP du signal')

%Affichage du signal bruité 
figure(3); plot(signal_recu);
axis([0 nb_bits-1 -1.5 1.5]);
title('Chaine de référence : Signal reçu avec bruit')

%Affichage du signal recu dans le filtre de reception
figure(4); plot(signal_recu_filtre)
axis([0 nb_bits-1 -5 5]);
title('Chaine de référence : Signal reçu filtré sans echantillonnage avec du bruit')

%Echantilonnage
signal_recu_filtre_sb=filter(hr,1,x); %Passage du signal recu dans le filtre de reception
signal_recu_filtre_echant_sb=signal_recu_filtre_sb(t0:Ns:end);
figure(5); plot (signal_recu_filtre_echant_sb)
axis([0 nb_bits-1 -5 5]);
title('Chaine de référence : Signal recu filtré et échantillonné sans bruit')

figure(6); plot (signal_recu_filtre_echant)
axis([0 nb_bits-1 -5 5]);
title('Chaine de référence : Signal recu filtré et échantillonné avec du bruit')

%Diagramme de l'oeil
s_oeil = filter(hr,1,x);
z_oeil=reshape(s_oeil(2*Ns+1:end), Ns, nb_bits-2);
figure(7); plot(z_oeil)
title("Chaine de référence : Diagramme de l'oeil en sortie du filtre")

%Decodage
decode=sign(signal_recu_filtre_echant); 
%figure(7); plot(decode)

%Calcul de TEB théorique
TEB_theo=1-normcdf(sqrt(2*10.^(Eb_N0_dB/10)));
%Affichage des courbes
figure(8); hold on 
plot(Eb_N0_dB,10*log10(TEB))
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Chaine de référence : Courbes des TEB théorique (rouge) et numérique (bleue)')
