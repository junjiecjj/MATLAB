theory_SNR=0:1:10;
S_N=10.^(theory_SNR./10);
simu_SNR=10*log10(2.*S_N);
for SNR=0:1:10
    Gaus_noise_signal=awgn(send_signal,simu_SNR(SNR+1)); %加入高斯噪声信号  
    %匹配滤波器+绘制接收信号的波形图+抽样
    receive_signal=Matched_filter(encoder_length,Matched_filter_length,Bipolar_signal(),Gaus_noise_signal);
    %接受信号的星座图
    %scatter_plot(receive_signal);
    %title('接收信号的星座图');
    %硬判决
    judge_signal(receive_signal>0)=1;
    judge_signal(receive_signal<=0)=0;
    %误码率的统计
    [M,q]=biterr(Gen_code_mat,judge_signal); %统计没有经过解码的误码率
    X=reshape(judge_signal,length(judge_signal)/7,7);
    [I,A]=Block_decoder(X);
    B=reshape(I,1,sym_length);
    [num,rate]=biterr(trans_binary,B); %仿真统计经过解码的误码数目
    simu_err_rate(SNR+1)=rate;
    theory_err_rate(SNR+1)=0.5*erfc(sqrt(S_N(SNR+1)));%理论误码率
end