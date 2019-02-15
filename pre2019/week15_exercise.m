%% week15_exercise.m 

% safety first
close all;
clear all;

% set up domain
L = 10; % domain size
dx= .2; % grid spacing
x = [0:dx:L]';
Nx= length(x);

% model parameters
k  = 1e-2; % diffusivity
T0 = 10;   % initial condition

% loop for time evolution
dt = 1;
Nt = 1000;

% initial condition for numerical solution
Tn = T0*ones(Nx,1);
Tn(1)=0;
Tn(Nx)=0;

% prepare diagonal matrix
d0=-2*ones(Nx,1);
d1=ones(Nx-1,1);
D = diag(d0) + diag(d1,1) + diag(d1,-1);

% prepare matrix for Euler backward
G = inv(eye(Nx,Nx) - dt*k/dx^2*D);

for t=1:Nt
    % prepare array for T
    T = zeros(Nx,1);
    time(t) = dt*(t-1);
    
    % Fourier series
    for n=1:2:201
        T = T + (4*T0)/(n*pi)*sin(n*pi*x/L)*exp(-(n*pi/L)^2*k*time(t));
    end
    
    % numerically integrate (Euler forward)
    % Tn = Tn + dt*k/dx^2*D*Tn;
    
    % numerically integrate (Euler backward)
    Tn = G*Tn;

    % boundary conditions
    Tn(1)=0;    Tn(Nx)=0;
    
    % plot temperature
    figure(1);
    plot(x,T,'k-');
    hold on;
    plot(x,Tn,'r--');
    hold off;
    
    xlabel('distance in x');
    ylabel('temperature');
    axis([0 L 0 T0+3]);
    title( ['time=',num2str(time(t))] );
    legend({'Analytic' 'Numerical'})
    drawnow;
    
end


