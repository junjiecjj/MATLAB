function[x,n] = realindex(ns,nf,a)
% ns=���е���㣻nf=���е��յ㣻n0=ʵָ����ֵ
% x=������ʵָ�����У�n=�������е�λ����Ϣ
n = [ns:nf];
x = a.^n;

%  4. ʵָ������