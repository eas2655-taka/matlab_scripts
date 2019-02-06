%% week4_lab 

% safety first
close all
clear all
clc

% load the data
load atlanta_temperature.mat

% X = Year
% Y = Annual
X = Year;
Y = Annual;

% calculate temporal trend first
C = cov(X,Y);
a(2)= C(1,2)/C(1,1); % slope
a(1)= mean(Y)-a(2)*mean(X); %intercept

% plot it
figure(1);
plot(X,Y,'k.');
xlabel('time');
ylabel('atlanta annual temp. deg F');
hold on;
plot(X,a(1)+a(2)*X,'r-');
hold off;

% test the significance of the trend

% 1. set CL
CL = 0.95;

% 2. State null hypothesis
disp('H0: there is no significant trend');
disp('H1: there is a signficant trend');

% 3. State statistic
disp('Use t-statistic with two tail test')

% 4. Calculate the critical t-value
N = length(X); % total sample size
[dummy,r]=regrcorr(Y(1:N-1),Y(2:N)); % calculating lag-1 auto correlation
Neff=N*(1-r)/(1+r);
df= Neff - 2; % degree of freedom
tcrit = tinv((CL+1)/2,df);

% 5. evaluate whether the data is in the confidence interval
err2 = sum( ((a(1)+a(2)*X) - Y).^2 )/(Neff-2);
SE2 = err2/( sum( (X-mean(X)).^2 ) );
SE = sqrt(SE2);

% t value = slope / SE;
t = a(2)/SE;




















