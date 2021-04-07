%% Quatrième chaine : impact du choix du mapping
clear;
close all;

%nombre de bits générés
nb_bits=10000;
%Génération de l?information binaire
bits=randi([0,1],1,nb_bits);
%Durée symbole en nombre d?échantillons (Ts=NsTe)
Ns=4;
Ts=2*Ns;
%M-Aire
M=4;
%Eb_N0_dB
Eb_N0_dB = (-2:6);
%Générationde la suite de Diracs pondérés par les symboles (suréchantillonnage)
Diracs=[1 zeros(1,Ts-1)];
Symboles = (2*bi2de(reshape(bits,2,length(bits)/2).')-3).';
Suite_diracs=kron(Symboles,Diracs); 

%Génération de la réponse impulsionnelle
h=ones(1,2*Ns);
h=h/norm(h);
hr=h;
%temps de départ d'échantillonnage
t0=Ts;
%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);

for i=1:length(Eb_N0_dB)
    nb_erreur_bit=0;
    nb_erreur_symb=0;
    cpt=0;
    while nb_erreur_bit<100
        Sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_dB(i)/10)); % ajout du bruit
        bruit=sqrt(Sigma2)*randn(1,nb_bits*Ts/2);
        Signal_recu=x+bruit;
        Signal_recu_filtre=filter(hr,1,Signal_recu);
        Signal_echant=Signal_recu_filtre(t0:Ts:end);
        moins3=Signal_echant<2;
        moins1=Signal_echant>-2 & Signal_echant<0;
        plus1=Signal_echant<2 & Signal_echant>0;
        plus3=Signal_echant>2;
        symboles_estimes=zeros(1,length(Signal_echant));
        symboles_estimes(moins3)=-3;
        symboles_estimes(moins1)=-1;
        symboles_estimes(plus1)=1;
        symboles_estimes(plus3)=3;
        bits_estimes=reshape(de2bi((symboles_estimes+3)/2).',1,length(bits));
        nb_erreur_symb=nb_erreur_symb+sum(symboles_estimes~=Symboles);
        nb_erreur_bit=nb_erreur_bit+sum(bits_estimes~=bits);
        cpt=cpt+1;
    end
    TEB(i)=nb_erreur_bit/(cpt*nb_bits);
    TES(i)=nb_erreur_symb/(cpt*nb_bits/2);
end

%Affichage du signal généré
figure(1) ; plot(x); 
axis([0 length(x) -4 4]);
title("Signal en sortie du filtre d'émission et échantillonné")
%Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
%Affichage de la DSP du signal généré
figure(2); plot(linspace(0,1,length(DSP_x)), DSP_x);
title('DSP du signal')

%DSP chaine de référence
SymbolesRef=2*bits-1;
Suite_diracsRef=kron(SymbolesRef,Diracs); 
xref=filter(h,1,Suite_diracsRef);
DSP_xref=(1/length(xref))*abs(fft(xref,2^nextpow2(length(xref)))).^2;

%Comparaison des DSP
figure(3); plot(linspace(0,1,length(DSP_x)), DSP_x,'b');
hold on
plot(linspace(0,1,length(DSP_xref)), DSP_xref,'r');
legend('DSP','DSP dela chaiîne de référence')
title('Comparaison : DSP du signal de référence et de la chaine 4')

%Diagramme de l'oeil
hr=ones(1,Ns);
s_oeil = filter(hr,1,x);
z_oeil=reshape(s_oeil, 2*Ns, nb_bits/2);
figure(4); plot(z_oeil)
axis([1 Ns -5 5]);
title('Diagramme de l oeil en sortie du filtre')

TES_theo=(2*(M-1)/M)*(1-normcdf(sqrt((6*log2(M)/(M*M-1))*10.^(Eb_N0_dB/10)))); %on rappelle que M=4
%Affichage des courbes

%TES
figure(5); hold on
plot(Eb_N0_dB,10*log10(TES),'b')
plot(Eb_N0_dB,10*log10(TES_theo),'r')
legend('TES simulé','TES théorique')
title('Chaine de transmission : Courbes des TES théorique et simulé')

% TEB
figure(6); hold on;
TEB_th=TES_theo/2;
plot(Eb_N0_dB,10*log10(TEB),'b')
plot(Eb_N0_dB,10*log10(TEB_th),'r')
legend('TEB simulé','TEB théorique')
title('Chaine de transmission : Courbes des TEB théorique et simulé')