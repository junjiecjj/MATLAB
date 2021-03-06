% 文件名 ex3_12.m
% 2015-4-10 产生码元宽度为 64 的随机序列
% 徐明远 - MATLAB 仿真在信号处理中的应用
% p92 【例 3-12】
% http://blog.sina.com.cn/s/blog_59a069d50102vn3p.html
n=1:8192;
m=1:128; x(n)=randint(1,8192,2); x=[x(n)]';
y(n)=zeros(1,8192); z(m)=zeros(1,128);
for n=1:8192
    for m=1:128
       if n==64*m-63
           z(m)=x(n);
           if m==ceil(n/64)
               y([(64*m-63):(64*m)]')=z(m);
           end
       end
    end
end
n=1:8192;
rm2=y (n); % 产生 rm2 数组

% =======================================

% 2015-4-10
% 应用码元宽度为 64 的随机序列作基带信号，对 1GHz 的载波频率作 ASK 调制，绘出
% 基带信号及其已调信号的频谱。
% 徐明远 - MATLAB 仿真在信号处理中的应用
% p93 【例 3-13】

n=[1:(2^13)];
x1=cos(n.*1e9*2*pi/4e9);
run('rm2');
X2=rm2; x2=X2';
x=x1.*X2;
b=.42+.5*cos(2*pi*(n-(2^12))/(2^13))+.08*cos(4*pi*(n-(2^12))/(2^13));
X=b.*x; x3=[ones(1,64) zeros(1,8128)];
y1=X(1:(2^13));y4=x1.* x3;
Y1=fft(y1,(2^13)); magY1=abs(Y1(1:1:(2^12)+1))/(200);
Y4=fft(y4,(2^13)); magY4=abs(Y4(1:1:(2^12)+1))/(40);
k1=0:(2^12); w1=(2 * pi/(2^13)) * k1;
u=(2*w1/pi)*1e9;
figure(1)
subplot(2,1,1);
plot(u,magY1,'b',u,magY4,'r');grid
title ('ASK 信号 频谱 ');axis ([4e8,1.6e9,0,1.1])
X2=b.* X2;
y2=X2(1:(2^13));
Y2=fft(y2,(2^13)); magY2=abs(Y2(1:1:(2^12)+1))/(200);
k1=0:(2^12);w1=(2*pi/(2^13))*k1;
u=(2*w1/pi)*1e9;
Y3=fft(x3,(2^13)); magY3=abs(Y3(1:1:(2^12)+1))/(40);
subplot(2,1,2);
semilogy(u,magY2,'b',u,magY3,'r'); grid
title (' 调制信号 频谱 '); axis ([0,1.2e9,3e-4,3])
figure(2)
subplot(2,1,1); plot(n,x2);
title (' 调制信号 ');axis ([0,720,-0.2,1.2])
subplot(2,1,2); plot(n,x);
title ('ASK 信号 ');axis ([0,720,-1.2,1.2])

% ==========================================