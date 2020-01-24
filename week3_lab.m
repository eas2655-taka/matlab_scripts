%% week3_lab.m

% by Taka Ito

%% week3 

close all
clear all

load Athens_temperature.mat;

% Quick look at the data
plot(year,annual,'k.-');
xlabel('time');
ylabel('Athens annual temperature, deg F');

% Part 1. Monte Carlo method

% 1. set CL
CL = .99;

% 2. H0: Athens (2010-2019) is not significantly warmer than ltm
%    H1: Athens (2010-2019) is significantly warmer than ltm

% 3. State statistic: Monte Carlo
disp('--- part 1. Monte Carlo approach ---')
K=10000; % 10000 random sampling
N=10;    % sample number 
for k=1:K
    data=randsample(annual,N);
    M(k)=mean(data);
end
figure(2);
hist(M);
xlabel('10-year mean temp');
ylabel('# of occurrence');

% 4. calculate confidence interval
Tcrit = prctile(M,CL*100);
disp(['confidence interval is T < ',num2str(Tcrit), ... 
    ' deg F with 99% probability']);

% 5. evaluate the hypothesis
Ttest = mean(annual(71:80));
if Ttest > Tcrit
    disp(['Ttest is ',num2str(Ttest), 'deg F', ...
        ', so H0 is rejected.']);
else
    disp(['Ttest is ',num2str(Ttest), 'deg F', ...
        ', so H0 cannot be rejected.']);
end

%% Part 2. Student's t-distribution

% 1. set CL
CL = .99;

% 2. H0: Athens (2010-2019) is not significantly warmer than ltm
%    H1: Athens (2010-2019) is significantly warmer than ltm

% 3. State statistic: Monte Carlo
disp('--- part 2. t-test ---')
N=10;    % sample number 
df=N-1;

% 4. calculate confidence interval
tcrit = tinv(CL,df);
disp(['confidence interval is t < ',num2str(tcrit), ... 
    ' with 99% probability']);
mu=mean(annual); % population mean (long term mean)
s=std(annual(71:80)); % sample std
SE=s/sqrt(N-1);       % standard error
xcrit = mu+tcrit*SE;  % critical temp
disp(['equivalnetly, confidence interval is T < ',num2str(xcrit), ... 
    ' with 99% probability']);

% 5. evaluate the hypothesis
% t-statistic of the last 10 year mean temp
ttest = (mean(annual(71:80)) - mu)/SE;
xtest = mean(annual(71:80));

if ttest > tcrit
    disp(['t value is ',num2str(ttest), ...
        ', so H0 is rejected.']);
    disp(['Ttest is ',num2str(xtest), ...
        'deg F, so H0 is rejected.']);
else
    disp(['t value is ',num2str(ttest), ...
        ', so H0 cannot be rejected.']);
    disp(['Ttest is ',num2str(xtest), ...
        'deg F, so H0 is rejected.']);
end


