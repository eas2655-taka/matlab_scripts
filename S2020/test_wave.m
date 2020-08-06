%% week14_exercise_1

clear all;

% set parameters
k = 1;    % wave number
lambda = 2*pi/k; % wave length
omega = 1; % angular frequency
T = 2*pi/omega; % period

% spatial domain
x=-10:.1:10; % x domain
t=0:.1:30;   % t domain
N=length(t); % number of time points

figure(1);
for n=1:N
    u=sin(k*x-omega*t(n));
    plot(x,u,'k-');
    xlabel('x, length');
    ylabel('u, wave function');
    title(['time=',num2str(t(n),2)]);
    drawnow;
end
