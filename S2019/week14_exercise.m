%% week14_analytic.m 

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

for t=1:Nt
    % prepare array for T
    T = zeros(Nx,1);
    time(t) = dt*(t-1);
    
    % Fourier series
    for n=1:2:21
        T = T + (4*T0)/(n*pi)*sin(n*pi*x/L)*exp(-(n*pi/L)^2*k*time(t));
    end
    
    % plot temperature
    figure(1);
    plot(x,T,'k-');
    xlabel('distance in x');
    ylabel('temperature');
    axis([0 L 0 T0+3]);
    title( ['time=',num2str(time(t))] );
    drawnow;
    
end
