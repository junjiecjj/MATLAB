
clc;
close all;
clear;


%%  https://www.cnblogs.com/xh0102/p/6382736.html
chan = rayleighchan (1/15000,500);%1/15000 代表我们的采样频率，也就是我一个点代表的是多长一段时间单位。500 就是最大多普勒频移...  
% 其实我们可以想这个函数怎么能工作呢？其实我们我们给定了 500 的多普勒，它就会按一定的相关时间计算出具体的相关时间，然后它又知道你的采样频率，它就知道在多少个采样点它应该是相关的了，就这么简单！  
x = ones (1,140);% 源数据  
y = filter (chan,x);% 经过信道后的输出 
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





