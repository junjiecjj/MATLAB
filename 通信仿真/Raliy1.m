
clc;
close all;
clear;


%%  https://blog.csdn.net/Hsaver/article/details/110184154

N=10000; % 序列长度
SNR=-5:5;
M=2;
tx=randi([0,M-1],N,1); % 原始信号
pskSig=pskmod(tx,M); % BPSK调制

%% 方法一：瑞利信道
rayleighChan=comm.RayleighChannel(); % 调用自带的瑞利信道
fadeSig = rayleighChan(pskSig);

%% 方法二：复高斯法
h = (randn(N,1)+i*randn(N,1))/sqrt(2);
fadeSig3 = h.*pskSig;

%% 高斯信道
awgnChan=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (SNR)');

%% 信号通过信道
for i=1:length(SNR)
    awgnChan.SNR=SNR(i);

    rxSig_rayleigh_awgn = awgnChan(fadeSig);
    rxSig3_rayleigh_awgn = awgnChan(fadeSig3);
    rxSig4_awgn = awgnChan(pskSig);
    
    rx_rayleigh_awgn=pskdemod(rxSig_rayleigh_awgn,M);
    rx3_rayleigh_awgn=pskdemod(rxSig3_rayleigh_awgn,M);
    rx4_awgn = pskdemod(rxSig4_awgn,M);
    
    [num1,err1] = biterr(tx,rx_rayleigh_awgn);
    [num3,err3] = biterr(tx,rx3_rayleigh_awgn);
    [num4,err4] = biterr(tx,rx4_awgn);
    
    BER_rayleigh_awgn(i) = err1;
    BER3_rayleigh_awgn(i) = err3;
    BER4_awgn(i) = err4;
    
end

BERtheory = berawgn(SNR','psk',M,'nondiff');
semilogy(SNR,BERtheory,'-',SNR,BER4_awgn,'-*');
legend('AWGN理论','AWGN仿真','Location','southwest');
hold on;

semilogy(SNR,BER_rayleigh_awgn,'-^',SNR,BER3_rayleigh_awgn,'-x','MarkerSize',10);
legend('AWGN理论','AWGN仿真','自带瑞利信道','复高斯法','Location','southwest');
hold off;

