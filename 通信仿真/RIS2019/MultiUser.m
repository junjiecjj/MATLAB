% https://blog.csdn.net/liujun19930425/article/details/127862357
clear;
clc;
close all;
 
Uk = 4; % 4个用户，图7仿真，假设U_k, k=1,2,3,4是活跃用户
epsilon = 1e-4; % 收敛停止条件
d0 = 51; % AP到IRS之间的距离
dv = 2; % 两条竖线之间的距离
d1 = 20; % AP到User之间的距离
d2 = 3; % User到IRS之间的距离
d_Au = [d1; sqrt((d0-d2*cos(2*pi/5))^2+(d2*sin(2*pi/5)^2)); d1; sqrt((d0-d2*cos(pi/5))^2+(d2*sin(pi/5)^2))]; % AP和User之间的距离
theta_Au = [7*pi/4; 2*pi-atan(d2*sin(2*pi/5)/(d0-d2*cos(2*pi/5))); pi/4; 2*pi-atan(d2*sin(pi/5)/(d0-d2*cos(pi/5)))];  % AP和User1,2,3,4之间的方位角
d_Iu = [sqrt((d0-d1*cos(pi/4))^2+(d1*sin(pi/4)^2)); d2; sqrt((d0-d1*cos(pi/4))^2+(d1*sin(pi/4)^2)); d2]; % IRS和User之间的距离
theta_Iu = [atan(d1*sin(pi/4)/(d0-d1*cos(pi/4))); 2*pi/5; -atan(d1*sin(pi/4)/(d0-d1*cos(pi/4))); pi/5];  % IRS和User1,2,3,4之间的方位角
C0 = db2pow(-30); % 参考距离时的路损
D0 = 1; % 参考距离
sigmaK2 = db2pow(-80); % 噪声功率
gamma = db2pow(20); % 信干噪比约束10dB
 
L = @(d, alpha)C0*(d/D0)^(-alpha); % 路损模型

% 路损参数
alpha_AI = 2.8;
alpha_Iu = 2.8;
alpha_Au = 3.5; 
% 莱斯因子
beta_Au = 0; % AP到User之间考虑瑞利衰落信道
beta_AI = db2pow(3); % AP到RIS之间考虑莱斯信道，莱斯因子为3dB
beta_Iu = db2pow(3); % IRS到User考虑瑞利莱斯信道，莱斯因子为3dB
 
% 天线数
M = 4; % AP天线数
Nx = 5; % IRS单元个数
Ny = 6;
N = Nx*Ny; 

G = sqrt(L(d0,alpha_AI))*(sqrt(beta_AI/(1+beta_AI))*ones(N,M)+sqrt(1/(1+beta_AI))*((randn(N,M)+1i*randn(N,M)/sqrt(2)))); % AP和RIS之间的角度都为0°
Hr = zeros(N,Uk);
Hd = zeros(M,Uk);
for i=1:Uk
    Hr(:,i) = sqrt(L(d_Iu(i),alpha_Iu)/sigmaK2)*(sqrt(beta_Iu/(1+beta_Iu))*URA_sv(theta_Iu(i),0,Nx,Ny)+sqrt(1/(1+beta_Iu))*((randn(N,1)+1i*randn(N,1)/sqrt(2)))); % IRS-User
    Hd(:,i) = sqrt(L(d_Au(i),alpha_Au)/sigmaK2)*((randn(M,1)+1i*randn(M,1)/sqrt(2))); % AP-User
end

theta = 2*pi*rand(1,N); % 随机初始化IRS的相位
Theta = diag(exp(1i*theta));
 
H = zeros(Uk,M);
P_old = 0 ;
P_new = 100;
maxIter = 30;
P = zeros(maxIter);
count = 0;
while(abs(P_old-P_new)>epsilon && count < maxIter)
    count = count + 1
    for i=1:Uk 
        H(i,:) = Hr(:,i)'*Theta*G+Hd(:,i)'; % 级联信道
    end
    W = PMQoSSOCP(H, gamma,M,Uk);
    P_opt = pow2db(norm(W,"fro")^2);
    P(count) = P_opt;
    P_old = P_new;
    P_new = P_opt;
    v = IRS_MultiUser(W,Hr,Hd,G,N,Uk,gamma);
    Theta = diag(v');   
end
plot(1:count,P(1:count),'-or','LineWidth',2)
xlabel('Number of iterations')
ylabel('Transmit power at the AP (dBm)')
grid on











