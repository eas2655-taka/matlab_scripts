%% HW8.m 

close all
clear all

%% 1 and 2. C-14 decay
t12 = 5730; 
lam = log(2)/t12;

% set up time axis
dt = 1; 
time = 0:dt:20000;
C0 = 1;

% analytic solution
Ca = C0*exp(-lam*time);

%% 3. Euler forward
Cf(1)=C0;
for n=1:length(time)-1
    Cf(n+1) = (1 - lam*dt)*Cf(n);
end

%% 4. Euler backward
Cb(1)=C0;
for n=1:length(time)-1
   Cb(n+1)=1/(1+lam*dt) * Cb(n);
end

%% 5. plot them altogether
figure(1);
p(1)=plot(time,Ca,'k-');
hold on;
p(2)=plot(time,Cf,'b--');
p(3)=plot(time,Cb,'r-.');
hold off;

xlabel('time(year)');
ylabel('concentration');
legend(p,{'Analytic' 'Euler forward' 'Euler backward'});

%% 6. Predator-Prey equation
a=1;
b=1;
c=1;

% calculate the steady solution
X0 = c/b;
Y0 = a/b;

% numerically integrate

% setting up time
dt = 0.01;
time = 0:dt:100;

% setting up init cond
X(1)=.9;
Y(1)=.9;

% integrate
for n=1:length(time)-1
    
    % calculate tendency
    Gx = a*X(n)-b*X(n)*Y(n);
    Gy = b*X(n)*Y(n)-c*Y(n);
    
    % euler step (prediction)
    Xp=X(n)+dt*Gx;
    Yp=Y(n)+dt*Gy;
    
    % re-calculate tendency
    Gx = a*Xp-b*Xp*Yp;
    Gy = b*Xp*Yp-c*Yp;
    
    % euler step (correction)
    X(n+1)=X(n)+dt*Gx;
    Y(n+1)=Y(n)+dt*Gy;

end

% plot the result as a time series
figure(2);
q(1)=plot(time,X,'b-');
hold on;
q(2)=plot(time,Y,'r-');
plot(time,X0,'b.');
plot(time,Y0,'r.');
hold off;

xlabel('time');
ylabel('population');
legend(q,{'prey' 'predator'})

























