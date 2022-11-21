% https://codeantenna.com/a/DMj34DPq5o

clear;
clc;
close all;

t = -1:0.001:1;
f = 1;
figure(1);
y = cos(2*pi*2*f*t);
subplot(1,2,1);plot(t,y);
y = sin(2*pi*2*f*t);
subplot(1,2,2);plot(t,y);


% �����ź�
figure(2);
subplot(3,2,1);
t=0:0.001:8;
d=[0 0; 0.5 1; 1 1; 1.5 0; 2 1; 2.5 1; 3 0; 3.5 0; 4 0; 4.5 1; 5 1; 5.5 0; 6 1; 6.5 1; 7 0; 7.5 0];
s=pulstran(t-0.25,d,'rectpuls',0.5);
plot(t,s) ;
title('ԭʼ������','FontSize',9)  
%xlabel('t(s)');
ylabel('ԭʼ����','fontsize',9);
axis([0 8 -0.5 1.5]);
text(0.25,1.2,'0') ; text(0.75,1.2,'1') ; text(1.25,1.2,'1') ; text(1.75,1.2,'0') ;
text(2.25,1.2,'1') ; text(2.75,1.2,'1') ; text(3.25,1.2,'0') ; text(3.75,1.2,'0') ;
text(4.25,1.2,'0') ; text(4.75,1.2,'1') ; text(5.25,1.2,'1') ; text(5.75,1.2,'0') ;
text(6.25,1.2,'1') ; text(6.75,1.2,'1') ; text(7.25,1.2,'0') ; text(7.75,1.2,'0') ;


% I ·�ź�
a =1/sqrt(2);
subplot(3,2,3);
d1=[0 -a ;1 +a; 2 -a; 3 +a; 4 -a; 5 +a;6 -a;7 +a];
s1=pulstran(t-0.5,d1,'rectpuls');
plot(t,s1) ;
title('I ·�ź�','FontSize',9)  
%xlabel('t(s)');
ylabel('I ·','fontsize',9);
axis([0 8 -2 2]);
text(0.5,1.5,'-0.7') ; text(1.5,1.5,'+0.7') ;text(2.5,1.5,'-0.7') ;text(3.5,1.5,'+0.7');
text(4.5,1.5,'-0.7') ; text(5.5,1.5,'+0.7') ;text(6.5,1.5,'-0.7') ;text(7.5,1.5,'+0.7');

% Q ·�ź�
subplot(3,2,5);
d2=[0 +a; 1 -a; 2 -a; 3 +a; 4 +a; 5 -a; 6 -a; 7 +a];
s2=pulstran(t-0.5, d2, 'rectpuls');
plot(t,s2) ;
title('Q·�ź�','FontSize',9)  
xlabel('t(s)');
ylabel('Q·','fontsize',9);
axis([0 8 -2 2]);
text(0.5,1.5,'+0.7') ; text(1.5,1.5,'-0.7') ; text(2.5,1.5,'-0.7') ; text(3.5,1.5,'+0.7')
text(4.5,1.5,'+0.7') ; text(5.5,1.5,'-0.7') ; text(6.5,1.5,'-0.7') ; text(7.5,1.5,'+0.7')



%QPSK �����ź�
subplot(3,2,6);
d3 = [0 -a ; 1 +a; 2 -a; 3 +a; 4 -a ; 5 +a; 6 -a; 7 +a];
s3 = pulstran(t-0.5,d3,'rectpuls').*cos(2*pi*5*t) ;
d4 = [0 +a; 1 -a; 2 -a; 3 +a; 4 +a; 5 -a; 6 -a; 7 +a];
s4=pulstran(t-0.5,d4,'rectpuls').*sin(2*pi*5*t);
plot(t,s3-s4) ;
title('QPSK�����ź�','FontSize',9)  
xlabel('t(s)');
ylabel('QPSK����','fontsize',9);
axis([0 8 -2 2]);
text(0.3,1.5,'3\pi/4') ; text(1.3,1.5, '7\pi/4') ; text(2.3,1.5,'5\pi/4') ; text(3.3,1.5,'\pi/4') ;
text(4.3,1.5, '3\pi/4') ; text(5.3,1.5, '7\pi/4') ; text(6.3,1.5,'5\pi/4') ; text(7.3,1.5,'\pi/4') ;



subplot(3,2,2);
plot(t,s3) ;
title('I*cos()','FontSize',9)  
xlabel('t(s)');
ylabel('I*cos()','fontsize',9);

subplot(3,2,4);
plot(t,-s4) ;
title('Q*sin()','FontSize',9)  
xlabel('t(s)');
ylabel('I*sin()','fontsize',9);
