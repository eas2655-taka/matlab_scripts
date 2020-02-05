close all
clear all

load atlanta_temperature.mat
year_atlanta = Year;
temp_atlanta = Annual;

load Athens_temperature.mat
year_athens = year;
temp_athens = annual;

load Boulder_temperature.mat
year_boulder = year;
temp_boulder = annual;

% set time period
range = [1940 2010];

% x = atlanta temp, y = athens temp
I=find(year_atlanta>=range(1)&year_atlanta<=range(2));
x = temp_atlanta(I);

I=find(year_athens>=range(1)&year_athens<=range(2));
y = temp_athens(I);

I=find(year_boulder>=range(1)&year_boulder<=range(2));
z = temp_boulder(I);

% quick look at the data
figure(1);
p(1)=plot(range(1):range(2),x,'b-');
hold on;
p(2)=plot(range(1):range(2),y,'m-');
p(3)=plot(range(1):range(2),z,'r-');
hold off;
xlabel('time');
ylabel('temperature, deg F');
legend(p,{'Atlanta' 'Athens' 'Boulder'});








