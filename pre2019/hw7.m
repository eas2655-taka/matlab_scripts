%% Homework 7 

% safety first
close all
clear all

% 1. set up model parameter
H = 4000;  % full ocean depth, m
R = 6.3e6; % radius of the Earth, m
Area = 4*pi*R^2*0.8; % total surface area, m2 
fL = 0.8;  % fraction of low lat ocean
V(1) = Area*fL*100; % surface low lat ocean vol, m3
V(2) = Area*(1-fL)*300; % surface high lat ocean vol, m3
V(3) = Area*H-V(1)-V(2); % deep ocean vol, m3; 
C = 20*1e6;  % circulation rate (m3/s);
M = 80*1e6;  % mixing rate, (m3/s);
lam = 1/(60*60*24*365); % biological P consumption rate, 1/s

% 2. set initial condition & time step
dt = 60*60*24;  % one day timestep
N = 365*20;     % 20 year integration
X = zeros(3,N); % preparing the solution storage
Xa= zeros(3,N); % preparing the analytic solution storage
Xb= zeros(3,N); % preparing the Euler backward storage
X(:,1) = [2e-3; 2e-3; 2e-3]; % initial P conc. = uniform 2 mmolP/m3
Xa(:,1)= X(:,1); % initial cond for analytic sol.
Xb(:,1)= X(:,1); % initial cond for euler backward sol.
time=0:dt:(N-1)*dt; % set up time array

%% Part I: shutdown scenario

% 3. set up model matrix
A1 = [ -(C+lam*V(1))/V(1)       0              C/V(1); ... % first row 
          C/V(2)        -(C+M+lam*V(2))/V(2)  M/V(2); ... % second row 
          lam*V(1)/V(3)  (C+M+lam*V(2))/V(3)  -(C+M)/V(3)]; % third row

C=C/2; M=M/2; % weaker circulation for the second half      
A2 = [ -(C+lam*V(1))/V(1)       0              C/V(1); ... % first row 
          C/V(2)        -(C+M+lam*V(2))/V(2)  M/V(2); ... % second row 
          lam*V(1)/V(3)  (C+M+lam*V(2))/V(3)  -(C+M)/V(3)]; % third row


% 4. execute numerical integration
G1 = eye(3,3) + dt*A1; % Euler forward
H1 = inv(eye(3,3) - dt*A1); % Euler backward
G2 = eye(3,3) + dt*A2; % Euler forward
H2 = inv(eye(3,3) - dt*A2); % Euler backward

for n=1:(N-1)
    if n<=N/2 % full circ. for the first half of the simulation
        G=G1; 
        H=H1;
        A=A1;
        Xa(:,n+1)= expm(A*time(n+1))*Xa(:,1); % analytic solution

    elseif n>N/2 % 50% weaker circulation for the second half
        G=G2; 
        H=H2;
        A=A2;
        Xa(:,n+1)= expm(A*time(n+1-N/2))*Xa(:,N/2); % analytic solution

    end
    
    X(:,n+1) = G*X(:,n); % Euler step forward
    Xb(:,n+1) = H*Xb(:,n); % Euler backward 
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
axis([0 20 0 .5e6]);
ylabel('Biological P export, molP/s');
title('Biological P export');

% spell out the changes in biological production
disp(['Biological P export decreases from ', ... 
    num2str(BioExport(N/2),2),'molP/sec to ', ... 
    num2str(BioExport(N),2),'molP/sec before and after ', ... 
    'the 50 percent reduction in C and M.']);

%% Part II: river input and sediment burial

% River input of P to low latitude
Rp = 1e3; % molP/sec
b = [Rp/V(1); 0; 0];

% Reformulate the model to bury some sinking organic P. 
C=20e6; 
M=80e6;     
f=0.01; % fraction of sinking organic that is buried
A = [ -(C+lam*V(1))/V(1)       0              C/V(1); ... % first row 
        C/V(2)        -(C+M+lam*V(2))/V(2)  M/V(2);   ... % second row 
        (1-f)*lam*V(1)/V(3)  (C+M+(1-f)*lam*V(2))/V(3)  -(C+M)/V(3)]; % third row

% Implicit scheme only
dt = 60*60*24*365*10; % 10 year timestep
N  = 25000; % 250,000 year simulation
H = inv(eye(3,3) - dt*A); % Euler backward
time=0:dt:(N-1)*dt; % set up time array

% start time stepping
clear Xb Xf Xa;
Xb(:,1)=[1; 1; 1]*2e-3;
for n=1:(N-1)    
    Xb(:,n+1) = H*Xb(:,n)+dt*b; % Euler backward 
end

% analytic solution
Xa = -inv(A)*b;

figure(2);
time=0:dt:(N-1)*dt;
year = time/(60*60*24*365);    

plot(year,Xb);
hold on;
plot(year(end),Xa,'kx');
hold off;

xlabel('time');
ylabel('P concentration');
legend({'low lat' 'high lat' 'deep' 'Analytic solutions'});
title('Euler backward');

