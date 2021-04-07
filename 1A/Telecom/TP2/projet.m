% Projet TP2 transmission sur fréquence porteuse

clear all
close all
clc

% Initialisation
Nbits=15000; % Nombre de bits envoyes
M=4; % taille de la constellation
n=log2(M); % Nombre bits par symbole de la constellation (QPSK)
Fe=10000;
Rs=1000;
Rb=1000;
Ns=Fe/Rs; % Nombre d'echantillons par symboles
nfft=2^nextpow2(Nbits/n*Ns); % nombre de points de la fft
alphaSRRCF=0.35; % roll-off factor
retardTs=6; % longueur du filtre en nombre de periode symbole
h=rcosdesign(alphaSRRCF,retardTs,Ns);
h=h/norm(h);
hr=h; %filtre de reception
fp=2000;
fpN=fp/Fe;

%% Implantation de la chaine sur fréquence porteuse
% Emission
bits=randi([0 1],1,Nbits); % generation des bits
symbI=1-2*bits(1:2:Nbits); % generation des symboles de la voie I
symbQ=1-2*bits(2:2:Nbits); % generation des symboles de la voie Q
symboles=symbI+1i*symbQ;
peigne=zeros(1,Nbits/n*Ns);
peigne(1:Ns:Nbits/n*Ns)=symbI+1i*symbQ;
xe=filter(h,1,peigne);
x=real(exp(1i*2*pi*fpN*[1:Nbits/n*Ns]).*xe);

figure(1)
periodogram(xe,hamming(length(xe)),nfft)

figure(2)
periodogram(x,hamming(length(x)),nfft)

%retour en bande de base
x1 = sin(2*pi*fpN*[1:Nbits/n*Ns]).*x;
x2 = cos(2*pi*fpN*[1:Nbits/n*Ns]).*x;
z = x2 + -1i*x1;
%passage dans le filtre
signal_recu_filtre=filter(hr,1,z);
%echantillonnage
signal_ech=signal_recu_filtre(1:Ns:end);
%Decision
symb_reel=sign(real(signal_ech));
symb_compl=sign(imag(signal_ech));

%TESi 
TESi=mean(symb_reel(1+retardTs:end) ~= symbI(1:end-retardTs));
%TESq
TESq=mean(symb_compl(1+retardTs:end) ~= symbQ(1:end-retardTs));

%Demapping
bits_reel_trouves=(1-symb_reel)/2;
bits_compl_trouves=(1-symb_compl)/2;
bits_estimes=zeros(1,Nbits);
bits_estimes(1:2:Nbits) = bits_reel_trouves;
bits_estimes(2:2:Nbits) = bits_compl_trouves;
TEB_sans_bruit = mean(bits_estimes(1+n*retardTs:end)~=bits(1:end-n*retardTs));


%Eb_N0_dB
Eb_N0_dB = [-2:6];
t0=1;
%TEB
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        Pr=mean(abs(x).^2); % puissance du signal reçu
        Sigma2=Pr*Ns/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruit=sqrt(Sigma2)*randn(1,Nbits*Ns/n);
        signal_recu_b=x+bruit;
        x1 = sin(2*pi*fpN*[1:Nbits/n*Ns]).*signal_recu_b;
        x2 = cos(2*pi*fpN*[1:Nbits/n*Ns]).*signal_recu_b;
        z = x2 + -1i*x1;
        signal_recu_filtre_b=filter(hr,1,z); %Passage du signal recu dans le filtre de reception
        signal_recu_filtre_echant=signal_recu_filtre_b(t0:Ns:end);
        symb_reel_b=sign(real(signal_recu_filtre_echant));
        symb_compl_b=sign(imag(signal_recu_filtre_echant));
        bits_reel_trouves_b=(1-symb_reel_b)/2;
        bits_compl_trouves_b=(1-symb_compl_b)/2;
        bits_estimes_b=zeros(1,Nbits);
        bits_estimes_b(1:2:Nbits) = bits_reel_trouves_b;
        bits_estimes_b(2:2:Nbits) = bits_compl_trouves_b;
        nb_erreurs=nb_erreurs+sum(bits_estimes_b(1+n*retardTs:end)~=bits(1:end-n*retardTs));
        cpt=cpt+1;
    end
    TEB(i)=nb_erreurs/(cpt*Nbits);
end

%Calcul de TEB théorique
TEB_theo=1-normcdf(sqrt(2*10.^(Eb_N0_dB/10)));
%Affichage des courbes
figure(4); hold on 
plot(Eb_N0_dB,10*log10(TEB))
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Chaine sur fréquence porteuse : Courbes des TEB théorique et simulé')
legend('TEB sur fréquence porteuse', 'TEB théorique');

%% Implantation de la chaîne passe-bas équivalente
% Le bruit est complexe
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        Pr=mean(abs(xe).^2); % puissance du signal reçu
        Sigma2=Pr*Ns/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruitI=sqrt(Sigma2)*randn(1,Nbits*Ns/n);
        bruitQ=sqrt(Sigma2)*randn(1,Nbits*Ns/n);
        bruit=bruitI+1j*bruitQ;
        signal_recu_b=xe+bruit;
        signal_recu_filtre_b=filter(hr,1,signal_recu_b); %Passage du signal recu dans le filtre de reception
        signal_recu_filtre_echant=signal_recu_filtre_b(t0:Ns:end);
        symb_reel_b=sign(real(signal_recu_filtre_echant));
        symb_compl_b=sign(imag(signal_recu_filtre_echant));
        bits_reel_trouves_b=(1-symb_reel_b)/2;
        bits_compl_trouves_b=(1-symb_compl_b)/2;
        bits_estimes_b=zeros(1,Nbits);
        bits_estimes_b(1:2:Nbits) = bits_reel_trouves_b;
        bits_estimes_b(2:2:Nbits) = bits_compl_trouves_b;
        nb_erreurs=nb_erreurs+sum(bits_estimes_b(1+n*retardTs:end)~=bits(1:end-n*retardTs));
        cpt=cpt+1;
    end
    TEB_passe_bas(i)=nb_erreurs/(cpt*Nbits);
end

figure(5); hold on 
plot(Eb_N0_dB,10*log10(TEB))
plot(Eb_N0_dB,10*log10(TEB_passe_bas),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Comparaison TEB des deux chaînes')
legend('TEB chaîne fréquence porteuse', 'TEB chaîne passe-bas équivalent','TEB théorique')

% Constellation en sortie du mapping et en sortie de l'échantillonneur pour
% Eb/N0 = 6 dB
figure(6);
plot(signal_recu_filtre_echant, 'b+')
hold on
plot(symboles, 'r+')
title('Constellation pour Eb/N0 = 6')
legend("sortie de l'echantillonneur", 'sortie du mapping')

%% Comparaison de modulation sur fréquence porteuse

%% Modulation 4-ASK
M=4;
Rs=Rb/log2(M);
Ns_ask=Fe/Rs;
h=rcosdesign(alphaSRRCF,retardTs,Ns_ask);
h=h/norm(h);
hr=h; %filtre de reception
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        z=reshape(bits,log2(M),Nbits/log2(M))';
        y=bi2de(z,2);
        symboles_ask=qammod(y,M);
        peigne=zeros(1,Nbits/log2(M)*Ns_ask);
        peigne(1:Ns_ask:Nbits/log2(M)*Ns_ask)=symboles_ask;
        xe_ask=filter(h,1,peigne);
        Pr=mean(abs(xe_ask).^2); % puissance du signal reçu
        Sigma2=Pr*Ns_ask/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruitI=sqrt(Sigma2)*randn(1,Nbits*Ns_ask/log2(M));
        bruitQ=sqrt(Sigma2)*randn(1,Nbits*Ns_ask/log2(M));
        bruit=bruitI+1j*bruitQ;
        ask_b=xe_ask+bruit;
        recu=filter(hr,1,ask_b); %Passage du signal recu dans le filtre de reception
        echant=recu(t0:Ns_ask:end);
        ask_demodule=qamdemod(echant,M);
        signalask=de2bi(ask_demodule);
        signalask_r=reshape(signalask',1,Nbits);
        nb_erreurs=nb_erreurs+sum(signalask_r(1+log2(M)*retardTs:end)~=bits(1:end-log2(M)*retardTs));
        cpt=cpt+1;
    end
    TEB_ask(i)=nb_erreurs/(cpt*(Nbits-log2(M)*retardTs));
end

figure(7); hold on
plot(Eb_N0_dB,10*log10(TEB_ask),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Modulation 4-ASK : Courbes des TEB théorique et simulé')
legend('TEB sur fréquence porteuse', 'TEB théorique');
hold off


%Constellations confondues
figure(8);
plot(echant, 'b+')
hold on
plot(symboles_ask, 'r+')
title('4-ASK : Constellation pour Eb/N0 = 6')
legend("sortie de l'echantillonneur", 'sortie du mapping')

%% Modulation QPSK
M=4;
Rs_qpsk=Rb/log2(M);
Ns_qpsk=Fe/Rs_qpsk;
h=rcosdesign(alphaSRRCF,retardTs,Ns_qpsk);
h=h/norm(h);
hr=h; %filtre de reception
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        z=reshape(bits,2,Nbits/2)';
        y=bi2de(z,2);
        symboles_qpsk=pskmod(y,M,pi/M);
        peigne=zeros(1,Nbits/log2(M)*Ns_qpsk);
        peigne(1:Ns_qpsk:Nbits/log2(M)*Ns_qpsk)=symboles_qpsk;
        xe_qpsk=filter(h,1,peigne);
        Pr=mean(abs(xe_qpsk).^2); % puissance du signal reçu
        Sigma2=Pr*Ns_qpsk/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruitI=sqrt(Sigma2)*randn(1,Nbits*Ns_qpsk/log2(M));
        bruitQ=sqrt(Sigma2)*randn(1,Nbits*Ns_qpsk/log2(M));
        bruit=bruitI+1j*bruitQ;
        qpsk_b=xe_qpsk+bruit;
        recu=filter(hr,1,qpsk_b); %Passage du signal recu dans le filtre de reception
        echant=recu(t0:Ns_qpsk:end);
        qpsk_demodule=pskdemod(echant,M,pi/M);
        signalqpsk=de2bi(qpsk_demodule);
        signalqpsk_r=reshape(signalqpsk',1,Nbits);
        nb_erreurs=nb_erreurs+sum(signalqpsk_r(1+log2(M)*retardTs:end)~=bits(1:end-log2(M)*retardTs));
        cpt=cpt+1;
    end
    TEB_qpsk(i)=nb_erreurs/(cpt*(Nbits-log2(M)*retardTs));
end

figure(9); hold on
plot(Eb_N0_dB,10*log10(TEB_qpsk),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Modulation QPSK : Courbes des TEB théorique et simulé')
legend('TEB sur fréquence porteuse', 'TEB théorique');
hold off;


%Constellations confondues
figure(10);
plot(echant, 'b+')
hold on
plot(symboles_qpsk, 'r+')
title('QPSK : Constellation pour Eb/N0 = 6')
legend("sortie de l'echantillonneur", 'sortie du mapping')


%% Modulation 8-PSK
M=8;
Rs=Rb/log2(M);
Ns_psk=Fe/Rs;
h=rcosdesign(alphaSRRCF,retardTs,Ns_psk);
h=h/norm(h);
hr=h; %filtre de reception
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        z=reshape(bits,3,Nbits/3)';
        y=bi2de(z,2);
        symboles_psk=pskmod(y,M,pi/M);
        peigne=zeros(1,Nbits/log2(M)*Ns_psk);
        peigne(1:Ns_psk:Nbits/log2(M)*Ns_psk)=symboles_psk;
        xe_psk=filter(h,1,peigne);
        Pr=mean(abs(xe_psk).^2); % puissance du signal reçu
        Sigma2=Pr*Ns_psk/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruitI=sqrt(Sigma2)*randn(1,Nbits*Ns_psk/log2(M));
        bruitQ=sqrt(Sigma2)*randn(1,Nbits*Ns_psk/log2(M));
        bruit=bruitI+1j*bruitQ;
        psk_b=xe_psk+bruit;
        recu=filter(hr,1,psk_b); %Passage du signal recu dans le filtre de reception
        echant=recu(t0:Ns_psk:end);
        psk_demodule=pskdemod(echant,M,pi/M);
        signalpsk=de2bi(psk_demodule);
        signalpsk_r=reshape(signalpsk',1,Nbits);
        nb_erreurs=nb_erreurs+sum(signalpsk_r(1+log2(M)*retardTs:end)~=bits(1:end-log2(M)*retardTs));
        cpt=cpt+1;
    end
    TEB_psk(i)=nb_erreurs/(cpt*(Nbits-log2(M)*retardTs));
end

figure(11); hold on
plot(Eb_N0_dB,10*log10(TEB_psk),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Modulation 8-PSK : Courbes des TEB théorique et simulé')
legend('TEB sur fréquence porteuse', 'TEB théorique');
hold off


%Constellations confondues
figure(12);
plot(echant, 'b+')
hold on
plot(symboles_psk, 'r+')
hold off
title('8-PSK : Constellation pour Eb/N0 = 6')
legend("sortie de l'echantillonneur", 'sortie du mapping')

%% Modulation 16-QAM
M=16;
Rs=Rb/log2(M);
Ns_qam=Fe/Rs;
h=rcosdesign(alphaSRRCF,retardTs,Ns_qam);
h=h/norm(h);
hr=h; %filtre de reception
for i=1:length(Eb_N0_dB)
    nb_erreurs=0;
    cpt=0; %compteur 
    while nb_erreurs<100
        % Ajout du bruit
        z=reshape(bits,log2(M),Nbits/log2(M))';
        y=bi2de(z,2);
        symboles_qam=qammod(y,M);
        peigne=zeros(1,Nbits/log2(M)*Ns_qam);
        peigne(1:Ns_qam:Nbits/log2(M)*Ns_qam)=symboles_qam;
        xe_qam=filter(h,1,peigne);
        Pr=mean(abs(xe_qam).^2); % puissance du signal reçu
        Sigma2=Pr*Ns_qam/(2*log2(M)*10^(Eb_N0_dB(i)/10)); % puissance du bruit
        bruitI=sqrt(Sigma2)*randn(1,Nbits*Ns_qam/log2(M));
        bruitQ=sqrt(Sigma2)*randn(1,Nbits*Ns_qam/log2(M));
        bruit=bruitI+1j*bruitQ;
        qam_b=xe_qam+bruit;
        recu=filter(hr,1,qam_b); %Passage du signal recu dans le filtre de reception
        echant=recu(t0:Ns_qam:end);
        qam_demodule=qamdemod(echant,M);
        signalqam=de2bi(qam_demodule);
        signalqam_r=reshape(signalqam',1,Nbits);
        nb_erreurs=nb_erreurs+sum(signalqam_r(1+log2(M)*retardTs:end)~=bits(1:end-log2(M)*retardTs));
        cpt=cpt+1;
    end
    TEB_qam(i)=nb_erreurs/(cpt*(Nbits-log2(M)*retardTs));
end

figure(13); hold on
plot(Eb_N0_dB,10*log10(TEB_qam),'b')
plot(Eb_N0_dB,10*log10(TEB_theo),'r')
title('Modulation 16-QAM : Courbes des TEB théorique et simulé')
legend('TEB sur fréquence porteuse', 'TEB théorique');
hold off

%Constellations confondues
figure(14);
plot(echant, 'b+')
hold on
plot(symboles_qam, 'r+')
hold off
title('16-QAM : Constellation pour Eb/N0 = 6')
legend("sortie de l'echantillonneur", 'sortie du mapping')

%% Comparaison des TEB

figure(15)
hold on
plot(Eb_N0_dB,10*log10(TEB_theo))
plot(Eb_N0_dB,10*log10(TEB_ask))
plot(Eb_N0_dB,10*log10(TEB_qpsk))
plot(Eb_N0_dB,10*log10(TEB_psk))
plot(Eb_N0_dB,10*log10(TEB_qam))
hold off
title('Comparaison des TEB pour les différentes modulations')
legend('TEB théorique', 'TEB simulé 4-ASK', 'TEB simulé QPSK', 'TEB simulé 8-PSK', 'TEB simulé 16-QAM');

%% Comparaison des DSPs pour un même débit binaire Rb.

DSP_x_ask=(1/length(xe_ask))*abs(fft(xe_ask,2^nextpow2(length(xe_ask)))).^2;
DSP_x_qpsk=(1/length(xe_qpsk))*abs(fft(xe_qpsk,2^nextpow2(length(xe_qpsk)))).^2;
DSP_x_psk=(1/length(xe_psk))*abs(fft(xe_psk,2^nextpow2(length(xe_psk)))).^2;
DSP_x_qam=(1/length(xe_qam))*abs(fft(xe_qam,2^nextpow2(length(xe_qam)))).^2;

%Affichage de la DSP du signal généré
figure(16)
hold on
plot(linspace(0,1,length(DSP_x_ask)), DSP_x_ask);
plot(linspace(0,1,length(DSP_x_qpsk)), DSP_x_qpsk);
plot(linspace(0,1,length(DSP_x_psk)), DSP_x_psk);
plot(linspace(0,1,length(DSP_x_qam)), DSP_x_qam);
hold off
title('DSP des signaux pour les différentes modulations')
legend('DSP simulé 4-ASK', 'DSP simulé QPSK', 'DSP simulé 8-PSK', 'DSP simulé 16-QAM');

%% Scatterplot des modulations (en fin de code pour un affichage correct)

% Constellations en sortie du mapping
scatterplot(symboles_ask);
scatterplot(symboles_qpsk);
scatterplot(symboles_psk);
scatterplot(symboles_qam);


