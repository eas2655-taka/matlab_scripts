%% week1_exercise

% safety first
clear all;
close all;
clc;

load atlanta_temperature.mat;

% plot temperature time series
figure(1); 
plot(Year,Annual);
xlabel('time');
ylabel('ATL temperature, degree F');

% calculate statistics
Tave = mean(Annual);
Tstd = std(Annual);
Tmedian = median(Annual);
% Tmedian = prctile(Annual,50);
Tiqr = iqr(Annual);
disp(['Mean temperature is ',num2str(Tave)]); 

% histogram
figure(2);
hist(Annual,57:.5:67);

% superimpose gaussian plot
x = 57:.1:67;
g = 1/(sqrt(2*pi)*Tstd)*exp(-.5*((x-Tave)/Tstd).^2);
N = length(Annual);
hold on; %superimpose the plot command below
plot(x,g*N*.5,'r-');
hold off;
xlabel('Temperature, degree F');
ylabel('# of occurrence');

% Boxwhiskar diagram
figure(3);
Temp = [Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec];
boxplot(Temp);









