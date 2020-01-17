%% week4_lab 

% safety first
close all
clear all
clc

% load the data
load atlanta_temperature.mat

% start year
yr0 = [1950:1980];
N0 = length(yr0);

% end year
yr1 = [1990:2018];
N1 = length(yr1);

% loop over N0 and N1

for i=1:N0 % loop over yr0
    for j=1:N1 % loop over yr1
       I=find(Year>=yr0(i)&Year<=yr1(j)); % select time range
       X=Year(I); % x is time
       Y=Annual(I); % y is annual temp
       [a,r]=regrcorr(X,Y); % calculate regression
       trd(i,j)=a(1); % store the temp trend as trd(i,j)
    end
end

% plot the result
figure(1);
pcolor(yr1,yr0,trd);
shading flat;
colormap('jet');
colorbar;
xlabel('end year');
ylabel('start year');

