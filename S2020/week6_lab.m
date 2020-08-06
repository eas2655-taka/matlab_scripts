%% week6

close all
clear all

% load MLO data
load ch4_global.mat;

% remove NaNs
I=find(isnan(time+ch4));
time(I)=[];
ch4(I)=[];

% t is adjusted time: t=time-2000;
t = time-2000;

% quick look
figure(1);
plot(time,ch4,'k.-');
xlabel('time');
ylabel('atmospheric CH4, ppb');
hold on;
% approximate co2 as a fxn of time

% linear regression again with matrix
N=length(time);
E=[t ones(N,1)];
x=inv(E'*E)*E'*ch4;
ch4est1=E*x;
plot(time,ch4est1,'b--');

% regression with quadratic term
E=[t.^2 t ones(N,1)];
x=inv(E'*E)*E'*ch4;
ch4est2=E*x;
plot(time,ch4est2,'g-','linewidth',2);

% regression with quadratic term
E=[t.^3 t.^2 t ones(N,1)];
x=inv(E'*E)*E'*ch4;
ch4est3=E*x;
plot(time,ch4est3,'r-','linewidth',2);

legend({'Observation' 'Linear' 'Quadratic' 'Cubic'})
