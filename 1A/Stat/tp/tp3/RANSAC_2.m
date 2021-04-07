function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)
ecart = 10000;
for k=1:parametres(3)
    indices=randperm(length(rho),2);
    rho1=rho(indices);
    theta1=theta(indices);
    [rho_F1,theta_F1,~] = estimation_F(rho1,theta1);
    
    rhoconforme=rho(abs(rho-rho_F1*cos(theta-theta_F1))<parametres(1));
    thetaconforme=theta(abs(rho-rho_F1*cos(theta-theta_F1))<parametres(1));
    
    if length(rhoconforme)/length(rho)>parametres(2)
        [rho_F1,theta_F1,ecart_moyen1] = estimation_F(rhoconforme,thetaconforme);
         if ecart_moyen1<ecart
             rho_F_1 =rho_F1;
             theta_F_1=theta_F1;
             ecart=ecart_moyen1;
         end
    end
end
