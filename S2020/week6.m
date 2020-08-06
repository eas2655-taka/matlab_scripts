%% week6

close all
clear all

% load MLO data
load co2_mlo.mat;

% quick look
figure(1);
plot(time,co2,'k.-');
xlabel('time');
ylabel('atmospheric co2, ppm');

% approximate co2 as a fxn of time

% linear regression
c=cov(time,co2);
a=c(1,2)/c(1,1);
b=mean(co2)-a*mean(time);
co2est=a*time+b;
hold on;
plot(time,co2est,'r-');

% linear regression again with matrix
N=length(time);
E=[time ones(N,1)];
x=inv(E'*E)*E'*co2;
co2est2=E*x;
plot(time,co2est2,'b--');

% regression with quadratic term
E=[time.^2 time ones(N,1)];
x=inv(E'*E)*E'*co2;
co2est3=E*x;
plot(time,co2est3,'g--');

% regression with quadratic and sin term
E=[sin(2*pi*time) time.^2 time ones(N,1)];
x=inv(E'*E)*E'*co2;
co2est4=E*x;
plot(time,co2est4,'c--');

% regression with quadratic and sin and cos term
E=[sin(2*pi*time) cos(2*pi*time) time.^2 time ones(N,1)];
x=inv(E'*E)*E'*co2;
co2est5=E*x;
plot(time,co2est5,'m--');







