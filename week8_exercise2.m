%% week 8 exercise2.m

% safety first, clean up  
close all
clearvars
addpath ~/MATLAB/m_map

% load in monthly mean surface air temp data
lat=ncread('air.mon.mean.nc','lat');
lon=ncread('air.mon.mean.nc','lon');
time=ncread('air.mon.mean.nc','time');
time=time/24/365+1800;
air=ncread('air.mon.mean.nc','air');

% calculate the monthly mean climatology: 1948 to 2015
cnt=1;
Nyr = 2015-1948+1;
for yr=1:Nyr
    for mon=1:12
       air2(:,:,mon,yr)=air(:,:,cnt);
       cnt=cnt+1;
    end
end
clim = mean(air2,4);

% remove the climatology to determine the anomalies
cnt=1;
for yr=1:Nyr
    for mon=1:12
       anom(:,:,cnt)=air(:,:,cnt)-clim(:,:,mon);
       time2(cnt)=time(cnt);
       cnt=cnt+1;
    end
end

% select region: tropical Pacific 
Ix = find(lon>120 & lon<290);
Iy = find(lat>-30 & lat<30);
anom2 = anom(Ix,Iy,:);
Nx=length(Ix);
Ny=length(Iy);

% Make the data matrix (time) x (space)
Nt= length(time2);

for n=1:Nt
    data=anom2(:,:,n);
    Tp(n,:)=data(:);
end

% calculate the covariance matrix
C = 1/(Nt-1)*Tp'*Tp;

% eigen decomposition of C
[E,D] = eig(C);

% explained variance
d = diag(D);
expvar = d/sum(d);
disp(['The 1st EOF explains ', ... 
    num2str(expvar(1)*100),'% of variance']);

% plot eigenvector
figure(1);
eof1 = reshape(E(:,1),[Nx Ny]);
m_proj('miller','lon',[125 285],'lat',[-28 28]);
m_pcolor(lon(Ix),lat(Iy),-eof1');
shading flat;
colormap('jet');
m_coast;
m_grid;
caxis([-1 1]*0.06);
title(['1st EOF pattern: ', ... 
    num2str(expvar(1)*100,3),'% of variance']);

% project 1st eof onto the data matrix
pc1 = -Tp*E(:,1);
% normalize the pc time series
pc1 = pc1/std(pc1); 
% plot the data and the 1st principal component
figure(2);
plot(time2,pc1);
xlabel('time');
ylabel('1st principal component');


  





