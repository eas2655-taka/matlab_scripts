%% week9_exercise.m

close all;
clear all;

load MLO_CO2.mat;
x = year;
y = pCO2;
N = length(x);

E = [ones(N,1) x cos(2*pi*x) sin(2*pi*x)];
% calculate pseudo inverse
a = inv(E'*E)*E'*y;

% plot regression
figure(1);
p(1)=plot(x,y,'k-'); % orig data
hold on;
p(2)=plot(x,E*a,'r--'); % MLR fit

% Analytic solution to the box model
Xo = 350; % initial cond
F = 4; % fossil fuel emission, ppm/yr
O = 2; % ocean/land uptake
B = 25; % biospheric flux
X = (F-O)*(x-x(1)) + B/(2*pi)*sin(2*pi*x) + Xo; 
p(3)=plot(x,X,'b-'); % Analytic solution to Box model

% Numerical solution (Euler's method)
dt=1/12;
time = x(1):dt:2017;
N = length(time); 
Xnum(1)=Xo;
for n=1:N-1
   Xnum(n+1)=Xnum(n)+dt*( F-O + B*cos(2*pi*time(n)) );
end
p(4)=plot(time,Xnum,'g-'); % Numerical solution to Box model

legend(p,{'OBS' 'MLR' 'Analytic' 'Numerical'})
