%% week10_exercise.m 

% PO4 box model

% clean first
clear all;
close all; 

% 1. set up model parameter
H = 4000;  % full ocean depth, m
R = 6.3e6; % radius of the Earth, m
Area = 4*pi*R^2*0.8; % total surface area, m2 
fL = 0.8;  % fraction of low lat ocean
V(1) = Area*fL*100; % surface low lat ocean vol, m3
V(2) = Area*(1-fL)*300; % surface high lat ocean vol, m3
V(3) = Area*H-V(1)-V(2); % deep ocean vol, m3; 
C = 10*1e6;  % circulation rate (m3/s);
M = 40*1e6;  % mixing rate, (m3/s);
lam = 1/(60*60*24*365); % biological P consumption rate, 1/s

% 2. set up model matrix
A = [ -(C+lam*V(1))/V(1)       0              C/V(1); ... % first row 
          C/V(2)        -(C+M+lam*V(2))/V(2)  M/V(2); ... % second row 
          lam*V(1)/V(3)  (C+M+lam*V(2))/V(3)  -(C+M)/V(3)]; % third row

% 3. set initial condition & time step
dt = 60*60*24;  % one day timestep
N = 365*10;     % 10 year integration
X = zeros(3,N); % preparing the solution storage
Xa= zeros(3,N); % preparing the analytic solution storage
Xb= zeros(3,N); % preparing the Euler backward storage
X(:,1) = [2e-3; 2e-3; 2e-3]; % initial P conc. = uniform 2 mmolP/m3
Xa(:,1)= X(:,1); % initial cond for analytic sol.
Xb(:,1)= X(:,1); % initial cond for euler backward sol.
time=0:dt:(N-1)*dt; % set up time array

% 4. execute numerical integration
G = eye(3,3) + dt*A; % Euler forward
H = inv(eye(3,3) - dt*A); % Euler backward

for n=1:(N-1)
    X(:,n+1) = G*X(:,n); % Euler step forward
    Xb(:,n+1) = H*Xb(:,n); % Euler backward 
    Xa(:,n+1)= expm(A*time(n+1))*Xa(:,1); % analytic solution
end

% 5. plot the result
figure(1);
year = time/(60*60*24*365);    

subplot(2,2,1); 
plot(year,X);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Euler forward');

subplot(2,2,2); 
plot(year,Xa);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Analytic solution');

subplot(2,2,3); 
plot(year,Xb);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Euler backward');

subplot(2,2,4); 
BioExport = lam*(Xb(1,:)*V(1)+Xb(2,:)*V(2));
plot(year,BioExport);
xlabel('time');
ylabel('Biological P export, molP/s');
%title('Euler backward');


