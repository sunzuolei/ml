clear all; close all; clc;

h = eps : 0.01 : 20;
%%
figure;
title('log(h)');
hold on;
plot(h, log(h), 'r-', 'linewidth', 2);
grid on;
grid minor;
axis equal;
set(gca,'XTick',[0, 1, 2, 5, 10, 20]);
% print('log.png', '-dpng');

%%
figure;
title('-log(h)');
hold on;
plot(h, -log(h), 'r-', 'linewidth', 2);
grid on;
grid minor;
axis equal;
set(gca,'XTick',[0, 1, 20]);
axis([0, 1, -log(1), 4]);
% print('mlog.png', '-dpng');
%%
h = 0 : 0.01 : 1-eps;
figure;
title('-log(1-h)');
hold on;
plot(h, -log(1-h), 'b-', 'linewidth', 2);
grid on;
grid minor;
axis equal;
set(gca,'XTick',[0, 1]);
axis([0, 1, 0, 4]);
% print('mlog1mh.png', '-dpng');
fprintf('Press any key to continue...')
pause;
%%
plot(h, -log(h), 'r-', 'linewidth', 2);
title('Cost function');
xlabel('h_\theta (x)');
ylabel('Cost');
print('logisticcostfunction.png', '-dpng');