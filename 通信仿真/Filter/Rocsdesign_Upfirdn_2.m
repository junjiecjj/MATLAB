%% https://blog.csdn.net/lanluyug/article/details/80401943
clc;clear all;close all;

rolloff = 0.25;
span = 4;
sps = 40;


h = rcosdesign(rolloff, span, sps);
size(h)
figure(1);
stem(h);
title('输入信号');

x = 2 * randi([0 1], 20, 1) - 1;
size(x)
figure(2);
stem(x);
title('系统函数');

y = upfirdn(x, h, sps);%成型滤波
size(y)
figure(3);
stem(y);
title('对输入序列上采样后的结果');


r = y + randn(size(y)) * 0.01;%随意加的热噪声
size(r)
figure(4);
stem(r);
title('过信道后的结果');

fc = 0.1;
t = [1:length(r)];
carrier = cos(2 * pi * fc * t);
size(carrier)

z = 20 * r .* carrier';%简单的调制一下
size(z)
figure(5);
plot(z);
title('carrier');