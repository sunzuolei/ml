clear all; close all; clc;
%% Theta computed from fminunc: 
path(path, genpath('../../Codes'));
load theta

%%
m         = 200;
feat1     = linspace(-3, 3, m); 
feat2     = linspace(-3, 3, m); 
feat1Tem  = repmat(feat1, m, 1);
feat1Seq  = reshape(feat1Tem, 1, m * m)';
feat2Seq  = repmat(feat2, 1, m)';
%%
degree    = 6;
feats     = genFeats(feat1Seq, feat2Seq, degree);
hSeqTem   = feats * theta;
hSeq      = reshape(hSeqTem, m, m);
%%
figure(1)
contour(feat1, feat2, hSeq, 'ShowText', 'on', 'linewidth', 3);
xlabel('feat1');
ylabel('feat2');
% print('contour.png', '-dpng');
%%
figure(2)
contour(feat1, feat2, hSeq, [0, 0], 'linewidth', 3, 'color', 'r');
xlabel('feat1');
ylabel('feat2');
axis equal;
xlim([-1.5, 1.5]);
ylim([-1, 1]);

% print('contour0.png', '-dpng');