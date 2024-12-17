addpath('..\Tools/');
clc;clear;

%法一：根据matlab自带程序获得生成多项式，再根据自带编码函数获得系统生成矩阵
% n = 7;
% k = 4;
% GP = bchgenpoly(n,k);%生成多项式
% enc = comm.BCHEncoder(n,k,GP);
% u=[zeros(1,k-1) 1]';
% G = zeros(k,n);
% for i=1:k
%     u=circshift(u,1);
%     G(i,:) = enc(u)';
% end
% save(['BCH_n' num2str(n) '_k' num2str(k) '_G.mat'],'G');

%法二：根据BOOK-2004-Error Control Coding-(Shu Lin)附录C的本原BCH码的生成多项式获得生成矩阵
clc;clear;
n = 15;
k = 7;
g_BCH = [1 1 1 0 1 0 0 0 1];%BCH生成多项式
Xn1 = [1 zeros(1,n-1) 1];%X^n+1
[h_BCH, a] = deconv(Xn1,g_BCH);
u=[mod(h_BCH,2)  zeros(1,n-k-1)];
H = zeros(n-k,n);
H(1,:) = u;
for i=2:n-k
    u=circshift(u,1);
    H(i,:) = u;
end
%在最右边添加全0列，最后一行添加全1行，得到扩展BCH码校验矩阵
H = [H,zeros(n-k,1)];
H = [H;ones(1,n+1)];
[H_sys,perm_index2] = my_Gauss_Elimination(H);
G_sys = [eye(k) H_sys(:,n-k+2:end)'];

save(['eBCH_n' num2str(n+1) '_k' num2str(k) '_G_sys.mat'],'G_sys');
save(['eBCH_n' num2str(n+1) '_k' num2str(k) '_H.mat'],'H');

test_num = 0;
for i = 0:k
total_TEP = nchoosek(k,i);%当前阶数下，总的TEPs数量
    temp = 1:k;
    C = nchoosek(temp,i);   %当前阶数下所有的组合数
    for j = 1:total_TEP     %遍历每个组合数
        test_num = test_num+1;
        TEP = zeros(1,k);
        TEP(C(j,:)) = 1; %得到错误模式
        c_temp = mod(TEP*G_sys,2);%重编码
        a(test_num) = sum(c_temp);
    end

end


