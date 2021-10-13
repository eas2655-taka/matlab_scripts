
%% EAS2655 Week 8 Exercise
% Data visualization for NETCDF
% plot global maps

% safety first
close all;
clear; clc;
fclose all;
%
fig_path='./fig/';

%% load netcdf data
% Download the most recent NCEP renalysis monthly data from the link below:
% https://psl.noaa.gov/data/gridded/data.ncep.reanalysis.derived.surface.html
% read NCEP reanalysis monthly data (in netcdf format)
fn='./air.mon.mean.nc';
ncdisp(fn);

% get lat lon coordinates
X=double(ncread(fn,'lon'));
Y=double(ncread(fn,'lat'));

% get date/time
T=ncread(fn,'time'); % unit: hours since 1800-01-01 00:00:0.0
T_num=datenum(1800,1,1,0,0,0)+T./24;
T_string=datestr(T_num,'yyyy-mm-dd');
T_Vector = datevec(T_num);

% get temperature
TMP=ncread(fn,'air');

%% extract surface air temperature data for 1948 to 2020
tind=(T_num>=datenum(1948,1,1,0,0,0)&T_num<datenum(2021,1,1,0,0,0));
T_num_NCEP=T_num(tind);
TMP_NCEP=TMP(:,:,tind);
% convert the 3-D matrix to 4-D and create a new dimension of "Year"
TMP_NCEP_reshape=reshape(TMP_NCEP,144,73,12,[]);


%% Make a simple 2-D plot
TMP_NCEP_mean=mean(TMP_NCEP,3);
C=TMP_NCEP_mean';

figure;
hold on;
p1=pcolor(X,Y,C);
shading flat;
colorbar('location','eastoutside');


%% Make it nicer

% grid boundaries
X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];

figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');
% set up map axes
ax=axesm('MapProjection','pcarree','MapLonLimit',[30,390]);
set(ax,'box','off','xcolor','none','ycolor','none');
hold on;
% plot colored map 
C2=C;
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
shading flat;
% add color bar
c1=colorbar();
c1.Label.String='Temperature (^\circC)';

% plot coastal lines
load coastlines
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;
% framem;
% gridm;

% add title
title('Global mean temperature, 1948-2020');

% save figure to file
fn=['Fig_glbal_mean_PlateCarree'];
print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);


%% Let's try other projections
% https://www.mathworks.com/help/map/summary-and-guide-to-projections.html

figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');

ax=axesm('MapProjection','robinson','MapLonLimit',[30,390]);
set(ax,'box','off','xcolor','none','ycolor','none');
X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];
C2=C;
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
hold on;
% pcolorm(lat-360,lon,C2);
shading flat;
c1=colorbar();
c1.Label.String='Temperature (^\circC)';
load coastlines
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;
% framem;
% gridm;
title('Global mean temperature, 1948-2020');
fn=['Fig_glbal_mean_Robinson'];

print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);

%% stereo
figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');

ax=axesm('MapProjection','stereo','MapLonLimit',[-180,180],'MapLatLimit',[-90 -50]);
set(ax,'box','off','xcolor','none','ycolor','none');
hold on;

setm(ax,'MeridianLabel','on','ParallelLabel','on');


X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];
C2=C;
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
shading flat;
c1=colorbar();
c1.Label.String='Temperature (^\circC)';

caxis([-55 5]);

load coastlines;
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;
% framem;
gridm;

title('Global mean temperature, 1948-2020');
fn=['Fig_glbal_mean_stereo'];

print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);


%%
