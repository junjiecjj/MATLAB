clc;
close all;
clear;

%% https://www.cxybb.com/article/weixin_37315722/116739459

clear all;
close all;
clc;
t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr);
figure(1);
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�');

z=y-x;
var(z)

t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr,10);
figure(2);
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�')

z=y-x;
var(z)


t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr,'measured');
figure(3);
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�')

z=y-x;
var(z)


t=0:0.001:10;
x=sin(2*pi*t);
px=norm(x).^2/length(x);      %�����ź�x�Ĺ���
snr=20;                       %����ȣ�dB��ʽ
pn=px./(10.^(snr./10));       %����snr������������
n=sqrt(pn)*randn(1,length(x));%�����������ʲ�����Ӧ�ĸ�˹����������
y=x+n;                  %���ź��ϵ��Ӹ�˹������
figure(4);
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�')

var(n)


nSamp = 8;
numSymb = 200000;
M =4;
SNR = -3:1:3;
grayencod = [0 1 3 2];
BER = zeros(1,length(SNR));
SER = zeros(1,length(SNR));
msg_demod  =  zeros(1,numSymb);
for ii=1:length(SNR)
    msg = randsrc(1,numSymb,[0:3]); % ԭʼ��Ϣ����
    msg_gr = grayencod(msg+1);  
    msg_tx = pskmod(msg_gr,M);
    msg_tx = rectpulse(msg_tx,nSamp);
    msg_rx = awgn(msg_tx,SNR(ii),'measured');
    msg_rx_down = intdump(msg_rx,nSamp);
    msg_gr_demod = pskdemod(msg_rx_down,M); % �����������Ϣ����
    %��������ӳ��
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
    [errorBit, BER(ii)] = biterr(msg,msg_demod,log2(M));
    [errorSym, SER(ii)] = symerr(msg,msg_demod);
end
figure(5);
scatterplot(msg_tx(1:100));
title('�����ź�����ͼ��');
xlabel('ͬ�����');
ylabel('��������');

scatterplot(msg_rx(1:100));
title('�����ź�����ͼ��');
xlabel('ͬ�����');
ylabel('��������');

figure
semilogy(SNR,BER,'-bo',SNR,SER,'-r*');
legend('BER','SER');
title('QPSK��AWGN��Ϣ�µ�����');
xlabel('����ȣ�dB��');
ylabel('������ʺ��������');
