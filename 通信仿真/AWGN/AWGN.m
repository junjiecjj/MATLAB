
clc;
close all;
clear;

% https://www.cnblogs.com/htj10/p/8610666.html
% To specify the power of X to be 0 dBW and add noise to produce
% an SNR of 10dB, use:
X = sqrt(2)*sin(0:pi/8:6*pi);
Y = awgn(X,10,0);
% To specify the power of X to be 3 Watts and add noise to
% produce a linear SNR of 4, use:
Y1 = awgn(X,4,3,'linear');
% To cause awgn to measure the power of X and add noise to
% produce a linear SNR of 4, use:
Y2 = awgn(X,4,'measured','linear'); %
figure(1);
subplot(411);
plot(X);
subplot(412);
plot(Y);
subplot(413);
plot(Y1);
subplot(414);
plot(Y2);


%%  https://blog.csdn.net/xuanx86/article/details/106925955
N=10000;
z=0.1*randn(1,N); %服从N(0,0.01)的高斯白噪声
figure(2);
subplot(2,1,1);
zi=linspace(-2,2,100);
f=ksdensity(z,zi,'function','cdf');
plot(zi,f);title('概率分布函数');
xlabel('x');ylabel('F(x)');
 
[p,zi] = ksdensity(z);
subplot(2,1,2);
plot(zi,p);title('概率密度函数');
xlabel('x');ylabel('p(x)');

figure(3);
[r,lags]=xcorr(z); %自相关函数
subplot(2,1,1);
plot(lags,r);title('自相关函数');
xlabel('t');ylabel('R(t)');

f=fft(r);%维纳辛钦关系
f1=fftshift(f);%频谱校正
x=(0:length(f1)-1)*200/length(f1)-100; %x轴进行处理
y=abs(f1);
subplot(2,1,2);
plot(x,y);title('功率谱密度');
xlabel('x');ylabel('P(x)');