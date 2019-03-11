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
T = [ -(C+lam*V(1))/V(1)       0              C/V(1); ... % first row 
          C/V(2)        -(C+M+lam*V(2))/V(2)  M/V(2); ... % second row 
          lam*V(1)/V(3)  (C+M+lam*V(2))/V(3)  -(C+M)/V(3)]; % third row

% 3. set initial condition & time step
dt = 60*60*24;  % one day timestep
N = 365*10;     % 10 year integration
P = zeros(3,N); % preparing the solution storage
Pa= zeros(3,N); % preparing the analytic solution storage
Pb= zeros(3,N); % preparing the Euler backward storage
P(:,1) = [2e-3; 2e-3; 2e-3]; % initial P conc. = uniform 2 mmolP/m3
Pa(:,1)= P(:,1); % initial cond for analytic sol.
Pb(:,1)= P(:,1); % initial cond for euler backward sol.
time=0:dt:(N-1)*dt; % set up time array

% 4. execute numerical integration
G = eye(3,3) + dt*T; % Euler forward
H = inv(eye(3,3) - dt*T); % Euler backward

for n=1:(N-1)
    P(:,n+1) = G*P(:,n); % Euler step forward
    Pb(:,n+1) = H*Pb(:,n); % Euler backward 
    Pa(:,n+1)= expm(T*time(n+1))*Pa(:,1); % analytic solution
end

% 5. plot the result
figure(1);
year = time/(60*60*24*365);    

subplot(2,2,1); 
plot(year,P);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Euler forward');

subplot(2,2,2); 
plot(year,Pa);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Analytic solution');

subplot(2,2,3); 
plot(year,Pb);
xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep'});
title('Euler backward');

subplot(2,2,4); 
BioExport = lam*(Pb(1,:)*V(1)+Pb(2,:)*V(2));
plot(year,BioExport);
xlabel('time');
ylabel('Biological P export, molP/s');
%title('Euler backward');
