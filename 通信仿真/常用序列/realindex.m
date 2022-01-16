function[x,n] = realindex(ns,nf,a)
% ns=序列的起点；nf=序列的终点；n0=实指数的值
% x=产生的实指数序列；n=产生序列的位置信息
n = [ns:nf];
x = a.^n;

%  4. 实指数序列