% https://zhuanlan.zhihu.com/p/253213570
%%%%%%%%%%%%%%%%%%%%%  BPSK���ƽ�������� %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  BPSK_modem_sim1_1_13.m  %%%%%%%%%
%%%%% data:2020��6��10��  ԭ�����㷨����    �Ķ�:����󽫾� %%%%%%%%%%

%%%%%����˵��
%%�����BPSK���ƽ������,�Ƚϲ�ͬ������µ�����������
%ͨ�����ƾ����������£�
%���Ʒ�ʽ��BPSK   ���뷽ʽ����
%�������ӣ�0.5
%�����ʽ����ɽ��  ���뷽ʽ����
%���������Ը�˹������

%%%%    ���滷��
%����汾��MATLAB R2019a

%%%    simϵ��˵��
%1_7����ȷ��Es/N0(dB)=10log10(0.5Tsym/Tsamp)+SNR(dB) for real input signals

clear all;
close all;
format long;
tic;


%********************** �������� ************%

%%%%%%%%%%%%%%%%%  �����趨   %%%%%%%%%%%%%%
bit_rate =1000;% ������
symbol_rate = 1000;%������
sps =16;%ÿ�����ŵĲ�������
fc =2000; %�ز�Ƶ��
fs =16000; %����Ƶ��

%%%%%%%%%%%%%%%%%   ��Դ   %%%%%%%%%%%%%%%%%%%
%%%%����ź�
msg_source = [ones(1,20) zeros(1,20) randi([0 1],1,99960)];
%������־�Ե�֡ͷ���������

%%%%%%%%%%%%%%%%%  �����  %%%%%%%%%%%%%%%%%%%
%%%%%%%%������
%%%%%˫���Ա任
bipolar_msg_source = 2*msg_source-1; %˫�����ź�

%%%�����˲���
rollof_factor = 0.5; %��������,�ɵ���
rcos_fir = rcosdesign(rollof_factor,6,sps);

%%%��ֵ
bipolar_msg_source_temp = [bipolar_msg_source',zeros(size(bipolar_msg_source,2),sps-1)]; 
length_x = size(bipolar_msg_source_temp,1);
length_y = size(bipolar_msg_source_temp,2);
up16_bipolar_msg_source = reshape(bipolar_msg_source_temp',1,length_x * length_y);

%%%%�����˲�
rcos_msg_source = filter(rcos_fir,1,up16_bipolar_msg_source);

% %���ι۲�
% figure(1);
% plot(rcos_msg_source);
% title('ʱ����');
% figure(2);
% plot(abs(fft(rcos_msg_source)));
% title('Ƶ����');
% 
% eyediagram(rcos_msg_source(49:end),sps);
% title('��ͼ');

%%%%%�ز�����
time = [1:length(rcos_msg_source)];
rcos_msg_source_carrier = rcos_msg_source.*cos(2*pi*fc.*time/fs);
%%%%%%��������ֱ���ø����ز��ź�ʵ�֣����ӷ���

% %���ι۲�
% figure(3);
% plot(rcos_msg_source_carrier);
% title('ʱ����');
% figure(4);
% plot(abs(fft(rcos_msg_source_carrier)));
% title('Ƶ����');

%%%%%%%%%%%%%%%%%  �ŵ�    %%%%%%%%%%%%%%%%%%%
%��������ȣ���λdB
ebn0 =[-6:8];
snr = ebn0 - 10*log10(0.5*16);

for i =1:length(snr)

%%%���Ը�˹�������ŵ�
rcos_msg_source_carrier_addnoise = awgn(rcos_msg_source_carrier,snr(i),'measured');

% %���ι۲�
% figure(5);
% plot(rcos_msg_source_carrier_addnoise);
% title('ʱ����');
% figure(6);
% plot(abs(fft(rcos_msg_source_carrier_addnoise)));
% title('Ƶ����');

%%%%%%%%%%%%%%%%%  ���ջ�  %%%%%%%%%%%%%%%%%%%
%%%%%%�ز��ָ�
%%%��ɽ��
rcos_msg_source_addnoise =rcos_msg_source_carrier_addnoise.*cos(2*pi*fc.*time/fs);

% %���ι۲�
% figure(7);
% plot(rcos_msg_source_addnoise);
% title('ʱ����');
% figure(8);
% plot(abs(fft(rcos_msg_source_addnoise)));
% title('Ƶ����');

%%%%%%%�˲�
%%%%��ͨ�˲�
fir_lp =fir1(128,0.2); %��ֹƵ��Ϊ0.2*(fs/2)
rcos_msg_source_lp = filter(fir_lp,1,rcos_msg_source_addnoise);
%�ӳ�64�����������

% %���ι۲�
% figure(9);
% plot(rcos_msg_source_lp);
% title('ʱ����');
% figure(10);
% plot(abs(fft(rcos_msg_source_lp)));
% title('Ƶ����');

%%%%%%ƥ���˲�
%����ƥ���˲���
rollof_factor =0.5;
rcos_fir = rcosdesign(rollof_factor,6,sps);
%�˲�
rcos_msg_source_MF = filter(rcos_fir,1,rcos_msg_source_lp);

% %���ι۲�
% figure(11);
% plot(rcos_msg_source_MF);
% title('ʱ����');
% figure(12);
% plot(abs(fft(rcos_msg_source_MF)));
% title('Ƶ����');

%%%%%��Ѳ���
%%%ѡȡ��Ѳ�����
decision_site = 160; %(96+128+96)/2 =160 �����˲������ӳ� 96 128 96


%ÿ������ѡȡһ������Ϊ�о�
rcos_msg_source_MF_option = rcos_msg_source_MF(decision_site:sps:end);
%�漰�������˲������̺����˲����ӳ��ۼ�


%%%�о�
msg_source_MF_option_sign= sign(rcos_msg_source_MF_option);

% %���ι۲�
% figure(13);
% plot(msg_source_MF_option,'-*');
% title('�о����');
% 
% eyediagram(rcos_msg_source,sps);
% title('�������ͼ');
% eyediagram(rcos_msg_source_MF,sps);
% title('���ն���ͼ');
% 
% scatterplot(rcos_msg_source(48+1:16:end-48));
% title('BPSK����ͼ');


%%%%%%%%%%%%%%%%%   ����    %%%%%%%%%%%%%%%%%%%%
%%%���������ܱȶ�
%[err_number,bit_err_ratio]=biterr(x,y)
[err_number(i),bit_err_ratio(i)]=biterr(msg_source(1:length(rcos_msg_source_MF_option)),(msg_source_MF_option_sign+1)/2);

end %for i
toc;
%%%%%%%%%%%%%%%%%   ������    %%%%%%%%%%%%%%%%%%%%
ber = berawgn(ebn0,'psk',2,'nondiff');
semilogy(ebn0,bit_err_ratio,'-*',ebn0,ber,'-+');
xlabel('���������');
ylabel('������');
title('��ͬ������������ʷ�������');
legend('ʵ������','��������');
grid on;
%bit_err_ratio = [0.244582012381114   0.213429208628777   0.187996919722775   0.163494714524307
%0.131351821663950   0.105409486853817   0.081767359062316   0.05948535368183
%0.039983598523867   0.025562300607055   0.014161274514706   0.007020631856867
%0.003290296126651   0.000920082807453   0.000360032402916 ]
%%%%%%%%%%%%%%%%%   ����    %%%%%%%%%%%%%%%%%%%%

%�����BPSK���ƽ�����ķ���
%û�а�������������
%2020-6-10