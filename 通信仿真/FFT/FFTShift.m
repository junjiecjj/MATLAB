
clear;
clc;
close all

% https://ww2.mathworks.cn/help/matlab/ref/fftshift.html

% 语法
% Y = fftshift(X)
% Y = fftshift(X,dim)
% 说明
% 示例
% Y = fftshift(X) 通过将零频分量移动到数组中心，重新排列傅里叶变换 X。
% 
% 如果 X 是向量，则 fftshift 会将 X 的左右两半部分进行交换。
% 
% 如果 X 是矩阵，则 fftshift 会将 X 的第一象限与第三象限交换，将第二象限与第四象限交换。
% 
% 如果 X 是多维数组，则 fftshift 会沿每个维度交换 X 的半空间。
% https://ww2.mathworks.cn/help/matlab/ref/fftshift.html


%==================================================================
% 平移向量元素
%==================================================================
Xeven = [1 2 3 4 5 6];
fftshift(Xeven)

Xodd = [1 2 3 4 5 6 7];
fftshift(Xodd)



%==================================================================
% 平移一维信号
%==================================================================
fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S = cos(2*pi*15*t);
n = length(S);
X = fft(S);
f = (0:n-1)*(fs/n);     %frequency range
power = abs(X).^2/n;    %power
plot(f,power)

%平移零频分量，然后绘制以零为中心的功率。
Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
plot(fshift,powershift)


%==================================================================
% 平移矩阵中的信号
%==================================================================


%要处理多个一维信号，可将它们表示为一个矩阵的各行。然后使用维度参数计算傅里叶变换，并平移每一行的零频分量。
%创建矩阵 A，其行表示两个一维信号，然后计算每个信号的傅里叶变换。绘制每个信号的功率。

fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S1 = cos(2*pi*15*t);
S2 = cos(2*pi*30*t);
n = length(S1);
A = [S1; S2];
X = fft(A,[],2);
f = (0:n-1)*(fs/n);     % frequency range
power = abs(X).^2/n;    % power
plot(f,power(1,:),f,power(2,:))


%平移零频分量，然后绘制每个信号以零为中心的功率。
Y = fftshift(X,2);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
plot(fshift,powershift(1,:),fshift,powershift(2,:))

