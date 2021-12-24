%https://www.cxyzjd.com/article/wangh0802/79077901
clear ; clc; close all;

%% ���� Matlab ����һ������Ϊ 1���� t = 2T Ϊ�Գ����ĵľ��������ź� y (t)
% ���������ź��� Matlab ���� rectpuls ������ʾ������÷�ʽΪ��
% y = rectpulse(t, width)
% ���Բ���һ������Ϊ 1�����Ϊ width �� t = 0 Ϊ�Գ����ĵľ������岨��Width ��Ĭ��ֵΪ 1��
t = 0:0.001:4;
T = 1;
yt = rectpuls(t-2*T, 2*T);
figure(1);
plot(t, yt)
axis([0, 4, 0, 1.2]);

%% ʹ�� Matlab �����ź� (y (t) = frac {sin [pi (t-2)]}{pi (t-2)}) �Ĳ��� 
%�ź� y (t) = sinc (t-2)������ʹ�� sinc ������ʾ
t = -4:0.001:8
t1 = t-2;
y = sinc(t1);
figure(2);
plot(t, y);
xlabel('t');
ylabel('y(t)');
axis([-4, 8, -0.4, 1.0]),grid on;

%% �� matlab �У��ṩ��һЩ���������źŵ� matlab ��������� 3.1 ��ʾ���ֱ����ڲ������ǲ���������sinc �������źŵĲ��Ρ�
% �� 3.1 �����źŵ� matlab ��������
% sawtooth	������ݲ������ǲ�	pulstran	���������
% square	��������	rectpuls	���������ڷ���
% sinc	���� sinc ��������	tripuls	�������������ǲ�
% chirp	������Ƶ�����ź�	diric	���� Dirichlet ������ sinc
% gauspuls	������˹���������ź�	gmonopuls	������˹�������ź�


%% �������һ��������Ϊ 1�����Ϊ 4 �����ǲ����� y (t)������ֵ�ķ���ֵΪ (-2, 2)�������� y (2 - 2t) �Ĳ��Ρ�
% ���ǲ��źŵĲ�������ͨ������ tripuls ʵ�֡�


t = -3:0.001:3;
width = 4;
skew = 0.5;
 
y = tripuls(t, width, skew);
figure(3);
subplot(2,1,1), plot(t, y)
 
xlabel('t'),ylabel('y(t)')
grid
y1 = tripuls(2-2*t, width, skew);
subplot(212),plot(t, y1)
xlabel('t'),ylabel('y(2-2t)')
grid



%% ���������������еľ��
% (x(k) = delta(k) + 2delta(k-1) + 2delta(k-2) + delta(k-3) + delta(k-4))
% (h(k) = 3delta(k) + 2delta(k-1) + delta(k-2))

x = [1 2 2 1 1];
h = [3 2 1];
y = conv(x, h);
figure(4);
subplot(311),stem(0:4, x, 'filled'),axis([-1 7 0 15]),ylabel('x(k)')
subplot(312),stem(0:2, h, 'filled'),axis([-1 7 0 15]),ylabel('h(k)')
subplot(313),stem(0:6, y, 'filled'),axis([-1 7 0 15]),ylabel('y(k) = x(k)*h(k)')

%%  pulstran
% MATLAB �����������У�pulstran ����ʹ�ü�ǣ�
% 
% pulstran �������������������У�����Ҫ�����﷨���£�
% 
% 1.pulstran��t,d,��func��,p1,p2,???��������һ�������������� func �������������С�
% ���� t Ϊʱ���ᣬһ����һ��һά���顣d Ϊ������������������У���һ�ж�Ӧƫ�������ڶ��ж�Ӧ��������
% pulstran �� func ���� length��d���εļ��㣬�������εĽ����ͣ�y=func (t=d (1))+func (t=d (2))+???��
% ���� func ���������� 3 ��ȡֵ��gauspuls������һ����˹���ƣ�Gaussian-modulated�����������壻
% reectpuls������һ�����������ھ��β���
% tripuls������һ���������������ǲ���p1��p2��???�Ǹ��Ӳ�����
% 
% 2.pulstran��t,d,p,fs��������һ������ p ����Ķ�����ʱ��ֵ֮�ͣ�������Ϊ fs��
% 
% 3.pulstran��t,d,p�����������Ƶ�� fd ���� 1Hz��

% pulstran �������������Ļ������ԭ�����������������С���ʾ�������ɸ�˹����Ķ���ӳٲ�ֵ֮����ɵ��������С�
% ���������ж���Ϊ���� 50 kHz �Ĳ����ʡ�10 ms ���������г��Ⱥ� 1 kHz �������ظ��ʡ�
% T ָ���������еĲ���ʱ�̡�D �ڵ�һ����ָ��ÿ�������ظ����ӳ٣��ڵڶ�����ָ��ÿ���ظ��Ŀ�ѡ˥����
% Ҫ������������У��뽫 gauspuls �����������Լ����Ӳ���������ָ������Ϊ 50% �� 10 kHz ��˹���壩���ݸ� pulstran��
T = 0:1/50e3:10e-3;
D = [0:1/1e3:10e-3;0.8.^(0:10)]';
% https://ww2.mathworks.cn/help/signal/gs/the-pulstran-function.html
Y = pulstran(T,D,'gauspuls',10e3,0.5);
figure(5);
subplot(2,1,1);
plot(T,Y);
xlabel 'Time (s)', 
ylabel 'Periodic Gaussian pulse';

% https://blog.csdn.net/wwjra/article/details/7728892
t=0:0.001:8;
d=[0:1:8;0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8]';
y=pulstran(t-0.25,d,'gauspuls',10,0.5);
subplot(2,1,2);
plot(t,y);
grid;
