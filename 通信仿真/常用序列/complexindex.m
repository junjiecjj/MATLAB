function[x,n] = complexindex(ns,nf,index)
% ns=���е���㣻nf=���е��յ㣻index=��ָ����ֵ
% x=�����ĸ�ָ�����У�n=�������е�λ����Ϣ
n = [ns:nf];
x = exp(index.*n);

% 6. ��ָ������