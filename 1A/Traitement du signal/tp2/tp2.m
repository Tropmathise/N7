close all
clear all

%Question 8.3.1.a
Nb=10;
bits=randi([0,1],1,Nb);
Fe=1000;
f0=200;
Ns=20;
Te=1/Fe;
Ts=Ns*Te;

%Question 8.3.1.b
m=kron(2*bits-1,ones(1,Ns));

%Question 8.3.1.c
figure(1); plot(linspace(0,4*Ts, length(m)),m);
title('Figure 1')
xlabel('t')
ylabel('m(t)')

%Question 8.3.1.d
f=fft(m);
figure(2); plot(linspace(0,Fe,length(f)), fftshift(abs(f)));
title('Figure 2')
xlabel('Frequence (Hz)')
ylabel('|X(f)|')

%Question 8.3.2.a
t_p=(1:length(m))/Fe;
c=cos(2*pi*f0*t_p);
x=c.*m;

%Question 8.3.2.b
X=fft(x);
figure(3); plot(linspace(0,Fe,length(X)), fftshift(abs(X)));
title('Figure 3')
xlabel('Frequence (Hz)')
ylabel('|X(f)|')

%Question 8.4.1
sig=c.*x;
SIG=fft(sig);
figure(4); plot(linspace(0,Fe,length(SIG)), fftshift(abs(SIG)));
title('Figure 4')
xlabel('Frequence (Hz)')
ylabel('|X(SIG)|')

%Question 8.4.3.a
N=100;
k=[-N:N];
h=2*Te*f0*sinc(2*f0*Te*k); %réponse impulsionnelle
figure(5);plot(k,h);
title('Figure 5')
xlabel('k')
ylabel('h(k)')

%Question 8.4.3.b
H=fft(h); %réponse en fréquence 
figure(6); plot(linspace(0,Fe,length(H)),fftshift(abs(H)));  %on obtient bien un filtre passe bas
title('Figure 6')
xlabel('fréquence(Hz)')
ylabel('H(k)')

%Question 8.4.3.c  Differents ordres pour les réponses impulsionnelles et
%en fréquence
N21=10;
N61=30;
k21=[-N21*Te:Te:N21*Te];
k61=[-N61*Te:Te:N61*Te];
h21=2*Te*f0*sinc(2*f0*Te*k21);
h61=2*Te*f0*sinc(2*f0*Te*k61);
H21=fft(h21);
H61=fft(h61);
figure(7); subplot(2,1,1); plot(k21,h21);
title('Figure 7.a')
xlabel('k21')
ylabel('h(k21)')
figure(7); subplot(2,1,2); plot(k61,h61);
title('Figure 7.b')
xlabel('k61')
ylabel('h(k61)')
figure(8); subplot(2,1,1); plot(linspace(0,Fe,length(H21)),fftshift(abs(H21)));
title('Figure 8.a')
xlabel('fréquence(Hz)')
ylabel('H(k21)')
figure(8); subplot(2,1,2); plot(linspace(0,Fe,length(H61)),fftshift(abs(H61)));
title('Figure 8.b')
xlabel('fréquence(Hz)')
ylabel('H(k61)')

%Question 8.4.3.d je choisis un ordre de 21
r=rectwin(length(h21));
b=blackman(length(h21));
figure(9); subplot(2,1,1); plot(k21,h21'.*r);
title('Figure 9.a: Fenetre rectangulaire')
xlabel('k21')
ylabel('h(k21)')
figure(9); subplot(2,1,2); plot(k21,h21'.*b);
title('Figure 9.a: Fenetre de blackman')
xlabel('k21')
ylabel('h(k21)')
H21b=fft(h21'.*b);
H21r=fft(h21'.*r);
figure(10); subplot(2,1,1); plot(linspace(0,Fe,length(H21r)),fftshift(abs(H21r)));
title('Figure 10.a: Fenetre rectangulaire')
xlabel('fréquence(Hz)')
ylabel('H(k21)')
figure(10); subplot(2,1,2); plot(linspace(0,Fe,length(H21b)),fftshift(abs(H21b)));
title('Figure 10.a: Fenetre de blackman')
xlabel('fréquence(Hz)')
ylabel('H(k21)')

%Question 8.4.3.e je choisis l'ordre 7 et la fenetre de troncature de
%blackman
N7=3;
k7=[-N21*Te:Te:N21*Te];
h7=Te*f0*sinc(2*f0*Te*k7); %réponse impulsionnelle
H7=fft(h7);
tronc=blackman(length(sig));
Y=fft(tronc'.*sig);
Ynormalise=(1/max(abs(Y)))*abs(Y);
H21Normalise=(1/max(abs(H7)))*abs(H7);
figure(11); plot(linspace(0,Fe,length(Ynormalise)),fftshift(abs(Ynormalise)),'r');
hold on
plot(linspace(0,Fe,length(H21Normalise)), fftshift(abs(H21Normalise)));
ylim([-1.2 1.2]);

%Question 8.4.3.f
j=conv(sig,h7,'same');

%Question 8.4.3.g
figure(12); plot(t_p,j,'r');
hold on 
plot(t_p,m);