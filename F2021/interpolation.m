clear all
close all

%% set up a 1D sine function
x0 = 0:pi/4:2*pi;
f0 = sin(x0);

%% WORK: linearly interpolate 
x1 = 0:pi/16:2*pi;
f1 = 

%% WORK : spline interpolate at a higher resolution as f2 (one line)
f2 = 

%% plotting
figure(1);
plot(x0,f0,'ko');
hold on;
plot(x1,f1,'b.--');
plot(x1,f2,'m.-');
hold off;

%% set up a 2D Gaussian (10 x 10 points)
x0 = linspace(-2,2,10);
y0 = linspace(-2,2,10);
[y,x]=meshgrid(y0,x0);
f = exp(-x.^2-y.^2);

%% Interpolate it onto (50 x 50 points)
x1=linspace(-2,2,50);
y1= linspace(-2,2,50);
[ynew,xnew]=meshgrid(y1,x1);
% WORK: perform 2D interpolation
fnew=

%% plotting
figure(2);
pcolor(xnew,ynew,fnew);
shading flat;
hold on;
H=scatter(x(:),y(:),50,f(:),'filled');
set(H,'MarkerEdgeColor','w');
hold off;

%% Smoothing of sparse data

% original mathmatical function is y(x) = exp(-x) * sin(2*pi*x) over x=[0,5]
N=100;
x=linspace(0,5,N);
y=exp(-x).*sin(2*pi*x);

% randomly subsample the data
M=50; % set sample size
ind=randi(100,[1 M]);
x0=x(ind);
% subsample the data to make it sparse
y0=y(ind);

% WORK: apply polyfit
C=
% WORK: apply polyval to create a polynomial data vector
yest=

% visualize the result
plot(x,y);
hold on;
plot(x0,y0,'o');
plot(x,yest,'m--');
hold off;
legend({'true signal' 'sample' 'LS estimate'});


