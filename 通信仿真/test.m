clear;clc;close all

% %% *仿真正交相移键控（QPSK）调制的基带数字通信系统通过AWGN信道的误符号率（SER）和误比特率（BER），假设发射端信息比特采用Gray编码影射，基带脉冲采用矩形脉冲，仿真时每个脉冲的采样点数为8，接收端采用匹配滤波器进行相干解调。
% 
% % 代码如下：
% %
% %                    .::::.
% %                  .::::::::.
% %                 :::::::::::  
% %             ..:::::::::::'
% %           '::::::::::::'
% %             .::::::::::
% %        '::::::::::::::..
% %             ..::::::::::::.
% %           ``::::::::::::::::
% %            ::::``:::::::::'        .:::.
% %           ::::'   ':::::'       .::::::::.
% %         .::::'      ::::     .:::::::'::::.
% %        .:::'       :::::  .:::::::::' ':::::.
% %       .::'        :::::.:::::::::'      ':::::.
% %      .::'         ::::::::::::::'         ``::::.
% %  ...:::           ::::::::::::'              ``::.
% % ```` ':.          ':::::::::'                  ::::..
% %                    '.:::::'                    ':'````..
% %
% clear all
% nSamp=8;%矩形脉冲的采样点数
% numSymb=200000;%每种SNR下传输的符号数
% M=4;%QPSK的符号类型数
% SNR=-3:3;%SNR的范围
% grayencod=[0 1 3 2 ];%Gray编码格式
% for ii=1:length(SNR)
% % ii = 7;
%     msg=randsrc(1,numSymb,[0:3]);%产生发送符号，1行numSymb列0-3的数。size(msg)=[1,200000]
%     msg_gr=grayencod(msg+1);%进行Gray编码影射（格雷码）,size(msg_gr)=[1,200000]
%     msg_tx=pskmod(msg_gr,M);%QPSK调制,size(msg_tx)=[1,200000]
%     msg_tx1=rectpulse(msg_tx,nSamp);%矩形脉冲成型,size(msg_gr1)=[1,1600000]
%     msg_rx=awgn(msg_tx1,SNR(ii),'measured');%通过AWGN信道,size(msg_rx)=[1,1600000]
%     msg_rx_down=intdump(msg_rx,nSamp);%匹配滤波相干解调,size(msg_rx_down)=[1,200000]
%     msg_gr_demod=pskdemod(msg_rx_down,M);%QPSK解调,size(msg_gr_demod)=[1,200000]
%     [dummy graydecod]=sort(grayencod);
%     graydecod=graydecod-1;
%     msg_demod=graydecod(msg_gr_demod+1);%Gray编码逆映射,size(msg_demod)=[1,200000]
%     [errorBit BER(ii)]=biterr(msg,msg_demod,log2(M));%计算BER
%     [errorSym SER(ii)]=symerr(msg,msg_demod);%计算SER
% end
% 
% scatterplot(msg_tx(1:100))%画出发射信号星座图
% title('发射信号星座图')
% xlabel('同相分量')
% ylabel('正交分量')
% scatterplot(msg_rx(1:100))%画出接收信号星座图
% title('接收信号星座图')
% xlabel('同相分量')
% ylabel('正交分量')
% figure;
% semilogy(SNR,BER,'-r*',SNR,SER,'-r*')%画出BER和SER随SNR变化的曲线
% legend('BER','SER')
% title('QPSK在AWGN信道下的性能')
% xlabel('信噪比（dB）')
% ylabel('误符号率和误比特率')


%% 试用 Matlab 生成一个幅度为 1，以 t = 2T 为对称中心的矩形脉冲信号 y (t)
% 矩形脉冲信号在 Matlab 中用 rectpuls 函数表示，其调用方式为：
% y = rectpulse(t, width)
% 用以产生一个幅度为 1，宽度为 width 以 t = 0 为对称中心的矩形脉冲波。Width 的默认值为 1。
t1 = 0:0.01:4;
t2 = t1-2;
T1 = 1;
yt1 = rectpuls(t1-2, 2)*2;
figure(1);
plot(t1, yt1)
axis([-3, 5, 0, 2.2]);

t2 = -2:0.01:2;
T1 = 1;
yt2 = rectpuls(t2, 2)*2;
figure(2);
plot(t2, yt2)
axis([-3, 5, 0, 2.2]);

% 
% M = 8;							%调制阶数
% data = randi([0 M-1],1000,1);	%生成随机序列作为待调制信号
% txSig = pskmod(data,M,pi/M);	%调制，频偏pi/4
% rxSig = awgn(txSig,20);			%白噪声，SNR=20dB
% scatterplot(txSig)				%绘制发送信号的星座图
% scatterplot(rxSig)				%绘制接收信号的星座图
