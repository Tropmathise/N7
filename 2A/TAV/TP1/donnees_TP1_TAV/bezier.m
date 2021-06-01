function y = bezier(beta_0,beta,beta_d,x)

d = length(beta)+1;
y = beta_0*(1-x).^d+beta_d*x.^d;
for i = 1:d-1
	y = y+beta(i)*nchoosek(d,i)*x.^i.*(1-x).^(d-i);
end
