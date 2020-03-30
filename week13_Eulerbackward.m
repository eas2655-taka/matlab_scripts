%% week13 exercise

close all
clear all

% 1. set parameters (from text)
VL = 3e16; 
VH = 1.6e16;
VD = 1.4e18;
C = 6e7;
M = 8e7;
lambda = 3.2e-8;

% parameter normalized by volume
cL = C/VL;
cH = C/VH;
cD = C/VD;
mH = M/VH;
mD = M/VD;

% time axis
dt = 60*60*24*30*12; % yearly time step
time=0:10;       % time in month
N=length(time);
P=zeros(3,N);     % P array
P(:,1)=[2;2;2];   % initial condition for P

% 2. time step loop
% model matrix T
T = [-(cL+lambda) 0 cL; cH -(cH+mH+lambda) mH; ... 
    lambda*VL/VD cD+mD+lambda*VH/VD -(cD+mD)];
for n=1:N-1
    P(:,n+1) = inv(eye(3)-dt*T)*P(:,n);
end

% 3. visualization
figure(1);
p=plot(time,P);
xlabel('time, year');
ylabel('P concentration, mmolP/m3');
legend(p,{'P_L' 'P_H' 'P_D'})




