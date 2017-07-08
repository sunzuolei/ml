A = [1 4;2 5;5 1;4 2];
theta = [2 5]';%int value
result = [19 26 19 20]';
learning_rate = 0.01;
loss = 1000;
i = 0;
error = zeros(4,1);
while ( i <= 100 && loss > 0.001 )
    j = mod(i,4)+1;
    error(j,:) = result(j,:)-A(j,:)*theta;%与批量梯度下降方法最大的区bie
    theta = theta + learning_rate.*A'*error;
    fprintf('theta now is %2.of\n',theta);
    loss=(A*theta-result)'*(A*theta-result);
    fprintf('loss now is %f\n',loss);
    i=i+1;
end
    
