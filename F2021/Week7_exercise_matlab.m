%% EAS2655 Week 7 Exercise
% Data visualization for NETCDF

% safety first
close all;
clear; 
fclose all;
%
fig_path='./fig/';

%% load Atlanta temperature data
% 
data=xlsread('./ATL_MonMeanTemp_1879_2020.xls');
TMP_ATL_month=data(:,2:end);
% calculate annual mean
TMP_ATL_year=mean(TMP_ATL_month,2);
year=data(:,1);
TMP_ATL_year_degC=(TMP_ATL_year-32).*(5./9);

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
TMP=ncread(fn,'air');

%% extract surface air temperature data for 1948 to 2020
T_num_NCEP=T_num(1:end-7);
TMP_NCEP=TMP(:,:,1:end-7);
TMP_NCEP_reshape=reshape(TMP_NCEP,144,73,12,[]);

% Atlanta lat lon
% 33.7490° N, 84.3880° W
% note that the longitude range in NCEP data is 0 - 360 deg
ilon=interp1(X,1:length(X),360-84.388,'nearest');
ilat=interp1(Y,1:length(Y),33.749,'nearest');

TMP_ATL_NCEP=TMP_NCEP(ilon,ilat,:);
TMP_ATL_NCEP=reshape(TMP_ATL_NCEP,[],1);
TMP_ATL_NCEP_mat=reshape(TMP_ATL_NCEP,12,[]);
% annual mean
year_NCEP=1948:1:2020;
TMP_ATL_NCEP_year=mean(TMP_ATL_NCEP_mat,1);
% monthly mean for ATL
TMP_ATL_NCEP_month=mean(TMP_ATL_NCEP_mat,2);

% monthly mean 
TMP_NCEP_month=mean(TMP_NCEP_reshape,4);

%% Make a comparison plot
%%
figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[2.5 2.5 4 3],'visible','on');
ax11= axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',12,'FontName','Arial','box','off','color','none',...
     'YAxisLocation','left','XAxisLocation','bottom',...
     'xcolor',[0 0 0],'ycolor',[0 0 0]);
hold on;
plot(year,TMP_ATL_year_degC,'linewidth',2,'Displayname','Measured (ATL site)');
plot(year_NCEP,TMP_ATL_NCEP_year,'linewidth',2,'Displayname','NCEP (regional)');
legend('location','northwest');
set(gca,'FontName','Arial','TickDir','out');
xlabel('Year');
ylabel('Annual mean T (^\circC)');

%% make a simple plot
TMP_NCEP_mean=mean(TMP_NCEP,3);
C=TMP_NCEP_mean';
figure;
hold on;
p1=pcolor(X,Y,C);
shading flat;
colorbar('location','eastoutside');
hold off;

%% Make it nicer
figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');

ax=axesm('MapProjection','pcarree','MapLonLimit',[30,390]);
set(ax,'box','off','xcolor','none','ycolor','none');
hold on;
X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];
% X2=X;
% Y2=Y;
C2=C;
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
shading flat;
c1=colorbar();
load coastlines
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;
% framem;
% gridm;


title('Global mean temperature, 1948-2020');
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
pcolorm(lat-360,lon,C2);
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






