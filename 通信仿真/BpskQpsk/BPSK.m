
% https://blog.csdn.net/naturly/article/details/109052428
clc
clear
close all;

%%初始化参数设置
data_len = 100000;                       % 原始数据长度
SNR_dB = 0:10;                           % 信噪比 dB形式
SNR = 10.^(SNR_dB/10);                   % Eb/N0
Eb = 1; % 每比特能量
N0 = Eb./SNR ; %噪声功率
error2 = zeros(1,length(SNR_dB));          % 码元错误个数
simu_ber_BPSK = zeros(1,length(SNR_dB));         % 仿真误误码率
theory_ber_BPSK = zeros(1,length(SNR_dB));   % BPSK理论误码率
demod2_signal= zeros(1,data_len);         % 解调信号

%%基带信号产生
data_source = round(rand(1,data_len));  % 二进制随机序列

%%BPSK基带调制   
send_signal2 = (data_source - 1/2)*2; % 双极性不归零序列 

%%高斯信道无编码
for z = 1:length(SNR_dB)
     noise2 = sqrt(N0(z)/2) * randn(1,data_len); %高斯白噪声
     receive_signal2 = send_signal2 + noise2;
     demod_signal2 = zeros(1,data_len);
        for w = 1:data_len
                if (receive_signal2(w) > 0)
                demod_signal2(w) = 1;              % 接收信号大于0  则判1
                else
                demod_signal2(w) = 0;              % 接收信号小于0  则判0
                end
        end
        %统计错误码元个数
       for w = 1:data_len
           if(demod_signal2(w) ~=data_source(w) )
                  error2(z) = error2(z) + 1;    % 错误比特个数
           end
       end
           %计算误码率
        simu_ber_BPSK(z) = error2(z) / data_len;         % 仿真误比特率
        theory_ber_BPSK(z) = qfunc(sqrt(2*SNR(z)));   % 理论误比特率
end

    

%%二进制序列、基带信号图像
figure(1);
stem(data_source);
title('二进制随机序列');
axis([0,50,0,1]);
figure(2);
stem(send_signal2);
title('BPSK基带调制--发送信号');
axis([0,50,-1.5,1.5]);

figure(4);
stem(noise2);
title('高斯白噪声');
axis([0,50,-0.5,0.5]);

figure(5)
stem(receive_signal2);
title('接收信号');
axis([0,50,-1.5,1.5]);

figure(7)
stem(demod_signal2);
title('解调信号');
axis([0,50,0,1]);

figure(8);
 semilogy(SNR_dB,simu_ber_BPSK,'M-X',SNR_dB,theory_ber_BPSK,'k-s');     

grid on;                                      
axis([0 10 10^-5 10^-1])                      
xlabel('Eb/N0 (dB)');                     
ylabel('BER');                                  
 legend('BPSK仿真误码率','BPSK理论误码率');  

%%画星座图
scatterplot(send_signal2);
title('发送信号星座图');
scatterplot(receive_signal2);
title('接收信号星座图');
scatterplot(demod_signal2);
title('解码信号星座图');


