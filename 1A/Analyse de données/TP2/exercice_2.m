clear;
close all;
load('SG5.mat');
load('ImSG5.mat');

% Jij=exp(-alpha*Iij+Beta)
% -alphaIij + Beta - ln(Jij) = 0
% A=[-Iij ones(n,1)]
% B=[-ln(Jij)]
% pinv(A)*B
% ||A*[alpha; beta] + [-ln(Jij)]||**2
%DataMod = Jij
%Data=Iij

A=[-Data(:) ones(50*50,1)];
B=[log(DataMod(:))];
gamma=pinv(A)*B;
Irecons=(-log(ImMod)+gamma(2))/gamma(1);

figure
subplot(1,2,1)
hold on 
title('Partie image originale')
imshow(Data)
axis equal

subplot(1,2,2)
hold on 
title('Partie image modifiée')
imshow(DataMod)
axis equal

figure
hold on
title('image reconstituée');
imshow(Irecons)
axis equal

RMSE_MCO=sqrt(mean(mean((Irecons-I).^2)));

%Problème moindre carrés totaux 
[U Sigma V]=svd([A B]);
%p=size(A,2)
%Sigma
gamma_chapeau=(1/V(3,3))*V(:,3);



