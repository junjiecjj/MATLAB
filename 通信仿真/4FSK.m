% 多进制数字幅度调制 MASK
% 本例 M=4
N=20;
f=2;
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
for i=1:N/2                      % M=4，设置 4 种取值情况
   temp=rand;
   if(temp<0.25)
       ak(i)=0;bk(i)=0;
   elseif(temp<0.5)
       ak(i)=0;bk(i)=1;
   elseif(temp<0.75)
       ak(i)=1;bk(i)=1;
    else
       ak(i)=1;bk(i)=0;
    end
end
for i=1:N/2                      % 根据 4 种取值情况 进去对应取值
   if((ak(i)==0))&(bk(i)==0)
       m=zeros(1,100);
   elseif((ak(i)==0))&(bk(i)==1)
       m=ones(1,100);
   elseif((ak(i)==1))&(bk(i)==0)
       m=2*ones(1,100);
    else
       m=3*ones(1,100);
    end
   c=sin(f*t);
    m1=[m1 m];
    c1=[c1 c];
end
ask=c1.*m1;
subplot(211);      % 绘制图形
plot(m1)
title (' 随机产生数字信号 ');
axis([0 50*N -0.1 4]);
subplot(212);
plot(ask)
title ('4ASK 信号 ');
axis([0 50*N -4 4]);

================================================

% 多进制数字频率调制 MFSK
% 本例 M=4
N=20; f1=1; f2=2; f3=3; f4=4;
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
b1=[];
for i=1:N/2      % 根据 4FSK 取 4 种不同情况
   temp=rand;
   if(temp<0.25)
       ak(i)=0;bk(i)=0;
   elseif(temp<0.5)
       ak(i)=0;bk(i)=1;
   elseif(temp<0.75)
       ak(i)=1;bk(i)=1;
    else
       ak(i)=1;bk(i)=0;
    end
end
for i=1:N/2      % 对应 4 种情况分别取值为 0、1、2、3
   if((ak(i)==0))&(bk(i)==0)
       m=ones(1,100);
       c=sin(f1*t);
       b=zeros(1,100);
   elseif((ak(i)==0))&(bk(i)==1)
       m=ones(1,100);
       c=sin(f2*t);
       b=ones(1,100);
   elseif((ak(i)==1))&(bk(i)==0)
       m=ones(1,100);
       c=sin(f3*t);
       b=2*ones(1,100);
    else
       m=ones(1,100);
       c=sin(f4*t);
       b=3*ones(1,100);
    end
    m1=[m1 m];
    c1=[c1 c];
    b1=[b1 b];
end
fsk=c1.*m1;
subplot(211);       % 绘制波形
plot(b1)
title (' 随机产生 4 进制数字序列 ');
axis([0 50*N -0.1 4]);
subplot(212);
plot(fsk)
title ('4FSK 信号 ');
axis([0 50*N -1.1 1.1]);