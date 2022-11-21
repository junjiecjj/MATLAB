function[x,n] = sinseq(ns,nf,A,w0,alpha)
% ns=序列的起点；nf=序列的终点；A=正弦序列的幅度
% w0=正弦序列的频率；alpha=正弦序列的初始相位
% x=产生的正弦序列；n=产生序列的位置信息
n = [ns:nf];
x = A * sin(w0 * n + alpha);


% 5. 正弦序列