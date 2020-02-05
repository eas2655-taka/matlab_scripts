%% week5

close all
clear all

% set time range
range=[1940 2018];

%load data
load atlanta_temperature.mat;
time1=Year;
temp1=Annual;
I=find(time1>=range(1)&time1<=range(2));
time1=time1(I);
temp1=temp1(I);

%load data
load boulder_temperature.mat;
time2=year1;
temp2=annual;
I=find(time2>=range(1)&time2<=range(2));
time2=time2(I);
temp2=temp2(I);

% quick look
figure(1)
p(1)=plot(time1,temp1,'k-');
xlabel('time');
ylabel('temperature, degF');
hold on;
p(2)=plot(time2,temp2,'r-');
hold off;
legend(p,{'Atlanta' 'Boulder'});

% calculate correlation coefficient
c=cov(temp1,temp2);
r=c(1,2)/sqrt(c(1,1)*c(2,2));
disp(['r value is : ',num2str(r)]);

% Testing the significance
CL=95; % 1. set CL
% H0: there is no significant positive correlation
% H1: there is significant positive correlation
% 3. t-test, 1 tail 
% 4. confidence interval
N=length(temp1);
df=N-2;
tcrit=tinv(CL/100,df);
% 5. Evaluate the hypothesis with the data
t = r*sqrt((N-2)/(1-r*r));





