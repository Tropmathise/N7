function y = bezier_bruitee(beta_0,beta,beta_d,x,sigma)

y = bezier(beta_0,beta,beta_d,x)+sigma*randn(size(x));
