clear all; close all; clc;
path(path, genpath('../../Codes'));

load dataChap4D
rng(552);

%%
numCol  = 13;
numRow  = 7;

m       = length(y);
iSelect = randperm(m, numCol * numRow);

xSelect = X(iSelect, :);
ySelect = y(iSelect, :);

%%
figure;
imagesc(xSelect(5, :));
axis off;
%%
figure;
img = reshape(xSelect(5, :), 20, 20);
imagesc(img);
axis image off;
%%
dispDigits(numRow, numCol, xSelect, ySelect, 1);