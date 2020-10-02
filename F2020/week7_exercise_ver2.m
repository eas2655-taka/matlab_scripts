%% week7 exercise ver 2

close all
clear all

%% load data
atl = load('DATA/atlanta_temperature.tsv');
x = atl(:,1); % year as x
y = atl(:,3); % feb temp as y
N = length(x); % sample size
T = x(N)-x(1)+1; % record length
dt = 1; % time step size

%% calculate Fourier coefficients
K = 10; % set the number to calculate
A = zeros(K,1);
B = zeros(K,1);
for n=1:K
    cosn=cos(2*pi*(n-1)*x/T);
    sinn=sin(2*pi*(n-1)*x/T);
    A(n)=2/T*y'*cosn*dT;
    B(n)=2/T*y'*sinn*dT;
end

%% assemble Fourier Series
yest=A(1)/2*ones(N,1);
for n=2:K
    cosn=cos(2*pi*(n-1)*x/T);
    sinn=sin(2*pi*(n-1)*x/T);
    yest=yest+A(n)*cosn+B(n)*sinn;
end

%% plot the result
figure(1);
plot(x,y,'b-'); % plot the raw data
hold on;
plot(x,yest,'k--','linewidth',2); % plot the FS
hold off;
xlabel('time');
ylabel('atlanta temperature');
legend({'raw data',[num2str(K),' term FS']});
set(gca,'fontsize',16);
