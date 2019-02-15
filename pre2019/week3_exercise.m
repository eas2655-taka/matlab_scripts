%% week3 exercise

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

% compare 1990s and 2000s 
n90s=find(Year>=1990 & Year<2000);
n00s=find(Year>=2000 & Year<2010);

% calculate two average temperatures
X1ave = mean(Annual(n90s))
X2ave = mean(Annual(n00s))

% visualize them
hold on;
plot(Year(n90s),X1ave*ones(10,1),'r-','linewidth',3);
plot(Year(n00s),X2ave*ones(10,1),'g-','linewidth',3);

% 1. Use 95% CL
CL = .95;

% 2. Null hypothesis
% H0: 2000s and 1990s aren't significantly different
% H1: 2000s is cooler than 1990s. 

% 3. Two tail test

% 4. Critical t-value
N1 = length(n90s);
N2 = length(n00s);
df = N1+N2-2;
tcrit = tinv(.5*(CL+1),df)

% 5. Evaluate the hypothesis
X1std=std(Annual(n90s));
X2std=std(Annual(n00s));
sigma = sqrt((N1*X1std^2+N2*X2std^2)/(N1+N2-2))
tval=(X1ave-X2ave)/(sigma*sqrt(1/N1+1/N2))

% display result
disp(['critical t-value is : ',num2str(tcrit)]);
disp(['observed t-value is : ',num2str(tval)]);

% The magnitude of observed t value is less than the critical t value. 
% Thus we cannot reject the null hypothesis. 
% 2000s and 1990s mean temperatures are not significantly different. 

return
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







