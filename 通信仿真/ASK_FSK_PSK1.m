function askdigital(s,f)
% 本函数实现将输入的一段二进制代码调制成相应的 ASK 信号输出
% s 为输入二进制码，f 为载波频率，ASK 为调制后输出信号
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
for n=1:length(s)
    if s(n)==0
       m=zeros(1,100);
    else s(n)==1;
       m=ones(1,100);
    end
   c=sin(f*t);
    m1=[m1 m];
    c1=[c1 c]
end
ask=c1.*m1;
subplot(211);
plot(m1)
title (' 二进制数字信号 ');
axis([0 100*length(s) -0.1 1.1]);
subplot(212);
plot(ask);
title ('ASK 信号 ');
==============================================

>> s=[1 0 1 0 1 1 0 0 1 0];
>> f=2;
>> askdigital(s,f)

==============================================

function fskdigital(s,f1,f2)
% 本函数实现将输入的一段二进制代码调制成相应的 FSK 信号输出
% s 为输入二进制代码，f1,f2 分别为代码 0、1 对应的载波频率，fsk 为调制后输出信号
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
b1=[];
for n=1:length(s)
    if s(n)==0;
       m=ones(1,100);
       c=sin(f2*t);
       b=zeros(1,100)
    else s(n)==1;
       m=ones(1,100);
       c=sin(f1*t);
       b=ones(1,100)
    end
    m1=[m1 m];
    c1=[c1 c];
    b1=[b1 b];
end
fsk=c1.*m1;
subplot(211);
plot(b1)
title (' 二进制数字信号 ');
axis([0 100*length(s) -0.1 1.1]);
grid on;
subplot(212);
plot(fsk)
title ('2FSK 信号 ');
grid on;
=============================================

>> s=[1 0 1 0 1 1 0 0 1 0];
>> f1=100;f2=400;
>> fskdigital(s,f1,f2)
=============================================

function pskdigital(s ,f)
% 本函数实现将输入的一段二进制代码调制成相应的 PSK 信号输出
% s 为输入二进制代码，f 为载波频率，psk 为调制后输出信号
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
b1=[];
for n=1:length(s)
    if s(n)==0;
       m=-ones(1,100);
       b=zeros(1,100)
    else s(n)==1;
       m=ones(1,100);
       b=ones(1,100)
    end
   c=sin(f*t);
    m1=[m1 m];
    c1=[c1 c];
    b1=[b1 b];
end
psk=c1.*m1;
subplot(211);
plot(b1);
title (' 二进制数字信号 ');
axis([0 100*length(s) -0.2 1.1]);
subplot(212);
plot(psk);
title ('PSK 信号 ');
grid on;

% http://blog.sina.com.cn/s/blog_59a069d50100x1wb.html
% >> s=[1 0 1 0 1 1 0 0 1 0];
% >> f=100;
% >> pskdigital(s,f)