
clc;
close all;
clear;


%%  https://www.cnblogs.com/xh0102/p/6382736.html
chan = rayleighchan (1/15000,500);%1/15000 �������ǵĲ���Ƶ�ʣ�Ҳ������һ���������Ƕ೤һ��ʱ�䵥λ��500 ������������Ƶ��...  
% ��ʵ���ǿ��������������ô�ܹ����أ���ʵ�������Ǹ����� 500 �Ķ����գ����ͻᰴһ�������ʱ��������������ʱ�䣬Ȼ������֪����Ĳ���Ƶ�ʣ�����֪���ڶ��ٸ���������Ӧ������ص��ˣ�����ô�򵥣�  
x = ones (1,140);% Դ����  
y = filter (chan,x);% �����ŵ������� 
figure(1);
plot(abs(y)) ;
[r,lags] = xcorr(y,'coeff');  
stem(lags,r)  ;

chan = rayleighchan(1/15000,500);  
x = ones(1,4000);  
y = filter(chan,x);  
fs = 15000;  
Y = fft(y,4096);  
Y = fftshift(abs(Y));  
figure(2);
plot([-2048:2047]*fs/4096,Y.*Y)  
axis([-1000 1000 min(Y.*Y) max(Y.*Y)])  





