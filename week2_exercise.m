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