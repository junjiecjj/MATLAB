% �﷨
% Y = fftshift(X)
% Y = fftshift(X,dim)
% ˵��
% ʾ��
% Y = fftshift(X) ͨ������Ƶ�����ƶ����������ģ��������и���Ҷ�任 X��
% 
% ��� X ���������� fftshift �Ὣ X ���������벿�ֽ��н�����
% 
% ��� X �Ǿ����� fftshift �Ὣ X �ĵ�һ������������޽��������ڶ�������������޽�����
% 
% ��� X �Ƕ�ά���飬�� fftshift ����ÿ��ά�Ƚ��� X �İ�ռ䡣
% https://ww2.mathworks.cn/help/matlab/ref/fftshift.html
clc
clear all
close all

% ʾ��
% Y = fftshift(X,dim) �� X ��ά�� dim ִ�����㡣���磬��� X �Ǿ������б�ʾ���һά�任���� fftshift(X,2) �Ὣ X ��ÿһ�е��������벿�ֽ��н�����


Xeven = [1 2 3 4 5 6];
fftshift(Xeven)
% ans = 1��6
% 
%      4     5     6     1     2     3

Xodd = [1 2 3 4 5 6 7];
fftshift(Xodd)
% ans = 1��7
% 
%      5     6     7     1     2     3     4

% ƽ��һά�ź�
% �����źŵ�Ƶ�ʷ���ʱ������Ƶ����ƽ�Ƶ����Ļ���а�����
% �����ź� S�������丵��Ҷ�任��Ȼ����ƹ��ʡ�

fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S = cos(2*pi*15*t);
n = length(S);  % 1000
X = fft(S);
f = (0:n-1)*(fs/n);     %frequency range
power = abs(X).^2/n;    %power
figure(1);
plot(f,power);


Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
figure(2);
plot(fshift,powershift)
%% ==============================================================
fs = 100;               % sampling frequency
t = 0:(1/fs):(10-1/fs); % time vector
S1 = cos(2*pi*15*t);
S2 = cos(2*pi*30*t);
n = length(S1);
A = [S1; S2];
X = fft(A,[],2);
f = (0:n-1)*(fs/n);     % frequency range
power = abs(X).^2/n;    % power
figure(3);
plot(f,power(1,:),f,power(2,:))


Y = fftshift(X,2);
fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
powershift = abs(Y).^2/n;     % zero-centered power
figure(4);
plot(fshift,powershift(1,:),fshift,powershift(2,:))






