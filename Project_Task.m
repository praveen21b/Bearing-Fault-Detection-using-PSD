%% 
% clc
% clear
% close all
% %
%% 
%% 1. Load Signal/s
load signal1;
% laod signal2;
% load signal3;
% whos
[m,n] = size(D);
plot(D)
xlabel('Data Points')
ylabel('Siganl')
title('Input Signal Data')
grid minor
hold on
%% 
%% 1.2 Find Statistical Features
RMS = rms(D);
yline(RMS,'r--','linewidth',1)
Mean = mean(D);
yline(Mean,'k--','linewidth',1)
legend('Signal','RMS','Mean')
%% 
%% 
actualPath = pwd;
savePath = fullfile(actualPath,'Bearing_data_Signal_1');
x = what(savePath);
x = x.mat;


