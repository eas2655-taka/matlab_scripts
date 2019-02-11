%% week6_exercise

% safety first
clear all
close all
clc

% read metadata
%ncdisp('air.mon.mean.nc');

% read in data
lon=ncread('air.mon.mean.nc','lon');
lat=ncread('air.mon.mean.nc','lat');
time=ncread('air.mon.mean.nc','time');
air=ncread('air.mon.mean.nc','air');

% decimal year
year = 1800+time/24/365.25;

% select July temperature
year1 = year(7:12:end);
air1  = air(:,:,7:12:end);

Nx=length(lon);
Ny=length(lat);
CL=0.95; % 95% confidence level

for i=1:Nx
    for j=1:Ny
        % set x = time, y = air temp (i,j) 
        X=year1;
        Y=squeeze(air1(i,j,:));
        [a,r,CI]=regrcorr2(X,Y,CL);
        trd(i,j)=a(1);
        r2(i,j)=r*r;
        confint(i,j)=CI;
    end
end

% set up a matrix indicating significant trend
trdsig=ones(Nx,Ny);
trdsig(abs(trd)<confint)=0;

% set up matrices for long and lat
[xx,yy]=meshgrid(lon,lat);
xx=xx'; yy=yy';

% replace the values of long and lat to NaN if no trend
xx(trdsig==0)=NaN;
yy(trdsig==0)=NaN;

% add m_map package to the MATLAB path
addpath m_map
cmp=[linspace(0,1,32)' linspace(0,1,32)' ones(32,1); ...
    ones(32,1) linspace(1,0,32)' linspace(1,0,32)'];

% plot the data using m_map package
figure(1);
m_proj('robinson'); % robinson projection (global)
lon(145)=lon(1)+360; % add 1 x-point to overlap
trd(145,:)=trd(1,:);
% then plot
m_pcolor(lon,lat,trd');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,trd');
% plot dots for significance
m_plot(xx(:),yy(:),'k.');
m_plot(xx(:)-360,yy(:),'k.');

m_coast; % draws coastlines
m_grid('xaxis','middle'); % adds grid line
shading flat; % removes grid lines
colormap(cmp); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface Jan air temperature trend');
caxis([-.2 .2]);

% repeat the plot without not significant data points

% plot the data using m_map package
figure(2);

% remove not significant trend
trdsig(145,:)=trdsig(1,:);
trd(trdsig==0)=NaN;

m_proj('robinson'); % robinson projection (global)
% then plot
m_pcolor(lon,lat,trd');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,trd');
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
title('surface Jan air temperature trend');
caxis([-.2 .2]);

