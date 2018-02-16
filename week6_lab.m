%% week6_lab.m

close all;
clear all;

load uscensus.txt;
x = uscensus(:,1);
y = uscensus(:,2);
N = length(x);
E = [ones(N,1) x];

% calculate pseudo inverse
a = inv(E'*E)*E'*y;

% plot regression
figure(1);
plot(x,y,'k-'); % orig data
hold on;
plot(x,E*a,'r--'); % linear fit

% quadratic fit
E = [ones(N,1) x x.^2];

% calculate pseudo inverse
a = inv(E'*E)*E'*y;

% plot regression
plot(x,E*a,'m--'); % quadratic fit
hold off;



