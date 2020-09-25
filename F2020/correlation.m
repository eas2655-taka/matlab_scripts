%% correlation 

close all
clear all

%% load data
atl=load('DATA/atlanta_temperature.tsv');
bos=load('DATA/bos_temp.tsv');
anc=load('DATA/anchorage_temp.tsv');
pas=load('DATA/Pasadena_temp.tsv');

%% select years after 1960-
stn={'atl' 'bos' 'anc' 'pas'};
for n=1:length(stn)
    eval(['data=',stn{n},';']); % set temporary data array
    % replace missing values with NaN
    data(data==-999)=NaN;
    yr=data(:,1); % get year
    ind=find(yr>=1960);
    JAN(:,n)=data(ind,2); % get jan
    JUL(:,n)=data(ind,8); % get jul
end
year=yr(ind);

% plot the data for a quick look
figure(1);
subplot(2,1,1);
plot(year,JAN);
legend(stn);
xlabel('time');
ylabel('January temperature');
set(gca,'fontsize',16);

subplot(2,1,2);
plot(year,JUL);
legend(stn);
xlabel('time');
ylabel('July temperature');
set(gca,'fontsize',16);

%% calculating correlation and covariance matrix
C_JAN = cov(JAN,'omitrows');
R_JAN = corrcoef(JAN,'Rows','complete');








