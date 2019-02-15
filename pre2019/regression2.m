function [a,b,R2,Neff,SE,tcrit,tval]=regression2(x,y,CL,tail)

% function regression
% input : x and y : two vectors of equal lengths
%         CL: confidence level
%         tail: one tail (tail=1) two tail (tail=2) test
%
% output: a = regression coefficient (slope)
%         b = intercept
%         R2 = coefficient of determination
%         Neff= effective sample size
%         SE = standard error of regression coeff (slope, a)
%         tcrit = critical t-value
%         tval  = t value of the regression coeff (slope, a)

covxy = mean(x.*y)-mean(x)*mean(y); % covariance
varx = mean(x.*x) - mean(x)^2; % variance in x
vary = mean(y.*y) - mean(y)^2; % variance in y

a = covxy/varx; % regression coeff
b = mean(y) - a*mean(x); % intercept
R2= covxy^2/(varx*vary); % R2 value

% calculate effective sample size...
N=length(y);
r = correlation(y(1:N-1),y(2:N)); % lag-1 auto correlation
if r>=0
    Neff=N*(1-r)/(1+r);
else
    Neff=N; % do not allow Neff > N
end

% calculate the SE... 
err = y - (a*x+b);
SE2 = sum(err.^2)/(Neff-2)/sum((x-mean(x)).^2);
SE = sqrt(SE2);

% calculate the critical t value... 
if tail == 1
    tcrit=tinv(CL,Neff-2);
elseif tail ==2 
    tcrit=tinv(.5*(CL+1),Neff-2);
end

% calculate the t-value
tval = a/SE;







