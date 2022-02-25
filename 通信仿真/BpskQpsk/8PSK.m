
% https://zhuanlan.zhihu.com/p/47258287
clc
clear all
close all
Fc=700e6;%Fc载波频率

data_num=300;
data = randint(1,data_num); %产生1行300列的矩阵，元数为0-1之间的随机数，包括0和1
figure(1)
subplot(211)
plot(data);title('原始基带信号')%以data分量为纵坐标，以元素序号为横坐标，用直线依次连接数据点，绘制曲线
ts=0:1:length(data)-1;
subplot(212)
stem(ts,data);title('原始基带信号');%“有时间向量的话，序列是冲激”

fs_16k=16e3;%假设最开始采样频率是16e3
it=[];qt=[];
sit=[];sqt=[];
for i=1:3:length(data)
    I(i) = data(i); 
    Q(i+1) = data(i+1);
    U(i+2) = data(i+2);   
    if I(i)==0 && Q(i+1)==0 && U(i+2)==0
        it=0.924*ones(1,1);%1行1列的全为1的矩阵
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
end %映射
figure(2)
subplot(221)
plot(sit);title('i路信号')
subplot(222)
plot(sqt);title('q路信号')
subplot(223)
plot(-fs_16k/2:fs_16k/length(sit):fs_16k/2-fs_16k/length(sit),fftshift(abs(fft(sit))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图')
subplot(224)
plot(-fs_16k/2:fs_16k/length(sqt):fs_16k/2-fs_16k/length(sqt),fftshift(abs(fft(sqt))));
xlabel('Frequency(Hz)');
title('Q路频谱图')

figure(3)
scatter(sit,sqt);%星座图
grid on


%% 提高采样频率 16k-160k,(插值：先插后滤，抽取：先抽后滤)

fs_160k=160e3;
sit_160k=upsample(sit,10);
sqt_160k=upsample(sqt,10);

beta=0.4;%r=0时是矩形
span=length(sit_160k);
sps=10;
h = rcosdesign(beta,span,sps);
sit_160k_f=conv(sit_160k,h,'same');
sqt_160k_f=conv(sqt_160k,h,'same');

figure(4)
subplot(221)
plot(sit_160k_f);title('10倍插值i路')
subplot(222)
plot(sqt_160k_f);title('10倍插值q路')
subplot(223)
plot(-fs_160k/2:fs_160k/length(sit_160k_f):fs_160k/2-fs_160k/length(sit_160k_f),fftshift(abs(fft(sit_160k_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(升余弦)')
subplot(224)
plot(-fs_160k/2:fs_160k/length(sqt_160k_f):fs_160k/2-fs_160k/length(sqt_160k_f),fftshift(abs(fft(sqt_160k_f))));
xlabel('Frequency(Hz)');
title('Q路频谱图(升余弦)')


%% 160k-1600k, 插值：先插后滤，抽取：先抽后滤

fs_1600k=1600e3;
sit_1600k=upsample(sit_160k_f,10);
sqt_1600k=upsample(sqt_160k_f,10);

y_de7=fir1(127,1/10);
sit_1600k_f=conv(sit_1600k,y_de7,'same');
sqt_1600k_f=conv(sqt_1600k,y_de7,'same');

figure(5)
subplot(221)
plot(sit_1600k_f);title('100倍插值i路')
subplot(222)
plot(sqt_1600k_f);title('100倍插值q路')
subplot(223)
plot(-fs_1600k/2:fs_1600k/length(sit_1600k_f):fs_1600k/2-fs_1600k/length(sit_1600k_f),fftshift(abs(fft(sit_1600k_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_1600k/2:fs_1600k/length(sqt_1600k_f):fs_1600k/2-fs_1600k/length(sqt_1600k_f),fftshift(abs(fft(sqt_1600k_f))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)');

%% 1600k-16M, 插值：先插后滤，抽取：先抽后滤

fs_16M=16e6;
sit_16M=upsample(sit_1600k_f,10);
sqt_16M=upsample(sqt_1600k_f,10);

y_de7=fir1(127,1/10);
sit_16M_f=conv(sit_16M,y_de7,'same');
sqt_16M_f=conv(sqt_16M,y_de7,'same');

figure(6)
subplot(221)
plot(sit_16M_f);title('1000倍插值i路')
subplot(222)
plot(sqt_16M_f);title('1000倍插值q路')
subplot(223)
plot(-fs_16M/2:fs_16M/length(sit_16M_f):fs_16M/2-fs_16M/length(sit_16M_f),fftshift(abs(fft(sit_16M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_16M/2:fs_16M/length(sqt_16M_f):fs_16M/2-fs_16M/length(sqt_16M_f),fftshift(abs(fft(sqt_16M_f))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)');

%% 16M-25M, 由于原始采样频率与信道传输需要的采样频率不一致，故需要变频。

fs_25M=25e6;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
sit_25M=resample(sit_16M_f,25,16);
sqt_25M=resample(sqt_16M_f,25,16);

figure(7)
subplot(221)
plot(sit_25M);title('25/16倍插值i路')
subplot(222)
plot(sqt_25M);title('25/16倍插值q路')
subplot(223)
plot(-fs_25M/2:fs_25M/length(sit_25M):fs_25M/2-fs_25M/length(sit_25M),fftshift(abs(fft(sit_25M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_25M/2:fs_25M/length(sqt_25M):fs_25M/2-fs_25M/length(sqt_25M),fftshift(abs(fft(sqt_25M))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')

%% 25M-250M

fs_250M=250e6;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
sit_250M=upsample(sit_25M,10);
sqt_250M=upsample(sqt_25M,10);

y_de7=fir1(127,1/10);
sit_250M_f=conv(sit_250M,y_de7,'same');
sqt_250M_f=conv(sqt_250M,y_de7,'same');

figure(8)
subplot(221)
plot(sit_250M_f);title('10倍插值i路')
subplot(222)
plot(sqt_250M_f);title('10倍插值q路')
subplot(223)
plot(-fs_250M/2:fs_250M/length(sit_250M_f):fs_250M/2-fs_250M/length(sit_250M_f),fftshift(abs(fft(sit_250M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_250M/2:fs_250M/length(sqt_250M_f):fs_250M/2-fs_250M/length(sqt_250M_f),fftshift(abs(fft(sqt_250M_f))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')

%% 带通调制

fs_250M=250e6;
T=length(sqt_250M_f);%T=
t=0 : 1/fs_250M :T/fs_250M - 1/fs_250M;%fs = 100
% c=exp(j*2*pi*Fc*t);	%载波信号,Fc=70e6
c1=cos(2*pi*Fc*t);	%同相载波
c2=-sin(2*pi*Fc*t);	%正交载波	
psk8 = sit_250M_f.*c1 + sqt_250M_f.*c2;
figure(9),
% subplot(221);plot(t,c);title('载波信号')
subplot(221);plot(t,c1);title('同相载波')
subplot(222);plot(t,c2);title('正交载波')
subplot(223);plot(t,psk8);	title('已调信号')
subplot(224);
plot(-fs_250M/2:fs_250M/length(psk8):fs_250M/2-fs_250M/length(psk8),fftshift(abs(fft(psk8))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('已调信号频谱图')
%% 解调

fs_250M=250e6;
rit_250M_de=2*psk8.*c1;
rqt_250M_de=2*psk8.*c2;
y_de7=fir1(127,1/10);
rit_250M_f=conv(rit_250M_de,y_de7,'same');
rqt_250M_f=conv(rqt_250M_de,y_de7,'same');
figure(10)
subplot(221)
plot(rit_250M_f);title('I路解调信号')
subplot(222)
plot(rqt_250M_f);title('Q路解调信号')
subplot(223)
plot(-fs_250M/2:fs_250M/length(rit_250M_f):fs_250M/2-fs_250M/length(rit_250M_f),fftshift(abs(fft(rit_250M_f))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路解调信号频谱图(低通)')
subplot(224)
plot(-fs_250M/2:fs_250M/length(rqt_250M_f):fs_250M/2-fs_250M/length(rqt_250M_f),fftshift(abs(fft(rqt_250M_f))));
xlabel('Frequency(Hz)');
title('Q路解调信号频谱图(低通)')
%% 250M-25M, 插值：先插后滤，抽取：先滤后抽

fs_25M=25e6;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
y_de7=fir1(127,1/10);
rit_250M_f1=conv(rit_250M_f,y_de7,'same');
rqt_250M_f1=conv(rqt_250M_f,y_de7,'same');

rit_25M=downsample(rit_250M_f1,10);
rqt_25M=downsample(rqt_250M_f1,10);

figure(11)
subplot(221)
plot(rit_25M);title('10倍抽取i路')
subplot(222)
plot(rqt_25M);title('10倍抽取q路')
subplot(223)
plot(-fs_25M/2:fs_25M/length(rit_25M):fs_25M/2-fs_25M/length(rit_25M),fftshift(abs(fft(rit_25M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_25M/2:fs_25M/length(rqt_25M):fs_25M/2-fs_25M/length(rqt_25M),fftshift(abs(fft(rqt_25M))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')
%% 25M-16M, 插值：先插后滤，抽取：先滤后抽

fs_16M=16e6;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
% y_de7=fir1(127,1/10);
% rit_25M_f=conv(rit_25M,y_de7,'same');
% rqt_25M_f=conv(rqt_25M,y_de7,'same');

rit_16M=resample(rit_25M,16,25);
rqt_16M=resample(rqt_25M,16,25);

figure(12)
subplot(221)
plot(rit_16M);title('10*25/16倍抽取i路')
subplot(222)
plot(rqt_16M);title('10*25/16倍抽取q路')
subplot(223)
plot(-fs_16M/2:fs_16M/length(rit_16M):fs_16M/2-fs_16M/length(rit_16M),fftshift(abs(fft(rit_16M))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_16M/2:fs_16M/length(rqt_16M):fs_16M/2-fs_16M/length(rqt_16M),fftshift(abs(fft(rqt_16M))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')
%% 16M-1600k, 插值：先插后滤，抽取：先滤后抽

fs_1600k=1600e3;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
y_de7=fir1(127,1/10);
rit_16M_f=conv(rit_16M,y_de7,'same');
rqt_16M_f=conv(rqt_16M,y_de7,'same');

rit_1600k=downsample(rit_16M_f,10);
rqt_1600k=downsample(rqt_16M_f,10);

figure(13)
subplot(221)
plot(rit_1600k);title('10倍抽取i路')
subplot(222)
plot(rqt_1600k);title('10倍抽取q路')
subplot(223)
plot(-fs_1600k/2:fs_1600k/length(rit_1600k):fs_1600k/2-fs_1600k/length(rit_1600k),fftshift(abs(fft(rit_1600k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_1600k/2:fs_1600k/length(rqt_1600k):fs_1600k/2-fs_1600k/length(rqt_1600k),fftshift(abs(fft(rqt_1600k))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')
%% 1600k-160k, 插值：先插后滤，抽取：先滤后抽

fs_160k=160e3;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。
y_de7=fir1(127,1/10);
rit_160k_f=conv(rit_1600k,y_de7,'same');
rqt_160k_f=conv(rqt_1600k,y_de7,'same');

rit_160k=downsample(rit_160k_f,10);
rqt_160k=downsample(rqt_160k_f,10);

figure(14)
subplot(221)
plot(rit_160k);title('10倍抽取i路')
subplot(222)
plot(rqt_160k);title('10倍抽取q路')
subplot(223)
plot(-fs_160k/2:fs_160k/length(rit_160k):fs_160k/2-fs_160k/length(rit_160k),fftshift(abs(fft(rit_160k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_160k/2:fs_160k/length(rqt_160k):fs_160k/2-fs_160k/length(rqt_160k),fftshift(abs(fft(rqt_160k))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')
%% 160k-16k, 插值：先插后滤，抽取：先滤后抽

fs_16k=16e3;
%resample为信号降采样处理，理解如下：B=resample(x,90,250); 
% 采样从250Hz降到90Hz，如果250在前,就是插值从90到250,可以看B的长度,250Hz采样4000个数据等于90hz采样1440个数据,这就是降采样。

y_de7=fir1(127,1/10);
rit_160k_f=conv(rit_160k,y_de7,'same');
rqt_160k_f=conv(rqt_160k,y_de7,'same');

rit_16k=downsample(rit_160k_f,10);
rqt_16k=downsample(rqt_160k_f,10);

figure(15)
subplot(221)
plot(rit_16k);title('10倍抽取i路')
subplot(222)
plot(rqt_16k);title('10倍抽取q路')
subplot(223)
plot(-fs_16k/2:fs_16k/length(rit_16k):fs_16k/2-fs_16k/length(rit_16k),fftshift(abs(fft(rit_16k))));
xlabel('Frequency(Hz)');
ylabel('Amp');
title('I路频谱图(低通)')
subplot(224)
plot(-fs_16k/2:fs_16k/length(rqt_16k):fs_16k/2-fs_16k/length(rqt_16k),fftshift(abs(fft(rqt_16k))));
xlabel('Frequency(Hz)');
title('Q路频谱图(低通)')
%% 星座图

figure(16)
scatter(rit_16k,rqt_16k);
grid on
%% 8psk 解调

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
plot(rt1);title('解调出的基带信号')%以data分量为纵坐标，以元素序号为横坐标，用直线依次连接数据点，绘制曲线
subplot(212)
ts=0:1:length(rt1)-1;
stem(ts,rt1);title('解调出的基带信号');
%% 误比特率

k=0;
for i=1:length(data)
    if(data(i)==rt1(i))
        k=k;
    else
        k=k+1;
    end
end
rate1=k/length(data);
fprintf('误比特率=%f',rate1);