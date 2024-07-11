clear all;
clc;

% 设计一个16阶升余弦滤波器，载波频率Fc = 1KHz，滚降系数0.25，采样率为8KHz。　
N = 16; 
Fc = 1000; 
R = 0.25; 
Fs = 8000; 
h = firrcos(N, Fc, R, Fs, 'rolloff', 'normal');
figure(1);
plot(h)