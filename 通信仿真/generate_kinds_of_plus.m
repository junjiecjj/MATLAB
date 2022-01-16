%https://www.cxyzjd.com/article/wangh0802/79077901
clear ; clc; close all;

%% 试用 Matlab 生成一个幅度为 1，以 t = 2T 为对称中心的矩形脉冲信号 y (t)
% 矩形脉冲信号在 Matlab 中用 rectpuls 函数表示，其调用方式为：
% y = rectpulse(t, width)
% 用以产生一个幅度为 1，宽度为 width 以 t = 0 为对称中心的矩形脉冲波。Width 的默认值为 1。
t1 = 0:0.001:4;
T1 = 1;
yt1 = rectpuls(t1-2*T1, 2*T1);
figure(1);
plot(t1, yt1)
axis([0, 4, 0, 1.2]);

%% 使用 Matlab 绘制信号 (y (t) = frac {sin [pi (t-2)]}{pi (t-2)}) 的波形 
%信号 y (t) = sinc (t-2)，可以使用 sinc 函数表示
t2 = -4:0.001:8
t2_1 = t2-2;
y2 = sinc(t2_1);
figure(2);
plot(t2, y2);
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


t3 = -3:0.001:3;
width = 4;
skew = 0.5;
 
y3 = tripuls(t3, width, skew);
figure(3);
subplot(2,1,1), plot(t3, y3)
 
xlabel('t'),ylabel('y(t)')
grid
y3_1 = tripuls(2-2*t3, width, skew);
subplot(212),plot(t3, y3_1)
xlabel('t'),ylabel('y(2-2t)')
grid



%% 计算下面两个序列的卷积
% (x(k) = delta(k) + 2delta(k-1) + 2delta(k-2) + delta(k-3) + delta(k-4))
% (h(k) = 3delta(k) + 2delta(k-1) + delta(k-2))

x4 = [1 2 2 1 1];
h4 = [3 2 1];
y4 = conv(x4, h4);
figure(4);
subplot(311),stem(0:4, x4, 'filled'),axis([-1 7 0 15]),ylabel('x(k)')
subplot(312),stem(0:2, h4, 'filled'),axis([-1 7 0 15]),ylabel('h(k)')
subplot(313),stem(0:6, y4, 'filled'),axis([-1 7 0 15]),ylabel('y(k) = x(k)*h(k)')

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
% 产生一个周期高斯脉冲信号在 10khz 与 50% 的带宽。脉冲重复频率为 1khz，采样率为 50khz，脉冲序列长度为 10ms。每个脉冲的振幅是前一个脉冲的 80%。
T1 = 0:1/50e3:10e-3;
D1 = [0:1/1e3:10e-3;0.8.^(0:10)]';
% https://ww2.mathworks.cn/help/signal/gs/the-pulstran-function.html
Y1 = pulstran(T1,D1,'gauspuls',10e3,0.5);
figure(5);
subplot(2,1,1);
plot(T1,Y1);
xlabel 'Time (s)',
ylabel 'Periodic Gaussian pulse';

% https://blog.csdn.net/wwjra/article/details/7728892
t5=0:0.001:8;
d5=[0:1:8;   0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8]';
y5=pulstran(t5-0.25,d5,'gauspuls',10,0.5);
subplot(2,1,2);
plot(t5,y5);
grid;



% pulstran函数，func=triplus
% 生成不对称三角波，重复频率3Hz,三角宽度0.1s,信号长度1s,采样频率1KHz.
figure(6);
t6 = 0:1e-3:1;  %设置采样频率为1KHz
d6 = 0:1/3:1;   %设置信号重复频率为3Hz，即周期为1/3
subplot(5,1,1);
y6 = pulstran(t6,d6,'tripuls',0.1, -1);%这个函数中的 0.1 以及 - 1 都是‘tripuls’的参数，例子 0.1 是脉宽，-1 表示脉冲最高幅值在最左边，如果将 - 1 去掉，则默认为 0.5. 
plot(t6,y6);

subplot(5,1,2);
y6_2 = pulstran(t6,d6,'tripuls',0.1, -0.6);
plot(t6,y6_2);

subplot(5,1,3);
y6_3 = pulstran(t6,d6,'tripuls',0.1, 0.6);
plot(t6,y6_3);

subplot(5,1,4);
y6_4 = pulstran(t6,d6,'tripuls',0.1, 1);
plot(t6,y6_4);


subplot(5,1,5);
y6_5 = pulstran(t6,d6,'tripuls',0.1, 0);
plot(t6,y6_5);  %三角波，p6:有效部分宽度；p6_1:信号最大部分偏移(0为对称的)


%%==========================================================================================================
%   pulstran(t,d,rectpuls)
% This example generates a pulse train using the default rectangular pulse of unit width. 
% The repetition frequency is 0.5 Hz, the signal length is 60 s, and the sample rate is 1 kHz. The gain factor is a sinusoid of frequency 0.05 Hz.
%%===========================================================================================================

t = 0:1/1e3:60;
d = [0:2:60;sin(2*pi*0.05*(0:2:60))]';
x = @rectpuls;
y = pulstran(t,d,x);

figure(7);
plot(t,y)
hold off
xlabel('Time (s)')
ylabel('Waveform')

%=========================================================================
% Plot a 10 kHz Gaussian RF pulse with 50% bandwidth, sampled at a rate of 10 MHz. Truncate the pulse where the envelope falls 40 dB below the peak.
%=========================================================================
fs = 1e7;
tc = gauspuls('cutoff',10e3,0.5,[],-40); 
t = -tc:1/fs:tc; 
x = gauspuls(t,10e3,0.5); 

figure(8);
plot(t,x)
xlabel('Time (s)')
ylabel('Waveform')


%=========================================================================
% The pulse repetition frequency is 1 kHz, the sample rate is 50 kHz, and the pulse train length is 25 ms. The gain factor is a sinusoid of frequency 0.1 Hz.
%=========================================================================
ts = 0:1/50e3:0.025;
d = [0:1/1e3:0.025;sin(2*pi*0.1*(0:25))]';
y = pulstran(ts,d,x,fs);

figure(9);
plot(ts,y)
xlim([0 0.01])
xlabel('Time (s)')
ylabel('Waveform')

%=========================================================================
% Write a function that generates custom pulses consisting of a sinusoid damped by an exponential. The pulse is an odd function of time. 
% The generating function has a second input argument that specifies a single value for the sinusoid frequency and the damping factor. 
% Display a generated pulse, sampled at 1 kHz for 1 second, with a frequency and damping value, both equal to 30.
%=========================================================================
fnx = @(x,fn) sin(2*pi*fn*x).*exp(-fn*abs(x));

ffs = 1000;
tp = 0:1/ffs:1;

pp = fnx(tp,30);

figure(10);
plot(tp,pp)
xlabel('Time (s)')
ylabel('Waveform')


%=========================================================================
% Use the pulstran function to generate a train of custom pulses. The train is sampled at 2 kHz for 1.2 seconds. The pulses occur every third of a second and have exponentially decreasing amplitudes.
% Initially specify the generated pulse as a prototype. Include the prototype sample rate in the function call. In this case, pulstran replicates the pulses at the specified locations.
%=========================================================================

fs = 2e3;
t = 0:1/fs:1.2;

d = 0:1/3:1;
dd = [d;4.^-d]';

z = pulstran(t,dd,pp,ffs);

figure(11);
plot(t,z)
xlabel('Time (s)')
ylabel('Waveform')

%=========================================================================
% Generate the pulse train again, but now use the generating function as an input argument. Include the frequency and damping parameter in the function call. 
% In this case, pulstran generates the pulse so that it is centered about zero.
%=========================================================================

y = pulstran(t,dd,fnx,30);
figure(12);
plot(t,y)
xlabel('Time (s)')
ylabel('Waveform')

%=========================================================================
% Write a function that generates a custom exponentially decaying sawtooth waveform of frequency 0.25 Hz. 
% The generating function has a second input argument that specifies a single value for the sawtooth frequency and the damping factor.
% Display a generated pulse, sampled at 0.1 kHz for 1 second, with a frequency and damping value equal to 50.
%=========================================================================
fnx = @(x,fn) sawtooth(2*pi*fn*0.25*x).*exp(-2*fn*x.^2);

fs = 100;
t = 0:1/fs:1;

pp = fnx(t,50);
figure(13);
plot(t,pp)

%=========================================================================
% Use the pulstran function to generate a train of custom pulses. The train is sampled at 0.1 kHz for 125 seconds. The pulses occur every 25 seconds and have exponentially decreasing amplitudes.
% Specify the generated pulse as a prototype. Generate three pulse trains using the default linear interpolation method, nearest neighbor interpolation and piecewise cubic interpolation. Compare the pulse trains on a single plot.
%=========================================================================

d = [0:25:125; exp(-0.015*(0:25:125))]';
ffs = 100;
tp = 0:1/ffs:125;

r = pulstran(tp,d,pp);
y = pulstran(tp,d,pp,'nearest');
q = pulstran(tp,d,pp,'pchip');

figure(13);
plot(tp,r)
hold on
plot(tp,y)
plot(tp,q)
xlim([0 125])
legend('Linear interpolation','Nearest neighbor interpolation','Piecewise cubic interpolation')
hold off


































