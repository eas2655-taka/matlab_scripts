%% week2_lab

% safety first
close all 
clear all

% load data
load atlanta_temperature.mat;

% a quick look : July temperature
figure(1);
plot(Year,Jul,'k.-');
xlabel('time');
ylabel('temperature');

% 1. population mean and std
mu = mean(Jul);
disp(['mu = ',num2str(mu)])
sigma = std(Jul);
disp(['sigma = ',num2str(sigma)])

% 2. Bootstrap the data
N=10; % sample size
K=10000; % number of re-sampling
% start the loop
for k=1:K
    index=randsample(140,N);
    % calculate sample mean
    M(k) = mean(Jul(index)); % M is sample mean
end

% 3. CLT mu = mean(M)
Mbar = mean(M);
disp(['Mbar = ',num2str(Mbar)]);

% 4. M follows Gaussian distribution
figure(2);
% plot histogram
hist(M,77:.1:82);
% compare Gaussian
SE = sigma/sqrt(N);
x = 77:.1:82;
f = 1/(sqrt(2*pi)*SE)*exp(-1/2*((x-mu)/SE).^2);
hold on;
plot(x,f*K*.1,'c-','linewidth',3);
hold off;
xlabel('temperature');
ylabel('# of occurrence');

% 5. last 10 year
Mtest = mean(Jul(131:140));
disp(['Mtest = ',num2str(Mtest)]);

% 6. Significance test
CL = 95;
M95 = prctile(M,CL);
disp(['M95 = ',num2str(M95)]);








































    
    
    
    
    
    





