%% week2 exercise.m

% by Taka Ito

% safety first
close all;
clear all;

%% Project 2
% Randomly select 10 years out of the last 141 years, 
% and average July temperature of Atlanta for those years. 
% Repeat this 10,000 times. 
% Will it follow CLT?

%% get the data
load atlanta_temperature.tsv;

%% extract july mean temp
july = atlanta_temperature(:,8);
N=10;
K=10000;
mu=mean(july);
sig=std(july);

%% Bootstrap: repeat resampling
for n=1:K
   data = randsample(july,N);
   M(n)=mean(data);
end

%% look at the histogram
figure(1);
bins=min(M):0.1:max(M);
histogram(M,bins);

%% get mean and STD of M, draw gaussian
SE=sig/sqrt(N);
x=min(M):.1:max(M);
f=K*.1/(sqrt(2*pi)*SE)*exp(-0.5*((x-mu)/SE).^2);
hold on;
plot(x,f,'m-');

%% calculate 95 percentile
t95=prctile(M,95);
disp(['95 percentile temp is ',num2str(t95)]);

%% calculate 99 percentile
t99=prctile(M,99);
disp(['99 percentile temp is ',num2str(t99)]);

%% calculate last 10 years average
l10=mean(july(132:141));
disp(['Last 10 years mean temp is ',num2str(l10)]);







