close all 
clear all
load donnees1.mat
load donnees2.mat

% Déclaration des données
T=0.04;
Fe=128000;
Te=1/Fe;
N=length(bits_utilisateur1);
Ts=T/N; %Nombre d'echantillons par bit separés par Te
Ns=Ts/Te;
fp1=0;
fp2=46000;
temps_total=5*T;
N_tot=N*Ns*5;

% Implantation 
% Question 2
m1=kron(2*bits_utilisateur1-1,ones(1,Ns));
m2=kron(2*bits_utilisateur2-1,ones(1,Ns));
temps=[1:length(m1)]/Fe;
figure(1); subplot(2,1,1); plot(temps, m1);
title('Figure 1.1 : m1(t)')
ylim([-1.1 1.1]);
ylabel('m1(t)')
xlabel('temps (s)')
figure(1); subplot(2,1,2); plot(temps,m2);
ylim([-1.1 1.1]);
title('Figure 1.2 : m2(t)')
ylabel('m2(t)')
xlabel('temps (s)')

% Question 3  Densité spectrale de puissance de m1 et m2
f1=fft(m1);
Sx=(abs(f1).^2)/N;
figure(2); subplot(2,1,1); plot(linspace(0,Fe,length(Sx)), fftshift(Sx));
title('Figure 2.1 : DSP de m1')
xlabel('Fréquence (Hz)')
ylabel('DSP')

f2=fft(m2);
Sx2=(abs(f2).^2)/N;
figure(2); subplot(2,1,2); plot(linspace(0,Fe,length(Sx2)), fftshift(Sx2));
title('Figure 2.2 : DSP de m2')
xlabel('Fréquence (Hz)')
ylabel('DSP')


% Construction du signal MF-TDMA

% message brut
slot_vide=zeros(1,N*Ns);
t=[0:Te:temps_total-Te];
figure(3); subplot(3,1,1); plot(t,[slot_vide m1 slot_vide slot_vide m2]);
ylim([-1.1 1.1]);
title('Figure 3.1 : m(t)')
ylabel('m(t)')
xlabel('temps (s)')

% signal non bruité
slot_vide=zeros(1,N*Ns);
slot_m1=m1;
c2=cos(2*pi*fp2*temps+2*pi*rand);
slot_m2=m2.*c2;
x=[slot_vide slot_m1 slot_vide slot_vide slot_m2];
figure(3); subplot(3,1,2); plot(t,x);
ylim([-1.1 1.1]);
title('Figure 3.2 : x(t) sans bruit')
ylabel('x(t)')
xlabel('temps (s)')

% signal bruité
PS=mean(abs(x).^2); %puissance du signal x
SNR_db=100; %rapport de puissance signal/bruit souhaité
PB= PS*10^(-SNR_db/10); % Puissance du bruit à ajouter
sigma=sqrt(PB); %amplitude maximale du bruit
bruit=sigma*randn(1,N_tot); 
x=x+bruit; %x bruité
figure(3); subplot(3,1,3); plot(t,x);
ylim([-1.5 1.5]);
title('Figure 3.3 : x(t) avec bruit')
ylabel('x(t) bruité')
xlabel('temps (s)')

% Question 3
X=fft(x);
dsp_signal=(abs(X).^2)/(N_tot);
figure(4); plot(linspace(0,Fe,length(dsp_signal)), fftshift(dsp_signal));
title('Figure 4 : DSP du signal MF-TDMA')
ylabel('DSP')
xlabel('Fréquence (Hz)')

% Mise en place du recepteur MF-TDMA

% Démultpilexage des porteuses

% Synthèse du filtre passe-bas

N201=100; % Ordre 201
k=[-N201:N201];
fc=30000; % fréquence de coupure choisie
h_bas=2*Te*fc*sinc(2*fc*Te*k); % réponse impulsionnelle
H_bas=fft(h_bas); % réponse en fréquence

% Affichage pour le filtre passe-bas
figure(5); subplot(2,1,1); plot(k,h_bas)
title('Figure 5 : réponse impulsionnelle du filtre passe-bas')
ylabel('Filtre passe-bas')
xlabel('Fréquence (Hz)')
figure(5); subplot(2,1,2); plot(linspace(-Fe/2,Fe/2,length(H_bas)),fftshift(H_bas));
title('Figure 5 : réponse en fréquence du filtre passe-bas')
ylabel('Filtre passe-bas')
xlabel('Fréquence (Hz)')

mod_filtre_bas=abs(H_bas);
figure(6); plot(linspace(-Fe/2,Fe/2,length(dsp_signal)), fftshift(dsp_signal));
hold on 
plot(linspace(-Fe/2,Fe/2,length(mod_filtre_bas)),55*fftshift(mod_filtre_bas));
title('Figure 6 : densité spectrale de puissance et module de la réponse en fréquence du filtre passe-bas')
xlabel('Fréquence (Hz)')

message_bas=conv(x,h_bas,'same');
figure(7); plot(t,message_bas);
title('Figure 7 : Message filtré avec un filtre passe-bas')
xlabel('temps(s)')

% Synthese du filtre passe-haut 

dirac=zeros(1,length(k));
dirac(N201+1)=1;
h_haut=dirac-h_bas; % réponse impulsionnelle du filtre passe-haut
H_haut=fft(h_haut); % réponse en fréquence du filtre passe-haut

% Affichage pour le filtre passe-haut
figure(8); subplot(2,1,1); plot(k,h_haut)
title('Figure 8 : réponse impulsionnelle du filtre passe-haut')
ylabel('Filtre passe-haut')
xlabel('Fréquence (Hz)')
figure(8); subplot(2,1,2); plot(linspace(-Fe/2,Fe/2,length(H_haut)),fftshift(H_haut));
title('Figure 8 : réponse en fréquence du filtre passe-haut')
ylabel('Filtre passe-haut')
xlabel('Fréquence (Hz)')

mod_filtre_haut=abs(H_haut);
figure(9); plot(linspace(-Fe/2,Fe/2,length(dsp_signal)), fftshift(dsp_signal));
hold on 
plot(linspace(-Fe/2,Fe/2,length(mod_filtre_haut)),20*fftshift(mod_filtre_haut));
title('Figure 9 : densité spectrale de puissance et module de la réponse en fréquence du filtre passe-haut')
xlabel('Fréquence (Hz)')

message_haut=conv(x,h_haut,'same'); 
figure(10); plot(t,message_haut);
title('Figure 10 : Message filtré avec un filtre passe-haut')
xlabel('temps(s)')

% Retour en bande de base 

message_haut=message_haut.*[c2 c2 c2 c2 c2]; % retour en bande de base sur chacun des slots séparemment
message_haut=conv(message_haut,h_bas,'same'); % passage par le filtre passe-bas


% Récupération et restitution des messages

% message 1 (basses fréquences)

max=[0 0];
for i=0:4
    if mean(abs(message_bas(i*N*Ns+1:(i+1)*N*Ns)))>max(1) % moyenne de la valeur absolue di signal 
        max=[mean(abs(message_bas(i*N*Ns+1:(i+1)*N*Ns))) i]; % récupération du maximum
    end
end
% Démodulation du premier message
x1_detecte=message_bas(max(2)*N*Ns+1:(max(2)+1)*N*Ns);
SignalFiltre_bas=conv(x1_detecte,ones(1,Ns),'same');
SignalEchantillonne_bas=SignalFiltre_bas(1:Ns:end);
BitsRecuperes_bas=(sign(SignalEchantillonne_bas)+1)/2;

% message 2 (hautes fréquences)

max=[0 0];
for i=0:4
    if mean(abs(message_haut(i*N*Ns+1:(i+1)*N*Ns)))>max(1)  % moyenne de la valeur absolue du signal
        max=[mean(abs(message_haut(i*N*Ns+1:(i+1)*N*Ns))) i]; % récupération du maximum
    end
end
% Démodulation du deuxième message
x2_detecte=message_haut(max(2)*N*Ns+1:(max(2)+1)*N*Ns);
SignalFiltre_haut=conv(x2_detecte,ones(1,Ns),'same');
SignalEchantillonne_haut=SignalFiltre_haut(1:Ns:end);
BitsRecuperes_haut=(sign(SignalEchantillonne_haut)+1)/2;

bin2str(BitsRecuperes_bas)
bin2str(BitsRecuperes_haut)

