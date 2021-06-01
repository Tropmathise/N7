function new_sinogramme = filtrage_sinogramme(sinogramme,nb_theta,nb_rayons)
    f=linspace(-1,1,nb_rayons).';
    filtre=abs(f);
    filtre=repmat(filtre,[1 nb_theta]);
    
    transfo_f=fftshift(fft(sinogramme,[],1),1);
    filtrepro=ifftshift(transfo_f.*filtre,1);
    new_sinogramme=real(ifft(filtrepro,[],1));

end

