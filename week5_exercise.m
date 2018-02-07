%% week5_exercise.m

% safety first, clean up  
close all
clearvars

% time period of analysis
per = [1900 2015];

% load Atlanta data
load AtlantaTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
x = Year(range);
y = Annual(range);
clear Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec

% plot the data and its linear trend
figure(1);
plot(x,y,'ko-');
[a,b,R2]=regression(x,y);
yest=a*x+b;
hold on;
plot(x,yest,'b--');
hold off;

% Is this trend significant?

% 1. confidence level
CL = .95;

% 2. H0: there is no significant trend from 1900 to 2000 in Atlanta temp
%    H1: there is a significant trend

% 3. We use t-test with two tail test
N = length(x);
r = correlation(y(1:N-1),y(2:N));
Neff = N*(1-r)/(1+r);

% 4. Critical region
tcrit = tinv(.5*(CL+1),Neff-2);

% 5. Evaluate the hypothesis
err = y-yest;
SE2 = sum(err.^2)/(Neff-2)/sum((x-mean(x)).^2);
SE = sqrt(SE2);
tval = a/SE;








