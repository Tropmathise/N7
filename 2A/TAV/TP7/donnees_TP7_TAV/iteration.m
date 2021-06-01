function [x_p1,y_p1] = iteration(x,y,Fx,Fy,gamma,A)
%ITERATION Summary of this function goes here
%   Detailed explanation goes here
    x_ent=round(x);
    y_ent=round(y);
    indice=sub2ind(size(Fx),y_ent,x_ent);
    Bx=-gamma*(Fx(indice));
    By=-gamma*(Fy(indice));
    x_p1=A*x+Bx;
    y_p1=A*y+By;
end

