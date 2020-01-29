%% week 4 : Regression

close all
clear all

% load data
load atlanta_temperature.mat

% quick look
plot(Year,Feb,'k.-');
xlabel('time');
ylabel('atlanta temperature, deg F');

% regression
x=Year;
y=Feb;
c=cov(x,y); % calculate covariance
a=c(1,2)/c(1,1); % calculate regression coeff
b=mean(y)-a*mean(x); % calculate intercept
yest=a*x+b;
hold on;
plot(x,yest,'b-');
hold off;

% calculate R2: coeff. of determination
R2 = c(1,2)^2/(c(1,1)*c(2,2));
disp(['R2 value is : ',num2str(R2)]); 

% significance testing by Monte Carlo method
CL = .99;
% H0: atlanta temperature has no significantly positive trend
% H1: atlanta tempearture has signficantly positive trend

% Use Monte Carlo method, 1 tail test
K=10000;
N=length(y);
for k=1:K
    data = randsample(y,N);
    c=cov(x,data);
    A(k)=c(1,2)/c(1,1);
end
figure(2);
hist(A,20);
xlabel('regression coeff: temperature trend');

% 4. calculate confidence interval
acrit = prctile(A,CL*100);
disp(['critical value is : ',num2str(acrit)]); 






