function [a,r,CI,siga,sigr]=regrcorrmap(X,Y,CL)

% input: X = X(t) 1 dimensional measurement (in time)
%      : Y = Y(x,y,t) 2-dimensional measurement (in space and time)
%      : CL : desired confidence level
% output: a = regression coefficient (slope)
%       : r = correlation
%       : CI= confidence interval of regression coeff
%       : siga= statistical significance of regression (1=significant)
%       : sigr= statistical significance of correlation (1=significant)

N = size(Y); % get dimensios

for i=1:N(1)
    for j=1:N(2)
        % set input
        xin = X;
        yin = squeeze(Y(i,j,:));
        % call regrcorr3 function
        [a(i,j),r(i,j),CI(i,j),siga(i,j),sigr(i,j)] ... 
            = regrcorr3(xin,yin,CL);
    end
end

return;
