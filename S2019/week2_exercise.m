%% week2_exercise.m

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

% make a map of air temperature (Jan 1948)
figure(1);
pcolor(lon,lat,air(:,:,1)');
shading flat; % removes grid lines
colormap('jet'); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface air temp in 1948 Jan');

% add m_map package to the MATLAB path
addpath m_map

% re-plot the data using m_map package
figure(2);
m_proj('robinson'); % robinson projection (global)
lon(145)=lon(1)+360; % add 1 x-point to overlap
air(145,:,:)=air(1,:,:);
% then plot
m_pcolor(lon,lat,air(:,:,1)');
hold on;
% twice for western hemisphere
m_pcolor(lon-360,lat,air(:,:,1)');

m_coast; % draws coastlines
m_grid; % adds grid line
shading flat; % removes grid lines
colormap('jet'); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface air temp in 1948 Jan');

% polar projection
figure(3);
m_proj('stereographic','lat',90,'radius',60);
% then plot
m_pcolor(lon,lat,air(:,:,1)');
hold on;
m_coast; % draws coastlines
m_grid; % adds grid line
shading flat; % removes grid lines
colormap('jet'); % changes color pattern;
colorbar; % adds colorbar;
xlabel('longitude');
ylabel('latitude');
title('surface air temp in 1948 Jan');











