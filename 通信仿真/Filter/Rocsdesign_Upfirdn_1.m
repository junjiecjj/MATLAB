%% https://blog.csdn.net/weixin_46136963/article/details/106691783
clc;clear all;close all;
%%%%%%%%%%%%%%%% 输入信号  %%%%%%%%%%%%%%%%%%
x = ones(1,10);
x = 2 * randi([0 1], 1, 10) - 1
size(x)
figure(1);
stem(x);
title('输入信号');
ylim([-1.2 1.2]);

%%%%%%%%%%%%%%%%% 设置滤波器 %%%%%%%%%%%%%%%%%%%%
span = 4;
sps = 6;
h = rcosdesign(0.5, span, sps,'sqrt');
size(h)
% figure(2);
% stem(h);
% title('系统函数');

%%%%%%%%%%%%%%%%% 上采样 %%%%%%%%%%%%%%%%%%%%
y = upfirdn(x, h, sps);   %对输入信号进行上采样
size(y)
%%% 想得到正确的结果，sps=4与sps1的值必须相等
% figure(3);
% plot(y);
% title('对输入序列上采样后的结果');
% hold on;

%%%%%%%%%%%%%% 添加噪声 %%%%%%%%%%%%%%%%%%
r = y + randn(size(y))*0.01;
size(r)
% plot(r, 'r');

%%%%%%%%%%%%%%% 下采样  恢复原信号 %%%%%%%%%%%%%%%
% 对接收到的信号进行滤波和下采样以进行匹配滤波。
x_hat = upfirdn(r, h, 1, sps);
size(x_hat)
figure(4);
stem(x_hat);
title('输出信号');


len_h = span * sps + 1;
(length(x)-1)*sps + 1 + span * sps + 1 - 1   == length(y)
(length(x)-1)*sps + 1 + len_h - 1   == length(y)
(length(x)-1)*sps + 1 + span * sps   == length(y)

