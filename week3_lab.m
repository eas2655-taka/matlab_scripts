%% week 3 lab

close all;
clearvars;

% display meta data
%ncdisp('air.mon.mean.nc');

%% load in monthly mean surface air temp data
lat=ncread('air.mon.mean.nc','lat');
lon=ncread('air.mon.mean.nc','lon');
time=ncread('air.mon.mean.nc','time');
time=time/24/365+1800;
air=ncread('air.mon.mean.nc','air');

%% extract temperature at equator
J=find(lat==0);   % find index for lat=0
Teq=air(:,J,:);
Teqm=mean(Teq,1); % average all longitude
Teqm=squeeze(Teqm);

figure(1);
plot(time,Teqm);  % take a look at the data 

% calculate annual mean
Teq_matrix = reshape(Teqm(1:68*12),12,68); % set up a matrix
Teq_annual = mean(Teq_matrix,1); % take averages of 12 months
year = 1948:2015; % set up new time axis

hold on;
plot(year,Teq_annual,'r-');

%% evaluate the 2005-2015 mean temperature

% 1. Confidence level
CL = .99;

% 2. Null hypothesis and alternate hypothesis
% H0: the 2005-2015 mean is not different from long term mean
% H1: the 2005-2015 mean is warmer than long term mean
mu = mean(Teq_annual)
J = find(year>=2005);
X = Teq_annual(J);
Xave = mean(X)
Xstd = std(X)
N = length(X)

% 3. use Student's t-dist with two tail test

% 4. calculate critical region
tcrit = tinv(.5*(CL+1),N-1)

% 5. evaluate the hypothesis
tval = (Xave-mu)/(Xstd/sqrt(N-1))

% The data rejects H0. 2005-2015 temperature is significantly warmer. 

