%% week1 exercise MATLAB

% safety first
close all
clear all

%% load the data (save the excel sheet in the same folder)
%! wget https://o2.eas.gatech.edu/data/ATL_MonMeanTemp_1879_2020.xls
data=xlsread('ATL_MonMeanTemp_1879_2020.xls');

%% extract August and Year
year=data(:,1);
AUG =data(:,9);

%% plot it
figure(1);
plot(year,AUG);
xlabel('year');
ylabel('temperature, deg F');
set(gca,'fontsize',14);

%% calculate mean
AUGave=mean(AUG);
disp(['average August temperature is ',num2str(round(AUGave,2)),' deg F']);

%% histogram
figure(2)
bin=74:1:86;
hist(AUG,bin);
xlabel('temperature');
ylabel('data count');
set(gca,'fontsize',14);

%% box plot
figure(3);
boxplot(data(:,2:13));
ylabel('temperature');
xlabel('month');
set(gca,'fontsize',14);









