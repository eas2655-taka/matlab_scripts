%% week2 exercise.m

% by Taka Ito

% safety first
close all;
clear all;

%% Project 1
% Roll a dice 10 times. Take the average. Repeat this 1000 times
% Evaluate Central Limit Theorem

N = 10;   % number to roll
K = 1000; % number of experiment sets
data = randi(6,[N K]); % generate random number from 1 to 6 with 
% equal probability into a NxK matrix
% calculate sample mean
M = mean(data,1);

% plot the histogram of M and compare it to Gaussian
figure(1);

% first plot histogram
bins=1:.5:6;
histogram(M,bins);

% then overlay gaussian
x=1:.05:6;
mu=3.5;
SE = 1.7/sqrt(N);
f=K*.5/(sqrt(2*pi)*SE)*exp(-0.5*((x-mu)/SE).^2);
hold on;
plot(x,f,'c-','linewidth',3);
hold off;
xlabel('M: sample mean');
ylabel('number of occurrence/frequency');
set(gca,'fontsize',16);




