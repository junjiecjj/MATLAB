
% https://zhuanlan.zhihu.com/p/47258287
clc
clear all
close all
Fc=700e6;%Fc�ز�Ƶ��

data_num=300;
data = randint(1,data_num); %����1��300�еľ���Ԫ��Ϊ0-1֮��������������0��1
figure(1)
subplot(211)
plot(data);title('ԭʼ�����ź�')%��data����Ϊ�����꣬��Ԫ�����Ϊ�����꣬��ֱ�������������ݵ㣬��������
ts=0:1:length(data)-1;
subplot(212)
stem(ts,data);title('ԭʼ�����ź�');%����ʱ�������Ļ��������ǳ弤��

fs_16k=16e3;%�����ʼ����Ƶ����16e3
it=[];qt=[];
sit=[];sqt=[];
for i=1:3:length(data)
    I(i) = data(i); 
    Q(i+1) = data(i+1);
    U(i+2) = data(i+2);   
    if I(i)==0 && Q(i+1)==0 && U(i+2)==0
        it=0.924*ones(1,1);%1��1�е�ȫΪ1�ľ���
        qt=0.383*ones(1,1);
       
    elseif I(i)==0 && Q(i+1)==0 && U(i+2)==1
        it=0.383*ones(1,1);
        qt=0.924*ones(1,1);
       
    elseif I(i)==0 && Q(i+1)==1 && U(i+2)==1
        it=-0.383*ones(1,1);
        qt=0.924*ones(1,1);
       
    elseif I(i)==0 && Q(i+1)==1 && U(i+2)==0
        it=-0.924*ones(1,1);
        qt=0.383*ones(1,1);
     
    elseif I(i)==1 && Q(i+1)==1 && U(i+2)==0
        it=-0.924*ones(1,1);
        qt=-0.383*ones(1,1);
      
    elseif I(i)==1 && Q(i+1)==1 && U(i+2)==1
        it=-0.383*ones(1,1);
        qt=-0.924*ones(1,1); 
        
    elseif I(i)==1 && Q(i+1)==0 && U(i+2)==1 
        it=0.383*ones(1,1);
        qt=-0.924*ones(1,1);
       
    elseif I(i)==1 && Q(i+1)==0 && U(i+2)==0
        it=0.924*ones(1,1);
        qt=-0.383*ones(1,1);
       
    end
   sit=[sit it]; sqt=[sqt qt];
end %ӳ��
figure(2)
subplot(221)
plot(sit);title('i·�ź�')
subplot(222)
plot(sqt);title('q·�ź�')
subplot(223)
plot(-fs_16k/2:fs_16k/length(sit):fs_16k/2-fs_16k/length(sit),fftshift(abs(fft(sit))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ')
subplot(224)
plot(-fs_16k/2:fs_16k/length(sqt):fs_16k/2-fs_16k/length(sqt),fftshift(abs(fft(sqt))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ')

figure(3)
scatter(sit,sqt);%����ͼ
grid on


%% ��߲���Ƶ�� 16k-160k,(��ֵ���Ȳ���ˣ���ȡ���ȳ����)

fs_160k=160e3;
sit_160k=upsample(sit,10);
sqt_160k=upsample(sqt,10);

beta=0.4;%r=0ʱ�Ǿ���
span=length(sit_160k);
sps=10;
h = rcosdesign(beta,span,sps);
sit_160k_f=conv(sit_160k,h,'same');
sqt_160k_f=conv(sqt_160k,h,'same');

figure(4)
subplot(221)
plot(sit_160k_f);title('10����ֵi·')
subplot(222)
plot(sqt_160k_f);title('10����ֵq·')
subplot(223)
plot(-fs_160k/2:fs_160k/length(sit_160k_f):fs_160k/2-fs_160k/length(sit_160k_f),fftshift(abs(fft(sit_160k_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(������)')
subplot(224)
plot(-fs_160k/2:fs_160k/length(sqt_160k_f):fs_160k/2-fs_160k/length(sqt_160k_f),fftshift(abs(fft(sqt_160k_f))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(������)')


%% 160k-1600k, ��ֵ���Ȳ���ˣ���ȡ���ȳ����

fs_1600k=1600e3;
sit_1600k=upsample(sit_160k_f,10);
sqt_1600k=upsample(sqt_160k_f,10);

y_de7=fir1(127,1/10);
sit_1600k_f=conv(sit_1600k,y_de7,'same');
sqt_1600k_f=conv(sqt_1600k,y_de7,'same');

figure(5)
subplot(221)
plot(sit_1600k_f);title('100����ֵi·')
subplot(222)
plot(sqt_1600k_f);title('100����ֵq·')
subplot(223)
plot(-fs_1600k/2:fs_1600k/length(sit_1600k_f):fs_1600k/2-fs_1600k/length(sit_1600k_f),fftshift(abs(fft(sit_1600k_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_1600k/2:fs_1600k/length(sqt_1600k_f):fs_1600k/2-fs_1600k/length(sqt_1600k_f),fftshift(abs(fft(sqt_1600k_f))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)');

%% 1600k-16M, ��ֵ���Ȳ���ˣ���ȡ���ȳ����

fs_16M=16e6;
sit_16M=upsample(sit_1600k_f,10);
sqt_16M=upsample(sqt_1600k_f,10);

y_de7=fir1(127,1/10);
sit_16M_f=conv(sit_16M,y_de7,'same');
sqt_16M_f=conv(sqt_16M,y_de7,'same');

figure(6)
subplot(221)
plot(sit_16M_f);title('1000����ֵi·')
subplot(222)
plot(sqt_16M_f);title('1000����ֵq·')
subplot(223)
plot(-fs_16M/2:fs_16M/length(sit_16M_f):fs_16M/2-fs_16M/length(sit_16M_f),fftshift(abs(fft(sit_16M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_16M/2:fs_16M/length(sqt_16M_f):fs_16M/2-fs_16M/length(sqt_16M_f),fftshift(abs(fft(sqt_16M_f))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)');

%% 16M-25M, ����ԭʼ����Ƶ�����ŵ�������Ҫ�Ĳ���Ƶ�ʲ�һ�£�����Ҫ��Ƶ��

fs_25M=25e6;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
sit_25M=resample(sit_16M_f,25,16);
sqt_25M=resample(sqt_16M_f,25,16);

figure(7)
subplot(221)
plot(sit_25M);title('25/16����ֵi·')
subplot(222)
plot(sqt_25M);title('25/16����ֵq·')
subplot(223)
plot(-fs_25M/2:fs_25M/length(sit_25M):fs_25M/2-fs_25M/length(sit_25M),fftshift(abs(fft(sit_25M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_25M/2:fs_25M/length(sqt_25M):fs_25M/2-fs_25M/length(sqt_25M),fftshift(abs(fft(sqt_25M))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')

%% 25M-250M

fs_250M=250e6;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
sit_250M=upsample(sit_25M,10);
sqt_250M=upsample(sqt_25M,10);

y_de7=fir1(127,1/10);
sit_250M_f=conv(sit_250M,y_de7,'same');
sqt_250M_f=conv(sqt_250M,y_de7,'same');

figure(8)
subplot(221)
plot(sit_250M_f);title('10����ֵi·')
subplot(222)
plot(sqt_250M_f);title('10����ֵq·')
subplot(223)
plot(-fs_250M/2:fs_250M/length(sit_250M_f):fs_250M/2-fs_250M/length(sit_250M_f),fftshift(abs(fft(sit_250M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_250M/2:fs_250M/length(sqt_250M_f):fs_250M/2-fs_250M/length(sqt_250M_f),fftshift(abs(fft(sqt_250M_f))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')

%% ��ͨ����

fs_250M=250e6;
T=length(sqt_250M_f);%T=
t=0 : 1/fs_250M :T/fs_250M - 1/fs_250M;%fs = 100
% c=exp(j*2*pi*Fc*t);	%�ز��ź�,Fc=70e6
c1=cos(2*pi*Fc*t);	%ͬ���ز�
c2=-sin(2*pi*Fc*t);	%�����ز�	
psk8 = sit_250M_f.*c1 + sqt_250M_f.*c2;
figure(9),
% subplot(221);plot(t,c);title('�ز��ź�')
subplot(221);plot(t,c1);title('ͬ���ز�')
subplot(222);plot(t,c2);title('�����ز�')
subplot(223);plot(t,psk8);	title('�ѵ��ź�')
subplot(224);
plot(-fs_250M/2:fs_250M/length(psk8):fs_250M/2-fs_250M/length(psk8),fftshift(abs(fft(psk8))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('�ѵ��ź�Ƶ��ͼ')
%% ���

fs_250M=250e6;
rit_250M_de=2*psk8.*c1;
rqt_250M_de=2*psk8.*c2;
y_de7=fir1(127,1/10);
rit_250M_f=conv(rit_250M_de,y_de7,'same');
rqt_250M_f=conv(rqt_250M_de,y_de7,'same');
figure(10)
subplot(221)
plot(rit_250M_f);title('I·����ź�')
subplot(222)
plot(rqt_250M_f);title('Q·����ź�')
subplot(223)
plot(-fs_250M/2:fs_250M/length(rit_250M_f):fs_250M/2-fs_250M/length(rit_250M_f),fftshift(abs(fft(rit_250M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·����ź�Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_250M/2:fs_250M/length(rqt_250M_f):fs_250M/2-fs_250M/length(rqt_250M_f),fftshift(abs(fft(rqt_250M_f))));
xlabel('Frequency(Hz)');
title('Q·����ź�Ƶ��ͼ(��ͨ)')
%% 250M-25M, ��ֵ���Ȳ���ˣ���ȡ�����˺��

fs_25M=25e6;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
y_de7=fir1(127,1/10);
rit_250M_f1=conv(rit_250M_f,y_de7,'same');
rqt_250M_f1=conv(rqt_250M_f,y_de7,'same');

rit_25M=downsample(rit_250M_f1,10);
rqt_25M=downsample(rqt_250M_f1,10);

figure(11)
subplot(221)
plot(rit_25M);title('10����ȡi·')
subplot(222)
plot(rqt_25M);title('10����ȡq·')
subplot(223)
plot(-fs_25M/2:fs_25M/length(rit_25M):fs_25M/2-fs_25M/length(rit_25M),fftshift(abs(fft(rit_25M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_25M/2:fs_25M/length(rqt_25M):fs_25M/2-fs_25M/length(rqt_25M),fftshift(abs(fft(rqt_25M))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')
%% 25M-16M, ��ֵ���Ȳ���ˣ���ȡ�����˺��

fs_16M=16e6;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
% y_de7=fir1(127,1/10);
% rit_25M_f=conv(rit_25M,y_de7,'same');
% rqt_25M_f=conv(rqt_25M,y_de7,'same');

rit_16M=resample(rit_25M,16,25);
rqt_16M=resample(rqt_25M,16,25);

figure(12)
subplot(221)
plot(rit_16M);title('10*25/16����ȡi·')
subplot(222)
plot(rqt_16M);title('10*25/16����ȡq·')
subplot(223)
plot(-fs_16M/2:fs_16M/length(rit_16M):fs_16M/2-fs_16M/length(rit_16M),fftshift(abs(fft(rit_16M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_16M/2:fs_16M/length(rqt_16M):fs_16M/2-fs_16M/length(rqt_16M),fftshift(abs(fft(rqt_16M))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')
%% 16M-1600k, ��ֵ���Ȳ���ˣ���ȡ�����˺��

fs_1600k=1600e3;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
y_de7=fir1(127,1/10);
rit_16M_f=conv(rit_16M,y_de7,'same');
rqt_16M_f=conv(rqt_16M,y_de7,'same');

rit_1600k=downsample(rit_16M_f,10);
rqt_1600k=downsample(rqt_16M_f,10);

figure(13)
subplot(221)
plot(rit_1600k);title('10����ȡi·')
subplot(222)
plot(rqt_1600k);title('10����ȡq·')
subplot(223)
plot(-fs_1600k/2:fs_1600k/length(rit_1600k):fs_1600k/2-fs_1600k/length(rit_1600k),fftshift(abs(fft(rit_1600k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_1600k/2:fs_1600k/length(rqt_1600k):fs_1600k/2-fs_1600k/length(rqt_1600k),fftshift(abs(fft(rqt_1600k))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')
%% 1600k-160k, ��ֵ���Ȳ���ˣ���ȡ�����˺��

fs_160k=160e3;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������
y_de7=fir1(127,1/10);
rit_160k_f=conv(rit_1600k,y_de7,'same');
rqt_160k_f=conv(rqt_1600k,y_de7,'same');

rit_160k=downsample(rit_160k_f,10);
rqt_160k=downsample(rqt_160k_f,10);

figure(14)
subplot(221)
plot(rit_160k);title('10����ȡi·')
subplot(222)
plot(rqt_160k);title('10����ȡq·')
subplot(223)
plot(-fs_160k/2:fs_160k/length(rit_160k):fs_160k/2-fs_160k/length(rit_160k),fftshift(abs(fft(rit_160k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_160k/2:fs_160k/length(rqt_160k):fs_160k/2-fs_160k/length(rqt_160k),fftshift(abs(fft(rqt_160k))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')
%% 160k-16k, ��ֵ���Ȳ���ˣ���ȡ�����˺��

fs_16k=16e3;
%resampleΪ�źŽ���������������£�B=resample(x,90,250); 
% ������250Hz����90Hz�����250��ǰ,���ǲ�ֵ��90��250,���Կ�B�ĳ���,250Hz����4000�����ݵ���90hz����1440������,����ǽ�������

y_de7=fir1(127,1/10);
rit_160k_f=conv(rit_160k,y_de7,'same');
rqt_160k_f=conv(rqt_160k,y_de7,'same');

rit_16k=downsample(rit_160k_f,10);
rqt_16k=downsample(rqt_160k_f,10);

figure(15)
subplot(221)
plot(rit_16k);title('10����ȡi·')
subplot(222)
plot(rqt_16k);title('10����ȡq·')
subplot(223)
plot(-fs_16k/2:fs_16k/length(rit_16k):fs_16k/2-fs_16k/length(rit_16k),fftshift(abs(fft(rit_16k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I·Ƶ��ͼ(��ͨ)')
subplot(224)
plot(-fs_16k/2:fs_16k/length(rqt_16k):fs_16k/2-fs_16k/length(rqt_16k),fftshift(abs(fft(rqt_16k))));
xlabel('Frequency(Hz)');
title('Q·Ƶ��ͼ(��ͨ)')
%% ����ͼ

figure(16)
scatter(rit_16k,rqt_16k);
grid on
%% 8psk ���

fs_16k=16e3;
rt=[ ];
rt1=[ ];  

for m=1:length(rit_16k)/100:length(rit_16k)
    II(m) = rit_16k(m); 
    QQ(m) = rqt_16k(m);

    if II(m)<0 && QQ(m)<0 && QQ(m)<II(m)
      rt=[1 1 1];%7
       
    elseif II(m)<0 && QQ(m)<0 && QQ(m)>II(m)
     rt=[1 1 0];%6
             
	elseif II(m)>0 && QQ(m)<0 && abs(QQ(m))>II(m)
     rt=[1 0 1];%5
       
    elseif II(m)>0 && QQ(m)<0 && abs(QQ(m))<II(m)
     rt=[1 0 0];%4
       
    elseif II(m)<0 && QQ(m)>0 && abs(II(m))<QQ(m)
       rt=[0 1 1];%3
       
    elseif II(m)<0 && QQ(m)>0 && abs(II(m))>QQ(m)
       rt=[0 1 0];%2
       
    elseif II(m)>0 && QQ(m)>0 && II(m)>QQ(m)
       rt=[0 0 0];%0
       
    elseif II(m)>0 && QQ(m)>0 && II(m)<QQ(m)
       rt=[0 0 1];%1
       
    end
   rt1=[rt1 rt];
end 
figure(17),
subplot(211)
plot(rt1);title('������Ļ����ź�')%��data����Ϊ�����꣬��Ԫ�����Ϊ�����꣬��ֱ�������������ݵ㣬��������
subplot(212)
ts=0:1:length(rt1)-1;
stem(ts,rt1);title('������Ļ����ź�');
%% �������

k=0;
for i=1:length(data)
    if(data(i)==rt1(i))
        k=k;
    else
        k=k+1;
    end
end
rate1=k/length(data);
fprintf('�������=%f',rate1);