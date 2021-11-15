%% Week 10 HW

clc;clear;close all;fclose all;

%% read data
df=readtable('NINO34_annual_mean_1870_2020.txt');
Year=df.Year;
nino34_year=df.NINO34_SST;


%% apply FFT and get frequency axis
x=Year;
y=nino34_year;
N=length(y); % length of data 
% apply fourier transform for y
c = fft(y); % fast fourier transform

%% apply inverse FFT
yest=ifft(c);
% make a simple plot
figure;
hold on;
plot(x,y,'o-');
plot(x,real(yest),'--');
% xlim([1875 2025]);
xlabel('Year');
ylabel('NINO3.4 SST (^\circC)');
title('NINO3.4');

%% get unique coefficients and frequency axis 
K=ceil((N+1)/2);
c1=c(1:K); % get the first N/2 data 
freq = [0:1/N:1/2]'; % frequency axis

%% get the periodogram
figure;
hold on;
% calculate the power spectrum
P0=2*abs(c1(2:end)).^2/N/(N-1); % multiply by 2 because there are both positive and negative frequencies
freq0=freq(2:end); % discard the constant term (freq=0)
plot(freq0,P0,'o-');
xlabel('Frequency, cycle/year')
ylabel('power density, degC2');
title('periodogram of NINO3.4');

%% low pass filtering
f_pass=1/10; % low pass filter to remove any high frequency data with periods shorter than 10 years
ind_low_pass=find(freq0<f_pass);
N_low=length(ind_low_pass); % determine how many terms to include

% take the first N_low+1 (including the constant term), and the last N_low
% terms
cX=0*c;
cX(1:N_low+1)=c(1:N_low+1);
cX(end-N_low+1:end)=c(end-N_low+1:end);

% reconstruct time series and plot
figure;
yest=ifft(cX); 
p(1)=plot(x,y);
hold on;
p(2)=plot(x,real(yest));
hold off;
xlabel('time')
ylabel('NINO3.4 SST, annual mean')
legend(p,{'raw data', ['Low-pass filterd for f<',num2str(f_pass)]})


