%% 0. safety first
close all
clear all

%% 1. load data
atl=load('DATA/atlanta_temperature.tsv');
bos=load('DATA/bos_temp.tsv');
anc=load('DATA/anchorage_temp.tsv');
pas=load('DATA/Pasadena_temp.tsv');

%% 2. set up data matrix for Jan and July after 1960
stn={'atl' 'bos' 'anc' 'pas'};
M=length(stn);
for n=1:M
    eval(['data=',stn{n},';']); % set temporary data array
    % replace missing values with NaN
    data(data==-999)=NaN;
    yr=data(:,1); % get year
    ind=find(yr>=1960);
    JAN(:,n)=data(ind,2); % get jan
    JUL(:,n)=data(ind,8); % get jul
end
year=yr(ind);

%% 3. calculate regression coefficient and R2
J1=JAN;
J1(:,M+1)=year;
C=cov(J1,'omitrows');
v=diag(C); % variance
a_JAN=C(1:M,M+1)/v(M+1); % regression coefficient
R2_JAN=C(1:M,M+1).^2/v(M+1)./v(1:M);

J1=JUL;
J1(:,M+1)=year;
C=cov(J1,'omitrows');
v=diag(C); % variance
a_JUL=C(1:M,M+1)/v(M+1); % regression coefficient
R2_JUL=C(1:M,M+1).^2/v(M+1)./v(1:M);

%% bar chart for regression and R2
figure(1);
subplot(2,1,1);
bar([a_JAN a_JUL]);
set(gca,'xticklabel',stn);
legend({'JAN' 'JUL'});
ylabel('Regr coeff., deg/yr');
set(gca,'fontsize',18);

subplot(2,1,2);
bar([R2_JAN R2_JUL]);
set(gca,'xticklabel',stn);
legend({'JAN' 'JUL'});
ylabel('R2');
set(gca,'fontsize',18);

%% Comment on the linear trends and R2
disp('The linear trend (regression coefficient) in the winter is approximately the same or slightly larger than the summer time values. ');
disp('However, it always explains smaller fraction of variance in the winter than the summer. ');

%% 4. calculating correlation and covariance matrix
disp(['January covariance matrix between ATL, BOS, ANC, PAS is ']);
C_JAN = cov(JAN,'omitrows')
disp('January correlation matrix is');
R_JAN = corrcoef(JAN,'Rows','complete')

disp(['July covariance matrix between ATL, BOS, ANC, PAS is ']);
C_JUL = cov(JUL,'omitrows')
disp('July correlation matrix is');
R_JUL = corrcoef(JUL,'Rows','complete')

%%  Comment on covariance/correlation matrix
disp('1. These matrices are symmetric. ');
disp('2. ATL and BOS are strongly correlated in the winter (see scatter diagram). ');
disp('3. In the winter, some cities are negatively correlated. ');

figure(2);
plot(JAN(:,1),JAN(:,2),'x','linewidth',2);
xlabel('ATL');
ylabel('BOS');
set(gca,'fontsize',18);




