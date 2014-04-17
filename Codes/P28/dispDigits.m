function h = dispDigits(numRow, numCol, x, y, display, pro, yTrue)
%%
if nargin < 5
    display = false;
end
if nargin < 6
    showPro = false;
else
    showPro = true;
end
if nargin < 7
    decEva  = ones(size(y));
else
    decEva  = (y == yTrue);
end
%%
fprintf('Plotting...\n');
h = figure;
colormap(gray);
for r = 1 : numRow
   for c = 1 : numCol
       idx = (r - 1) * numCol + c;
       img = reshape(x(idx, :), 20, 20);
       subplot(numRow, numCol, idx);
       imagesc(img);
       dig = y(idx);
       if dig == 10;
            dig = 0;
       end
       if showPro
            hTitle = title(sprintf('%d\n%.3f', dig, pro(idx)));
       else
            hTitle = title(sprintf('%d', dig));
       end
       if ~decEva(idx);
            set(hTitle, 'color', 'r');
       end
       axis image off
       if display
        fprintf('...%.2f%%...\n',...
            idx / (numCol * numRow) * 100 );
       end
   end
end
set(h, 'unit', 'normalized', 'position', [0,0,1,1]);