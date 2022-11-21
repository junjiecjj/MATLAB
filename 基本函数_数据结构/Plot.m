close all;
clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 ����ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X1 = (0:12)*pi/6;     Y1 = cos(3*X1);
X2 = (0:360)*pi/180;  Y2 = cos(3*X2);
figure(1)
grid on;
subplot(2,3,1); plot(X1,Y1,'o', 'MarkerSize', 3,'color','g');xlim([0 2*pi]);xlabel('X');ylabel('Y');grid on;title('��ͼ1');
subplot(2,3,2); plot(X1,Y1,'-', 'MarkerSize', 3,'color','m','LineWidth',2);xlim([0 2*pi]);xlabel('X');ylabel('Y');xlim([0 2*pi]);grid on;title('��ͼ2');
subplot(2,3,3); plot(X1,Y1,':', 'MarkerSize', 3,'color','b','LineWidth',2);xlim([0 2*pi]);xlabel('X');ylabel('Y');xlim([0 2*pi]);grid on;title('��ͼ3');
subplot(2,3,4); plot(X2,Y2,'--', 'MarkerSize', 3,'color','k');xlabel('X');xlim([0 2*pi]);xlabel('X');ylabel('Y');  grid on;title('��ͼ4');
subplot(2,3,5); plot(X2,Y2,'.-', 'MarkerSize', 3,'color','b');xlabel('X');xlim([0 2*pi]);xlabel('X');ylabel('Y');title('��ͼ5');
subplot(2,3,6); plot(X2,Y2,'-.', 'MarkerSize', 3,'color','y');xlabel('X');xlim([0 2*pi]);xlabel('X');ylabel('Y');title('��ͼ6');
box on; axis tight;


%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 legend %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)

X1 = 0:0.1:2*pi;
Y1 = sin(X1);
Y2 = cos(X2);
plot(X1,Y1,'r:*',X2,Y2,'c.-');xlim([0 8]);ylim([-1 1.2]);xlabel('\fontname{Roman}{X�᷽������}');ylabel('Y�᷽������');zlabel('Z�᷽������');title('����2');hold on;
box on; axis tight;text(3,0.8,'ͼ������');

%ͨ��ʹ����꣬�ƶ�ͼ�δ����е�ʮ�ֹ�꣬���û����ַ���text������ͼ�δ�����;
%gtext('ͼ������1');

%�ڵ�ǰͼ�����ͼ��������˵���Ե��ַ���str1/str2����Ϊ��ע��pos���£�
%North,South,East,West,NorthEast,NorthEast,SouthWest,NorthOutside,BestOutside;
legend('\fontname{����}\fontsize{12}\bf{\alpha^2+\Pi^3+\propto^#}','\fontname{Roman}\fontsize{12}\rm{x^5+2x^4+3}','Location','BestOutside');
%legendoff;


%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 ˫y�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)

ang1 = 0 : 0.01*pi : 2*pi;
amp1 = sin(0 : 0.01*pi : 2*pi);
z = amp1.*(cos(ang1) + sqrt(-1)*sin(ang1));
[AX,H1,H2] = plotyy(0:200, abs(z), 0:200, angle(z)*180/pi);
set(get(AX(1),'Ylabel'), 'String', '\fontname{����}\fontsize{12}\bf{����}');
set(get(AX(2),'Ylabel'), 'String', '\fontname{����}\fontsize{12}\bf{��λ}');
set(H1,'LineWidth',2);
set(H2,'LineStyle',':','LineWidth',2);
%�ڵ�ǰͼ�����ͼ��������˵���Ե��ַ���str1/str2����Ϊ��ע��pos���£�
%North,South,East,West,NorthEast,NorthEast,SouthWest,NorthOutside,BestOutside;
%legend('\fontname{����}\fontsize{12}\bf{\alpha^2+\Pi^3+\propto^#}','\fontname{Roman}\fontsize{12}\rm{x^5+2x^4+3}','Location','BestOutside');
%legendoff;

%%%%%%%%%%%%%%%%%%%%%%%%%%% 4  ˫y�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)

x = 10.^(0.1:0.1:4);
y = 1./(x+1000);
subplot(1,2,1);semilogx(x,y,'+','MarkerSize',5,'LineWidth',2);title('y(x+1000)^{-1}');xlabel('X');ylabel('Y');grid on;title('��ͼ1');
subplot(1,2,2);plot(x,y,'+','MarkerSize',5,'LineWidth',2);title('y(x+1000)^{-1}');xlabel('X');ylabel('Y');grid on;title('��ͼ2');


%�ڵ�ǰͼ�����ͼ��������˵���Ե��ַ���str1/str2����Ϊ��ע��pos���£�
%North,South,East,West,NorthEast,NorthEast,SouthWest,NorthOutside,BestOutside;
%legend('\fontname{����}\fontsize{12}\bf{\alpha^2+\Pi^3+\propto^#}','\fontname{Roman}\fontsize{12}\rm{x^5+2x^4+3}','Location','BestOutside');
%legendoff;

%%%%%%%%%%%%%%%%%%%%%%%%%%% 5 ����ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y = [75.995  91.972 105.711 123.203 131.669 ...
    150.797 179.323 203.212 226.505 249.633 281.422];

figure(5);
bar(y);xlabel('X');ylabel('Y');grid on;title('ͼ5');legend('hehe');

%%%%%%%%%%%%%%%%%%%%%%%%%%% 6  ��״ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6);
x = [1 5 0.5 3.5 2];
explode = [0 1  0 0 0];
pie(x,explode);xlabel('X');ylabel('Y');grid on;title('��״ͼ');legend('��״');
%pie3(x,explode);
colormap hsv;

%%%%%%%%%%%%%%%%%%%%%%%%%%% 7  ֱ��ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(7);
x = -4:0.1:4;
y = randn(5000,1);
hist(y,x);xlabel('X');ylabel('Y');grid on;title('ֱ��ͼ');legend('ֱ��');

%%%%%%%%%%%%%%%%%%%%%%%%%%% 8 ɢ��ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(8);
x = [1 5 6 7 9 5 1 3 12 20];
y = [20 15 6 3 1 5 3 0 1 5];
subplot(121);scatter(x,y);xlabel('X');ylabel('Y');grid on;title('ɢ��ͼ');legend('ɢ��ͼ1');
subplot(122);scatter(x,y,[],[1,0,0],'fill');xlabel('X');ylabel('Y');grid on;title('ɢ��ͼ');legend('ɢ��ͼ2');


%%%%%%%%%%%%%%%%%%%%%%%%%%% 9 ��άͼ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(9);
theta = 0 : 0.01*pi : 2*pi;
x = sin(theta);
y = cos(theta);
z = cos(4*theta);
plot3(x,y,z,'LineWidth',2);hold on;

theta = 0 : 0.02*pi : 2*pi;
x = sin(theta);
y = cos(theta);
z = cos(4*theta);
plot3(x,y,z,'rd','MarkerSize',10,'LineWidth',2);hold on;xlabel('X');ylabel('Y');zlabel('Z');grid on;title('��ά');legend('��ά1');


%%%%%%%%%%%%%%%%%%%%%%%%%%% 10 ��ά����ͼ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(10);
X = -10 : 0.1 : 10;
Y = -10 : 0.1 : 10;
[X,Y] = meshgrid(X,Y);
Z = -X.^2 - Y.^2 +200;
mesh(X,Y,X);
xlabel('X');ylabel('Y');zlabel('Z');grid on;title('��ά2');legend('��ά22');


%%%%%%%%%%%%%%%%%%%%%%%%%%% 11 ��ά����ͼ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig(11) = figure(11);
[x,y,z] = peaks(35);
R= sqrt(x.^2 + y.^2);
surf(x,y,z);
mesh(x,y,z);
xlabel('X');ylabel('Y');zlabel('Z');grid on;title('��ά����ͼ');legend('��ά����ͼ');

%%%%%%%%%%%%%%%%%%%%%%%%%%% 12 ����ɫ��������ά %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure(12);
fig = gcf; % current figure handle
[x,y,z] = peaks(35);
R= sqrt(x.^2 + y.^2);surf(x,y,z,z);
axis tight;
R= sqrt(x.^2 + y.^2);surf(x,y,z,R);
axis tight;

xlabel('X');ylabel('Y');zlabel('Z');grid on;title('����ɫ��������ά');legend('����ɫ��������ά');

savefig(fig,'D:\cjj\MATLAB\figure\12.fig','compact')
saveas(gcf, 'D:\cjj\MATLAB\figure\12.jpg','jpg');
saveas(gcf, 'D:\cjj\MATLAB\figure\12.png','png');
saveas(gcf, 'D:\cjj\MATLAB\figure\12.eps','eps');
%%%%%%%%%%%%%%%%%%%%%%%%%%% 13  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure(13);
fig = gcf; % current figure handle
subplot(2,2,1);plot(rand(1,20));title('grid off');xlabel('X');ylabel('Y');zlabel('Z');
subplot(2,2,2);plot(rand(1,20));grid on;title('grid on');xlabel('X');ylabel('Y');zlabel('Z');
subplot(2,2,[3,4]);plot(rand(1,20));grid(gca,'minor');title('grid minor');xlabel('X');ylabel('Y');zlabel('Z');title('grid minor');legend('grid minor');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.jpg','jpg');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.png','png');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.eps','eps');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.emf','emf');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.pdf','pdf');
saveas(gcf, 'D:\cjj\MATLAB\figure\13.bmp','bmp');





