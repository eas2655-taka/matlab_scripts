%% simple ice sheet model

% by T. Ito 2018 for EAS2655
% originally published as Oerlemans (1981) Tellus, 33, 1-11.

% safety first
close all
clear all

% set domain
L = 1e6; % 1000km
dx= 1e5; % 100km
x=[-L:dx:L]';
Nx=length(x);

% set time steps
dt = 50;    % 10 year timestep
Nt = 400; % # of time steps to take

% model parameters
G0 = 0.3;
Y = 5e5; % 500km wide 
m = 2.5; % ice flow exponent
A = 1; % ice flow parameter
B0 =0; % topography height

% bottom topography
B = -B0*4/L^2*(x+L/2).*(x-L/2);
B(B<0)=0;

% surface mass balance
G = G0*ones(Nx,1);

% set initial condition
H = zeros(Nx,1); % ice free initial condition

% start numerical integration
for n=1:Nt
    % update clock
    time(n) = n*dt;
    
    % Total height, Hs
    Hs = H + B;
    
    % calculate ice flow in X
    dHdx = (Hs(2:Nx)-Hs(1:Nx-1))/dx;
    Hc   = (H(2:Nx)+H(1:Nx-1))/2;   
    D = A*Hc.^(m+1).*(dHdx.^2).^((m-1)/2);
    Fx = -D.*dHdx;
    
    % calculate ice flow convergence in x
    dFxdx = (Fx(2:Nx-1)-Fx(1:Nx-2))/dx;
    
    % calculate ice flow convergence in y
    dHdx = (Hs(3:Nx)-Hs(1:Nx-2))/(2*dx);
    D = A*H(2:Nx-1).^(m+1).*(dHdx.^2).^((m-1)/2);
    dFydy = D/Y^2.*H(2:Nx-1);
    
    % Euler step forward
    H(2:Nx-1) = H(2:Nx-1) + dt*(G(2:Nx-1) - dFxdx - dFydy);

    % apply boundary condition
    H(1)=0;
    H(Nx)=0;
    H(H<0)=0;
    
    % calculate Courant number
    C = D*dt/dx^2;
    maxC=max(C);
    
    % plot the ice sheet height
    figure(1);
    subplot(2,1,1);
    plot(x,Hs,'k.-');
    hold on;
    plot(x,B,'b-');
    hold off;
    axis([-L L -50 4000]);
    title(['year=',num2str(floor(time(n))),' max C =',num2str(maxC,2)]);
    ylabel('height');
    legend({'Total height' 'Bedrock'})

    subplot(2,1,2);
    plot(x,G,'b.-');    
    axis([-L L -1 1]);
    xlabel('distance in x');
    ylabel('surface mass balance');
    grid on;
    drawnow;
    
end
