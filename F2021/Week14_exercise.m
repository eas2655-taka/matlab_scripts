clc;clear;close all;fclose all;
%%%%%%%%%%%%%%%
fig_path='./fig/';
addpath('./cbrewer');

%% load data
data=table2array(readtable('Temp_Jan_4USCities.csv'));
Year=data(:,1);
TMP=data(:,2:end);
TMP_ano=TMP-mean(TMP); %% anomalies

city={'ATL','BOS','ANC','PAS'};
%% make a plot
figure;
hold on;
plot(Year,TMP_ano);
legend(city)
xlabel('time')
ylabel('temperature anomaly from mean')

%% # covariance matrix
C=cov(TMP_ano);

%% correlation matrix r_mat
r_mat=corrcoef(TMP_ano);
figure;
hold off;
cmap=cbrewer('div','RdBu',128,'linear');
cmap2=flipud(cmap);
heatmap(r_mat);
colormap(gca,cmap2);
set(gca,'XDisplayLabels',city);
set(gca,'YDisplayLabels',city);
caxis([-1 1]);

%% # PCA using eigen decomposition
% # find the principal components
% note that the order of eigen values is ascending (the last is PC1) 
[eigen_values, eigen_vectors]=eig(C)

%# project X to PC space
X=TMP_ano;
Y_PCA=X*eigen_vectors


%% PCA using SVD
[U,S,V]=svd(TMP_ano,'eco');

%% display the variance explained by the singular vectors (principal components)
figure;
expvar=diag(S).^2/sum(diag(S).^2);
bar([1,2,3,4],expvar);
ylabel('fraction of variance explained')
set(gca,'xticklabel',{'PC1','PC2','PC3','PC4'});

%% plot the EOF1 pattern
EOF=V;
figure;
bar([1:4],EOF(:,1))
set(gca,'xticklabel',city);
xlabel('city')
title('EOF1')

%% plot the time series of EOF1 
PC=U;
figure;
bar(Year,PC(:,1))
xlabel('Year')
title('PC1')

%% plot the second component
figure;
subplot(1,2,1);
bar([1:4],EOF(:,2))
set(gca,'xticklabel',city);
xlabel('city')
title('EOF2')
subplot(1,2,2);
bar(Year,PC(:,2))
xlabel('Year')
title('PC2')


