% removing seasonal cycle (monthly climatology)
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

% 1948 to 2015
cnt=1;
Nyr = 2015-1948+1;
for yr=1:Nyr
    for mon=1:12
       air2(:,:,mon,yr)=air(:,:,cnt);
       cnt=cnt+1;
    end
end
clim = mean(air2,4);

cnt=1;
for yr=1:Nyr
    for mon=1:12
       anom(:,:,cnt)=air(:,:,cnt)-clim(:,:,mon);
       cnt=cnt+1;
    end
end



