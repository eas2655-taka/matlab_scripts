%% EAS2655 Week 7 Exercise
% Handling NETCDF data

% safety first
close all;
clear; clc;
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
% fahrenheit-> celsius
TMP_ATL_year_degC=(TMP_ATL_year-32).*(5./9);


%% Mini project #1: handling NETCDF data

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

%% select data for the grid cell Atlanta located
% Atlanta lat lon
% 33.7490° N, 84.3880° W
% note that the longitude range in NCEP data is 0 - 360 deg
ilon=interp1(X,1:length(X),360-84.388,'nearest');
ilat=interp1(Y,1:length(Y),33.749,'nearest');

TMP_ATL_NCEP=TMP_NCEP_reshape(ilon,ilat,:,:);
% disp(size(TMP_ATL_NCEP));
% annual mean for ATL
year_NCEP=[1948:1:2020]';
TMP_ATL_NCEP_year=mean(TMP_ATL_NCEP,3);
% reshape it to a column vector
TMP_ATL_NCEP_year=reshape(TMP_ATL_NCEP_year,[],1);

% more examples 
% climatological mean of each month for ATL
TMP_ATL_NCEP_month=reshape(mean(TMP_ATL_NCEP,4),1,[]);

% August temperature for ATL
mon=8;
TMP_ATL_NCEP_AUG=reshape(TMP_ATL_NCEP(:,:,mon,:),[],1);

%% Mini project #2: simple 1-D plot
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

plot(year,TMP_ATL_year_degC,'linewidth',1.5,'Displayname','Measured (ATL site)','color',cmap(1,:));
plot(year_NCEP,TMP_ATL_NCEP_year,'linewidth',1.5,'Displayname','NCEP','color',cmap(2,:));
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








