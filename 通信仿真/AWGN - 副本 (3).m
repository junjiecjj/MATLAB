


%%  https://blog.csdn.net/xuanx86/article/details/106925955
N=10000;
z=0.1*randn(1,N); %����N(0,0.01)�ĸ�˹������
figure(1);
subplot(2,1,1);
zi=linspace(-2,2,100);
f=ksdensity(z,zi,'function','cdf');
plot(zi,f);title('���ʷֲ�����');
xlabel('x');ylabel('F(x)');

[p,zi] = ksdensity(z);
subplot(2,1,2);
plot(zi,p);title('�����ܶȺ���');
xlabel('x');ylabel('p(x)');

figure(2);
[r,lags]=xcorr(z); %����غ���
subplot(2,1,1);
plot(lags,r);title('����غ���');
xlabel('t');ylabel('R(t)');

f=fft(r);%ά�����չ�ϵ
f1=fftshift(f);%Ƶ��У��
x=(0:length(f1)-1)*200/length(f1)-100; %x����д���
y=abs(f1);
subplot(2,1,2);
plot(x,y);title('�������ܶ�');
xlabel('x');ylabel('P(x)');