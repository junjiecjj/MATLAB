clc;
clear;
close all;

%% 傅里叶变换 (fft) matlab 程序二

tp=0:2048; % 时域数据点数
yt=sin(0.08*pi*tp).*exp (-tp/80); % 生成正弦衰减函数
figure(3);
plot(tp,yt);
axis([0,400,-1,1]), % 绘正弦衰减曲线
t=0:800/2048:800; % 频域点数 Nf
f=0:1.25:1000;
yf = fft(yt); % 快速傅立叶变换

ya=abs(yf(1:801)); % 幅值
yp=angle(yf(1:801))*180/pi; % 相位

r=real(yf(1:801)); % 实部
yi=imag(yf(1:801)); % 虚部

figure(4); 
subplot(2,2,1)
plot(f,ya);
axis([0,200,0,60]) % 绘制幅值曲线
title('幅值曲线')

subplot(2,2,2)
plot(f,yp);
axis([0,200,-200,10]) % 绘制相位曲线
title('相位曲线')

subplot(2,2,3)
plot(f,r);
axis([0,200,-40,40]) % 绘制实部曲线
title('实部曲线')

subplot(2,2,4)
plot(f,yi);
axis([0,200,-60,10]) % 绘制虚部曲线
title('虚部曲线')

