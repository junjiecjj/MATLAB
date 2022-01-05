%https://www.cxyzjd.com/article/wangh0802/79077901
clear ; clc; close all;

%% ���� Matlab ����һ������Ϊ 1���� t = 2T Ϊ�Գ����ĵľ��������ź� y (t)
% ���������ź��� Matlab ���� rectpuls ������ʾ������÷�ʽΪ��
% y = rectpulse(t, width)
% ���Բ���һ������Ϊ 1�����Ϊ width �� t = 0 Ϊ�Գ����ĵľ������岨��Width ��Ĭ��ֵΪ 1��
t1 = 0:0.001:4;
T1 = 1;
yt1 = rectpuls(t1-2*T1, 2*T1);
figure(1);
plot(t1, yt1)
axis([0, 4, 0, 1.2]);

%% ʹ�� Matlab �����ź� (y (t) = frac {sin [pi (t-2)]}{pi (t-2)}) �Ĳ��� 
%�ź� y (t) = sinc (t-2)������ʹ�� sinc ������ʾ
t2 = -4:0.001:8
t2_1 = t2-2;
y2 = sinc(t2_1);
figure(2);
plot(t2, y2);
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


t3 = -3:0.001:3;
width = 4;
skew = 0.5;
 
y3 = tripuls(t3, width, skew);
figure(3);
subplot(2,1,1), plot(t3, y3)
 
xlabel('t'),ylabel('y(t)')
grid
y3_1 = tripuls(2-2*t3, width, skew);
subplot(212),plot(t3, y3_1)
xlabel('t'),ylabel('y(2-2t)')
grid



%% ���������������еľ��
% (x(k) = delta(k) + 2delta(k-1) + 2delta(k-2) + delta(k-3) + delta(k-4))
% (h(k) = 3delta(k) + 2delta(k-1) + delta(k-2))

x4 = [1 2 2 1 1];
h4 = [3 2 1];
y4 = conv(x4, h4);
figure(4);
subplot(311),stem(0:4, x4, 'filled'),axis([-1 7 0 15]),ylabel('x(k)')
subplot(312),stem(0:2, h4, 'filled'),axis([-1 7 0 15]),ylabel('h(k)')
subplot(313),stem(0:6, y4, 'filled'),axis([-1 7 0 15]),ylabel('y(k) = x(k)*h(k)')

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
T1 = 0:1/50e3:10e-3;
D1 = [0:1/1e3:10e-3;0.8.^(0:10)]';
% https://ww2.mathworks.cn/help/signal/gs/the-pulstran-function.html
Y1 = pulstran(T1,D1,'gauspuls',10e3,0.5);
figure(5);
subplot(2,1,1);
plot(T1,Y1);
xlabel 'Time (s)',
ylabel 'Periodic Gaussian pulse';

% https://blog.csdn.net/wwjra/article/details/7728892
t5=0:0.001:8;
d5=[0:1:8;0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8]';
y5=pulstran(t5-0.25,d5,'gauspuls',10,0.5);
subplot(2,1,2);
plot(t5,y5);
grid;



% pulstran������func=triplus
% ���ɲ��Գ����ǲ����ظ�Ƶ��3Hz,���ǿ��0.1s,�źų���1s,����Ƶ��1KHz.
figure(6);
t6 = 0:1e-3:1;  %���ò���Ƶ��Ϊ1KHz
d6 = 0:1/3:1;   %�����ź��ظ�Ƶ��Ϊ3Hz��������Ϊ1/3
subplot(2,1,1);
y6 = pulstran(t6,d6,'tripuls',0.1, 1);
plot(t6,y6);
subplot(2,1,2);
y6_1 = pulstran(t6,d6,'tripuls',0.1, 0);
plot(t6,y6_1);  %���ǲ���p6:��Ч���ֿ�ȣ�p6_1:�ź���󲿷�ƫ��(0Ϊ�ԳƵ�)

