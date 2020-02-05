%% week4 lab

close all
clear all

% load the data
load air.mon.mean.mat;

% annual mean land temp
lndtempam=mean(lndtemp,4);

% calculate regression coefficients
N = size(lndtempam);
x = yr(:,1);
% loop over all grid points
for i=1:N(1)
    for j=1:N(2)
        y=squeeze(lndtempam(i,j,:));
        [a,b,r2]=regr(x,y);
        % record the regression coeffs
        A(i,j)=a;
        B(i,j)=b;
        R2(i,j)=r2;
    end
end

% load new color scale
load br.mat;

figure(1);
pcolor(lon,lat,A'); % 2D color plot
shading flat; % remove grid lines
set(gca,'layer','top'); % bring axis lines to front
colormap(br); % set color scheme
colorbar; % add color bar
caxis([-.1 .1]); % set the max/min color shading
title('Linear trend of surface air temp, deg C/year');
xlabel('longitude');
ylabel('latitude');