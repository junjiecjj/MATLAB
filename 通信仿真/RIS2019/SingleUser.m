clear;
clc;
close all;

epsilon = 1e-4; % 收敛停止条件
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
M = 4; % AP天线数
N = 30; % IRS单元个数

d = 20:5:50; % User和AP之间的水平距离
frame = 500;

P1 = zeros(length(d),1);
P2 = zeros(length(d),1);
P3 = zeros(length(d),1);
P4 = zeros(length(d),1);
P5 = zeros(length(d),1);
P6 = zeros(length(d),1);
P7 = zeros(length(d),1);
for i = 1:length(d)
    i
    d1 = sqrt(d(i)^2+dv^2); % AP到User之间的距离
    d2 = sqrt((d0-d(i))^2+dv^2); % User到IRS之间的距离
    for j = 1:frame
        G = sqrt(L(d0,alpha_AI))*ones(N,M); % LoS信道,除以噪声功率是为了进行噪声功率归一化，因为G和hr是级联的，对一个信道进行归一化即可
        hr = sqrt(L(d2,alpha_Iu)/(2*sigmaK2)) * (randn(1,N)+1i*randn(1,N)); % 瑞利信道, IRS-User
        hd = sqrt(L(d1,alpha_Au)/(2*sigmaK2)) * (randn(1,M)+1i*randn(1,M)); % 瑞利信道, AP-User
        
        % SDR优化方法，得到下界
        [v, lower_bound] = SDR_solving(hr, G, hd, N);
        P_opt = gamma/(norm(v'*(diag(hr)*G)+hd)^2);
        P1(i) = P1(i) + P_opt;
        P4(i) = P4(i) + gamma / lower_bound;
        
        % AP-User MRT
        [v_aumrt, w_aumrt] = AUMRT(hd,hr,G);
        P_aumrt = gamma/(norm((v_aumrt.'*(diag(hr)*G)+hd)*w_aumrt)^2); % 注意这里的相位对齐后，对v只需要转置即可，不需要共轭转置
        P2(i) = P2(i) + P_aumrt;

        % AP-IRS MRT
        [v_aimrt, w_aimrt] = AIMRT(hd,hr,G);
        P_aimrt = gamma/(norm((v_aimrt.'*(diag(hr)*G)+hd)*w_aimrt)^2);
        P3(i) = P3(i) + P_aimrt;

        % 交替迭代算法
        P_AO = AO(hd,hr,G,epsilon,gamma);
        P7(i) = P7(i) + P_AO;

        % IRS随机相位算法
        theta = 2*pi*rand(1,N); % 随机初始化IRS的相位
        Theta = diag(exp(1i*theta));
        P_rand = gamma / (norm(hr*Theta*G+hd)^2);
        P5(i) = P5(i) + P_rand;

        % 无IRS的场景
        P6(i) = P6(i) + gamma / (norm(hd)^2);
    end
end
P1 = pow2db(P1 / frame);
P2 = pow2db(P2 / frame);
P3 = pow2db(P3 / frame);
P4 = pow2db(P4 / frame);
P5 = pow2db(P5 / frame);
P6 = pow2db(P6 / frame);
P7 = pow2db(P7 / frame);
plot(d, P1, 'g-','LineWidth',2.5)
hold on
plot(d, P2, 'r^-.','LineWidth',2)
plot(d, P3, 'cv-.','LineWidth',2)
plot(d, P4, 'mo-','LineWidth',1)
plot(d, P5, 'kp:','LineWidth',2)
plot(d, P6, 'ks:','LineWidth',2)
plot(d, P7, 'b:','LineWidth',2)
xlabel('AP-user horizontal distance, d(m)')
ylabel('Transmit power at the AP (dBm)')
grid on
legend('SDR','AP-suer MRT','AP-IRS MRT','Lower bound','Random pahse shift','Without IRS','Alternating optimization','location','best')


























