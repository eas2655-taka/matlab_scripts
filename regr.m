function [a,b,R2]=regr(x,y)

% first calculate the covariance matrix
c=cov(x,y);

% calculate regression coefficient
a=c(1,2)/c(1,1);

% intercept
b = mean(y)-a*mean(x);

% R2 value
R2 = c(1,2)^2/(c(1,1)*c(2,2));
