% Script de mise en place d'une chaîne de communication sur fréquence
% porteuse
close all;

%%Affichage du TEB réel
longueurTest = 500;
TEBs = zeros(1, longueurTest);
TEBths = zeros(1, longueurTest);
[~, oeil] = comm(inf, 1);
for i=1:longueurTest
    [TEBs(i), ~] = comm((i) * 6 / longueurTest, 0);
    TEBths(i) = 1 - normcdf(sqrt(2 * 10^((i-1) * 6 / longueurTest / 10)));
end
figure;
set(gcf, 'name', 'Tracé des TEB théorique et expérimental')
title("Tracé des TEB théorique et expérimental")
semilogy((0:longueurTest - 1) * 6 / longueurTest, TEBs, (0:longueurTest - 1) * 6 / longueurTest, TEBths);
legend('TEBs simulés', 'TEBs théoriques');
grid on;
%% Affichages

Te = 10^-3 *10^4;
eyediagram(oeil, Te * 2);


%% Chaîne de communication 1
function [ TEB, oeil ] = comm( Eb_N0_db, affichage)


%% Initialisation variables
longueurMessage = 1000;
erreur = 0;
passages = 0;
fp = 2*10^3;
fe = 10^4;
rs = 10^3; %débit symbole
Ts = 1/rs; %durée symbole

pointsSymbole = 2 * fe * Ts;
Te = Ts * fe;
Tb = Ts/pointsSymbole; %durée bit
temps =  0: 1 / fe : Ts * longueurMessage / 2 - 1 / fe;
%temps = (0:Tb: Tb * longueurMessage * pointsSymbole - Tb);
while erreur < 50

    %% Génération de l'information binaire à transmettre
    
    message = randi([0,1],1,longueurMessage);
    
    messageColonne = reshape(message, [longueurMessage/2 2]);
    
    messageDecimal = bi2de(messageColonne);
    
    symboles = transpose(pskmod(messageDecimal, 4, pi/4, 'gray'));
    
    %% suréchantillonage
    
    surechant = kron(symboles,[1 zeros(1, Te - 1)]);
    
    %% Filtrage de mise en forme
    
    %h = rcosdesign(0.35, 2 * fe * Ts, pointsSymbole);
    h = rcosdesign(0.35, 8, Ts * fe, 'sqrt');
    retard = 8 *(Ts * fe) / 2;
    %Expliquer
    signal = filter(h, 1, cat(2, surechant, zeros(1, retard)));
    signal = signal(retard + 1 : end);
    %signal = filter(h, 1, cat(2, surechant, zeros(1,pointsSymbole/2)));
    %signal = signal(pointsSymbole/2 + 1 :end);
    
    %% Transposition de fréquence
    
    expo = exp(1i*2*pi*fp*temps);
    signal = real(signal .*expo);
    
    %%Tracé de la DSP et de la puissance
    if( affichage == 1)
        
        xcor = xcorr(signal, 'biased');
        DSP = real(fft(xcor));
        milieu = (length(xcor)-1)/2;
        xcor = [xcor(milieu:end) xcor(1:milieu-1)];
        figure;
        set(gcf, 'name', 'Signal transposé sur fréquence porteuse')
        title("Signal transposé sur fréquence porteuse");
        plot(temps, signal);
        figure;
        set(gcf, 'name', 'Densite spectrale du signal transposé sur fréquence porteuse')
        title("Densite spectrale du signal");
        plot(linspace(-fe/2, fe/2, length(xcor)), 10 * log10((fftshift(abs(DSP)))));
        xlabel({'f','(en Hz)'});
        ylabel('Estimateurs de la DSP');
        figure
        set(gcf, 'name', 'Puissance du signal transposé sur fréquence porteuse')
        title('Puissance du signal')
        plot(temps, signal(:).^2)
    end

    
 %% Ajout d'un bruit blanc
    %sigma2 = mean(abs(signal).^2) * pointsSymbole/(2*10^(Eb_N0_db/10));
    sigma2 = (mean(abs(signal).^2) * Te) / (2 * log2(4) *10^(Eb_N0_db/10));
    %signalbruit = signal;
    signalbruit = signal + sqrt(sigma2) .* randn(1, length(signal));
    
    %% Retour en bande de base
    signalcos = cos( 2 * pi * fp * temps) .* signal;
    signalsin = sin( 2 * pi * fp * temps) .* signal;
    
    signalcosbruit = cos( 2 * pi * fp * temps) .* signalbruit;
    signalsinbruit = sin( 2 * pi * fp * temps) .* signalbruit;
    
    if (affichage == 1)
       figure;
       subplot(2,1,1)
       title('Cosinus en phase');
       plot(temps, signalcosbruit);
       title('Signaux en phase');
       subplot(2,1,2)
       title('Sinus en phase');
       plot(temps, signalsinbruit);
       
       figure;
       subplot(2,1,1)
       title('Cosinus en quadrature');
       plot(temps, signalcosbruit.^2);
       title('Signaux en quadrature');
       subplot(2,1,2)
       title('Sinus en quadrature');
       plot(temps, signalsinbruit.^2);
       
    end
    
    sortie = signalcos + signalsin * (-1j);
    sortiebruit = signalcosbruit + signalsinbruit * (-1j);
   
    %% Diagramme de l'oeil
    h = conj(fliplr(h));
    sortie = filter(h, 1, cat(2, sortie, zeros(1, retard)));
    sortie = sortie(retard + 1 : end);
    
    % oeil = reshape(sortie, pointsSymbole, longueurMessage);
    %oeil = reshape(real(sortie), 2 * pointsSymbole, longueurMessage / 2);
    %oeil = reshape(angle(sortie(1+Te:end-Te)),2*Te,[]);
    oeil = sortie;
    
    
    
    %% Filtrage de réception
    sortiebruit = filter(h, 1, cat(2, sortiebruit, zeros(1, retard)));
    sortiebruit = sortiebruit(retard + 1 : end);
    %sortie = filter(h, 1, cat(2, signal, zeros(1,pointsSymbole/2)));
    %sortie = sortie(pointsSymbole/2 + 1 :end);
    
    %% Echantillonnage
    echant = sortiebruit(1:Te:end);
    %echant = downsample(sortie, pointsSymbole);

    
    %% Décision
    if (affichage == 1)
        figure;
        set(gcf, 'name', 'Constellation en entrée de la chaîne')
        plot(symboles, 'b+');
    end; 
    
    symbolesPossibles = [sqrt(2)/2 + 1j * sqrt(2)/2 sqrt(2)/2 - 1j * sqrt(2)/2 -sqrt(2)/2 + 1j * sqrt(2)/2 -sqrt(2)/2 - 1j * sqrt(2)/2];
    [~, decision(:)] = min(symbolesPossibles(:) - echant);
    decision = symbolesPossibles(decision);
    symbolesRecus = pskdemod(decision, 4, pi/4, 'gray');
    
    messageRecu = de2bi(symbolesRecus); 
    messageRecu = reshape(messageRecu, [1, numel(messageRecu)]);
    

    erreur = erreur + sum(messageRecu ~= message);
    passages = passages + 1;
    if (affichage == 1)
        break;
    end;
end
%TEB = mean(messageRecu ~= message);
TEB = erreur / (passages * longueurMessage);
end


