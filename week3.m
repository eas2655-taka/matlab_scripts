%% week3 

close all
clear all

load atlanta_temperature.mat;

% 1. set CL
CL = .99;

% 2. hypothesis: H0 Atl (2010-2019) is not significantly warmer than ltm
%                H1 Atl (2010-2019) is significantly warmer than ltm

% 3. State statistic: t-test 1 tail

% 4. calculate confidence interval
N=10;
tcrit=tinv(CL,N-1);
disp(['confidence interval is t <',num2str(tcrit)]);

% 5. evaluate the hypothesis
x = mean(Annual(131:140));
mu = mean(Annual);
s = std(Annual(131:140));
t = (x-mu)/(s/sqrt(N-1));

% t > tcrit so H0 is rejected. 

