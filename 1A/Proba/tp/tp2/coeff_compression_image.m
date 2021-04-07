function coeff_compression_avant_decorrelation = coeff_compression_image(histogramme,dico)
pixel=sum(histogramme)
tailleencode=0
taille_bit_initiale=pixel*8
for i=1:length(histogramme)
    tailleencode=tailleencode + length(dico{i,2})*histogramme(i)
end
coeff_compression_avant_decorrelation=taille_bit_initiale/tailleencode

