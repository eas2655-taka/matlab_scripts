
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

%% pick a month
mon=7; % July
nino34_July=nino34_sel(:,7);

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
% pick a month
TMP_reshape=reshape(TMP_1948_2020,dim(1),dim(2),12,[]);
[nlon,nlat,nmon,ny]=size(TMP_reshape); % 
TMP_NCEP_July=squeeze(TMP_reshape(:,:,mon,:));


%% calculate correlation coefficient

% slope
slope=nan(nlon,nlat);
% r
r_mat=nan(nlon,nlat);
% Confidence interval for slope
confint_slope=nan(nlon,nlat);
% Confidence interval for r
confint_r=nan(nlon,nlat);

% confidence level
CL=0.95;

for ii=1:nlon
%     disp(ii);
    for jj=1:nlat
        xx=squeeze(TMP_NCEP_July(ii,jj,:));
        yy=nino34_July;
        
        [a,r,CI_slope,CI_r] = regrcorr3(xx,yy,CL);        
        slope(ii,jj)=a(1);
        r_mat(ii,jj)=r;
        confint_slope(ii,jj)=CI_slope;
        confint_r(ii,jj)=CI_r;
        
    end
end

% if significant, rsig=1; otherwise, rsig=0;
rsig=zeros(dim(1),dim(2));
rsig(confint_r<abs(r_mat))=1;

ind_plot=(rsig==1);

%%
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


%
[lat1,lon1]=meshgrat(Y,X);
plotm(lat1(ind_plot'),lon1(ind_plot'),'.','markersize',2,'color',0.5*[1 1 1]);


% using diverging colorscale
cmap=cbrewer('div','RdBu',128,'linear');
cmap2=flipud(cmap);
colormap(cmap2);
caxis([-0.8 0.8]);
framem;

title('Correlation map, T_{air} vs. NINO3.4');

fn='Fig_ncep_nino34_correlation_plot_July_sig';
print(figure1,'-dpdf','-painters',[fig_path,fn,'.pdf']);
print(figure1,'-dpng','-r300', [fig_path,fn,'.png']);

%%
function [a,r,CI_slope,CI_r] = regrcorr3(X,Y,CL)

% Input : two vectors of equal length and confidence level (CL)
% Output: a = regression coefficient
%         r = correlation coefficient
%         CI= confidence interval

% covarince matrix
C=cov(X,Y);

% slope
a(1) = C(1,2)/C(1,1);
% intercept
a(2) = mean(Y)-a(1)*mean(X);

% correlation
r = C(1,2)/sqrt(C(1,1)*C(2,2));

% effective sample size
N = length(Y);

% lag-1 autocorrelation for Y
y0 = Y(1:N-1);
y1 = Y(2:N);
C=cov(y0,y1);
r1 = C(1,2)/sqrt(C(1,1)*C(2,2));

% lag-1 autocorrelation for X
x0 = X(1:N-1);
x1 = X(2:N);
C=cov(x0,x1);
r2 = C(1,2)/sqrt(C(1,1)*C(2,2));

% effective sample size
Neff=N*(1-r1*r2)/(1+r1*r2);
Neff=min(N,Neff); % only allow Neff <= N

% SE of regression
err2 = sum( ( Y - (a(2)+a(1)*X) ).^2 )/(Neff - 2);
% err2 = sum( ( Y - (a(2)+a(1)*X) ).^2 )/(N - 2);
SE2  = err2/( sum((X-mean(X)).^2)  );
SE   = sqrt(SE2);

% SE of r
SE_r=sqrt((1-r^2)./(Neff-2));

% calculate tcrit (two tail)
tcrit = tinv( (CL+1)/2 , Neff-2);

% Calculate CI
CI_slope = tcrit*SE;
%
CI_r = tcrit*SE_r;

return
end