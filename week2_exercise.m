%% week2_exercise.m

close all;
clearvars;

% display meta data
%ncdisp('air.mon.mean.nc');

% load in monthly mean surface air temp data
lat=ncread('air.mon.mean.nc','lat');
lon=ncread('air.mon.mean.nc','lon');
time=ncread('air.mon.mean.nc','time');
time=time/24/365+1800;
air=ncread('air.mon.mean.nc','air');

% make a 2D plot
pcolor(lon,lat,air(:,:,end)');
shading flat;
colormap ('jet');
colorbar ;
xlabel('longitude');
ylabel('latitude');
title('surface air temperature , degree C');

% include m_map in the path (this is specific to where you saved m_map)
addpath m_map

% global equal-area projection, hammer-aitoff
figure(3);
m_proj('hammer-aitoff','clongitude',-150); % define projection
lon(end+1)=lon(1)+360;                     % wrap around the globe
air(end+1,:,:)=air(1,:,:);
m_pcolor(lon,lat,air(:,:,end)');
hold on;
m_pcolor(lon-360,lat,air(:,:,end)');       % plot twice for western hemis.
shading flat;
colormap('jet');
colorbar;
m_coast;
m_grid('xaxis','middle');
xlabel('longitude');
ylabel('latitude');

% polar projection, stereographic, with m_contourf, m_contour or m_pcolor
figure(4)
m_proj('stereographic','latitude',90,'longitude',0,'radius',60); 
%m_pcolor(lon,lat,air(:,:,end)');
%m_contour(lon,lat,air(:,:,end)');
m_contourf(lon,lat,air(:,:,end)');
hold on;
shading flat;
colormap('jet');
colorbar;
m_coast;
m_grid('xaxis','bottom');

