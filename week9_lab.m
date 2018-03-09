%% week9_lab.m

close all
clear all

% model parameters
So = 30;
k  = 3;
To = 10;

% set up time array
dt = 1/120; % timestep
time = 0:dt:10;
N = length(time); 

% Numerical solution (Euler's method)
Tf(1)=To; % set initial condition
Tb(1)=To;
for n=1:N-1
    % forward scheme
    Tf(n+1)=(1-dt*k)*Tf(n)+dt*So*(1-cos(2*pi*time(n)) );
    % backward scheme
    Tb(n+1)=Tb(n)/(1+dt*k)+dt*So/(1+dt*k)*(1-cos(2*pi*time(n+1)) );    
end

% plot
figure(1);
plot(time,Tf,'k-');
hold on;
plot(time,Tb,'m-');
xlabel('time');
ylabel('temperature');
legend({'Euler forward' 'Euler backward'})



