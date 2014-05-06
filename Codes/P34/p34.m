clear all; close all; clc;

rng(666);

%%
s1 = 3;
s2 = 2;
s3 = 1;

%%
Theta1 = rand(s2, s1 + 1);
Theta2 = rand(s3, s2 + 1);

disp('Theta1 =');
disp(Theta1);
disp('Theta2 =');
disp(Theta2);

%% Unrolling
thetaVec  = [Theta1(:); Theta2(:)];
thetaVec2 = [reshape(Theta1, [], 1); reshape(Theta2, [], 1)];

disp('thetaVec =');
disp(thetaVec);
disp('thetaVec2 =');
disp(thetaVec2);

%% Rolling
Theta1Bak = reshape(thetaVec(1 : s2 * (s1+1) ),       s2, s1 + 1);
Theta2Bak = reshape(thetaVec(s2 * (s1+1) + 1 : end ), s3, s2 + 1);

disp('Theta1Bak =');
disp(Theta1Bak);
disp('Theta2Bak =');
disp(Theta2Bak);

%%
disp('Differences are');
disp(  Theta1Bak - Theta1 );
disp(  Theta2Bak - Theta2 );