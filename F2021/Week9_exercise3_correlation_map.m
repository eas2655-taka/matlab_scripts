%% EAS2655 Week 9 Exercise
% correlation plot for NINO3.4

% safety first
clc;
close all;
clear; 
fclose all;
% 
fig_path='./fig/';
addpath('./cbrewer/');

%% read data table
% data loading
% Nino3.4 SST downloaded from:
% https://climatedataguide.ucar.edu/climate-data/nino-sst-indices-nino-12-3-34-4-oni-and-tni

% load nino3.4 SST data
data=table2array(readtable('./nino34_1870_2020.txt'));
% replace missing with NaN
data(data==-99.99)=NaN;
% get time
year=data(:,1);
% get the matrix for nino3.4 SST (152 years * 12 months)
nino34=data(:,2:end);

% time range
tr=[1948,2021];
% get indices for Jan 1948 to Dec 2020
tind=(year>=tr(1)&year<tr(2));

% get year within time range
year_sel=year(tind);
% get nino3.4 SST within time range
nino34_sel=nino34(tind,:);

ny=length(year_sel);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get anomaly for all months
%% calculate anomaly to remove seasonal cycle

% get the climatological mean
nino34_mean=mean(nino34_sel,1);

% get the anomaly for each month
nino34_anomaly=nino34_sel-repmat(nino34_mean,ny,1);

% reshape the anomaly matrix into a time series
% transpose nino34 matrix to get the correct order
nino34_ano_ser=reshape(nino34_anomaly',[],1);

%% get year + month
[month_mat,year_mat]=meshgrid([1:12],year_sel);
T_mat=year_mat+(month_mat-1)/12;
T_ser=reshape(T_mat',1,[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% if we only need one month data (i.e., homework)
% get July nino34 SST
nino34_JUL=nino34_sel(:,7);
% get nino34 SST anomaly (i.e., nino3.4 index)
nino34_ano_JUL=nino34_JUL-nanmean(nino34_JUL);

x=year_sel;
y=nino34_ano_JUL;

figure;
plot(x,y);
xlabel('Year');
ylabel('Nino 3.4 index, July (^\circC)');


%% calculate the z-score
z_nino34=(nino34_ano_ser-nanmean(nino34_ano_ser))./std(nino34_ano_ser,0);

%%
% make a quick plot
figure1=figure; 
subplot(2,1,1);
hold on;
plot(T_ser,nino34_ano_ser);
xlim([1948,2021]);
xlabel('Year');
ylabel('Anomaly (^\circC)');
title('Nino3.4 index');

subplot(2,1,2);
hold on;
plot(T_ser,z_nino34);
plot([1948 2021],[0 0],'-','color','k');
plot([1948 2021],[1 1],'--','color','r');
plot([1948 2021],[-1 -1],'--','color','b');

plot([1948 2021],[2 2],'--','color','r');
plot([1948 2021],[-2 -2],'--','color','b');

xlim([1948,2021]);
xlabel('Year');
ylabel('z-score');
title('Nino3.4, z-score');

fn=['Fig_nino34_1948_2020'];

print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);


%% load netcdf data
% Download the most recent NCEP renalysis monthly data from the link below:
% https://psl.noaa.gov/data/gridded/data.ncep.reanalysis.derived.surface.html
% read NCEP reanalysis monthly data (in netcdf format)
fn='./air.mon.mean.nc';
X=double(ncread(fn,'lon'));
Y=double(ncread(fn,'lat'));
T=ncread(fn,'time'); % unit: hours since 1800-01-01 00:00:0.0
T_num=datenum(1800,1,1,0,0,0)+T./24;
T_string=datestr(T_num,'yyyy-mm-dd');

tr2(1)=datenum(1948,1,1,0,0,0);
tr2(2)=datenum(2021,1,1,0,0,0);
tind2=(T_num>=tr2(1)&T_num<tr2(2));

TMP=ncread(fn,'air');
TMP_1948_2020=TMP(:,:,tind2);
dim=size(TMP_1948_2020);

%% calculate anomaly for NCEP data
TMP_reshape=reshape(TMP_1948_2020,dim(1),dim(2),12,[]);
TMP_reshape_mean=mean(TMP_reshape,4);
[nlon,nlat,nmon,ny]=size(TMP_reshape); % 

TMP_reshape_mean_mat=repmat(TMP_reshape_mean,1,1,1,ny);

% calculate anomaly
TMP_reshape_anomaly=TMP_reshape-TMP_reshape_mean_mat;
TMP_anomaly=reshape(TMP_reshape_anomaly,144,73,[]);

% for validation purpose only
TMP_reconstruct=TMP_anomaly+reshape(TMP_reshape_mean_mat,144,73,[]);
% diff should be all zero values
diff=TMP_reconstruct(10,10,:)-TMP_1948_2020(10,10,:);


%% test code
x=squeeze(TMP_anomaly(50,45,:));
y=nino34_ano_ser;
[a,r,CI] = regrcorr2(x,y,0.95);   


%% calculate correlation coefficient

% slope
slope=nan(nlon,nlat);
% r
r_mat=nan(nlon,nlat);
r_mat2=nan(nlon,nlat);
% Confidence interval
confint=nan(nlon,nlat);

% r_mat=nan(nlon,nlat);

% confidence level
CL=0.99;

for ii=1:nlon
%     disp(ii);
    for jj=1:nlat
        xx=squeeze(TMP_anomaly(ii,jj,:));
        yy=nino34_ano_ser;
        
        [a,r,CI] = regrcorr2(xx,yy,CL);        
        slope(ii,jj)=a(1);
        r_mat(ii,jj)=r;
        confint(ii,jj)=CI;   
        
    end
end

%%
figure1=figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperUnits','inches','PaperSize',[8.5 11],...
    'PaperPosition',[.5 2.5 7 4],'visible','on');

ax=axesm('MapProjection','robinson','MapLonLimit',[30,390]);
set(ax,'box','off','xcolor','none','ycolor','none');
X2=[-2.5/2:2.5:360]';
Y2=[90;[90-2.5/2:-2.5:-90]';-90];
C2=r_mat';
[lat,lon]=meshgrat(Y2,X2);
pcolorm(lat,lon,C2);
hold on;
shading flat;
c1=colorbar();
c1.Label.String='Correlation coefficient, \itr';
load coastlines
plotm(coastlat,coastlon,'-','linewidth',0.5);
tightmap;

% using diverging colorscale
cmap=cbrewer('div','RdBu',128,'linear');
cmap2=flipud(cmap);
colormap(cmap2);
caxis([-0.8 0.8]);
framem;

title('Correlation map, T_{air} vs. NINO3.4');

fn='Fig_correlation_map_nino34';
print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);

%%




