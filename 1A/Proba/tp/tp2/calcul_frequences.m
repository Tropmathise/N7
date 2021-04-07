function frequences = calcul_frequences(texte, alphabet)
for i = 1:length(alphabet)
    frequences(i)=sum(texte==alphabet(i))/length(texte)
end