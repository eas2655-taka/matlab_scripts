%% week7_exercise

clear all
close all
clc

% load data
load uscensus.txt;
X = uscensus(:,1);
Y = uscensus(:,2)*1e-6; % US population in millions

% plot
figure(1);
plot(X,Y,'ko-');
xlabel('year')
ylabel('US population in millions');

% linear regression
C = cov(X,Y);
a(2)=C(1,2)/C(1,1);
a(1)=mean(Y)-a(2)*mean(X);
Yest = a(1)+a(2)*X;
R2(1)=C(1,2)^2/C(1,1)/C(2,2);
R2(2)=var(Yest)/var(Y);

% plot the regression line
hold on;
plot(X,Yest,'r-');

% calculate error
err = Y - Yest;
figure(2);
plot(X,err);
xlabel('time');
ylabel('error: Y - Yest');

% quadratic term centered at mean(X)
X2 = (X-mean(X)).^2;
X2 = X2-mean(X2); % make the average X2 to be 0
C=cov(X2,err);
a(3)=C(1,2)/C(1,1);

% multiple linear regression
Yest2 = a(1)+a(2)*X+a(3)*X2;
figure(1);
plot(X,Yest2,'m--');

R2(3)=var(Yest2)/var(Y);

% matrix approach
N=length(Y);
X0=mean(X);
E(1:N,1)=1;
E(1:N,2)=X-X0;
E(1:N,3)=(X-X0).^2;
a=inv(E'*E)*E'*Y;
Yest3=E*a;
figure(1);
hold on;
plot(X,Yest3,'g-.');









