%https://www.cxyzjd.com/article/wangh0802/79077901
clear ; clc; close all;

%% 试用 Matlab 生成一个幅度为 1，以 t = 2T 为对称中心的矩形脉冲信号 y (t)
% 矩形脉冲信号在 Matlab 中用 rectpuls 函数表示，其调用方式为：
% y = rectpulse(t, width)
% 用以产生一个幅度为 1，宽度为 width 以 t = 0 为对称中心的矩形脉冲波。Width 的默认值为 1。
t = 0:0.001:4;
T = 1;
yt = rectpuls(t-2*T, 2*T);
figure(1);
plot(t, yt)
axis([0, 4, 0, 1.2]);

%% 使用 Matlab 绘制信号 (y (t) = frac {sin [pi (t-2)]}{pi (t-2)}) 的波形 
%信号 y (t) = sinc (t-2)，可以使用 sinc 函数表示
t = -4:0.001:8
t1 = t-2;
y = sinc(t1);
figure(2);
plot(t, y);
xlabel('t');
ylabel('y(t)');
axis([-4, 8, -0.4, 1.0]),grid on;

%% 在 matlab 中，提供了一些产生常用信号的 matlab 函数，如表 3.1 所示。分别用于产生三角波、方波、sinc 函数等信号的波形。
% 表 3.1 常用信号的 matlab 产生函数
% sawtooth	产生锯齿波和三角波	pulstran	产生冲击串
% square	产生方波	rectpuls	产生非周期方波
% sinc	产生 sinc 函数波形	tripuls	产生非周期三角波
% chirp	产生调频余弦信号	diric	产生 Dirichlet 或周期 sinc
% gauspuls	产生高斯正弦脉冲信号	gmonopuls	产生高斯单脉冲信号


%% 编程生成一个最大幅度为 1，宽度为 4 的三角波函数 y (t)，函数值的非零值为 (-2, 2)，并画出 y (2 - 2t) 的波形。
% 三角波信号的产生可以通过函数 tripuls 实现。


t = -3:0.001:3;
width = 4;
skew = 0.5;
 
y = tripuls(t, width, skew);
figure(3);
subplot(2,1,1), plot(t, y)
 
xlabel('t'),ylabel('y(t)')
grid
y1 = tripuls(2-2*t, width, skew);
subplot(212),plot(t, y1)
xlabel('t'),ylabel('y(2-2t)')
grid



%% 计算下面两个序列的卷积
% (x(k) = delta(k) + 2delta(k-1) + 2delta(k-2) + delta(k-3) + delta(k-4))
% (h(k) = 3delta(k) + 2delta(k-1) + delta(k-2))

x = [1 2 2 1 1];
h = [3 2 1];
y = conv(x, h);
figure(4);
subplot(311),stem(0:4, x, 'filled'),axis([-1 7 0 15]),ylabel('x(k)')
subplot(312),stem(0:2, h, 'filled'),axis([-1 7 0 15]),ylabel('h(k)')
subplot(313),stem(0:6, y, 'filled'),axis([-1 7 0 15]),ylabel('y(k) = x(k)*h(k)')

%%  pulstran
% MATLAB 生成脉冲序列：pulstran 函数使用简记：
% 
% pulstran 函数用来生成脉冲序列，其主要调用语法如下：
% 
% 1.pulstran（t,d,‘func’,p1,p2,???）：生成一个基于连续函数 func 样本的脉冲序列。
% 其中 t 为时间轴，一般是一个一维数组。d 为采样间隔，可以是两列，第一列对应偏移量，第二列对应增益量。
% pulstran 对 func 进行 length（d）次的计算，并将各次的结果求和：y=func (t=d (1))+func (t=d (2))+???。
% 其中 func 可以有如下 3 种取值：gauspuls，生成一个高斯调制（Gaussian-modulated）的正弦脉冲；
% reectpuls，生成一个采样非周期矩形波；
% tripuls，生成一个采样非周期三角波。p1，p2，???是附加参数。
% 
% 2.pulstran（t,d,p,fs）：生成一个向量 p 脉冲的多重延时插值之和，采样率为 fs。
% 
% 3.pulstran（t,d,p）：假设采样频率 fd 等于 1Hz。

% pulstran 函数基于连续的或采样的原型脉冲生成脉冲序列。此示例生成由高斯脉冲的多次延迟插值之和组成的脉冲序列。
% 该脉冲序列定义为具有 50 kHz 的采样率、10 ms 的脉冲序列长度和 1 kHz 的脉冲重复率。
% T 指定脉冲序列的采样时刻。D 在第一列中指定每个脉冲重复的延迟，在第二列中指定每个重复的可选衰减。
% 要构造该脉冲序列，请将 gauspuls 函数的名称以及附加参数（用于指定带宽为 50% 的 10 kHz 高斯脉冲）传递给 pulstran。
T = 0:1/50e3:10e-3;
D = [0:1/1e3:10e-3;0.8.^(0:10)]';
% https://ww2.mathworks.cn/help/signal/gs/the-pulstran-function.html
Y = pulstran(T,D,'gauspuls',10e3,0.5);
figure(5);
subplot(2,1,1);
plot(T,Y);
xlabel 'Time (s)', 
ylabel 'Periodic Gaussian pulse';

% https://blog.csdn.net/wwjra/article/details/7728892
t=0:0.001:8;
d=[0:1:8;0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8]';
y=pulstran(t-0.25,d,'gauspuls',10,0.5);
subplot(2,1,2);
plot(t,y);
grid;
