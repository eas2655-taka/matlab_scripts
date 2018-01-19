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

%% calculate climatology

% generate a matrix including all months
all = [Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec];

% select 1989 to 2015
all0= all(range,:);

% calculate climatology
clim= mean(all0,1);

% plot monthly climatology
figure(3);
plot(1:12,clim,'k-');
ylabel('climatological temperature','fontsize',14);
set(gca,'xtick',2:2:12);
set(gca,'xticklabel',{'Feb' 'Apr' 'Jun' 'Aug' 'Oct' 'Dec'}); 

% calculate anomalies from the climatology
anom = all0 - repmat(clim,[N 1]);
% for loop method
%for n=1:N
%    anom(n,:) = all0(n,:) - clim;
%end

% convert 137x12 matrix into (137x12) x 1 vector
anom = anom';
anomv=anom(:);
time=1879:1/12:(2016-1/12);
%cnt=0;
%for n=1:N
%    for m=1:12
%       cnt=cnt+1;
%       anomv(cnt) = anom(n,m);
%       time(cnt)=1879+1/12*(cnt-1);
%    end
%end

% plot temperature anomaly
figure(4);
plot(time,anomv,'k-');
ylabel('temperature anomaly','fontsize',14);
xlabel('time','fontsize',14);

