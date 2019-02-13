function [a,r,CI,siga,sigr] = regrcorr3(X,Y,CL)

% Input : two vectors of equal length and confidence level (CL)
% Output: a = regression coefficient
%         r = correlation coefficient
%         CI= confidence interval

% covarince matrix
X = squeeze(X); % safety 
Y = squeeze(Y);
C=cov(X,Y);

% slope
a(1) = C(1,2)/C(1,1);
% intercept
a(2) = mean(Y)-a(1)*mean(X);

% correlation
r = C(1,2)/sqrt(C(1,1)*C(2,2));

% effective sample size
N = length(Y);

% lag-1 autocorrelation of X
x0 = X(1:N-1);
x1 = X(2:N);
C=cov(x0,x1);
r1 = C(1,2)/sqrt(C(1,1)*C(2,2));
%Neff=N*(1-r1)/(1+r1);
%Neff=min(N,Neff); % only allow Neff <= N

% lag-1 autocorrelation of Y
y0 = Y(1:N-1);
y1 = Y(2:N);
C=cov(y0,y1);
r2 = C(1,2)/sqrt(C(1,1)*C(2,2));
Neff=N*(1-r1*r2)/(1+r1*r2);
Neff=min(N,Neff); % only allow Neff <= N

% SE of regression
err2 = sum( ( Y - (a(2)+a(1)*X) ).^2 )/(Neff - 2);
SE2  = err2/( sum((X-mean(X)).^2)  );
SE   = sqrt(SE2);

% calculate tcrit (two tail)
tcrit = tinv( (CL+1)/2 , Neff-2);

% Calculate CI
CI = tcrit*SE;

% Test the significance of the trend
t = a(1)/SE;
if abs(t) > tcrit
    siga = 1; % 1 for significant trend
else
    siga = 0; 
end

% Testing the significance of correlation
t = r*sqrt( (Neff-2)/(1-r*r)  ); 
if abs(t) > tcrit
    sigr = 1; % 1 for significant correlation
else
    sigr = 0; 
end

return