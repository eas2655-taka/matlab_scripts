%% trend map

% safety first
clear all
close all
clc

% read metadata
ncdisp('air.mon.mean.nc');

% read in data
lon=ncread('air.mon.mean.nc','lon');
lat=ncread('air.mon.mean.nc','lat');
time=ncread('air.mon.mean.nc','time');
air=ncread('air.mon.mean.nc','air');

% decimal year
year = 1800+time/24/365.25;

% select January temperature
year1 = year(1:12:end);
air1  = air(:,:,1:12:end);

Nx=length(lon);
Ny=length(lat);

for i=1:Nx
    for j=1:Ny
        % set x = time, y = air temp (i,j) 
        X=year1;
        Y=squeeze(air1(i,j,:));
        [a,r]=regrcorr(X,Y);
        trd(i,j)=a(1);
        r2(i,j)=r*r;
    end
end

% add m_map package to the MATLAB path
addpath m_map

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
m_coast; % draws coastlines
m_grid('xaxis','middle'); % adds grid line
shading flat; % removes grid lines
colormap('jet'); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface Jan air temperature trend');
caxis([-.2 .2]);




