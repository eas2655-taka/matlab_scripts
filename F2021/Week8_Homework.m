% %% EAS2655 Week 8 Homework
% Data visualization for NETCDF
% safety first
clc;
close all;
clear; 
fclose all;
%
fig_path='./fig/';
addpath('./cbrewer');

%% load Atlanta temperature data
% 
data=xlsread('./ATL_MonMeanTemp_1879_2020.xls');
% July temperature
TMP_ATL_July=data(:,7+1);
year=data(:,1);
% fahrenheit-> celsius
TMP_ATL_July_degC=(TMP_ATL_July-32).*(5./9);
%% load netcdf data
% Download the most recent NCEP renalysis monthly data from the link below:
% https://psl.noaa.gov/data/gridded/data.ncep.reanalysis.derived.surface.html
% read NCEP reanalysis monthly data (in netcdf format)
fn='./air.mon.mean.nc';
ncdisp(fn);
X=double(ncread(fn,'lon'));
Y=double(ncread(fn,'lat'));
T=ncread(fn,'time'); % unit: hours since 1800-01-01 00:00:0.0
T_num=datenum(1800,1,1,0,0,0)+T./24;
T_string=datestr(T_num,'yyyy-mm-dd');
T_Vector = datevec(T_num);
TMP=ncread(fn,'air');

%% extract surface air temperature data for 1948 to 2020
tind=(T_num>=datenum(1948,1,1,0,0,0)&T_num<datenum(2021,1,1,0,0,0));
T_num_NCEP=T_num(tind);
TMP_NCEP=TMP(:,:,tind);
% convert the 3-D matrix to 4-D with a new dimension of "Year"
TMP_NCEP_reshape=reshape(TMP_NCEP,144,73,12,[]);
TMP_NCEP_July=squeeze(TMP_NCEP_reshape(:,:,7,:));
%% select data for the grid cell Atlanta located
% Atlanta lat lon
% 33.7490° N, 84.3880° W
% note that the longitude range in NCEP data is 0 - 360 deg
ilon=interp1(X,1:length(X),360-84.388,'nearest');
ilat=interp1(Y,1:length(Y),33.749,'nearest');
TMP_ATL_NCEP_July=squeeze(TMP_NCEP_July(ilon,ilat,:));
year_NCEP=[1948:1:2020]';
%%
% Make a comparison plot (NCEP vs Measured)
% Figure size 3.5 * 2.5
fig=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits',...
    'inches','PaperSize',[8.5 11],...
    'PaperPosition',[2.5 2.5 3.5 2.5],'visible','on');
ax= axes('Parent',fig,'LineWidth',1,...
     'Layer','top','FontSize',10,'FontName','Arial','box','off','color','none',...
     'YAxisLocation','left','XAxisLocation','bottom',...
     'position',[0.15,0.18,0.8,0.75]);
hold on;

cmap=cbrewer('qual','Paired',12);

plot(year,TMP_ATL_July_degC,'linewidth',1.5,'Displayname','Measured (ATL site)','color',cmap(1,:));
plot(year_NCEP,TMP_ATL_NCEP_July,'linewidth',1.5,'Displayname','NCEP','color',cmap(2,:));
l1=legend('location','northwest');
set(l1,'box','off');
set(gca,'FontName','Arial','FontSize',10,'TickDir','out');
xlabel('Year');
ylabel('Annual mean T (^\circC)');
xlim([1880,2020]);

% save figures
fn=['Fig_ATL_temp'];
print(fig,'-dpdf','-painters',['./fig/',fn,'.pdf']);
print(fig,'-dpng','-r300', ['./fig/',fn,'.png']);

%% extract surface air temperature data for 1948 to 2020


T_num_NCEP=T_num(tind);
TMP_NCEP=TMP(:,:,tind);
%%%%%%%%%%%%%%%%%%%%%

T_num_NCEP=T_num(tind);
TMP_NCEP=TMP(:,:,tind);
TMP_NCEP_reshape=reshape(TMP_NCEP,144,73,12,[]);

% July temperature, 1950-1960
yind1=(year_NCEP)>=1950&(year_NCEP<=1960);
TMP_NCEP_JUL1=mean(TMP_NCEP_reshape(:,:,7,yind1),4);
% July temperature, 2010-2020
yind2=(year_NCEP)>=2010&(year_NCEP<=2020);
TMP_NCEP_JUL2=mean(TMP_NCEP_reshape(:,:,7,yind2),4);

delta_TMP_JUL=TMP_NCEP_JUL2-TMP_NCEP_JUL1;

%% Let's try other projections
% https://www.mathworks.com/help/map/summary-and-guide-to-projections.html

figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');

ax=axesm('MapProjection','robinson','MapLonLimit',[30,390]);
set(ax,'box','off','xcolor','none','ycolor','none');
X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];
C2=delta_TMP_JUL';
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
hold on;
cmap=cbrewer('div','RdBu',128,'linear');
cmap2=flipud(cmap);
colormap(ax,cmap2);
caxis([-10 10]);
% pcolorm(lat-360,lon,C2);
shading flat;
c1=colorbar();
c1.Label.String='\DeltaT (^\circC)';
load coastlines
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;
% framem;
% gridm;
title('1950-1960 to 2010-2020, July');
fn=['Fig_Delta_T_July_RobinsonProj'];

print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);

