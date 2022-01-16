
clc;
close all;
clear;


%%  https://blog.csdn.net/Hsaver/article/details/110184154

N=10000; % ���г���
SNR=-5:5;
M=2;
tx=randi([0,M-1],N,1); % ԭʼ�ź�
pskSig=pskmod(tx,M); % BPSK����

%% ����һ�������ŵ�
rayleighChan=comm.RayleighChannel(); % �����Դ��������ŵ�
fadeSig = rayleighChan(pskSig);

%% ������������˹��
h = (randn(N,1)+i*randn(N,1))/sqrt(2);
fadeSig3 = h.*pskSig;

%% ��˹�ŵ�
awgnChan=comm.AWGNChannel('NoiseMethod','Signal to noise ratio (SNR)');

%% �ź�ͨ���ŵ�
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
legend('AWGN����','AWGN����','Location','southwest');
hold on;

semilogy(SNR,BER_rayleigh_awgn,'-^',SNR,BER3_rayleigh_awgn,'-x','MarkerSize',10);
legend('AWGN����','AWGN����','�Դ������ŵ�','����˹��','Location','southwest');
hold off;

