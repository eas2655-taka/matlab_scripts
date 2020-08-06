%% week2_S20

% safety first
close all
clear all

%% ex 1. rolling a die N times, take average = M
%        repeat K sets of this calculation
N = 30;
K = 1000; 
data = randi(6,[N K]);

% calculate sample mean
M = mean(data,1);
mu = mean(M);
disp(['mean of M is ;',num2str(mu)]);

% calculate SE
SE = 1.7/sqrt(N);
disp(['SE is ;',num2str(SE)]);

% look at the distribution
figure(1);
hist(M,2:.1:5);
xlabel('value of M');
x=2:.1:5;
f=1/(sqrt(2*pi)*SE)*exp(-1/2*((x-mu)/SE).^2);
hold on;
plot(x,f*K*.1,'c-','linewidth',3);
hold off;

%% Project 2 
% Randomly select N years from the past 140 years of ATL temperature
% Take the average = M, repeat this K times

clear all
close all

% reset parameters here
N=10;
K=1000;

load atlanta_temperature.mat;
for n=1:K
    data=Jul(randi(140,[N 1]));
    M(n)=mean(data);
end

% calculate sample mean
mu = mean(Jul);
disp(['mean of M is ;',num2str(mean(M))]);
disp(['population mean is ;',num2str(mu)]);

% calculate SE
SE = std(Jul)/sqrt(N);
disp(['SE is ;',num2str(SE)]);

% look at the distribution
figure(1);
hist(M,77:.1:81);
xlabel('July temperature, N-year mean, deg F');
x=77:.1:81;
f=1/(sqrt(2*pi)*SE)*exp(-1/2*((x-mu)/SE).^2);
hold on;
plot(x,f*K*.1,'c-','linewidth',3);
hold off;





