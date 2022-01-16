function[x,n] = stepseq(n0,ns,nf)
% ns=序列的起点；nf=序列的终点
% n0=从n0处开始生成单位阶跃序列
% x=产生的单位阶跃序列； n=产生序列的位置信息
n = [ns:nf];
x = [(n-n0)>=0];

% 2. 单位阶跃序列