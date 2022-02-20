clc;
close all;
clear;

%% https://www.cxybb.com/article/weixin_37315722/116739459
% https://blog.csdn.net/jack_liu90s/article/details/91038445?spm=1001.2101.3001.6650.3&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-3.pc_relevant_paycolumn_v3&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-3.pc_relevant_paycolumn_v3&utm_relevant_index=5


clear all;
close all;
clc;

%格式一：awgn(xin，snr);
%此种调用方式假设输入信号xin的功率为0dBW（0dBW=10log10(1W)),按照snr(dB)的信噪比添加噪声。
%matlab仿真代码如下：
t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr);
figure(1);
subplot(2,1,1);plot(t,x);title('正弦信号x')
subplot(2,1,2);plot(t,y);title('叠加了高斯白噪声后的正弦信号');

z=y-x;
var(z)


% 格式二：awgn(xin,snr,sigpower)
% 这种调用方式是假设输入信号的功率为sigpower(单位为dBW),按照此信号功率和信噪比添加白噪声，运行如下代码：
t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr,10);
figure(2);
subplot(2,1,1);plot(t,x);title('正弦信号x')
subplot(2,1,2);plot(t,y);title('叠加了高斯白噪声后的正弦信号')

z=y-x;
var(z)

% 格式三：awgn(xin,snr,‘measured’)
% 这种格式是根据输入信号的实际功率和信噪比来计算所加噪声的功率的，仿真代码：
t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr,'measured');
figure(3);
subplot(2,1,1);plot(t,x);title('正弦信号x')
subplot(2,1,2);plot(t,y);title('叠加了高斯白噪声后的正弦信号')

z=y-x;
var(z)

%除了采用awgn函数，我们也可以采用randn函数来产生加性高斯白噪声。
%这里只给出其中一种调用格式：randn(n)
%它返回一个n行n列的随机矩阵，其中每一行每一列都服从均值为0，方差为1的标准正态分布。
%下面给出一个调用randn函数来实现信号加噪的仿真代码：
t=0:0.001:10;
x=sin(2*pi*t);
px=norm(x).^2/length(x);      %计算信号x的功率
snr=20;                       %信噪比，dB形式
pn=px./(10.^(snr./10));       %根据snr计算噪声功率
n=sqrt(pn)*randn(1,length(x));%根据噪声功率产生相应的高斯白噪声序列
y=x+n;                  %在信号上叠加高斯白噪声
figure(4);
subplot(2,1,1);plot(t,x);title('正弦信号x')
subplot(2,1,2);plot(t,y);title('叠加了高斯白噪声后的正弦信号')

var(n)


% 章节3只是简单的介绍了如何对一个输入信号添加高斯白噪声，接下来，我们以一个简化的通信系统为例，
% 仿真正交相移键控（QPSK）调制的基带数字通信系统通过AWGN信道的误符号率（SER）和误比特率（BER），
% 假设发射端信息比特采用Gray编码影射，基带脉冲采用矩形脉冲，仿真时每个脉冲的采样点数为8，接收端采用匹配滤波器进行相干解调。
% matlab仿真代码如下：
nSamp = 8;%矩形脉冲的采样点数
numSymb = 200000;%每种SNR下传输的符号数
M =4;%QPSK的符号类型数
SNR = -3:1:3;%SNR的范围
grayencod = [0 1 3 2];%Gray编码格式
BER = zeros(1,length(SNR));
SER = zeros(1,length(SNR));
msg_demod  =  zeros(1,numSymb);
for ii=1:length(SNR)
    msg = randsrc(1,numSymb,[0:3]); % 原始信息比特,产生发送符号，1行numSymb列0-3的数。
    msg_gr = grayencod(msg+1);  %进行Gray编码影射（格雷码）
    msg_tx = pskmod(msg_gr,M);%QPSK调制
    msg_tx = rectpulse(msg_tx,nSamp);%矩形脉冲成型
    msg_rx = awgn(msg_tx,SNR(ii),'measured');%通过AWGN信道
    msg_rx_down = intdump(msg_rx,nSamp);%匹配滤波相干解调
    msg_gr_demod = pskdemod(msg_rx_down,M); % 解调出来的信息比特,QPSK解调
    %格雷码逆映射
    for jj=1:length(msg_gr_demod)
        if(msg_gr_demod(jj)==0)
            msg_demod(jj) = 0;
        elseif(msg_gr_demod(jj)==1)
            msg_demod(jj) = 1;
        elseif(msg_gr_demod(jj)==3)
            msg_demod(jj) = 2;
        else
            msg_demod(jj) = 3;
        end
    end
    [errorBit, BER(ii)] = biterr(msg,msg_demod,log2(M));%计算BER
    [errorSym, SER(ii)] = symerr(msg,msg_demod);%计算SER
end

scatterplot(msg_tx(1:100));%画出发射信号星座图
title('发射信号星座图点');
xlabel('同相分量');
ylabel('正交分量');

scatterplot(msg_rx(1:100));%画出接收信号星座图
title('接收信号星座图点');
xlabel('同相分量');
ylabel('正交分量');

figure
semilogy(SNR,BER,'-bo',SNR,SER,'-r*');%画出BER和SER随SNR变化的曲线
legend('BER','SER');
title('QPSK在AWGN信息下的性能');
xlabel('信噪比（dB）');
ylabel('误符号率和误比特率');
