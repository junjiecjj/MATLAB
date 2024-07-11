clear;
clc;
close all;

 
d0 = 51; % AP到IRS之间的距离
dv = 2; % 两条竖线之间的距离
% d = 50; % User和AP之间的水平距离
% d1 = sqrt(d^2+dv^2); % AP到User之间的距离
% d2 = sqrt((d0-d)^2+dv^2); % User到IRS之间的距离
C0 = db2pow(-30); % 参考距离时的路损
D0 = 1; % 参考距离
sigmaK2 = db2pow(-80); % 噪声功率
gamma = db2pow(10); % 信干噪比约束10dB

L = @(d, alpha)C0*(d/D0)^(-alpha); % 路损模型

% 路损参数
alpha_AI = 2;
alpha_Iu = 2.8;
alpha_Au = 3.5; 
beta_IU = 0; % IRS到User考虑瑞利衰落信道，AP和IRS之间为纯LoS信道

% 天线数
M = 3; % AP天线数
N = 4; % IRS单元个数 

G = sqrt(L(d0,alpha_AI))*ones(N,M);
hr =  [[-5.52410927+5.11202098j,  2.21161698+3.83710666j,  -6.87020352+8.59078659j, -4.45867517-1.69307665j]];
hd =  [[ 9.63447462-5.59241419j,  4.06630045-7.78999435j,  -0.60554468+3.04178728j]];


Phi = diag(hr)*G;
R = [Phi*Phi' Phi*hd'; hd*Phi' 0];
cvx_begin sdp quiet
    variable V(N+1,N+1) hermitian
    maximize(real(trace(R*V))+norm(hd)^2);
    subject to
        diag(V) == 1;
        V ==  hermitian_semidefinite(N+1);
cvx_end

lower_bound = cvx_optval

L = 1000
% 高斯随机化过程
%% method 1
max_F = 0;
max_v = 0;
[U, Sigma] = eig(V);
for l = 1 : L
    r = sqrt(2) / 2 * (randn(N+1, 1) + 1j * randn(N+1, 1));
    v = U * Sigma^(0.5) * r;
    if v' * R * v > max_F
        max_v = v;
        max_F = v' * R * v;
    end
end

v = exp(1j * angle(max_v / max_v(end)));
v = v(1 : N);

P_opt = gamma/(norm(v'*(diag(hr)*G)+hd)^2)





