%% Week 11 exercise

%% safety first
close all
clear all

%% set up parameters
a  = -log(2)/5700; % per year
b  = 0;   % no source for C-14 
X0 = 100; % initial condition
dt = 10000;   % time step
N  = 5; % number of time steps
t  = 0:dt:(N-1)*dt; % set up time axis

%% steady state solution
Xbar = -b/a;

%% analytic solution
X0p = X0-Xbar;
Xa = Xbar + X0p*exp(a*t);

%% plot the analytic solution
p(1)=plot(t/1000,Xa,'b-','linewidth',2);
xlabel('1000s of years');
ylabel('C-14');
legend(p,{'Analytic'});

%% we solve with Euler forward method
X(1)=X0; % set initial condition
for n=1:N-1
%    dXdt = a*X(n)+b;
    X(n+1)=(1+a*dt)*X(n)+b*dt;
end

%% plot in red
hold on; 
p(2)=plot(t/1000,X,'ro-');
legend(p,{'Analytic' 'Euler Forward'});

%% we solve with Euler backward method
X(1)=X0; % set initial condition
for n=1:N-1
    X(n+1)=(X(n)+b*dt)/(1-dt*a);
end

%% plot in cyan
hold on; 
p(3)=plot(t/1000,X,'c.-');
legend(p,{'Analytic' 'Euler Forward' 'Euler backward'});
