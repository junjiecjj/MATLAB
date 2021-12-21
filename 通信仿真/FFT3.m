%   https://ww2.mathworks.cn/help/matlab/math/fourier-transforms.html
clear;clc;close all


%MATLAB? 中的 fft 函数使用快速傅里叶变换算法来计算数据的傅里叶变换。以正弦信号 x 为例，该信号是时间 t 的函数，频率分量为 15 Hz 和 20 Hz。使用在 10 秒周期内以 
%1/50秒为增量进行采样的时间向量。

Ts = 1/50;
t = 0:Ts:10-Ts;
x = sin(2*pi*15*t) + sin(2*pi*20*t);
figure(1);
plot(t,x)
xlabel('Time (seconds)')
ylabel('Amplitude')

%计算信号的傅里叶变换，并在频率空间创建对应于信号采样的向量 f。
y = fft(x);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
%以频率函数形式绘制信号幅值时，幅值尖峰对应于信号的 15 Hz 和 20 Hz 频率分量。
figure(2);
plot(f,abs(y));
%plot(f,abs(y/length(y)))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')

%该变换还会生成尖峰的镜像副本，该副本对应于信号的负频率。为了更好地以可视化方式呈现周期性，您可以使用 fftshift 函数对变换执行以零为中心的循环平移。

n = length(x);                         
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);
figure(3);
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%含噪信号
%在科学应用中，信号经常遭到随机噪声破坏，掩盖其频率分量。傅里叶变换可以清除随机噪声并显现频率。例如，通过在原始信号 x 中注入高斯噪声，创建一个新信号 xnoise。

rng('default')
xnoise = x + 2.5*randn(size(t));
%频率函数形式的信号功率是信号处理中的一种常用度量。功率是信号的傅里叶变换按频率样本数进行归一化后的平方幅值。计算并绘制以零频率为中心的含噪信号的功率谱。尽管存在噪声，您仍可以根据功率中的尖峰辨识出信号的频率。

ynoise = fft(xnoise);
ynoiseshift = fftshift(ynoise);    
power = abs(ynoiseshift).^2/n; 
figure(4);
plot(fshift,power)
title('Power')
xlabel('Frequency (Hz)')
ylabel('Power')

% %计算效率
% %直接使用傅里叶变换公式分别计算 y 的 n 个元素需要 n^2
% % 数量级的浮点运算。使用快速傅里叶变换算法，则只需要 nlogn 数量级的运算。在处理包含成百上千万个数据点的数据时，这一计算效率会带来很大的优势。在 n 为 2 的幂时，许多专门的快速傅里叶变换实现可进一步提高效率。
% %以加利福尼亚海岸的水下麦克风所收集的音频数据为例。在康奈尔大学生物声学研究项目维护的库中可以找到这些数据。载入包含太平洋蓝鲸鸣声的文件 bluewhale.au，并对其中一部分数据进行格式化。由于蓝鲸的叫声是低频声音，人类几乎听不到。数据中的时间标度压缩了 10 倍，以便提高音调并使叫声更清晰可闻。可使用命令 sound(x,fs) 来收听完整的音频文件。
% 
% whaleFile = 'bluewhale.au';
% [x,fs] = audioread(whaleFile);
% whaleMoan = x(2.45e4:3.10e4);
% t = 10*(0:1/fs:(length(whaleMoan)-1)/fs);
% figure(5);
% plot(t,whaleMoan)
% xlabel('Time (seconds)')
% ylabel('Amplitude')
% xlim([0 t(end)])
% 
% 
% %指定新的信号长度，该长度是大于原始长度的最邻近的 2 的幂。然后使用 fft 和新的信号长度计算傅里叶变换。fft 会自动用零填充数据，以增加样本大小。此填充操作可以大幅提高变换计算的速度，对于具有较大质因数的样本大小更是如此。
% 
% m = length(whaleMoan); 
% n = pow2(nextpow2(m));
% y = fft(whaleMoan,n);        
% %绘制信号的功率谱。绘图指示，呻吟音包含约 17 Hz 的基本频率和一系列谐波（其中强调了第二个谐波）。
% 
% f = (0:n-1)*(fs/n)/10; % frequency vector
% power = abs(y).^2/n;   % power spectrum      
% figure(6);
% plot(f(1:floor(n/2)),power(1:floor(n/2)))
% xlabel('Frequency (Hz)')
% ylabel('Power')