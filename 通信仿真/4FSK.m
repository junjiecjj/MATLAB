% ��������ַ��ȵ��� MASK
% ���� M=4
N=20;
f=2;
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
for i=1:N/2                      % M=4������ 4 ��ȡֵ���
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
for i=1:N/2                      % ���� 4 ��ȡֵ��� ��ȥ��Ӧȡֵ
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
subplot(211);      % ����ͼ��
plot(m1)
title (' ������������ź� ');
axis([0 50*N -0.1 4]);
subplot(212);
plot(ask)
title ('4ASK �ź� ');
axis([0 50*N -4 4]);

================================================

% ���������Ƶ�ʵ��� MFSK
% ���� M=4
N=20; f1=1; f2=2; f3=3; f4=4;
t=0:2*pi/99:2*pi;
m1=[];
c1=[];
b1=[];
for i=1:N/2      % ���� 4FSK ȡ 4 �ֲ�ͬ���
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
for i=1:N/2      % ��Ӧ 4 ������ֱ�ȡֵΪ 0��1��2��3
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
subplot(211);       % ���Ʋ���
plot(b1)
title (' ������� 4 ������������ ');
axis([0 50*N -0.1 4]);
subplot(212);
plot(fsk)
title ('4FSK �ź� ');
axis([0 50*N -1.1 1.1]);