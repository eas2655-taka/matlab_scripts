%% week6_exercise2.m

% safety first, clean up  
close all
clearvars

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
       time2(cnt)=time(cnt);
       cnt=cnt+1;
    end
end

% calculate the number of x and y grid cells
Nx=length(lon);
Ny=length(lat);
load nino34SST.mat; % read in the nino 3.4 sst index
% set time axis from 1950 to 2015
nx = find(year_monthly>=1950&year_monthly<=2016);
x = nino34a_monthly(nx);
ny = find(time2>=1950&time2<=2016);

for i=1:Nx
    for j=1:Ny

        % inputs
        % x=time2';
        y=squeeze(anom(i,j,ny));
        CL = .95;
        tail=2;
        
        [R(i,j),Neff(i,j),tcrit(i,j),tval(i,j)] ... 
            =correlation2(x,y,CL);

        % call the regression2 function
        [a(i,j),b(i,j),R2(i,j),Neffr,SE(i,j),tcritr,tvalr] ... 
            =regression2(x,y,CL,tail);

    end
end

% plot the dots with significant correlation
[xx,yy]=meshgrid(lon,lat);
sig=zeros(size(R));
sig(abs(tval)>tcrit)=1;
R(sig==0)=NaN;

figure(1);
% plot the result
addpath m_map1.4/m_map
m_proj('robinson','clongitude',-150);
m_pcolor(lon,lat,R');
hold on;
m_pcolor(lon-360,lat,R');
shading flat;
caxis([-1 +1])
colormap('jet');
colorbar;
m_coast;
m_grid;
title('Air temp correlated with Nino 3.4 SST index');

figure(2);
% plot the result
addpath m_map1.4/m_map
m_proj('robinson','clongitude',-150);
m_pcolor(lon,lat,a');
hold on;
m_pcolor(lon-360,lat,a');
shading flat;
caxis([-1 +1])
colormap('jet');
colorbar;
m_coast;
m_grid;
title('Air temp regressed onto Nino 3.4 SST index');



return;
% plot the dots with significant correlation
[xx,yy]=meshgrid(lon,lat);
sig=zeros(size(R));
sig(abs(tval)>tcrit)=1;
xx=xx';
yy=yy';
xx(sig==0)=NaN;
yy(sig==0)=NaN;
m_plot(xx(:),yy(:),'k.');
m_plot(xx(:)-360,yy(:),'k.');
hold off;


