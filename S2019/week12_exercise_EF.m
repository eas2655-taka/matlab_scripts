%% week12_exercise_EulerForward.m 

% safety first
close all
clear all

% define parameters
H=1;   % water depth
g=9.8; % gravity
L=5;   % half domain size
dx=.2; % grid spacing
dt=.01;% time step size
Nt=500;% number of timesteps

% define domain
xu=[-L:dx:L]; 
xh=(-L+dx/2):dx:(L-dx/2);
Nx=length(xh);
time=0:dt:(Nt*dt);

% initial condition
u=zeros(Nx+1,1);
h=0.3*exp(-(xh'+L));

% time stepping loop
for m=1:Nt
   
    % set up dudt and dhdt array as Gu and Gh
    Gu=zeros(Nx+1,1);
    Gh=zeros(Nx,1);
    
    % calculate Gu and Gh
    Gu(2:Nx)=-g/dx*( h(2:Nx)-h(1:Nx-1) );
    Gh=-H/dx*(u(2:Nx+1)-u(1:Nx));

    % Euler Forward time step
    u = u + dt*Gu;
    h = h + dt*Gh;
            
    % plot the surface height
    plot(xh,h,'k.-');
    hold on;
    quiver(xu',zeros(size(xu')),u,zeros(size(xu')),.1);
    hold off;
    xlabel('distance in x');
    ylabel('surface height');
    axis([-5 5 -.3 .3]);
    drawnow;
    
end
