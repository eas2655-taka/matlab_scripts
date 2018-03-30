%% week12_lab.m 

% safety first
close all
clear all

% define parameters
H=1;   % water depth
g=9.8; % gravity
L=5;   % half domain size
dx=.1; % grid spacing
dt=.01;% time step size
Nt=300;% number of timesteps

% define domain
xu=[-L:dx:L]; 
xh=(-L+dx/2):dx:(L-dx/2);
Nx=length(xh);
time=0:dt:(Nt*dt);

% initial condition
u=zeros(Nx+1,1);
%h=0.3*exp(-(xh'+L));
h=zeros(Nx,1);

% time stepping loop
for m=1:Nt
   
    % introduce a wave maker
    h(1)=0.3*sin(2*pi*time(m));
    
    % set up Gu and Gh array, with zeros
    Gu=zeros(Nx+1,1);
    Gh=zeros(Nx,1);
    
    % define Gu and Gh
    Gu(2:Nx)=-g/dx*( h(2:Nx)-h(1:Nx-1) );
    Gh=-H/dx*(u(2:Nx+1)-u(1:Nx));
    
    % prediction step
    up = u + dt*Gu;
    hp = h + dt*Gh;
    
    % re-define Gu and Gh
    Gu(2:Nx)=-g/dx*( hp(2:Nx)-hp(1:Nx-1) );
    Gh=-H/dx*(up(2:Nx+1)-up(1:Nx));
    
    % correction step
    u = u + dt*Gu;
    h = h + dt*Gh;
        
    % plot the surface height
    plot(xh,h,'k.-');
    hold on;
    quiver(xu',zeros(size(xu')),u,zeros(size(xu')),.1);
    hold off;
    xlabel('distance in x');
    ylabel('surface height');
    maxu=max(u);
    maxC=maxu*dt/dx;
    title(['time=',num2str(time(m),3),'; maxU=',num2str(maxu,3), ... 
        '; maxC=',num2str(maxC,3)])
    axis([-5 5 -.3 .3]);
    drawnow;
    
end


