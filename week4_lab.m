%% week4_lab.m

% safety first, clean up  
close all
clearvars

% time period of analysis
per = [1880 2010];

% load Atlanta data
load AtlantaTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
x = Year(range);
yA= Annual(range);
clear Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec

% load Savannah 
load SavannahTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
x = Year(range);
yS= Temp_annual(range);

% plot the raw data
figure(1);
p(1)=plot(x,yA,'b-');
hold on;
p(2)=plot(x,yS,'r-');
xlabel('Year','fontsize',15);
ylabel('Temperature','fontsize',15);
legend(p,{'Atlanta' 'Savannah'},'fontsize',13)

% calculate linear trend
for i=1:2
    if i==1 % Atlanta
        y=yA;
    elseif i ==2 % Savannah
        y=yS;
    end
    cm = cov(x,y); % covariance matrix
    a(i) = cm(1,2)/cm(1,1);
    b(i) = mean(y) - a(i)*mean(x);
end
% regression line
yAreg = a(1)*x + b(1);
ySreg = a(2)*x + b(2);

% plot the lines
%plot(x,yAreg,'b--');
%plot(x,ySreg,'r--');

% detrending
yAd = yA - yAreg;
ySd = yS - ySreg;

% open new figure and plot the detrended time series
figure(2);
p(1)=plot(x,yAd,'b-');
hold on;
p(2)=plot(x,ySd,'r-');
xlabel('Year','fontsize',15);
ylabel('De-trended Temperature','fontsize',15);

% calculate correlation
cm = cov(yAd,ySd);
R = cm(1,2)/sqrt(cm(1,1)*cm(2,2));

% load AMO index
load AMO.mat
range = find(Year_AMO>=per(1)&Year_AMO<=per(2));
x = Year_AMO(range);
yAMO= AMO_annual(range);
yAMO=yAMO/std(yAMO);

p(3)=plot(x-10,yAMO,'k--','linewidth',3);
legend(p,{'Atlanta' 'Savannah' 'AMO'},'fontsize',13);





