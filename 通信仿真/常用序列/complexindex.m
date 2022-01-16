function[x,n] = complexindex(ns,nf,index)
% ns=序列的起点；nf=序列的终点；index=复指数的值
% x=产生的复指数序列；n=产生序列的位置信息
n = [ns:nf];
x = exp(index.*n);

% 6. 复指数序列