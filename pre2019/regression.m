function [a,b,R2]=regression(x,y)

% function regression
% input : x and y : two vectors of equal lengths
% output: a = regression coefficient (slope)
%         b = intercept
%         R2 = coefficient of determination

covxy = mean(x.*y)-mean(x)*mean(y);
varx = mean(x.*x) - mean(x)^2;
vary = mean(y.*y) - mean(y)^2;

a = covxy/varx;
b = mean(y) - a*mean(x);
R2= covxy^2/(varx*vary);



