function [mu, Sigma] = estimation_mu_Sigma(X)
n=length(X);
mu=mean(X);
X_c=X-ones(n,1)*mu;
Sigma=(X_c')*X_c/n;
mu=mu';
end
