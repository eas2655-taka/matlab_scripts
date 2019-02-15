%% week5_lab.m

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
for i=1:Nx
    for j=1:Ny

        % inputs
        x=time2';
        y=squeeze(anom(i,j,:));
        CL = .95;
        tail=2;

        % call the regression2 function
        [a(i,j),b(i,j),R2(i,j),Neff(i,j),SE(i,j),tcrit(i,j),tval(i,j)] ... 
            =regression2(x,y,CL,tail);

    end
end

figure(1);
pcolor(lon,lat,a');
hold on;
shading flat;
colorbar;
colormap('jet');

% plot the dots with significant a (slope)
[xx,yy]=meshgrid(lon,lat);
sig=zeros(size(a));
sig(abs(tval)>tcrit)=1;
xx=xx';
yy=yy';
xx(sig==0)=NaN;
yy(sig==0)=NaN;
plot(xx(:),yy(:),'k.');
hold off;

return

% time period of analysis
per = [1879 2015];

% load Atlanta data
load AtlantaTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
x = Year(range);
y = Annual(range);
clear Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec

% test the regression2 function

% inputs
CL = .95;
tail=2;

% call the regression2 function
[a,b,R2,Neff,SE,tcrit,tval]=regression2(x,y,CL,tail);



