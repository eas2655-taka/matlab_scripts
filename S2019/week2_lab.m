%% week2_lab.m

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

% calculate 1970s mean temperature
I = find(year>1970&year<1980);
air70s=mean(air(:,:,I),3);

% calculate 2000s mean temperature
I00s = find(year>2000&year<2010);
air00s=mean(air(:,:,I00s),3);

% calculate the difference
delta = air00s - air70s; 

% add m_map package to the MATLAB path
addpath m_map

% plot the data using m_map package
figure(1);
m_proj('robinson'); % robinson projection (global)
lon(145)=lon(1)+360; % add 1 x-point to overlap
delta(145,:)=delta(1,:);
% then plot
m_pcolor(lon,lat,delta');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,delta');
m_coast; % draws coastlines
m_grid('xaxis','middle'); % adds grid line
shading flat; % removes grid lines
colormap('jet'); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface air temperature difference: 2000s - 1970s');
caxis([-5 +5]);




