% Week 10: Exercise 1 
% Fourier analysis of Atlanta temperature
% Fourier series & Low-pass filtering

%% safety first
clc;clear;close all;fclose all;

%% load data, extract time and July temperature for Atlanta

data=xlsread('./ATL_MonMeanTemp_1879_2020.xls');
year=data(:,1); % get time
TMP_ATL_month=data(:,2:end); % get temperature for all months
TMP_ATL_JUL=TMP_ATL_month(:,7); % get temperture for July

%% make a simple plot
figure(1);
hold on;
plot(year, TMP_ATL_JUL,'-');
xlim([1875 2025]);

%% set up parameters for Fourier transform
x=year;
y=TMP_ATL_JUL;
N=length(x);  % number of data points
dT=1;  % data points are 1 year apart
T=x(end)-x(1)+1; % the length of data record

%% set up Fourier coefficients
K = ceil((N+1)/2); % set the number to calculate
A = zeros(K,1);
B = zeros(K,1);
for n=1:K
    cosn=cos(2*pi*(n-1)*x/T);
    sinn=sin(2*pi*(n-1)*x/T);
    A(n)=2/T*y'*cosn*dT;
    B(n)=2/T*y'*sinn*dT;
end

%% assemble Fourier Series
yest=A(1)/2*ones(N,1);
for n=2:K
    cosn=cos(2*pi*(n-1)*x/T);
    sinn=sin(2*pi*(n-1)*x/T);
    yest=yest+A(n)*cosn+B(n)*sinn;
end

%% plot the result
fig=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits',...
    'inches','PaperSize',[8.5 11],...
    'PaperPosition',[2.5 2.5 3.5 2.5],'visible','on');
ax= axes('Parent',fig,'LineWidth',1,...
     'Layer','top','FontSize',12,'FontName','Arial','box','off','color','none',...
     'YAxisLocation','left','XAxisLocation','bottom');
hold on;
plot(x,y,'-','DisplayName','Raw data'); % plot the raw data
plot(x,yest,'--','linewidth',2,'DisplayName',[num2str(K),' term FS']); % plot the FS
xlabel('Year');
ylabel('Atlanta temperature, July');
l1=legend('box','off','location','northwest');
xlim([1875 2025]);



%% plot the prediction using K<=10
% smooth data using FT filter
yest2=A(1)/2*ones(N,1);
for n=2:10
    cosn=cos(2*pi*(n-1)*x/T);
    sinn=sin(2*pi*(n-1)*x/T);
    yest2=yest2+A(n)*cosn+B(n)*sinn;
end

%% plot the result
fig=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits',...
    'inches','PaperSize',[8.5 11],...
    'PaperPosition',[2.5 2.5 3.5 2.5],'visible','on');
ax= axes('Parent',fig,'LineWidth',1,...
     'Layer','top','FontSize',12,'FontName','Arial','box','off','color','none',...
     'YAxisLocation','left','XAxisLocation','bottom');
hold on;
plot(x,y,'-','DisplayName','Raw data'); % plot the raw data
plot(x,yest2,'--','linewidth',2,'DisplayName',[num2str(10),' term FS']); % plot the FS
xlabel('Year');
ylabel('Atlanta temperature, July');
l1=legend('box','off','location','northwest');
xlim([1875 2025]);






