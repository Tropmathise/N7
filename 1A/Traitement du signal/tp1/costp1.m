close all 
clear all

% Q5.2.1 : premier cosinus
t_echant=90; %nombre d'echantillons
f0=1100; %frequence du cosinus
Fe=10000; %frequence échantillonnage
Te=1/Fe; %Periode d'échantillonnage 
x=cos(2*pi*f0*[0:Te:(t_echant-1)*Te]);
subplot(2,1,1)
figure(1); plot([0:Te:(t_echant-1)*Te],x)
title('Figure1')
xlabel('temps(s)')
ylabel('cosinus')

% Q5.2.3 : deuxieme cosinus
t_echant2=90; %nombre d'echantillons
f0=1100; %frequence du cosinus
Fe2=1000; %frequence échantillonnage
Te2=1/Fe2; %Periode d'échantillonnage 
x2=cos(2*pi*f0*[0:Te2:(t_echant2-1)*Te2]);
figure(1); subplot(2,1,2)
plot([0:Te2:(t_echant2-1)*Te2],x2)
title('Figure2')
xlabel('temps(s)')
ylabel('cosinus')

%Question 5.3.2a
X=fft(x);
figure(2); subplot(2,1,1); semilogy(linspace(-Fe/2,Fe/2,length(X)),fftshift(abs(X)));
title('Question 5.3.2a')
xlabel('fréquence (Hz)')
ylabel('|X(f)|')

%Question 5.3.2b
X2=fft(x2);
figure(2); subplot(2,1,2); semilogy(linspace(-Fe2/2,Fe2/2,length(X2)),fftshift(abs(X2)));
title('Question 5.3.2b')
ylabel('|X(f)|')
xlabel('fréquence (Hz)')

%Question 4 Zero Padding
X3=fft(x,2^nextpow2(length(x)));
figure(3); subplot(3,1,1); semilogy(linspace(-Fe/2,Fe/2,length(X3)),fftshift(abs(X3)));
title('Figure 5 : N=128')
ylabel('|X(f)|')
xlabel('fréquence (Hz)')

X4=fft(x,2^(nextpow2(length(x))+1));
figure(3); subplot(3,1,2); semilogy(linspace(-Fe/2,Fe/2,length(X4)),fftshift(abs(X4)));
title('Figure 6.1 : N=256')
ylabel('|X(f)|')
xlabel('fréquence (Hz)')

X5=fft(x,2^(nextpow2(length(x))+4));
figure(3); subplot(3,1,3); semilogy(linspace(-Fe/2,Fe/2,length(X5)),fftshift(abs(X5)));
title('Figure 6.2 : N=2048')
ylabel('|X(f)|')
xlabel('fréquence (Hz)')

%Question 5.4.1
f0=1100;
Fe=10000;
Te=1/Fe;
N=90;
X=[0:1:(N-1)];
T=X/Fe;
x=cos(2*pi*(f0*T +rand));

%Question 5.4.2
X6=fft(x, 2^nextpow2(length(x))); %avec Zero Padding
Sx=(abs(X6).^2)/N;    %utilisation d'un périodogramme sans fenetrage
figure(4); plot(linspace(-Fe/2,Fe/2,length(Sx)),fftshift(Sx));
title('Figure 7')
ylabel('Sx')
xlabel('fréquence (Hz)')

% Question 5.4.3 périodogramme avec fenêtrage Hamming/Blackman
w=hamming(length(x));
X7=abs(fft(x'.*w))/N;
figure(5); subplot(2,1,1); plot(linspace(-Fe/2,Fe/2,length(X7)),fftshift(X7));
title('Figure 8.a : Fenetre de Hamming')
ylabel('DSP')
xlabel('fréquence (Hz)')

b=blackman(length(x));
X8=abs(fft(x'.*b))/N;
figure(5); subplot(2,1,2); plot(linspace(-Fe/2,Fe/2,length(X8)), fftshift(X8));
title('Figure 8.b : Fenetre de Blackman')
ylabel('DSP')
xlabel('fréquence (Hz)')

%Question 5.4.4
DSPx=pwelch(x,[],[],[],'twosided');
figure(6); plot(linspace(-Fe/2, Fe/2, length(DSPx)),fftshift(DSPx));
title('Figure9 périodogramme de Welch')
ylabel('DSPx')
xlabel('fréquence (Hz)')





