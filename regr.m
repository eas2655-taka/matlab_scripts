function [a,b,R2,r,t,tcrit]=regr(x,y,CL)

% input
% x - 1st variable (explaining variable)
% y - 2nd variable (explained variable)
% CL- confidence level (%)
% output
% a,b - regression coeff and intercept (y = a*x+b )
% R2 - coeff of determination
% r - correlation coeff
% t - t value of the correlation
% tcrit - critical t value

% first calculate the covariance matrix
c=cov(x,y);

% calculate regression coefficient
a=c(1,2)/c(1,1);

% intercept
b = mean(y)-a*mean(x);

% R2 value
R2 = c(1,2)^2/(c(1,1)*c(2,2));

% correlation
r = c(1,2)/sqrt(c(1,1)*c(2,2));

% calculate t statistic
N=length(x);
t=r*sqrt((N-2)/(1-r*r));

% calculate critical t-value, 2 tail
tcrit = tinv((CL/100+1)/2,N-2);

