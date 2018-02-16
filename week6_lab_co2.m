%% week6_lab.m

close all;
clear all;

load MLO_CO2.mat;
x = year;
y = pCO2;
N = length(x);

E = [ones(N,1) x cos(2*pi*x) sin(2*pi*x)];
% calculate pseudo inverse
a = inv(E'*E)*E'*y;

% plot regression
figure(1);
plot(x,y,'k-'); % orig data
hold on;
plot(x,E*a,'r--'); % linear fit
hold off;

