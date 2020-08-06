%% week5_lab

close all
clear all

% set time range
range=[1950 2017];

% load data
load NINO_34_INDEX.mat;
I=find(YEAR>=range(1)&YEAR<=range(2));
x = DEC(I); % x is dec nino index

load air.mon.mean.mat;
year=yr(:,12);
I=find(year>=range(1)&year<=range(2));
yo=squeeze(ocntemp(:,:,I,12));
yl=squeeze(lndtemp(:,:,I,12));

% make loops to calcualte correlation
N=size(yo);
for i=1:N(1)
    for j=1:N(2)
        y=squeeze(yl(i,j,:));
        [a,b,R2,r,t,tcrit]=regr(x,y,95);
        rval(i,j)=r; % correlation map
        tval(i,j)=t;
        tc(i,j)=tcrit;
    end
end

% plot the correlation map
figure(1);
load br.mat;
pcolor(lon,lat,rval');
shading flat;
colormap(br);
colorbar;
xlabel('longtiude');
ylabel('latitude');
caxis([-1 1]);

% test statistical significance
hold on;
for i=1:N(1)
    for j=1:N(2)
        if abs(tval(i,j))>tc(i,j)
            plot(lon(i),lat(j),'k.');
        end
    end
end
hold off;

snapnow;
disp('Figure 1: correlation between Nino3.4 index and suface air temperature in December');











