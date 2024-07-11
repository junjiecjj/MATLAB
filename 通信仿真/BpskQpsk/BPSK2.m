% https://zhuanlan.zhihu.com/p/253213570
%%%%%%%%%%%%%%%%%%%%%  BPSK调制解调器仿真 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  BPSK_modem_sim1_1_13.m  %%%%%%%%%
%%%%% data:2020年6月10日  原创：算法工匠    改动:飞蓬大将军 %%%%%%%%%%

%%%%%程序说明
%%完成了BPSK调制解调仿真,比较不同信噪比下的误码率性能
%通信体制具体内容如下：
%调制方式：BPSK   编码方式：无
%滚降因子：0.5
%解调方式：相干解调  译码方式：无
%噪声：线性高斯白噪声

%%%%    仿真环境
%软件版本：MATLAB R2019a

%%%    sim系列说明
%1_7：明确了Es/N0(dB)=10log10(0.5Tsym/Tsamp)+SNR(dB) for real input signals

clear all;
close all;
format long;
tic;


%********************** 程序主体 ************%
%%%%%%%%%%%%%%%%%  参数设定   %%%%%%%%%%%%%%
bit_rate =1000;      % 比特率
symbol_rate = 1000;  % 符号率
sps = 16;   % 每个符号的采样点数
fc = 2000;  % 载波频率
fs = 16000; % 采样频率

%%%%%%%%%%%%%%%%%   信源   %%%%%%%%%%%%%%%%%%%
%%%% 随机信号
msg_source = [ones(1,20) zeros(1,20) randi([0 1],1,99960)];
%给出标志性的帧头，方便调试

%%%%%%%%%%%%%%%%%  发射机  %%%%%%%%%%%%%%%%%%%
%%%%%%%% 调制器
%%%%% 双极性变换
bipolar_msg_source = 2*msg_source-1; %双极性信号

%%%滚降滤波器
rollof_factor = 0.5; %滚降因子,可调整
rcos_fir = rcosdesign(rollof_factor,6,sps);

%%%插值
bipolar_msg_source_temp = [bipolar_msg_source',zeros(size(bipolar_msg_source,2),sps-1)]; 
length_x = size(bipolar_msg_source_temp,1);
length_y = size(bipolar_msg_source_temp,2);
up16_bipolar_msg_source = reshape(bipolar_msg_source_temp',1,length_x * length_y);

%%%%滚降滤波
rcos_msg_source = filter(rcos_fir,1,up16_bipolar_msg_source);

% %波形观察
% figure(1);
% plot(rcos_msg_source);
% title('时域波形');
% figure(2);
% plot(abs(fft(rcos_msg_source)));
% title('频域波形');
% 
% eyediagram(rcos_msg_source(49:end),sps);
% title('眼图');

%%%%%载波发送
time = [1:length(rcos_msg_source)];
rcos_msg_source_carrier = rcos_msg_source.*cos(2*pi*fc.*time/fs);
%%%%%%后续考虑直接用复数载波信号实现，更加方便

% %波形观察
% figure(3);
% plot(rcos_msg_source_carrier);
% title('时域波形');
% figure(4);
% plot(abs(fft(rcos_msg_source_carrier)));
% title('频域波形');

%%%%%%%%%%%%%%%%%  信道    %%%%%%%%%%%%%%%%%%%
%设置信噪比，单位dB
ebn0 =[-6:8];
snr = ebn0 - 10*log10(0.5*16);

for i =1:length(snr)
    %%%线性高斯白噪声信道
    rcos_msg_source_carrier_addnoise = awgn(rcos_msg_source_carrier,snr(i),'measured');
    
    % %波形观察
    % figure(5);
    % plot(rcos_msg_source_carrier_addnoise);
    % title('时域波形');
    % figure(6);
    % plot(abs(fft(rcos_msg_source_carrier_addnoise)));
    % title('频域波形');
    
    %%%%%%%%%%%%%%%%%  接收机  %%%%%%%%%%%%%%%%%%%
    %%%%%%载波恢复
    %%%相干解调
    rcos_msg_source_addnoise = rcos_msg_source_carrier_addnoise.*cos(2*pi*fc.*time/fs);
    
    %波形观察
    figure(7);
    plot(rcos_msg_source_addnoise);
    title('时域波形');
    figure(8);
    plot(abs(fft(rcos_msg_source_addnoise)));
    title('频域波形');
    
    %%%%%%%滤波
    %%%%低通滤波
    fir_lp =fir1(128, 0.2); %截止频率为0.2*(fs/2)
    rcos_msg_source_lp = filter(fir_lp,1,rcos_msg_source_addnoise);

    
    %延迟64个采样点输出
    
    %波形观察
    figure(9);
    plot(rcos_msg_source_lp);
    title('时域波形');
    figure(10);
    plot(abs(fft(rcos_msg_source_lp)));
    title('频域波形');
    
    %%%%%%匹配滤波
    %生成匹配滤波器
    rollof_factor = 0.5;
    rcos_fir = rcosdesign(rollof_factor,6,sps);
    %滤波
    rcos_msg_source_MF = filter(rcos_fir,1,rcos_msg_source_lp);
    
    %波形观察
    figure(11);
    plot(rcos_msg_source_MF);
    title('时域波形');
    figure(12);
    plot(abs(fft(rcos_msg_source_MF)));
    title('频域波形');
    
    %%%%%最佳采样
    %%%选取最佳采样点
    decision_site = 160; %(96+128+96)/2 =160 三个滤波器的延迟 96 128 96
    
    %每个符号选取一个点作为判决
    rcos_msg_source_MF_option = rcos_msg_source_MF(decision_site:sps:end);
    %涉及到三个滤波器，固含有滤波器延迟累加
    
    %%%判决
    msg_source_MF_option_sign= sign(rcos_msg_source_MF_option);
    
    % %波形观察
    % figure(13);
    % plot(msg_source_MF_option,'-*');
    % title('判决结果');
    % 
    % eyediagram(rcos_msg_source,sps);
    % title('发射端眼图');
    % eyediagram(rcos_msg_source_MF,sps);
    % title('接收端眼图');
    % 
    % scatterplot(rcos_msg_source(48+1:16:end-48));
    % title('BPSK星座图');
    
    
    %%%%%%%%%%%%%%%%%   信宿    %%%%%%%%%%%%%%%%%%%%
    %%%误码率性能比对
    %[err_number,bit_err_ratio]=biterr(x,y)
    [err_number(i), bit_err_ratio(i)] = biterr(msg_source(1:length(rcos_msg_source_MF_option)), (msg_source_MF_option_sign+1)/2);

end %for i
toc;
%%%%%%%%%%%%%%%%%   仿真结果    %%%%%%%%%%%%%%%%%%%%
ber = berawgn(ebn0,'psk',2,'nondiff');
semilogy(ebn0,bit_err_ratio,'-*',ebn0, ber,'-+');
xlabel('比特信噪比');
ylabel('误码率');
title('不同信噪比下误码率仿真曲线');
legend('实验曲线','理论曲线');
grid on;
%bit_err_ratio = [0.244582012381114   0.213429208628777   0.187996919722775   0.163494714524307
%0.131351821663950   0.105409486853817   0.081767359062316   0.05948535368183
%0.039983598523867   0.025562300607055   0.014161274514706   0.007020631856867
%0.003290296126651   0.000920082807453   0.000360032402916 ]
%%%%%%%%%%%%%%%%%   结论    %%%%%%%%%%%%%%%%%%%%

%完成了BPSK调制解调器的仿真
%没有包含编译码内容
%2020-6-10