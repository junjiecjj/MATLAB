
clc;
close all;
clear;

%%  https://blog.csdn.net/aixdm/article/details/107557145


t = 0:0.0001:10;
x = sin(t);
subplot(2,2,1),plot(t,x),title('正弦信号y')
y = awgn(x,20);

subplot(2,2,2),plot(t,y),title('加AWGN后的正弦信号y')
var(y-x)

z  = awgn(x,20,10);
subplot(2,2,3),plot(t,z),title('加AWGN后的正弦信号z')
var(z-x)
