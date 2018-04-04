%% week13_exerise.m 

% safety first
close all;
clear all;

% set parameters
k=2*pi;
w=2*pi;
dk=.2;
dw=-.5;

L=30;
dx=0.1;
x=-L:dx:L;
dt=0.1;
time=0:dt:30;
Nt=length(time);

% plot the wave
for t=1:Nt
    f1 = sin((k+dk)*x-(w+dw)*time(t));
    f2 = sin((k-dk)*x-(w-dw)*time(t));
    
    % plot
    figure(1);
    % plot f1 in the top panel
    subplot(3,1,1)
    plot(x,f1);
    xlabel('x');
    ylabel('f1');
    
    % plot f2 in the middle panel
    subplot(3,1,2)
    plot(x,f2);
    xlabel('x');
    ylabel('f2');
    
    % plot f1+f2 in the bottom
    subplot(3,1,3)
    plot(x,f1+f2);
    xlabel('x');
    ylabel('f1+f2');

    drawnow;
end
