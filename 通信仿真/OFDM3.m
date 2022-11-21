
% https://zhuanlan.zhihu.com/p/347445588
NFFT=64;
Ng=NFFT/4;                                    %Guard interval size
Nsym=NFFT+Ng;                                 %Symbol duration
Nused=52;
M=16; 
k=log2(M);
Es=10;
nOFDM_symbol=300;
EbN0dB=1:30;   
EsN0dB=EbN0dB+10*log10(k)+10*log10(Nused/Nsym);
EbN0=10.^(EbN0dB/10);
EsN0=10.^(EsN0dB/10);


N0=Es./EsN0;
variance=N0/2;
Standard_variance=sqrt(variance);
data_subcarriers=52;

nbit=data_subcarriers*nOFDM_symbol*k;     

N_err_bit=zeros(1,length(EbN0dB));

subcarrierIndex = [-26:-1 1:26];


for i=1:length(EbN0dB)
 x= rand(1,nbit)>0.5;                                          %随机产生长度为n的0或者1
 x_reshape=reshape(x,k,length(x)/k)';                          %对数据流进行分组，对于16QAM，则每4位一组
 x_de=bi2de(x_reshape,'left-msb');                             %转化成10进制，作为qammod的输入
 x_mod=qammod(x_de,M,'Gray');                                  %调制到星座图上
 x_OFDM_symbol=reshape(x_mod,data_subcarriers,nOFDM_symbol);   %将产生的bit分配到各个OFDM symbol 上
 x_before_ifft=zeros(64,1);
 for j=1:nOFDM_symbol                                         %发射第j个OFDM symbol
   x_before_ifft(subcarrierIndex+NFFT/2+1)=x_OFDM_symbol(:,j); %给第6个到32和34到59个子载波赋值
   
   X_IFFT=(sqrt(NFFT))*ifft(fftshift(x_before_ifft),NFFT).';
   s=[X_IFFT(NFFT-Ng+1:NFFT) X_IFFT].';
   n=randn(1,length(s)).'+1i*randn(1,length(s)).';
   n_w=Standard_variance(i)*n;
   y=s*(sqrt(Nsym/Nused))+n_w;
   %去除循环前缀
   y=y(Ng+1:Nsym);
   %进入FFT
   yFFT=fftshift(fft(y,NFFT))*(sqrt(Nused)/sqrt(NFFT*Nsym));
   %把对应子载波上的数据提取出来
   yMod=yFFT(subcarrierIndex+NFFT/2+1);
   y_demod=qamdemod(yMod,M,'Gray');
   test=de2bi(y_demod,k,'left-msb');
   N_err_bit(i)= N_err_bit(i)+sum(sum(test~=x_reshape(data_subcarriers*(j-1)+1:data_subcarriers*j,:)));
 end
end
err=N_err_bit/nbit;
semilogy(EbN0dB,err,'mx-','LineWidth',2);
xlabel('Eb/N0, dB')
ylabel('Bit Error Rate')

hold on
a= 4*(1-1/sqrt(M))/log2((M));
b= 3*k/(M-1);

ber = a*Q(sqrt(b*10.^(EbN0dB/10)));
semilogy(EbN0dB,ber,'cd-','LineWidth',1);
axis([1 30 10^-4 1]);
legend('simulation','theory'); 
title('OFDM 16-QAM BER under AWGN channel');
grid on
hold off

function y=Q(x)
y=(1/2)*erfc(x/sqrt(2));
end