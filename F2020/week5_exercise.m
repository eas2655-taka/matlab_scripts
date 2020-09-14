%% week5_exercise: more regression!! 

% safety first
close all
clear all

% load data
load DATA/atlanta_temperature.tsv
x = atlanta_temperature(:,1); % year
y = atlanta_temperature(:,8); % july

% quick look
figure(1);
plot(x,y,'b-');
xlabel('time','fontsize',16);
ylabel('temperature, deg F','fontsize',16);

%% regresion (covariance)
c=cov(x,y);
a=c(1,2)/c(1,1);
b=mean(y)-a*mean(x);
hold on;
yest=a*x+b;
plot(x,yest,'r--');
disp(['a,b=',num2str(a),', ',num2str(b)])

%% regression pseudo iverse
N=length(x);
E=ones(N,2);
E(:,1)=x;
avec=inv(E'*E)*E'*y;
yest=E*avec;
plot(x,yest,'y.');
disp(['a vector=',num2str(avec')])

%% K-th order polynomial fit
K=12;
E=ones(N,K+1);
xx=(x-mean(x))/std(x);
for k=1:K
    E(:,k+1)=xx.^k;
end
avec=inv(E'*E)*E'*y;
yest=E*avec;
plot(x,yest,'m--');
