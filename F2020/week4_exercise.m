%% week4 exercise

close all
clear all

%% generate a synthetic data
x = 0:100;
y = 0.5*x;
n = 10*randn([1 101]);

%% quick look
yy = y + n; % add noise to the signal for yy
plot(x,yy);  % plot the signal+noise
hold on;
plot(x,y);   % plot the signal only
legend({'signal+noise' 'signal only'});

%% perform linear regression
C = cov(x,yy);
a = C(1,2)/C(1,1);
b = mean(yy) - a*mean(x);
disp(['regression coefficient is ',num2str(a)]);

%% plot the result
yyy=a*x+b;
plot(x,yyy,'linewidth',2);
legend({'signal+noise' 'signal only' 'linear regression'});

%% Pseudo inverse
N=length(x);
E = ones(N,2);
E(:,1)=x;
E(:,2)=1;
ab=inv(E'*E)*E'*yy';
disp(['regression coefficient is ',num2str(ab(1))]);

%% plot the result
yyyy=E*ab;
plot(x,yyyy,'.','linewidth',2);
legend({'signal+noise' 'signal only' 'linear regression' 'pseudo inv'});





