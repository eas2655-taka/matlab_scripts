%% week 8 lab

% safety first, clean up  
close all
clearvars

% time period of analysis
per = [1900 2015];

% stations
stn={'Boston' 'Philadelphia' 'Raleigh' 'SavannahTemp' 'Miami'};

% load 5 stations
N=5;
for i = 1:N
    load(stn{i});
    range = find(Year>=per(1)&Year<=per(2));
    T(:,i) = Temp_annual(range);
    year = Year(range);
end

% remove linear trend from each column
for i = 1:N
    [a,b,R2]=regression(year,T(:,i));
    D(:,i)=T(:,i)-(a*year+b);
end

Nt=length(year);
% calculate the covariance matrix
C = 1/(Nt-1)*D'*D;

% eigen decomposition of C
[E,V] = eig(C);

% explained variance
lambda = diag(V);
expvar = lambda/sum(lambda);
[maxvar,nmax]=max(expvar); % find the maximum eigenvalue

disp(['The 1st EOF explains ', ... 
    num2str(expvar(nmax)*100),'% of variance'])

% plot eigenvectors
figure(1);
bar(E(:,nmax));
ax=get(gcf,'currentaxes');
set(ax,'xticklabel',char(stn));
title('1st EOF');

figure(3);
disp(['The 2nd EOF explains ', ... 
    num2str(expvar(2)*100),'% of variance'])
bar(E(:,2));
ax=get(gcf,'currentaxes');
set(ax,'xticklabel',char(stn));
title('2nd EOF');

% plot the data and the 1st principal component
pc1 = D*E(:,nmax);
% normalize pc1
pc1 = pc1/std(pc1);

figure(2);
plot(year,D);
hold on;
p=plot(year,pc1,'k-','linewidth',1);
hold off;
legend(p,{'PC1'});
xlabel('time');
ylabel('annual temp anomaly, deg F');

