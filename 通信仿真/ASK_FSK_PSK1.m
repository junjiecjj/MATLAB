function askdigital(s,f)
% ������ʵ�ֽ������һ�ζ����ƴ�����Ƴ���Ӧ�� ASK �ź����
% s Ϊ����������룬f Ϊ�ز�Ƶ�ʣ�ASK Ϊ���ƺ�����ź�
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
title (' �����������ź� ');
axis([0 100*length(s) -0.1 1.1]);
subplot(212);
plot(ask);
title ('ASK �ź� ');
==============================================

>> s=[1 0 1 0 1 1 0 0 1 0];
>> f=2;
>> askdigital(s,f)

==============================================

function fskdigital(s,f1,f2)
% ������ʵ�ֽ������һ�ζ����ƴ�����Ƴ���Ӧ�� FSK �ź����
% s Ϊ��������ƴ��룬f1,f2 �ֱ�Ϊ���� 0��1 ��Ӧ���ز�Ƶ�ʣ�fsk Ϊ���ƺ�����ź�
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
title (' �����������ź� ');
axis([0 100*length(s) -0.1 1.1]);
grid on;
subplot(212);
plot(fsk)
title ('2FSK �ź� ');
grid on;
=============================================

>> s=[1 0 1 0 1 1 0 0 1 0];
>> f1=100;f2=400;
>> fskdigital(s,f1,f2)
=============================================

function pskdigital(s ,f)
% ������ʵ�ֽ������һ�ζ����ƴ�����Ƴ���Ӧ�� PSK �ź����
% s Ϊ��������ƴ��룬f Ϊ�ز�Ƶ�ʣ�psk Ϊ���ƺ�����ź�
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
title (' �����������ź� ');
axis([0 100*length(s) -0.2 1.1]);
subplot(212);
plot(psk);
title ('PSK �ź� ');
grid on;

% http://blog.sina.com.cn/s/blog_59a069d50100x1wb.html
% >> s=[1 0 1 0 1 1 0 0 1 0];
% >> f=100;
% >> pskdigital(s,f)