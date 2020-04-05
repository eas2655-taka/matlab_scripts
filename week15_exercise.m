%% week15_exercise

% safety first
clear all

% Predictor-Corrector method
% for shallow water equation

% 1. Set parameters
H = 1;
g = 9.8;
L = 10;
dx= .5; % x grid space
dt= .01;% time step size

xu = -L:dx:L; % velocity x-points
xh = (-L+dx/2):dx:(L-dx/2); % height x-points
Nu = length(xu);
Nh = length(xh);

t  = 0:dt:20; % time axis
Nt = length(t);

% initial condition
u = zeros(1,Nu); % resting initial state
h = exp(-(xh+L)); % initial condition for h

% plot the surface height initial cond 
figure(1);
plot(xh,h,'k.-');
xlabel('x coordinate');
ylabel('surface height');
axis([-L L -1 1]);
drawnow;

% 2. time step loop
for n=1:Nt
    % calculate gradients in u and h
    dudx = (u(2:Nu)-u(1:Nu-1))/dx;
    dhdx = (h(2:Nh)-h(1:Nh-1))/dx;
    % Euler step forward (prediction step)
    up=zeros(1,Nu);
    up(2:Nu-1) = u(2:Nu-1) - g*dt*dhdx;
    hp = h - H*dt*dudx;
    % re-calculate the gradients 
    dudx = (up(2:Nu)-up(1:Nu-1))/dx;
    dhdx = (hp(2:Nh)-hp(1:Nh-1))/dx;
    % step forward for u and h (correction step)
    u(2:Nu-1) = u(2:Nu-1) - g*dt*dhdx;
    h = h - H*dt*dudx;

    C = abs(u)*dt/dx; % Courant number
    Cmax = max(C);
    
    % 3. visualization
    figure(1);
    plot(xh,h,'k.-');
    xlabel('x coordinate');
    ylabel('surface height');
    axis([-L L -.6 .6]);
    title(['time=',num2str(t(n)), ... 
        ' : Cmax = ',num2str(Cmax,3)],'fontsize',16); % show time
    hold on;
    quiver(xu,-.4*ones(1,Nu),u,zeros(1,Nu),.2); % vector plot
    hold off;
    drawnow;
end
















