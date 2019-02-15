%% week6_nino

% safety first
close all
clear all
clc

% for the month of Jan
mon=1;

% read in nino34SST.mat
load nino34SST.mat
nino=nino34a_monthly(mon:12:end);
nyear=1950:2017;%year_monthly(mon:12:end);

%plot
plot(nyear,nino,'b-');
xlabel('time');
ylabel('nino 3.4 index');

% read in air temp data
lon=ncread('air.mon.mean.nc','lon');
lat=ncread('air.mon.mean.nc','lat');
time=ncread('air.mon.mean.nc','time');
air=ncread('air.mon.mean.nc','air');

% decimal year
year = 1800+time/24/365.25;

% select a specific month
%year1 = year(mon:12:end);
year1 = 1948:2016;
air1  = air(:,:,mon:12:end);

% select 1950 to 2016
In=find(nyear>=1950&nyear<=2016); % time indices for nino index
Ia=find(year1>=1950&year1<=2016); % time indices for air temp

% calculate the regression / correlation
CL=.95; % 95 % confidence level
[a,r,CI,siga,sigr]=regrcorrmap(nino(In),air1(:,:,Ia),CL); 

% add m_map package to the MATLAB path
addpath m_map
cmp=[linspace(0,1,32)' linspace(0,1,32)' ones(32,1); ...
    ones(32,1) linspace(1,0,32)' linspace(1,0,32)'];

% plot the data using m_map package
figure(1);
a(siga==0)=NaN; % remove non-significant trend to NaN
m_proj('robinson','clon',-150); % robinson projection (global)
lon(145)=lon(1)+360; % add 1 x-point to overlap
a(145,:)=a(1,:);
% then plot
m_pcolor(lon,lat,a');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,a');
% plot dots for significance
%m_plot(xx(:),yy(:),'k.');
%m_plot(xx(:)-360,yy(:),'k.');
m_coast; % draws coastlines
m_grid('xaxis','middle'); % adds grid line
shading flat; % removes grid lines
colormap(cmp); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('Regression of air temp onto Nino 3.4 index, Jan');
caxis([-1 +1]);


% plot the data using m_map package
figure(2);
r(sigr==0)=NaN; % remove non-significant trend to NaN
m_proj('robinson','clon',-150); % robinson projection (global)
lon(145)=lon(1)+360; % add 1 x-point to overlap
r(145,:)=r(1,:);
% then plot
m_pcolor(lon,lat,r');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,r');
% plot dots for significance
%m_plot(xx(:),yy(:),'k.');
%m_plot(xx(:)-360,yy(:),'k.');
m_coast; % draws coastlines
m_grid('xaxis','middle'); % adds grid line
shading flat; % removes grid lines
colormap(cmp); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('Correlation of air temp onto Nino 3.4 index, Jan');
caxis([-1 +1]);





