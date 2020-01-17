%% week7_lab

close all
clear all
clc

load MLO_CO2.mat;

X=year;
Y=pCO2;

% plot the raw data
figure(1);
p(1)=plot(X,Y,'k-');
xlabel('time');
ylabel('partial pressure of CO2 in ppm');

% linear regression
N = length(Y); % count the number of data points
Xp= X-mean(X); % Xp is anomaly in X

% set up E matrix
E(1:N,1)=1;   
E(1:N,2)=Xp;
E(1:N,3)=sin(2*pi*Xp);

% calculate regression coefficient
a=inv(E'*E)*E'*Y;

% Y estimate = E*a
Yest = E*a;
R2=var(Yest)/var(Y);

figure(1);
hold on;
p(2)=plot(X,Yest,'b-');

legend(p,{'Raw' 'inverse'})

%% analytic solution
disp(['X0 is ',num2str(a(1)),'ppm and is set to Year ',num2str(mean(X))]);
X0=a(1);
disp(['F-O is ',num2str(a(2),3),' ppm/yr']);
FmO=a(2);
disp(['B is ',num2str(a(3)*2*pi,3),'ppm']);
B=a(3)*2*pi;

% set time axis
time=1992:1/12:2015;
% analytic solution
co2a=X0+B/(2*pi)*sin(2*pi*(time-mean(X)))+FmO*(time-mean(X));

figure(1);
hold on;
p(3)=plot(time,co2a,'g-');
legend(p,{'Raw' 'inverse' 'analytic'})

% numerical solution
dt = 1/12; % set time step
time = 1992:dt:2015;
M = length(time);

% initial condition for 1992
co2n(1)=X0-FmO*(mean(X)-time(1)); 

% loop over M time step
for n=1:M-1
    co2n(n+1)=co2n(n)+dt*( B*cos(2*pi*time(n)) + FmO );
end

figure(1);
hold on;
p(4)=plot(time,co2n,'m-');
legend(p,{'Raw' 'inverse' 'analytic' 'numerical'})













