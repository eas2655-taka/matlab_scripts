%% week1 exercise

% Taka Ito

% safety first
close all;
clear all;

%% load data
load atlanta_temperature.tsv

%% define year and annual mean temp (Ann)
yr=atlanta_temperature(:,1);
Ann=mean(atlanta_temperature(:,2:13),2);

%% plot time series
figure(1);
plot(yr,Ann,'k.-','linewidth',1);
xlabel('year','fontsize',16,'color','k');
ylabel('annual mean temperature, deg F','fontsize',16,'color','k');
set(gca,'fontsize',16);
axis([1879 2020 58 67]);

%% plot histogram
% use histogram command
figure(2);
bins=57:.5:68;
histogram(Ann,bins,'facecolor','b','edgecolor','k');
xlabel('temperature','fontsize',16);
ylabel('number of occurrence','fontsize',16);
set(gca,'fontsize',16);

%% overlay Gaussian
N=length(Ann);
mu=mean(Ann);
sig=std(Ann);
x=57:.1:68;
f=.5*N/sqrt(2*pi)/sig*exp(-.5*((x-mu)/sig).^2);
hold on;
plot(x,f,'k-','linewidth',2);
hold off;

%% plot boxcar diagram
% use boxplot command
figure(3);
boxplot(atlanta_temperature(:,2:13));
ylabel('temperature','fontsize',16);
xlabel('month','fontsize',16);
set(gca,'fontsize',16);
set(gca,'fontsize',16);


