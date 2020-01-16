%% week15_exercise.m

close all
clear all

N = 10000; % number of timesteps
dt= 1;   % delta t; time step size
lam=.01;  % decaying coefficient

% initial condition
T(1) = .5/lam;

for n=1:N-1
    T(n+1)=T(n)*(1-lam*dt) + rand(1)*dt;
end

figure(1);
plot(1:N,T,'k.-');
xlabel('time');


