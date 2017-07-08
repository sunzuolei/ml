 %A*theta = [19 26 19 20]';
A = [1 4;2 5;5 1;4 2];
theta = [2 5]';
result = [19 26 19 20]';
learning_rate = 0.01;
loss = 1000;
i = 0;
while(i<=100&&loss>0.0001)
    %error_sum=0;
    i = i+1;
    error = result-A*theta;
    theta = theta + learning_rate*A'*error;
    fprintf('theta now is %2.of\n',theta);
    loss = (A*theta - result)'*(A*theta-result);
    fprintf('loss now is %f\n',loss);
end
    
