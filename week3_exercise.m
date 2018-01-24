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

% generate random number to sample 
Annual = Annual(range);
Year = Year(range);
N = 6; % take N samples
M = 1000; % repeat sampling

for i=1:M
    
n = floor(rand(N,1)*137)+1; % generate random number
X = Annual(n);
% hold on;
% plot(Year(n),X,'ro');
% hold off;
Xave(i) = mean(X);
Xstd(i) = std(X);
t(i) = (Xave(i) - tempmn)/(Xstd(i)/sqrt(N-1));

end

% plot the histogram
figure(2);
hist(t,[-10:.25:10]);
hold on;
t0 = -10:.25:10;
y0 = tpdf(t0,N-1);
plot(t0,y0*M*.25,'linewidth',2);

% 4. calculate tcrit
tcrit = tinv(.975,N-1);

% t-test
n = find(Year>=2010);
X = Annual(n);
Xave = mean(X);
Xstd = std(X);
t = (Xave - tempmn)/(Xstd/sqrt(N-1));







