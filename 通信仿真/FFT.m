clear;clc;close all
%  https://www.guyuehome.com/35495

%%==================================================
% 半谱图
%==================================================
%% 定义时域采样信号 x
Fs=100;             % 信号采样频率
Ts=1/Fs;            % 采样时间间隔
N=200;             % 采样信号的长度
t=(0:1:N-1)*Ts;     % 定义信号采样的时间点 t
t=t';               % 为了方便查看, 将行向量 t 转置成列向量

f1=16;              % 第一个余弦信号的频率
f2=45;              % 第二个余弦信号的频率
x=4.5+2.7*cos(2*pi*f1*t+pi/4)+8.2*cos(2*pi*f2*t-pi/6);  % 定义时域采样信号 x

%% 对时域采样信号, 执行快速傅里叶变换 FFT
X=fft(x);           % 执行 FFT 计算, 结果保存在 X 里


%% 消除相位混乱
X(abs(X)<1e-8)=0;   % 将频域序列 X 中, 幅值小于 1e-8 的数值置零

%% 修正频域序列的幅值, 使得 FFT 变换的结果有明确的物理意义
X=X/N;              % 将频域序列 X 除以序列的长度 N

%% 提取 X 里正频率的部分, 并且将 X 里负频率的部分合并到正频率  
Y=X(1:N/2+1);              % 提取 X 里正频率的部分
Y(2:end-1)=2*Y(2:end-1);   % 将 X 里负频率的部分合并到正频率

%% 计算频域序列 Y 的幅值和相角
A=abs(Y);           % 计算频域序列 Y 的幅值
Pha=angle(Y);       % 计算频域序列 Y 的相角 (弧度制)
R = real(Y);	% 计算频域序列 Y 的实部
I = imag(Y);	% 计算频域序列 Y 的虚部

%% 定义序列 Y 对应的频率刻度
df=Fs/N;            % 频率间隔
f=(0:1:N/2)*df;     % 频率刻度
f=f';               % 为了方便查看, 将行向量 f 转置成列向量

%% 绘制时域采样信号 x 的波形
figure
plot(t,x)
xlabel('时间 [s]')
ylabel('信号值 x(t)')

%% 绘制频域序列 Y 的幅频图 & 相频图
figure
subplot(2,1,1)
plot(f,A)         % 绘制频域序列 Y 的幅频图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的幅值')

subplot(2,1,2)
plot(f,Pha)       % 绘制频域序列 Y 的相频图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的相角')


%% 绘制频域序列 Y 的实部图 & 虚部图
figure
subplot(2,1,1)
plot(f,R)         % 绘制频域序列 Y 的实部图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的实部')

subplot(2,1,2)
plot(f,I)       % 绘制频域序列 Y 的虚部图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的虚部')

%%==================================================
% 全谱图
%%==================================================

%% 定义时域采样信号 x
Fs=100;             % 信号采样频率
Ts=1/Fs;            % 采样时间间隔
N=200;             % 采样信号的长度
t=(0:1:N-1)*Ts;     % 定义信号采样的时间点 t
t=t';               % 为了方便查看, 将行向量 t 转置成列向量

f1=16;              % 第一个余弦信号的频率
f2=45;              % 第二个余弦信号的频率
x=4.5+2.7*cos(2*pi*f1*t+pi/4)+8.2*cos(2*pi*f2*t-pi/6);  % 定义时域采样信号 x

%% 对时域采样信号, 执行快速傅里叶变换 FFT
X=fft(x);           % 执行 FFT 计算, 结果保存在 X 里


%% 消除相位混乱
X(abs(X)<1e-8)=0;   % 将频域序列 X 中, 幅值小于 1e-8 的数值置零

%% 修正频域序列的幅值, 使得 FFT 变换的结果有明确的物理意义
X=X/N;              % 将频域序列 X 除以序列的长度 N


%% 将 X 重新排列, 把负频率部分搬移到序列的左边, 把正频率部分搬移到序列的右边
Y=fftshift(X);      % 新的频域序列 Y

%% 计算频域序列 Y 的幅值和相角
A=abs(Y);           % 计算频域序列 Y 的幅值
Pha=angle(Y);       % 计算频域序列 Y 的相角 (弧度制)
R = real(Y);	% 计算频域序列 Y 的实部
I = imag(Y);	% 计算频域序列 Y 的虚部

%% 定义序列 Y 对应的频率刻度
df=Fs/N;            % 频率间隔
f=(-N/2:1:N/2-1)*df;     % 频率刻度
f=f';               % 为了方便查看, 将行向量 f 转置成列向量

%% 绘制时域采样信号 x 的波形
figure
plot(t,x)
xlabel('时间 [s]')
ylabel('信号值 x(t)')

%% 绘制频域序列 Y 的幅频图 & 相频图
figure
subplot(2,1,1)
plot(f,A)         % 绘制频域序列 Y 的幅频图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的幅值')

subplot(2,1,2)
plot(f,Pha)       % 绘制频域序列 Y 的相频图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的相角')


%% 绘制频域序列 Y 的实部图 & 虚部图
figure
subplot(2,1,1)
plot(f,R)         % 绘制频域序列 Y 的实部图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的实部')

subplot(2,1,2)
plot(f,I)       % 绘制频域序列 Y 的虚部图
grid on
xlabel('频率 [Hz]')
ylabel('Y 的虚部')


%%================================
%我们可以通过 ifft 函数将频域信号 X 反变换回原本的空域信号
%%================================

IX = ifft(X);
%% 绘制频域信号 x 的反傅里叶变换波形
figure
plot(t,IX)
xlabel('时间 [s]')
ylabel('信号值 x(t)')