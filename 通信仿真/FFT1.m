% http://www.4k8k.xyz/article/weixin_36309562/115817406
clear;
clc;
close all


Fs = 128; % 采样频率
T = 1/Fs; % 采样时间
L = 256; % 信号长度
t = (0:L-1)*T; % 时间
x = 5 + 7*cos (2*pi*15*t - pi/6) + 3*cos (2*pi*40*t - pi/2); % cos 为底原始信号
y = x + randn (size (t)); % 添加噪声 

figure(1); 
plot (t,y);

title ('加噪声的信号')
xlabel ('时间 (s)')

N = 2^nextpow2 (L); % 采样点数，采样点数越大，分辨的频率越精确，N>=L，超出的部分信号补为 0
Y = fft (y,N)/N*2; % 除以 N 乘以 2 才是真实幅值，N 越大，幅值精度越高
f = Fs/N*(0:1:N-1); % 频率
A = abs(Y); % 幅值
P = angle (Y); % 相值
figure(2);
subplot (211);
plot(f(1:N/2),A(1:N/2)); % 函数 fft 返回值的数据结构具有对称性，因此我们只取前一半
title ('幅值频谱');
xlabel ('频率 (Hz)');
ylabel ('幅值');

subplot(212);
plot(f(1:N/2),P(1:N/2));
title ('相位谱频');
xlabel ('频率 (Hz)');
ylabel ('相位');

%% 傅里叶变换 (fft) matlab 程序二

tp=0:2048; % 时域数据点数
yt=sin (0.08*pi*tp).*exp (-tp/80); % 生成正弦衰减函数
figure(3);
plot(tp,yt);
axis([0,400,-1,1]), % 绘正弦衰减曲线
t=0:800/2048:800; % 频域点数 Nf
f=0:1.25:1000;
yf=fft (yt); % 快速傅立叶变换
ya=abs(yf(1:801)); % 幅值
yp=angle(yf(1:801))*180/pi; % 相位 y
r=real(yf(1:801)); % 实部

yi=imag(yf(1:801)); % 虚部
figure(4); 
subplot(2,2,1)
plot (f,ya),axis ([0,200,0,60]) % 绘制幅值曲线
title ('幅值曲线')

subplot(2,2,2)
plot (f,yp),axis ([0,200,-200,10]) % 绘制相位曲线
title ('相位曲线')

subplot(2,2,3)
plot (f,r),axis ([0,200,-40,40]) % 绘制实部曲线
title ('实部曲线')

subplot(2,2,4)
plot (f,yi),axis ([0,200,-60,10]) % 绘制虚部曲线
title ('虚部曲线')


%% 傅里叶变换 (fft) matlab 程序三


%% 执行 FFT 点数与原信号长度相等 (100 点)

% 构建原信号

N=100; % 信号长度 (变量 @@@@@@@)
Fs=1; % 采样频率
dt=1/Fs; % 采样间隔
t=[0:N-1]*dt; % 时间序列
xn=cos(2*pi*0.24*[0:99])+cos(2*pi*0.26*[0:99]);
xn=[xn,zeros(1,N-100)]; % 原始信号的值序列

figure(5);
subplot (3,2,1) % 变量 @@@@@@@
plot (t,xn) % 绘出原始信号
xlabel ('时间 /s'),title ('原始信号 (向量长度为 100)') % 变量 @@@@@@@

% FFT 分析

NN=N; % 执行 100 点 FFT
XN=fft(xn,NN)/NN; % 共轭复数，具有对称性
f0=1/(dt*NN); % 基频
f=[0:ceil((NN-1)/2)]*f0; % 频率序列
A=abs (XN); % 幅值序列
subplot (3,2,2);
stem (f,2*A (1:ceil ((NN-1)/2)+1));
xlabel ('频率 / Hz') % 绘制频谱 (变量 @@@@@@@)

axis ([0 0.5 0 1.2]) % 调整坐标范围

title ('执行点数等于信号长度 (单边谱 100 执行点)'); % 变量 @@@@@@@

%% 执行 FFT 点数大于原信号长度

% 构建原信号

N=100; % 信号长度 (变量 @@@@@@@)
Fs=1; % 采样频率
dt=1/Fs; % 采样间隔
t=[0:N-1]*dt; % 时间序列
xn=cos(2*pi*0.24*[0:99])+cos(2*pi*0.26*[0:99]);
xn=[xn,zeros(1,N-100)]; % 原始信号的值序列
subplot (3,2,3) % 变量 @@@@@@@
plot (t,xn) % 绘出原始信号

xlabel ('时间 /s');
title ('原始信号 (向量长度为 100)') % 变量 @@@@@@@

% FFT 分析

NN=120; % 执行 120 点 FFT (变量 @@@@@@@)
XN=fft (xn,NN)/NN; % 共轭复数，具有对称性
f0=1/(dt*NN); % 基频
f=[0:ceil((NN-1)/2)]*f0; % 频率序列
A=abs (XN); % 幅值序列
subplot (3,2,4);
stem (f,2*A (1:ceil ((NN-1)/2)+1));
xlabel ('频率 / Hz') % 绘制频谱 (变量 @@@@@@@)
axis ([0 0.5 0 1.2]) % 调整坐标范围
title ('执行点数大于信号长度 (单边谱 120 执行点)'); % 变量 @@@@@@@

%% 执行 FFT 点数与原信号长度相等 (120 点)

% 构建原信号

N=120; % 信号长度 (变量 @@@@@@@)
Fs=1; % 采样频率
dt=1/Fs; % 采样间隔
t=[0:N-1]*dt; % 时间序列
xn=cos(2*pi*0.24*[0:99])+cos(2*pi*0.26*[0:99]);
xn=[xn,zeros(1,N-100)]; % 原始信号的值序列
subplot (3,2,5) % 变量 @@@@@@@
plot (t,xn) % 绘出原始信号
xlabel ('时间 /s');
title ('原始信号 (向量长度为 120)') % 变量 @@@@@@@

% FFT 分析

NN=120; % 执行 120 点 FFT (变量 @@@@@@@)
XN=fft (xn,NN)/NN; % 共轭复数，具有对称性
f0=1/(dt*NN); % 基频
f=[0:ceil((NN-1)/2)]*f0; % 频率序列

A=abs (XN); % 幅值序列
subplot (3,2,6);
stem (f,2*A (1:ceil ((NN-1)/2)+1));
xlabel ('频率 / Hz') % 绘制频谱 (变量 @@@@@@@)
axis ([0 0.5 0 1.2]) % 调整坐标范围
title ('执行点数等于信号长度 (单边谱 120 执行点)'); % 变量 @@@@@@@