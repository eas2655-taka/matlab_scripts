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

% time axis : dt = 1 month
dt = 60*60*24*30; 
time = 0:120;     % 10 year time series
N=length(time);
P=zeros(3,N);     % initialize P array
P(:,1) = [2; 2; 2]; % mmolP/m3

% 2. time step loop
% model matrix T
T = [-(cL+lambda) 0 cL; cH -(cH+mH+lambda) mH; ... 
    lambda*VL/VD cD+mD+lambda*VH/VD -(cD+mD)];
for n=2:N
    P(:,n)=expm(T*time(n)*dt)*P(:,1);
end
    
% 3. visualization
figure(1);
p=plot(time,P);
xlabel('time');
ylabel('P concentration, mmol/m3');
legend(p,{'P_L' 'P_H' 'P_D'});





