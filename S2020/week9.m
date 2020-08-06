%% week9
close all
clear all

% load MLO data
load co2_mlo.mat;

I=find(time>=1990);
% assign variables as X and Y
Y=co2(I);
X=time(I)-1990;

% quick look
figure(1);
plot(X,Y,'k.-');
xlabel('time');
ylabel('atmospheric co2, ppm'); 

% empirical model
E=[sin(2*pi*X) X ones(size(X))];
a=inv(E'*E)*E'*Y; % pseudo-inverse
Yest=E*a;
R2=var(Yest)/var(Y);
hold on;
plot(X,Yest,'b-');

% analytic solution
B=2*pi*a(1); % land photosynthesis
FmO=a(2);    % fossil fuel emission - ocean uptake
C=a(3);      % CO2 level in 1990
Ya=B/(2*pi)*sin(2*pi*X) + FmO*X + C;
plot(X,Ya,'r--');
legend({'Raw data' 'inverse' 'analytic'})

% numerical solution
dx=1/360;
x=[1990:dx:2020]-1990;
N=length(x);  % number of time step
Yn(1)=C;      % initial value
for i=1:N-1   % start time stepping
    Yn(i+1)=Yn(i)+dx*( B*cos(2*pi*x(i))+FmO );
end
plot(x,Yn,'g-');
legend({'Raw data' 'inverse' 'analytic' 'numerical'})














