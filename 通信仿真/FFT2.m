clear;clc;close all
%  https://ww2.mathworks.cn/help/matlab/ref/fft.html

% fft
% ���ٸ���Ҷ�任ȫҳ�۵�
% �﷨
% Y = fft(X)
% Y = fft(X,n)
% Y = fft(X,n,dim)
% ˵��
% ʾ��
% Y = fft(X) �ÿ��ٸ���Ҷ�任 (FFT) �㷨���� X ����ɢ����Ҷ�任 (DFT)��
% 
% ��� X ���������� fft(X) ���ظ������ĸ���Ҷ�任��
% 
% ��� X �Ǿ����� fft(X) �� X �ĸ�����Ϊ������������ÿ�еĸ���Ҷ�任��
% 
% ��� X ��һ����ά���飬�� fft(X) ���ش�С������ 1 �ĵ�һ������ά�ȵ�ֵ��Ϊ������������ÿ�������ĸ���Ҷ�任��
% 
% ʾ��
% Y = fft(X,n) ���� n �� DFT�����δָ���κ�ֵ���� Y �Ĵ�С�� X ��ͬ��
% 
% ��� X �������� X �ĳ���С�� n����Ϊ X ����β���Դﵽ���� n��
% 
% ��� X �������� X �ĳ��ȴ��� n����� X ���нض��Դﵽ���� n��
% 
% ��� X �Ǿ�����ÿ�еĴ������������������ͬ��
% 
% ��� X Ϊ��ά���飬���С������ 1 �ĵ�һ������ά�ȵĴ������������������ͬ��
% 
% ʾ��
% Y = fft(X,n,dim) ������ά�� dim �ĸ���Ҷ�任�����磬��� X �Ǿ����� fft(X,n,2) ����ÿ�е� n �㸵��Ҷ�任��

%% ʹ�ø���Ҷ�任�����������ص��źŵ�Ƶ�ʷ�����

%ָ���źŵĲ���������Ƶ��Ϊ 1 kHz���źų���ʱ��Ϊ 1.5 �롣

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
%����һ���źţ����а�����ֵΪ 0.7 �� 50 Hz �������ͷ�ֵΪ 1 �� 120 Hz ��������

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
%�þ�ֵΪ�㡢����Ϊ 4 �İ��������Ҹ��źš�

X = S + 2*randn(size(t));
%��ʱ���л��ƺ����źš�ͨ���鿴�ź� X(t) ����ȷ��Ƶ�ʷ�����
figure(1);
plot(1000*t,X)
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

%�����źŵĸ���Ҷ�任��

Y = fft(X);

%����˫��Ƶ�� P2��Ȼ����� P2 ��ż���źų��� L ���㵥��Ƶ�� P1��
f = Fs*(0:(L/2))/L;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
figure(2);
plot(f,P1) 

P1(2:end-1) = 2*P1(2:end-1);
%����Ƶ�� f �����Ƶ����ֵƵ�� P1����Ԥ�������������������������ֵ������ȷ���� 0.7 �� 1��һ������£��ϳ����źŻ�������õ�Ƶ�ʽ���ֵ��


figure(3);
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%���ڣ�����ԭʼ�ġ�δ�ƻ��źŵĸ���Ҷ�任��������ȷ��ֵ 0.7 �� 1.0��

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
figure(4);
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


%����˹�����ʱ��ת��ΪƵ��

%�����źŲ����͸�˹���� X��

Fs = 100;           % Sampling frequency
t = -0.5:1/Fs:0.5;  % Time vector 
L = length(t);      % Signal length

X = 1/(4*sqrt(2*pi*0.01))*(exp(-t.^2/(2*0.01)));
%��ʱ���л������塣
figure(5);
plot(t,X)
title('Gaussian Pulse in Time Domain')
xlabel('Time (t)')
ylabel('X(t)')

%Ҫʹ�� fft ���ź�ת��ΪƵ�����ȴ�ԭʼ�źų���ȷ������һ�� 2 ���ݵ������볤�ȡ��⽫��β��������ź� X �Ը��� fft �����ܡ�

n = 2^nextpow2(L);
%����˹����ת��ΪƵ��

Y = fft(X,n);
%����Ƶ�򲢻���ΨһƵ�ʡ�

f = Fs*(0:(n/2))/n;
P = abs(Y/n).^2;
figure(6);
plot(f,P(1:n/2+1)) 
title('Gaussian Pulse in Frequency Domain')
xlabel('Frequency (f)')
ylabel('|P(f)|^2')

%�Ƚ�ʱ���Ƶ���е����Ҳ���

%ָ���źŵĲ���������Ƶ��Ϊ 1kHz���źų���ʱ��Ϊ 1 �롣

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sampling period
L = 1000;                     % Length of signal
t = (0:L-1)*T;                % Time vector
%����һ����������ÿһ�д���һ��Ƶ�ʾ������ŵ����Ҳ������ X Ϊ 3��1000 ���󡣵�һ�еĲ�ƵΪ 50���ڶ��еĲ�ƵΪ 150�������еĲ�ƵΪ 300��

x1 = cos(2*pi*50*t);          % First row wave
x2 = cos(2*pi*150*t);         % Second row wave
x3 = cos(2*pi*300*t);         % Third row wave

X = [x1; x2; x3];
%�ڵ���ͼ���а�˳����� X ��ÿ�е�ǰ 100 ������Ƚ���Ƶ�ʡ�
figure(7);
for i = 1:3
    subplot(3,1,i)
    plot(t(1:100),X(i,1:100))
    title(['Row ',num2str(i),' in the Time Domain'])
end

%�����㷨���ܵĿ��ǣ�fft ��������β����������롣����������£�������� X ��ÿһ�У���ʹÿ�еĳ���Ϊ�ȵ�ǰ���ȴ����һ����С�� 2 �Ĵ���ֵ��ʹ�� nextpow2 ���������³��ȡ�

n = 2^nextpow2(L);
%ָ�� dim ������ X ���У�����ÿ���źţ�ʹ�� fft��

dim = 2;
%�����źŵĸ���Ҷ�任��

Y = fft(X,n,dim);
%����ÿ���źŵ�˫��Ƶ�׺͵���Ƶ�ס�

P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
%��Ƶ���ڣ�Ϊ����ͼ���е�ÿһ�л��Ƶ����ֵƵ�ס�
figure(8);
for i=1:3
    subplot(3,1,i)
    plot(0:(Fs/n):(Fs/2-Fs/n),P1(i,1:n/2))
    title(['Row ',num2str(i),' in the Frequency Domain'])
end