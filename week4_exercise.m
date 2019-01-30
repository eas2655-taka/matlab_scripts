%% week4_exercise

% Taka Ito

% safety first
clear all;
close all;
clc;

% load the data 
load atlanta_temperature.mat;

% Compare (1980-1989) versus (2009-2018)
I1=find(Year>=1980&Year<1990); % sample 1
I2=find(Year>=2009&Year<2019); % sample 2
X1=Annual(I1); % 1980s
X2=Annual(I2); % 2009-2018
% calculate means
X1ave=mean(X1);
X2ave=mean(X2);
% calculat variances
X1var=var(X1);
X2var=var(X2); 
disp(['Mean and variance (1980-1989) are ',num2str(X1ave),' degF and ', ...
    num2str(X1var),' degF2. ']);
disp(['Mean and variance (2009-2018) are ',num2str(X2ave),' degF and ', ...
    num2str(X2var),' degF2. ']);

% 1-1. Confidence level
CL=.95;
disp(['Confidence level is ',num2str(CL*100),' percent.']);

% 1-2. Hypotheses
disp(['H0 (null) : The two periods are not significantly different. ']);
disp(['H1 (alt) : The (2009-2018) mean is significantly warmer than 1980s. ']);

% 1-3. Statistics
disp(['The t-statistics will be used with two tail test. ']); 

% 1-4. Calculate the critical t-value
N1=length(X1);
N2=length(X2);
df=N1+N2-2; % degree of freedom
tcrit=tinv((CL+1)/2,df); % tinv is the CDF of t-distribution
disp(['The critical t-value is ',num2str(tcrit)]);

% 1-5. Evaluate the data
sigma = sqrt( (N1*X1var+N2*X2var)/(N1+N2-2) );
t = (X2ave - X1ave)/(sigma*sqrt(1/N1+1/N2));
disp(['The t-value of the data is ',num2str(t)]);

if abs(t) > tcrit
    disp('The t-value of the data is greater than t-critical. H0 is rejected. '); 
else
    disp('The t-value of hte data is smaller than t-critical. H0 is NOT rejected. ');
end

% 2. Regression
I=find(Year>=1980); % find data points after 1980
Y=Annual(I); % y = annual temp
X=Year(I);   % x = time

% 2-1. slope and intercept of linear regression
C = cov(X,Y);
a1= C(1,2)/C(1,1); % slope
a0=mean(Y)-a1*mean(X); % intercept
disp(['The slope = ',num2str(a1),' degF/Year and the intercept is ',num2str(a0)]);

% 2-2. plot the regression line and the data
figure(1);
plot(X,Y,'k.');
hold on;
x=1980:2019; % x axis in year
yest=a0+a1*x; % linear regression
plot(x,yest,'r-');
hold off;
xlabel('YEAR');
ylabel('Annual temp of Atlanta');

% 2-3. R2
R2 = C(1,2)^2/(C(1,1)*C(2,2));
disp(['R2 = ',num2str(R2),'. R2 is the fraction of variance explained by the regression. ']);


































return
% plot temperature time series
figure(1); 
plot(Year,Annual);
xlabel('time');
ylabel('ATL temperature, degree F');

% least square fit
Y = Annual;
X = Year;
C = cov(X,Y);
a1= C(1,2)/C(1,1);
a0= mean(Y)-a1*mean(X);

% plot the result
x=1870:2018;
y=a0+a1*x;
figure(1);
hold on;
plot(x,y,'r-');

% calculate R2
R2 = C(1,2)^2/C(1,1)/C(2,2);
disp(['R2 value is :',num2str(R2)]);




