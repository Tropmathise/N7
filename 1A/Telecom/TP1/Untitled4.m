close all;
clear;
%Eb_N0_dB
Eb_N0_dB = [0:6];
%Calcul de TEB théorique
TEB_theo=1-normcdf(sqrt(2*10.^(Eb_N0_dB/10)));
%Affichage des courbes
figure(1);
plot(Eb_N0_dB,10*log10(TEB_theo),'r')