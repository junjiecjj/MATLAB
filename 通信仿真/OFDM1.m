% https://zhuanlan.zhihu.com/p/57967971

clear;
%% 参数设置
sub_carriers=2048;%子载波数
T = 1 / sub_carriers;
time = [0:T:1-T];% Nifft份，每份相隔T

Lp=4984;
P_Tx=(rand(1,Lp)>0.5);%(bits)%产生1个长为Lp的数据包:
conv_out=convolutional_en(P_Tx);%（卷积编码）：
interleave_table = interleav_matrix(ones(1,2*(Lp+8)));
interleav_out = interleaving(conv_out ,interleave_table);%（交织器）

x=qpsk(interleav_out);%（4QAM 调制）
L=length(x);%信号长度

s=48;
symbol_used_len=L/s;%把输入分为S个符号，每个符号长为symbol_used_len
%循环前缀的长度
cp=256;
%每一个OFDM符号的抽样值应补‘0’个数zeros_pad
zeros_pad=sub_carriers-symbol_used_len;
%每一个OFDM符号一侧应该补‘0’个数zeros_pad_side
zeros_pad_side=zeros_pad/2;

%对输入信号进行分割，分割为s个符号，再对每个符号进行FFT运算，实现OFDM解调,并保证能量不变
time_domain_x_link=[];
for I=0:(s-1)
    %对输入进行分割 
    x_temp=x(I*symbol_used_len+1:I*symbol_used_len+symbol_used_len);
    %对每个分割的部分进行补零操作，使其长为sub_carriers
    x_temp_pad=[zeros(1,zeros_pad_side),x_temp,zeros(1,zeros_pad_side)];
    %对每个符号进行IFFT运算
    time_domain_x_temp=ifft(x_temp_pad)*sqrt(sub_carriers);
    %对每个符号添加循环前缀
    time_domain_x_cp_temp=[time_domain_x_temp(sub_carriers-cp+1:sub_carriers),time_domain_x_temp];
    %将符号连接成为串行数据流
    time_domain_x_link=[time_domain_x_link,time_domain_x_cp_temp];

end
sum_xI = real(time_domain_x_link);
sum_xQ = imag(time_domain_x_link);

figure;
num=1000;%画出前num个点  
xaxis   = zeros(length(time(1:num)));
plot(time(1:num), sum_xI(1:num), 'b:', time(1:num), sum_xQ(1:num), 'g:', time(1:num), abs(sum_xI(1:num)+j*sum_xQ(1:num)), 'k-', time(1:num), xaxis, 'r-');
ylabel('y'),xlabel('t'),
title(['前', num2str(num),'个点经ifft的QAM符号实部之和虚部之和以及实部与虚部的绝对值波形']),
legend('实部之和','虚部之和', '绝对值');