

clear all;
close all;



M=16
k=log2(M);  % bitsPerSym = log2(m)
n=10000; %定义基本参数
x = randi([0,1], n*k,1); %生成随机二进制数比特流，序列长度为k倍数
x4 = reshape(x,k,length(x)/k);
xsym = bi2de(x4','left-msb'); % 将矩阵转化为相应的二进制数M进制数

y = qammod(x,M,'bin','InputType','bit'); %QAM调制
yn = awgn(y,13);


scatterplot(y); % 画出16QAM信号的调制图
text(real(y)+0.1, imag(y), dec2bin(xsym)); % 在横real(y)+1,纵imag(y)处按列标注M进制xsym转二进制的数
axis([-5 5 -5 5]);
hold on;


h = scatterplot(yn, 1, 0,'b.'); % 经过信道后接收到的含白噪声的信号星座图
hold on;
scatterplot(y,1, 0,'r*', h); % 加入不含白噪声的信号星座图
title('接收信号星座图')
legend('含噪声接收信号','不含噪声信号');
axis([-5 5 -5 5]);
hold on;


%figure(3);
eyediagram(yn,2); % 眼图
yd = qamdemod(y, M, 'bin', 'OutputType', 'bit'); %QAM解调


%%%%% 基带信号和解调信号
figure();
subplot(2,1,1);
stem(x(1:50),'filled'); % 画出相应的二进制比特流信号前五十位
title('基带二进制随机序列');
xlabel('比特序列'); ylabel('信号幅度');
subplot(2,1,2);
stem(yd(1:50));  % 画出相应的M进制信号序列
title('解调后的二进制序列')
xlabel('比特序列'); ylabel('信号幅度');

%%%%% 实际与理论码错误率计算
SNR_in_dB=0:1:24; % AWGN信道噪声比
for j=1: length(SNR_in_dB)
    numoferr=0;
    y_add_noise = awgn(y, SNR_in_dB(j)); % 加入不同强度的高斯白噪声
    y_output= qamdemod(y_add_noise,M,'bin','OutputType','bit'); % 对已调信号进行解调
    for i=1: length(x)
        if(y_output(i)~=x(i))
            numoferr=numoferr+1;
        end
    end
    Pe(j) = numoferr/length(x); %t通过错误码元数与总码元数之比求误码率，不同j是不同信噪比下的误码率
end

%%% 理论误差值
SNR_in_dB=0:1:24;
berQ = berawgn(SNR_in_dB,'qam',M);

%%% 合并画误码率曲线图
figure();
semilogy(SNR_in_dB,Pe,'red*-');
hold on;
semilogy(SNR_in_dB, berQ);
title('误码率比较');
legend('实际误码率','理论误码率');
hold on;
grid on;
xlim([0,15]);
xlabel('SNR/dB');
ylabel('Pe1')
disp(Pe);
disp(berQ);

