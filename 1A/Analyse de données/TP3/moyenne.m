function x = moyenne(im)
%conversion au format flottant
Ibis=single(im);
somme=max(1,sum(Ibis,3));
r = Ibis(:,:,1)./somme;
v = Ibis(:,:,2)./somme;
r_barre=mean(r(:));
v_barre=mean(v(:));
x=[r_barre; v_barre];

end