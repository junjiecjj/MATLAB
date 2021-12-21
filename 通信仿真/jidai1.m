theory_SNR=0:1:10;
S_N=10.^(theory_SNR./10);
simu_SNR=10*log10(2.*S_N);
for SNR=0:1:10
    Gaus_noise_signal=awgn(send_signal,simu_SNR(SNR+1)); %�����˹�����ź�  
    %ƥ���˲���+���ƽ����źŵĲ���ͼ+����
    receive_signal=Matched_filter(encoder_length,Matched_filter_length,Bipolar_signal(),Gaus_noise_signal);
    %�����źŵ�����ͼ
    %scatter_plot(receive_signal);
    %title('�����źŵ�����ͼ');
    %Ӳ�о�
    judge_signal(receive_signal>0)=1;
    judge_signal(receive_signal<=0)=0;
    %�����ʵ�ͳ��
    [M,q]=biterr(Gen_code_mat,judge_signal); %ͳ��û�о��������������
    X=reshape(judge_signal,length(judge_signal)/7,7);
    [I,A]=Block_decoder(X);
    B=reshape(I,1,sym_length);
    [num,rate]=biterr(trans_binary,B); %����ͳ�ƾ��������������Ŀ
    simu_err_rate(SNR+1)=rate;
    theory_err_rate(SNR+1)=0.5*erfc(sqrt(S_N(SNR+1)));%����������
end