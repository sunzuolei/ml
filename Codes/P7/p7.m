% Test the cost function value without theta0
% NOTE: theta0 is not considered here!

clear all; clc; close all;
load '../Data/dataChap3.mat';

%%
houseSize  = data(:, 1);
numBedroom = data(:, 2);
m          = length(houseSize);

%%
figure('name', 'Feature quantity')
plot(1 : m, houseSize,  'r-*',...
     1 : m, numBedroom, 'g-o');
legend('House size', 'Number of bedroom');
% print('features.png', '-dpng');

%% Normalize the features
data(:, 1:2) = normFeat(data(:, 1:2));

figure('name', 'Normalized feature quantity')
plot(1 : m, data(:, 1),  'r-*',...
     1 : m, data(:, 2),  'g-o');
legend('House size', 'Number of bedroom');
% print('normfeatures.png', '-dpng');