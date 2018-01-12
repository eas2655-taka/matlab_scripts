%% week1 exercise

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

% mean over 1879 to 2015
tempmn = mean(Annual(range));
disp(['average temperature over 1879 to 2015 is ',num2str(tempmn),' deg F.'])

% calculate median
tempmd = prctile(Annual(range),50);
disp(['median temperature over 1879 to 2015 is ',num2str(tempmd),' deg F.'])

% calculate IQR
tempIQR =  prctile(Annual(range),75) -  prctile(Annual(range),25);
disp(['IQR of temperature over 1879 to 2015 is ',num2str(tempIQR),' deg F.'])

% standard deviation
N = length(range);
tempvar =N/(N-1)*(mean(Annual(range).^2)-tempmn^2);
tempstd = sqrt(tempvar);
disp(['STDEV of temperature over 1879 to 2015 is ',num2str(tempstd),' deg F.'])

%% plot histogram
figure(2); % open 2nd figure window
hist(Annual(range),[57:68]);
xlabel('Temperature','fontsize',16);
ylabel('number of occurence','fontsize',16);

x =57:0.1:68;
y = N/(sqrt(2*pi)*tempstd)*exp(-0.5*((x-tempmn)/tempstd).^2);
hold on;
plot(x,y,'g-','linewidth',2);
hold off;




