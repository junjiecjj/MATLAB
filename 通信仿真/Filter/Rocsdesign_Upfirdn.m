%% https://blog.csdn.net/weixin_43870101/article/details/106794354
clear all;
clc;
% 指定过滤器参数
rolloff = 0.25;     % 滚降因子
span = 6;           % 滤波器宽度（符号数）
sps = 4;            % 每个符号的样本数

% 生成根升余弦滤波器的系数
h = rcosdesign(rolloff, span, sps);
size(h)
figure(1);
stem(h);
title('系统函数');


% 生成双极性数据向量。
x = 2*randi([0 1], 100, 1) - 1;
figure(2);
stem(x);
title('输入信号');
size(x)


% 上采样并过滤数据以进行脉冲整形。
y = upfirdn(x, h, sps);
size(y)
figure(3);
title('对输入序列上采样+noise后的结果');
plot(y, 'g');
hold on;

len_h = span * sps + 1;
(length(x)-1)*sps + 1 + span * sps + 1 - 1   == length(y)
(length(x)-1)*sps + 1 + len_h - 1   == length(y)
(length(x)-1)*sps + 1 + span * sps   == length(y)

% 添加噪声。
r = y + randn(size(y))*0.01;
size(r)
plot(r, 'r');

% 对接收到的信号进行滤波和下采样以进行匹配滤波。
x_hat = upfirdn(r, h, 1, sps);
size(x_hat)
figure(4);
stem(x_hat);
title('输出信号');



