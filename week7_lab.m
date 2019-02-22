%% week7_lab

close all
clear all
clc

load MLO_CO2.mat;

X=year;
Y=pCO2;

% plot the raw data
figure(1);
p(1)=plot(X,Y,'k-');
xlabel('time');
ylabel('partial pressure of CO2 in ppm');

% linear regression
N = length(Y); % count the number of data points
Xp= X-mean(X); % Xp is anomaly in X

% set up E matrix
E(1:N,1)=1;   
E(1:N,2)=Xp;

% calculate regression coefficient
a=inv(E'*E)*E'*Y;

% Y estimate = E*a
Yest = E*a;
R2(1)=var(Yest)/var(Y);

figure(1);
hold on;
p(2)=plot(X,Yest,'r-');

% include X2 term
E(1:N,3)=Xp.^2;

% re-calculate regression coefficient
a=inv(E'*E)*E'*Y;

% Y estimate = E*a
Yest = E*a;
R2(2)=var(Yest)/var(Y);

figure(1);
hold on;
p(3)=plot(X,Yest,'g-');

% include sin and cos terms
E(1:N,4)=sin(2*pi*Xp);
E(1:N,5)=cos(2*pi*Xp);

% re-calculate regression coefficient
a=inv(E'*E)*E'*Y;

% Y estimate = E*a
Yest = E*a;
R2(3)=var(Yest)/var(Y);

figure(1);
hold on;
p(4)=plot(X,Yest,'b-');

legend(p,{'Raw' 'lin' 'quad' 'sin/cos'})

