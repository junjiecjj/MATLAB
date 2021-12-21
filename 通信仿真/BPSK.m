
% https://blog.csdn.net/naturly/article/details/109052428
clc
clear
close all;

%%��ʼ����������
data_len = 100000;                       % ԭʼ���ݳ���
SNR_dB = 0:10;                           % ����� dB��ʽ
SNR = 10.^(SNR_dB/10);                   % Eb/N0
Eb = 1; % ÿ��������
N0 = Eb./SNR ; %��������
error2 = zeros(1,length(SNR_dB));          % ��Ԫ�������
simu_ber_BPSK = zeros(1,length(SNR_dB));         % ������������
theory_ber_BPSK = zeros(1,length(SNR_dB));   % BPSK����������
demod2_signal= zeros(1,data_len);         % ����ź�

%%�����źŲ���
data_source = round(rand(1,data_len));  % �������������

%%BPSK��������   
send_signal2 = (data_source - 1/2)*2; % ˫���Բ��������� 

%%��˹�ŵ��ޱ���
for z = 1:length(SNR_dB)
     noise2 = sqrt(N0(z)/2) * randn(1,data_len); %��˹������
     receive_signal2 = send_signal2 + noise2;
     demod_signal2 = zeros(1,data_len);
        for w = 1:data_len
                if (receive_signal2(w) > 0)
                demod_signal2(w) = 1;              % �����źŴ���0  ����1
                else
                demod_signal2(w) = 0;              % �����ź�С��0  ����0
                end
        end
        %ͳ�ƴ�����Ԫ����
       for w = 1:data_len
           if(demod_signal2(w) ~=data_source(w) )
                  error2(z) = error2(z) + 1;    % ������ظ���
           end
       end
           %����������
        simu_ber_BPSK(z) = error2(z) / data_len;         % �����������
        theory_ber_BPSK(z) = qfunc(sqrt(2*SNR(z)));   % �����������
end

    

%%���������С������ź�ͼ��
figure(1);
stem(data_source);
title('�������������');
axis([0,50,0,1]);
figure(2);
stem(send_signal2);
title('BPSK��������--�����ź�');
axis([0,50,-1.5,1.5]);

figure(4);
stem(noise2);
title('��˹������');
axis([0,50,-0.5,0.5]);

figure(5)
stem(receive_signal2);
title('�����ź�');
axis([0,50,-1.5,1.5]);

figure(7)
stem(demod_signal2);
title('����ź�');
axis([0,50,0,1]);

figure(8);
 semilogy(SNR_dB,simu_ber_BPSK,'M-X',SNR_dB,theory_ber_BPSK,'k-s');     

grid on;                                      
axis([0 10 10^-5 10^-1])                      
xlabel('Eb/N0 (dB)');                     
ylabel('BER');                                  
 legend('BPSK����������','BPSK����������');  

%%������ͼ
scatterplot(send_signal2);
title('�����ź�����ͼ');
scatterplot(receive_signal2);
title('�����ź�����ͼ');
scatterplot(demod_signal2);
title('�����ź�����ͼ');


