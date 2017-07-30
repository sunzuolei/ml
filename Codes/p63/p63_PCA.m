%基于PCA的人脸识别
clear; clc; close all

addpath('./Testing')
addpath('./Training')
N=5;%5个人
M=5;%每个人5幅图
for i=1:N
    for j=1:M
        image=double(rgb2gray(imread(['orl_00',num2str(i),'_00',num2str(j),'.bmp'])));
        x(:,(i-1)*N+j)=reshape(image,size(image,1)*size(image,2),1);%样本矩阵
    end
end
meanx=1/(N*M)*sum(x,2);%计算平均脸
A=x-repmat(meanx,1,N*M);%计算差值脸矩阵，每一列是一个差值脸向量
C=1/(N*M)*A'*A;%计算协方差矩阵
[U,lamda,V]=svd(C);%求特征值、特征向量
eigenvalues = sort(diag(lamda),'descend');%特征值降序排列
%选取最大的几个特征值
Tolerance=0.9999;
phi=0;
eigen=0;
eigennum=0;
eigensum=sum(eigenvalues.^2);
while phi<=Tolerance
    eigennum=eigennum+1;
    eigen=eigen+(eigenvalues(eigennum).^2);
    phi=eigen/eigensum;
end

for i=1:eigennum
    k=find(diag(lamda)==eigenvalues(i));
    w(:,i)=1/eigenvalues(i)*A*V(:,k);
end
save A A
save meanx meanx
save w w



