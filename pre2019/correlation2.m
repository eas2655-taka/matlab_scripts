function [R,Neff,tcrit,tval]=correlation2(x,y,CL)

% correlation2 function
%
% input  : x and y : vectors of same length
%        : CL confidence level for t-test
% output : Neff, effective sample size
%        : tcrit, critical t-value
%        : tval, t-value based on the data

covxy = mean(x.*y)-mean(x)*mean(y);
varx = mean(x.*x) - mean(x)^2;
vary = mean(y.*y) - mean(y)^2;
R= covxy/sqrt(varx*vary);

% calculate effective sample size
N = length(x);
rx = correlation(x(1:N-1),x(2:N));
ry = correlation(y(1:N-1),y(2:N));
Neff = N*(1-rx*ry)/(1+rx*ry);

% critical t value assume two tail test
tcrit = tinv(.5*(CL+1),Neff-2);

% calculate the t-value
tval = R*sqrt( (Neff-2)/(1-R^2) );


