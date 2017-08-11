J=J+sum(sum((R.*(X*Theta'-Y).^2)))/2+lambda/2*sum(sum(Theta.^2))+...  
    lambda/2*sum(sum(X.^2));  
for i=1:size(X,1)  
    idx = find(R(i,:)==1);  
    Thetatemp = Theta(idx,:);  
    Ytemp = Y(i,idx);  
    X_grad(i,:)=(X(i,:)*Thetatemp'-Ytemp)*Thetatemp+lambda*X(i,:);  
end  
for j=1:size(Theta,1)  
    idx = find(R(:,j)==1);  
    Xtemp = X(idx,:);  
    Ytemp = Y(idx,j);  
   Theta_grad(j,:)=(Xtemp*Theta(j,:)'-Ytemp)'*Xtemp+lambda*Theta(j,:);  
end  function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


end

