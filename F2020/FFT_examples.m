%% FFT example

close all
clear all

% 1. define y(x)=cos(x)+sin(4x) in domain -10pi < x < +10pi for 0.1 increment
dt=0.1;
x=-10*pi:dt:10*pi;
y=cos(x)+sin(4*x);
N=length(x);
disp(['there are ',num2str(N),' data points'])
figure(1);
subplot(2,2,1);
plot(x,y);
title('original data');

% 2. calculate the variance
v0=var(y);
disp(['variance is ',num2str(v0)]);

% 3. perform FFT of y
yhat=fft(y);

figure(1);
subplot(2,2,2);
plot(real(yhat));
title('real part of y-hat')

subplot(2,2,3);
plot(imag(yhat));
title('imaginary part of y-hat')

% plot the amplitude
subplot(2,2,4);
yhat2=yhat.*conj(yhat)/N;
plot(yhat2);
title('y-hat squared')

% ### 4. plot PSD (periodogram)
figure(2);
freq0=1/N;
freq=[freq0:freq0:1/2]*1/dt;
PSD=yhat2(1:round((N-1)/2));
plot(freq,PSD);
xlabel('frequyency')
ylabel('power density')
title('Periodogram')

%# Calculate variance in frequency domain. Confirm Perseval's theorem
v1=sum(yhat2)/N;
disp(['variance based on yhat is ',num2str(v1)]);
