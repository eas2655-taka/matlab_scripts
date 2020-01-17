close all
clear all
clc

N=289; 

% do experiment
for i=1:1000
    X = ceil(rand(N,1)*6);
    Xave(i)=mean(X); % sample mean
end

% plot histogram
hist(Xave);

% looking at 2.5 percentle
X25=prctile(Xave,2.5);
disp(['The value of 2.5 percentile is :',num2str(X25)]);

% looking at 97.5 percentile
X975=prctile(Xave,97.5);
disp(['The value of 97.5 percentile is :',num2str(X975)]);




    
