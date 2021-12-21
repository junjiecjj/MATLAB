%   https://ww2.mathworks.cn/help/matlab/math/fourier-transforms.html
clear;clc;close all


%MATLAB? �е� fft ����ʹ�ÿ��ٸ���Ҷ�任�㷨���������ݵĸ���Ҷ�任���������ź� x Ϊ�������ź���ʱ�� t �ĺ�����Ƶ�ʷ���Ϊ 15 Hz �� 20 Hz��ʹ���� 10 ���������� 
%1/50��Ϊ�������в�����ʱ��������

Ts = 1/50;
t = 0:Ts:10-Ts;
x = sin(2*pi*15*t) + sin(2*pi*20*t);
figure(1);
plot(t,x)
xlabel('Time (seconds)')
ylabel('Amplitude')

%�����źŵĸ���Ҷ�任������Ƶ�ʿռ䴴����Ӧ���źŲ��������� f��
y = fft(x);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
%��Ƶ�ʺ�����ʽ�����źŷ�ֵʱ����ֵ����Ӧ���źŵ� 15 Hz �� 20 Hz Ƶ�ʷ�����
figure(2);
plot(f,abs(y));
%plot(f,abs(y/length(y)))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')

%�ñ任�������ɼ��ľ��񸱱����ø�����Ӧ���źŵĸ�Ƶ�ʡ�Ϊ�˸��õ��Կ��ӻ���ʽ���������ԣ�������ʹ�� fftshift �����Ա任ִ������Ϊ���ĵ�ѭ��ƽ�ơ�

n = length(x);                         
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);
figure(3);
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%�����ź�
%�ڿ�ѧӦ���У��źž����⵽��������ƻ����ڸ���Ƶ�ʷ���������Ҷ�任��������������������Ƶ�ʡ����磬ͨ����ԭʼ�ź� x ��ע���˹����������һ�����ź� xnoise��

rng('default')
xnoise = x + 2.5*randn(size(t));
%Ƶ�ʺ�����ʽ���źŹ������źŴ����е�һ�ֳ��ö������������źŵĸ���Ҷ�任��Ƶ�����������й�һ�����ƽ����ֵ�����㲢��������Ƶ��Ϊ���ĵĺ����źŵĹ����ס����ܴ������������Կ��Ը��ݹ����еļ���ʶ���źŵ�Ƶ�ʡ�

ynoise = fft(xnoise);
ynoiseshift = fftshift(ynoise);    
power = abs(ynoiseshift).^2/n; 
figure(4);
plot(fshift,power)
title('Power')
xlabel('Frequency (Hz)')
ylabel('Power')

% %����Ч��
% %ֱ��ʹ�ø���Ҷ�任��ʽ�ֱ���� y �� n ��Ԫ����Ҫ n^2
% % �������ĸ������㡣ʹ�ÿ��ٸ���Ҷ�任�㷨����ֻ��Ҫ nlogn �����������㡣�ڴ�������ɰ���ǧ������ݵ������ʱ����һ����Ч�ʻ�����ܴ�����ơ��� n Ϊ 2 ����ʱ�����ר�ŵĿ��ٸ���Ҷ�任ʵ�ֿɽ�һ�����Ч�ʡ�
% %�Լ��������Ǻ�����ˮ����˷����ռ�����Ƶ����Ϊ�����ڿ��ζ���ѧ������ѧ�о���Ŀά���Ŀ��п����ҵ���Щ���ݡ��������̫ƽ�������������ļ� bluewhale.au����������һ�������ݽ��и�ʽ�������������Ľ����ǵ�Ƶ���������༸���������������е�ʱ����ѹ���� 10 �����Ա����������ʹ�������������š���ʹ������ sound(x,fs) ��������������Ƶ�ļ���
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
% %ָ���µ��źų��ȣ��ó����Ǵ���ԭʼ���ȵ����ڽ��� 2 ���ݡ�Ȼ��ʹ�� fft ���µ��źų��ȼ��㸵��Ҷ�任��fft ���Զ�����������ݣ�������������С�������������Դ����߱任������ٶȣ����ھ��нϴ���������������С������ˡ�
% 
% m = length(whaleMoan); 
% n = pow2(nextpow2(m));
% y = fft(whaleMoan,n);        
% %�����źŵĹ����ס���ͼָʾ������������Լ 17 Hz �Ļ���Ƶ�ʺ�һϵ��г��������ǿ���˵ڶ���г������
% 
% f = (0:n-1)*(fs/n)/10; % frequency vector
% power = abs(y).^2/n;   % power spectrum      
% figure(6);
% plot(f(1:floor(n/2)),power(1:floor(n/2)))
% xlabel('Frequency (Hz)')
% ylabel('Power')