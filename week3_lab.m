%% week3_lab

% Taka Ito

% safety first
close all
clear all
clc

% 1. load the data
load atlanta_temperature.mat;

% 2. long term mean
mu = mean(Jul);
disp(['The long term mean July temperature is :',num2str(mu)]);

% 3. 2000-2018 mean
I = find(Year>=2000);
X = Jul(I); % extract July temperature after 2000 
Xave = mean(X); % take the mean
disp('---------')
disp(['The 2000-2018 mean July temperature is :',num2str(Xave)]);

% 4. 5 steps 
% (1) state the confidence level
CL = 0.99;
disp('---------')
disp(['The confidence level is ',num2str(CL*100),' percent. ']);

% (2) define null hypothesis and its alternative
disp('---------')
disp('H0 (Null): 2000-2018 mean July temp. is not significantly different from the long-term mean.');
disp('H1 (Alternative): 2000-2018 mean July temp. is significantly warmer than long-term mean.'); 

% (3) state the statistics used
disp('---------')
disp('We use Students t distribution and perform two-tail test.');

% (4) calculate the critical region
N=19;
df=N-1;
tcrit = tinv((1+CL)/2,df);
disp('---------')
disp(['The critical t-value is :',num2str(tcrit)]);

% (5) evaluate whether or not the data is within the critical region
s = std(X); % sample STD
t = (Xave-mu)/(s/sqrt(N-1));
disp('---------')
disp(['The t-value of the data is :',num2str(t)]);

if abs(t) > tcrit
   disp(['|t| > tcrit: the null hypothesis is rejected. ']);
   %2000-2018 july is hotter than long term mean
else
   disp(['|t| < tcrit: the null hypothesis is not rejected. '])
   %2000-2018 july is not significantly different from the long term mean
end

