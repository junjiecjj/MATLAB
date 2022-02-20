
% https://zhuanlan.zhihu.com/p/46668425


clc;
close all;
clear;


t=0:0.001:10;
x=sin(2*pi*t);
snr=20;%噪声功率为20dBW
y0=awgn(x,snr);%将高斯白噪声叠加到信号上
y1=awgn(x,snr,10);%y1=awgn(x,snr,sigpower)假设了输入信号功率为sigpower单位dBW
y2=awgn(x,snr,'measured');%首先计算输入信号的功率，然后按照snr添加相应的高斯白噪声
figure(1);
subplot(411);plot(t,x);title('正弦信号x');
subplot(412);plot(t,y0);title('叠加了高斯白噪声后的正弦信号0');%若未说明输入信号功率，则假设为0dBW
subplot(413);plot(t,y1);title('叠加了高斯白噪声后的正弦信号1');%因为输入信号实际功率（输入函数是0.5）小于10dBW，图是根据给出的输入信号功率画的
subplot(414);plot(t,y2);title('叠加了高斯白噪声后的正弦信号2');%（添加的噪声功率根据实际给出输入信号的信号功率计算得出）

z0=y0-x;
var(z0);%均方差


%% *仿真正交相移键控（QPSK）调制的基带数字通信系统通过AWGN信道的误符号率（SER）和误比特率（BER），假设发射端信息比特采用Gray编码影射，基带脉冲采用矩形脉冲，仿真时每个脉冲的采样点数为8，接收端采用匹配滤波器进行相干解调。

% 代码如下：
%
%                    .::::.
%                  .::::::::.
%                 :::::::::::  
%             ..:::::::::::'
%           '::::::::::::'
%             .::::::::::
%        '::::::::::::::..
%             ..::::::::::::.
%           ``::::::::::::::::
%            ::::``:::::::::'        .:::.
%           ::::'   ':::::'       .::::::::.
%         .::::'      ::::     .:::::::'::::.
%        .:::'       :::::  .:::::::::' ':::::.
%       .::'        :::::.:::::::::'      ':::::.
%      .::'         ::::::::::::::'         ``::::.
%  ...:::           ::::::::::::'              ``::.
% ```` ':.          ':::::::::'                  ::::..
%                    '.:::::'                    ':'````..
%
clear all
nSamp=8;%矩形脉冲的采样点数
numSymb=200000;%每种SNR下传输的符号数
M=4;%QPSK的符号类型数
SNR=-3:3;%SNR的范围
grayencod=[0 1 3 2 ];%Gray编码格式
for ii=1:length(SNR)
    msg=randsrc(1,numSymb,[0:3]);%产生发送符号，1行numSymb列0-3的数。
    msg_gr=grayencod(msg+1);%进行Gray编码影射（格雷码）
    msg_tx=pskmod(msg_gr,M);%QPSK调制
    msg_tx=rectpulse(msg_tx,nSamp);%矩形脉冲成型
    msg_rx=awgn(msg_tx,SNR(ii),'measured');%通过AWGN信道
    msg_rx_down=intdump(msg_rx,nSamp);%匹配滤波相干解调
    msg_gr_demod=pskdemod(msg_rx_down,M);%QPSK解调
    [dummy graydecod]=sort(grayencod);graydecod=graydecod-1;
    msg_demod=graydecod(msg_gr_demod+1);%Gray编码逆映射
    [errorBit BER(ii)]=biterr(msg,msg_demod,log2(M));%计算BER
    [errorSym SER(ii)]=symerr(msg,msg_demod);%计算SER
end

scatterplot(msg_tx(1:100))%画出发射信号星座图
title('发射信号星座图')
xlabel('同相分量')
ylabel('正交分量')
scatterplot(msg_rx(1:100))%画出接收信号星座图
title('接收信号星座图')
xlabel('同相分量')
ylabel('正交分量')
figure;
semilogy(SNR,BER,'-r*',SNR,SER,'-r*')%画出BER和SER随SNR变化的曲线
legend('BER','SER')
title('QPSK在AWGN信道下的性能')
xlabel('信噪比（dB）')
ylabel('误符号率和误比特率')








% *仿真8-PSK载波调制信号在AWGN信道下的误码率和误比特率性能，并与理论值比较。假设符号周期为1s，载波频率为10Hz，每个符号周期内采样100个点。程序如下：

nsymbol=10000;	%每种信噪比下的发送符号数
T=1;	%符号周期
fs=100;	%每个符号的采样点数
ts=1/fs;	%采样时间间隔
t=0:ts:T-ts;	%时间向量
fc=10;	%载波频率
c=sqrt(2/T)*exp(j*2*pi*fc*t);	%载波信号
figure(1),plot(t,c);
c1=sqrt(2/T)*cos(2*pi*fc*t);	%同相载波
figure(2),plot(t,c1);
c2=-sqrt(2/T)*sin(2*pi*fc*t);	%正交载波	
figure(3),plot(t,c2);				
M=8;	%8-PSK		
graycode=[0 1 2 3 6 7 4 5];		%Gray编码规则
EsN0=0:15;	%信噪比， Es/N0
snr1=10.^(EsN0/10);		%信噪比转换为线性值,倍数
msg=randi([0,M-1],1,nsymbol);			%消息数据
msg1=graycode(msg+1);			%Gray映射,将序列msg+1编成格雷码取出
figure(4),plot(msg,msg1);				
msgmod=pskmod(msg1,M).';		%基带 8-PSK调制
figure(5),scatterplot(msgmod);			
tx=real(msgmod*c);		%载波调制
tx1=reshape(tx.',1,length(msgmod)*length(c));	% B = reshape(A,m,n)  将矩阵A的元素返回到一个m×n的矩阵B。
figure(6),plot(tx1);				
spow=norm(tx1).^2/nsymbol;		%求每个符号的平均功率，n=norm(A)返回A的最大奇异值，即max(svd(A))
for indx=1:length(EsN0)				
sigma=sqrt(spow/(2*snr1(indx)));		%根据符号功率求噪声功率				
rx=tx1+sigma*randn(1,length(tx1));	%加入高斯白噪声，randn 生成标准正态分布的伪随机数（均值为0，方差为1）
rx1=reshape(rx,length(c),length(msgmod));
r1=(c1*rx1)/length(c1);	%相关运算
r2=(c2*rx1)/length(c2);
r=r1+j*r2;
y=pskdemod(r,M);	%PSK解调
decmsg=graycode(y+1);
[err,ber(indx)]=biterr(msg,decmsg,log2(M));	%误比特率，biterr(x,y)是比特的误码率，symerr(x,y)是符号的，在二进制时，它两一样
[err,ser(indx)]=symerr(msg,decmsg);	%误符号率
end
ser1=2*qfunc(sqrt(2*snr1)*sin(pi/M));	%理论误符号率，误差函数
ber1=1/log2(M)*ser1;	%理论误比特率
figure(7),semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');%semilogx函数，semilogy函数，即后标为x的是在x轴取对数，为y的是y轴坐标取对数。
title('8-PSK载波调制信号在AWGN信道下的性能')
xlabel('Es/N0');ylabel('误比特率和误符号率')
legend('误比特率','误符号率','理论误符号率','理论误比特率')