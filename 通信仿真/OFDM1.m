% https://zhuanlan.zhihu.com/p/57967971

clear;
%% ��������
sub_carriers=2048;%���ز���
T = 1 / sub_carriers;
time = [0:T:1-T];% Nifft�ݣ�ÿ�����T

Lp=4984;
P_Tx=(rand(1,Lp)>0.5);%(bits)%����1����ΪLp�����ݰ�:
conv_out=convolutional_en(P_Tx);%��������룩��
interleave_table = interleav_matrix(ones(1,2*(Lp+8)));
interleav_out = interleaving(conv_out ,interleave_table);%����֯����

x=qpsk(interleav_out);%��4QAM ���ƣ�
L=length(x);%�źų���

s=48;
symbol_used_len=L/s;%�������ΪS�����ţ�ÿ�����ų�Ϊsymbol_used_len
%ѭ��ǰ׺�ĳ���
cp=256;
%ÿһ��OFDM���ŵĳ���ֵӦ����0������zeros_pad
zeros_pad=sub_carriers-symbol_used_len;
%ÿһ��OFDM����һ��Ӧ�ò���0������zeros_pad_side
zeros_pad_side=zeros_pad/2;

%�������źŽ��зָ�ָ�Ϊs�����ţ��ٶ�ÿ�����Ž���FFT���㣬ʵ��OFDM���,����֤��������
time_domain_x_link=[];
for I=0:(s-1)
    %��������зָ� 
    x_temp=x(I*symbol_used_len+1:I*symbol_used_len+symbol_used_len);
    %��ÿ���ָ�Ĳ��ֽ��в��������ʹ�䳤Ϊsub_carriers
    x_temp_pad=[zeros(1,zeros_pad_side),x_temp,zeros(1,zeros_pad_side)];
    %��ÿ�����Ž���IFFT����
    time_domain_x_temp=ifft(x_temp_pad)*sqrt(sub_carriers);
    %��ÿ���������ѭ��ǰ׺
    time_domain_x_cp_temp=[time_domain_x_temp(sub_carriers-cp+1:sub_carriers),time_domain_x_temp];
    %���������ӳ�Ϊ����������
    time_domain_x_link=[time_domain_x_link,time_domain_x_cp_temp];

end
sum_xI = real(time_domain_x_link);
sum_xQ = imag(time_domain_x_link);

figure;
num=1000;%����ǰnum����  
xaxis   = zeros(length(time(1:num)));
plot(time(1:num), sum_xI(1:num), 'b:', time(1:num), sum_xQ(1:num), 'g:', time(1:num), abs(sum_xI(1:num)+j*sum_xQ(1:num)), 'k-', time(1:num), xaxis, 'r-');
ylabel('y'),xlabel('t'),
title(['ǰ', num2str(num),'���㾭ifft��QAM����ʵ��֮���鲿֮���Լ�ʵ�����鲿�ľ���ֵ����']),
legend('ʵ��֮��','�鲿֮��', '����ֵ');