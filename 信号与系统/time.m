% MATLAB �ź���ϵͳ������һ������ ����ʱ���ź���ϵͳ��ʱ�����
% https://blog.csdn.net/weixin_34357887/article/details/86043813?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-4.no_search_link&spm=1001.2101.3001.4242.3&utm_relevant_index=7
clc;
clear
clear all;

figure(1);
t=-10:1.5:10;%ȡ�����Ƚ��٣�ͼ�λ�Ƚ�ʧ��
f=sin(t)./t;
subplot(2,2,1),plot(t,f)

t=-10:0.1:10;%ȡ�����Ƚ϶࣬ͼ�λ�ȽϽӽ�
f=sin(t)./t;
subplot(2,2,2),plot(t,f)

f=sym('sin(t)/t');%���÷��ŷ���
subplot(2,2,3),ezplot(f,[-10 10])
t=-3*pi:pi/100:3*pi;

ft=sinc(t/pi);%ֱ����malab�еĺ���
subplot(2,2,4),plot(t,ft)


% ���÷��ź��������ɵ�λ��Ծ����
t=-10:0.1:10;
f=sign(t)/2+0.5;
figure(2);
plot(t,f);
axis([-5,5,-1.2,1.2]);


%����maple�е�heaviside������ʵ��u(t+3)-2u(t)
subplot(2,2,1);
syms t
f=heaviside(t+3)-2*heaviside(t);
ezplot(f,[-3*pi,3*pi])
axis([-5,5,-1.2,1.2]);
title('u(t+3)-2u(t)');

%�����Լ���д��heaviside������ʵ��u(t+3)-2u(t)
subplot(2,2,2);
t=-5:0.01:5;
f=Heaviside(t+3)-2*Heaviside(t);
plot(t,f);
axis([-5,5,-1.2,1.2]);
title('u(t+3)-2u(t)')

%���÷��ź�����ʵ�ֵ�λ��Ծ�ź�
subplot(2,2,3);
t=-5:0.05:5;
f=sign(t);
ff=1/2+1/2*f;
plot(t,ff);
axis([-5 5 -0.1 1.1]);
title('u(t)')

%���÷��ź�����ʵ��u(t+3)-2u(t)
subplot(2,2,4);
t=-5:0.01:5;
f=(1/2+1/2*sign(t+3))-2*(1/2+1/2*sign(t));
plot(t,f),axis([-5,5,-1.2,1.2]),title('u(t+3)-2u(t)')





%ָ���źŵı�ʾy=A*exp(a*t)
figure(3);
subplot(2,4,1);
A=1;
a=-0.4;
t=0:0.01:10;
ft=A*exp(a*t);
plot(t,ft);
title('ָ���ź�')  %Ҫ����plot����
grid on

%�����ź�y=A*sin(w0*t+phi)
subplot(2,4,2);
A=1;
w0=2*pi;
phi=pi/6;
t=0:0.001:8;
ft=A*sin(w0*t+phi);
plot(t,ft);
title('�����ź�');
grid on;

%��������sinc(t)=sin(pi*t)/pi*t
subplot(2,4,3);
t=-3*pi:pi/100:3*pi;
ft=sinc(t/pi);
plot(t,ft);
title('���������ź�');
grid on;

%���������ź�y=rectpuls(t,width)����һ����ֵΪ1�����Ϊwidth�������t=0�����ҶԳƵľ��β��ź�
subplot(2,4,4);
t=0:0.001:4;
T=1;
ft=rectpuls(t-2*T,2*T);
plot(t,ft);
axis([-1 5 -0.5 1.5]);  %Ҫ����plot����
title('���������ź�');
grid on;

%�����Ծ����źż������ź�y=square(t,DUTY)����һ������Ϊ2*pi����ֵΪ1����1���������Է����źţ�duty��ʾռ�ձ�
subplot(2,3,4);
t=-0.0625:0.001:0.0625;
ft=square(2*pi*30*t,75);
plot(t,ft);
axis([-0.0625 0.0625 -1.5 1.5]);   
title('Ƶ��Ϊ30���ȵ������Է����ź�');
grid on;

%���ǲ������ź�y=tripuls(t,width,skew)���Բ���һ��������Ϊ1�����Ϊwidth��б��Ϊskew�����ǲ��źš�
%�ú����ĺ����귶Χ������t����������t=0Ϊ���������Ҹ�չ��width/2�ķ�Χ��
%б��skew�ǽ���-1��1֮���ֵ������ʾ������1��������Ӧ�ĺ�����λ�á�
%һ��أ�������1������t=(width/2)��skew�ĺ�����λ��
subplot(2,3,5);
t=-3:0.001:3;
ft=tripuls(t,4,0.5);
plot(t,ft);
axis([-3 3 -0.5 1.5]);   
title('���ǲ������ź�');
grid on;

%���������ǲ��ź�y=sawtooth(t,width)���Բ���һ������Ϊ2*pi��������Ϊ1����С����Ϊ-1�����������ǲ��źţ��ֳƾ�ݲ��źţ���
%width��ʾ�����ȳ��ֵ�λ��
subplot(2,3,6);
t=-5*pi:pi/10:5*pi;
ft=sawtooth(t,0.5);
plot(t,ft);
axis([-16 16 -1.5 1.5]);   
title('���������ǲ��ź�');
grid on;



%һ�������������ź�y=pulstran(t,d,'func',p1,p2,...)
%t�ƶ�pulstran�ĺ����귶Χ������d����ָ�������Ե�ƫ���������������ڵ����ĵ㣩
%����pulstran�����ķ���ֵʵ���Ͼ��൱��y=func(t-d(1))+func(t-d(2))+......
%p1��p2...����Ҫ���͸�func�����Ķ����������ֵ����ȥʱ�����t�⣩������rectpuls��Ҫwidth������������
figure(4);
subplot(1,2,1);
t=-0.5:0.001:1.5;
d=0:0.5:1;
y=pulstran(t,d,'rectpuls',0.1);%�����Ծ����ź�
plot(t,y);
axis([-0.1 1.1 -0.1 1.1]);
title('�����Ծ����ź�')   
grid on

%�������ǲ��ź�
subplot(1,2,2);
t=-0.2:0.001:1.2;
d=0:1/2:1;
y=pulstran(t,d,'tripuls',0.1,-1);
plot(t,y);
axis([-0.1 1.1 -0.1 1.1]);
title('���������ǲ��ź�');
grid on;




%ʵ�ַ���һ��

%fuction fexp(d,w,t1,t2,a)
%���Ƹ�ָ���ź�ʱ���γ���
%d����ָ���źŸ�Ƶ��ʵ��
%w����ָ���źŸ�Ƶ���鲿
%t1�����Ʋ��ε���ʼʱ��
%t2�����Ʋ��ε���ֹʱ��
%a����ָ���źŵķ���
figure(5);
%fexp(0,pi/4,0,15,2);

%ʵ�ַ�������
t=0:0.01:15;
a=0;b=pi/4;
z=2*exp((a+i*b)*t);
figure(6)
subplot(2,2,1),plot(t,real(z)),title('ʵ��')
subplot(2,2,3),plot(t,imag(z)),title('�鲿') 
subplot(2,2,2),plot(t,abs(z)),title('ģ')
subplot(2,2,4),plot(t,angle(z)),title('���')




figure(7);
syms t
%f=sym('(t/2+1)*(heaviside(t+2)-heaviside(t-2))')

f=(t/2+1)*(heaviside(t+2)-heaviside(t-2));
subplot(2,3,1),ezplot(f,[-3,3]),title('f(t)')

y1=subs(f,t,t+2)
subplot(2,3,2),ezplot(y1,[-5,1]),title('f(t+2)')

y2=subs(f,t,t-2)
subplot(2,3,3),ezplot(y2,[-1,5]),title('f(t-2)')

y3=subs(f,t,-t)
subplot(2,3,4),ezplot(y3,[-3,3]),title('f(-t)')

y4=subs(f,t,2*t)
subplot(2,3,5),ezplot(y4,[-2,2]),title('f(2*t)')

y5=-f
subplot(2,3,6),ezplot(y5,[-3,3]),title('-f(t)')



a=[1 5 6];
b=[3 0 2];

%�����Ӧ
figure(8)
subplot(2,2,1),impulse(b,a)
subplot(2,2,2),impulse(b,a,5) %����0��5��Χ�ڳ弤��Ӧ��ʱ����
subplot(2,2,3),impulse(b,a,1:0.1:2) %����1��2��Χ�ڣ�����Ϊ0.1�ĳ弤��Ӧ��ʱ����
y1=impulse(b,a,1:0.1:3);%������ֵ��
subplot(2,2,4),plot(1:0.1:3,y1)

%��Ծ��Ӧ
figure(9)
subplot(2,2,1),step(b,a)
subplot(2,2,2),step(b,a,5)
subplot(2,2,3),step(b,a,1:0.1:2)
y2=step(b,a,1:0.1:3);
subplot(2,2,4),plot(1:0.1:3,y2)





a=[1 3 2];
b=[1 3];
t=0:0.01:10;
x=exp(-3*t);
rc=[2,1];
sys=tf(b,a)
[A,B,C,D]=tf2ss(b,a)
figure(10)
subplot(3,1,1),initial(A,B,C,D,rc,t) %��������Ӧ
subplot(3,1,2),lsim(b,a,x,t)         %��״̬��Ӧ
subplot(3,1,3),lsim(A,B,C,D,x,t,rc)  %ȫ��Ӧ,ֻ����״̬ϵ������ʾϵͳ



%��������ʱ���źž�����ֲ��沨��
t1=-1:0.01:3;
f1=Heaviside(t1)-Heaviside(t1-2);               %�����ź� 
t2=t1;
f2=0.5*t2.*(Heaviside(t2)-Heaviside(t2-2));     %�����ź� 
[t,f]=gggfconv(f1,f2,t1,t2);                    %���������ֲ����ʱ����
















