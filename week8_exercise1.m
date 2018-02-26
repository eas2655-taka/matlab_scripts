%% week 8 exercise2.m

% safety first, clean up  
close all
clearvars

% time period of analysis
per = [1900 2015];

% load Atlanta data
N=1;
load AtlantaTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
year = Year(range);
T(:,N) = Annual(range);
clear Jan Feb Mar Apr May Jun Jul Aug Sep Nov Dec
Nt=length(year);

% load Savannah data
N=N+1;
load SavannahTemp.mat;
range = find(Year>=per(1)&Year<=per(2));
T(:,N) = Temp_annual(range);

% remove mean values
for i=1:N
  Tp(:,i)=T(:,i)-mean(T(:,i));
end

% % replace NaNs with 0
% Tp(isnan(Tp))=0;

% look at the two variables
plot(Tp(:,1),Tp(:,2),'ko');
xlabel('Atlanta temperature anomaly, deg F');
xlabel('Savannah temperature anomaly, deg F');

% calculate the covariance matrix
C = 1/(Nt-1)*Tp'*Tp;

% eigen decomposition of C
[E,D] = eig(C);

% explained variance
d = diag(D);
expvar = d/sum(d);
disp(['The 1st EOF explains ', ... 
    num2str(expvar(N)*100),'% of variance'])

% plot eigenvectors
hold on;
for i=1:N
  quiver(0,0,E(1,i),E(2,i),5*expvar(i));
end

% plot the data and the 1st principal component
figure(2);
plot(year,Tp);
hold on;
plot(year,-Tp*E(:,N),'k-','linewidth',1);
hold off;
legend({'Atlanta' 'Savannah' 'PC1'});
xlabel('time');
ylabel('annual temp anomaly, deg F');


  





