%% week13 exercise - FTCS

close all
clear all

% set parameters
L=5;
dt=0.1;
Nx=20;
Nt=500;
x=linspace(-L,L,Nx);
U=0.3;
dx=2*L/Nx;

% set initial condition
C=zeros(Nx,Nt);
C(:,1)=exp(-0.5*(x.^2));

% solve time stepping loop
for n=2:Nt
    
    % include spatial loop
    for m=2:Nx-1
        % FTCS scheme
        C(m,n)=C(m,n-1)-dt*U/(2*dx)*(C(m+1,n-1)-C(m-1,n-1));
    end
    
    % insert boundary condition
    C(1,n)=C(1,n-1)-dt*U/(2*dx)*(C(2,n-1)-C(Nx,n-1));
    C(Nx,n)=C(Nx,n-1)-dt*U/(2*dx)*(C(1,n-1)-C(Nx-1,n-1));
    
end

% plot the result
for n=1:Nt
    figure(1);
    p=plot(x,C(:,n),'.k-');
    axis([-L L -0.2 1.2]);
    hold off;
    xlabel('distance in x');
    ylabel('concentration in C');
    title(['time = ',num2str(dt*n)]);
    drawnow;
end

