% QPSK 1en bande transposee

clear all
close all
clc

% Initialisation
Nbits=1000; % Nombre de bits envoyes
M=4 % taille de la constellation
n=log2(M); % Nombre bits par symbole de la constellation (QPSK)
Fe=10000;
Rs=1000;
Ns=Fe/Rs; % Nombre d'echantillons par symboles
nfft=2^nextpow2(Nbits/n*Ns); % nombre de points de la fft
alphaSRRCF=0.35; % roll-off factor
retardTs=6; % longueur du filtre en nombre de periode symbole
h=rcosdesign(alphaSRRCF,retardTs,Ns);
fp=2000;
fpN=fp/Fe;

% Emission
bits=randi([0 1],1,Nbits); % generation des bits
symbI=1-2*bits(1:2:Nbits); % generation des symboles de la voie I
symbQ=1-2*bits(2:2:Nbits); % generation des symboles de la voie Q
peigne=zeros(1,Nbits/n*Ns);
peigne(1:Ns:Nbits/n*Ns)=symbI+1i*symbQ;
xe=filter(h,1,peigne);
x=real(exp(1i*2*pi*fpN*[1:Nbits/n*Ns]).*xe);


figure
periodogram(xe,hamming(length(xe)),nfft)

figure
periodogram(x,hamming(length(x)),nfft)


%TESi 
TESi=mean(symb_reel(1+retardTs:end) ~= symbI(1:end-retardTs));
%TESq
TESq=mean(symb_compl(1+retardTs*2:end) ~= symbQ(1:end-retardTs));
%TES
TES = TESi+TESq -TESi*TESq;