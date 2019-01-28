%% week4_exercise

% Taka Ito

% safety first
clear all;
close all;
clc;

load atlanta_temperature.mat;

% plot temperature time series
figure(1); 
plot(Year,Annual);
xlabel('time');
ylabel('ATL temperature, degree F');

% least square fit
Y = Annual;
X = Year;
C = cov(X,Y);
a1= C(1,2)/C(1,1);
a0= mean(Y)-a1*mean(X);

% plot the result
x=1870:2018;
y=a0+a1*x;
figure(1);
hold on;
plot(x,y,'r-');

% calculate R2
R2 = C(1,2)^2/C(1,1)/C(2,2);
disp(['R2 value is :',num2str(R2)]);




