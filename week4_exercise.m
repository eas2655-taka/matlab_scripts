%% week4_exercise.m 

% safety first
clear all;
close all;

% load AtlantaTemp data
load AtlantaTemp.mat

% set range to 2nd thru 138th entry
range = 2:138;

% make a time series plot
plot(Year(range),Annual(range));
xlabel('Time','fontsize',16);
ylabel('Atlanta Temperature, deg F','fontsize',16);
axis([1879 2015 58 66]);

% regression coeff
range = find(Year>=1879&Year<2015);

x=Year(range);
y=Annual(range);
xyave = mean(x.*y);
xave = mean(x);
yave = mean(y);
x2ave= mean(x.^2);
y2ave= mean(y.^2);
a = (xyave-xave*yave)/(x2ave-xave^2); % regression coeff. 
b = yave - a*xave;
R = (xyave-xave*yave)/sqrt((x2ave-xave^2)*(y2ave-yave^2));

% plot the regression lien over the data
hold on;
x0 = Year(range);
y0 = a*x0+b;
plot(x0,y0,'r-');
hold off;

% check the fraction of variance explained by the regression

Ratio = var(y0)/var(y);











