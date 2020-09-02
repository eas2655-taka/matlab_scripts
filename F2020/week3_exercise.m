%% week3 exercise

% safety first!
close all
clear all

%% 1. State the confidence level
CL=0.95;

%% 2. State the null hypothesis and alternative hypothesis

% H0: Mean temp from last 10 years in Boston is NOT significantly warmer than long-term mean
% H1: Mean temp from last 10 years in Boston is significantly warmer than long-term mean 

load bos_temp.tsv
year=bos_temp(:,1);
temp=bos_temp(:,8); % for july => 8th column
temp(temp==-999)=NaN;

figure(1);
plot(year,temp,'.-');
xlabel('year');
ylabel('boston temperature, deg F');
set(gca,'fontsize',16);

% calculate ltm, m10, s10
mu=nanmean(temp);
N=length(temp);
m10=nanmean(temp(N-9:N));
s10=nanstd(temp(N-9:N));
disp(['long term mean is ',num2str(round(mu,2)),' deg F'])
disp(['the last 10 year mean is ',num2str(round(m10,2)),' deg F'])

%% 3. State the statistics used

% We use Student's t-distribution with one-tail test
N=10;
df=N-1;
t=-5:.1:5;
tdist=tpdf(t,df);
figure(2);
plot(t,tdist)
xlabel('t')
ylabel('t-distribution');
set(gca,'fontsize',16);

%% 4. Calculate the critical region
tcrit=tinv(CL,df);
disp(['critical t value is ',num2str(round(tcrit,2))]);

%% 5. Evaluate if the data is within the critical region
tval=(m10-mu)/(s10/sqrt(N-1));
disp(['t value is ',num2str(round(tval,2))]);

% write your conclusion statement!



