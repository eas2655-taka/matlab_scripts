% trend calc

close all
clear all
clc

% load the data
load atlanta_temperature.mat

% X = Year
% Y = Annual
X = Year;
Y = Annual;

% calculate temporal trend first
C = cov(X,Y);
a(2)= C(1,2)/C(1,1); % slope
a(1)= mean(Y)-a(2)*mean(X); %intercept

% matrix approach
E(:,2)=X;
E(:,1)=1;
a_matrix = inv(E'*E)*E'*Y;


