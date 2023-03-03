
% ����	����	��ʾ������
% "-"	ʵ��	
% 
% "--"	����	
% 
% ":"	����	
% 
% "-."	�㻮��	
% 
% ���	����	���ɵı��
% "o"	ԲȦ	
% 
% "+"	�Ӻ�	
% 
% "*"	�Ǻ�	
% 
% "."	��	
% 
% "x"	���	
% 
% "_"	ˮƽ����	
% 
% "|"	��ֱ����	
% 
% "square"	����	
% 
% "diamond"	����	
% 
% "^"	������	
% 
% "v"	������	
% 
% ">"	������	
% 
% "<"	������	
% 
% "pentagram"	�����	
% 
% "hexagram"	������	



% ��ɫ����	������	RGB ��Ԫ��	���
% "red"	"r"	[1 0 0]	
% Sample of the color red
% 
% "green"	"g"	[0 1 0]	
% Sample of the color green
% 
% "blue"	"b"	[0 0 1]	
% Sample of the color blue
% 
% "cyan"	"c"	[0 1 1]	
% Sample of the color cyan
% 
% "magenta"	"m"	[1 0 1]	
% Sample of the color magenta
% 
% "yellow"	"y"	[1 1 0]	
% Sample of the color yellow
% 
% "black"	"k"	[0 0 0]	
% Sample of the color black
% 
% "white"	"w"	[1 1 1]	
% Sample of the color white




clear;%���workspace�ı�������ֹͬ����������
clc;%���workspace��������ʾ��

width = 7;%����ͼ��������ø�
height = 7*0.75;%����ͼ�ߣ�������ø�
fontsize = 18;%����ͼ�������С
linewidth = 2;%�����߿�һ���СΪ2���ÿ�Щ��1��Ĭ�ϴ�С
markersize = 6;%��ǵĴ�С�����ո���ϲ�����á�


%����������
%��һ�����ݣ���һ����Eb/N0, �ڶ�����BER����ͬ��
LDPC5GFreeRideExtra1BitExtraBerFer = [
0.000000  0.0277023658  0.0277023658
0.500000  0.0023673570  0.0023673570
1.000000  0.0000250000  0.0000250000
];

 
%The following results correspond to Setup_of_BPSK_AWGN0.txt
LDPC5GFreeRideExtra1BitPayloadBerFer = [...
0.000000 0.1695081791  0.9956230262
0.500000 0.0902647746  0.7433074818
1.000000 0.0111053406  0.1133065000
1.500000 0.0001254078  0.0014485000
2.000000 0.0000002755  0.0000090000
];

%�ڶ�������
%The results correspond to .\Set_up\Setup_of_BlockCodeCRC_BPSK_AWGN0.txt
LDPC5GFreeRideExtra2BitExtraBerFer = [...

];

LDPC5GFreeRideExtra2BitPayloadBerFer = [...

];


%����������
LDPC5GFreeRideExtra6BitExtraBerFer = [...

];

LDPC5GFreeRideExtra6BitPayloadBerFer = [...

];

%����������
LDPC5GFreeRideExtra10BitExtraBerFer = [...

];

LDPC5GFreeRideExtra10BitPayloadBerFer = [...

];


%%========================================================================================
%    ��ʼ��ͼ
%%========================================================================================

h = figure(1);
% fig(h, 'units','inches','width',width, 'height', height, 'font','Times New Roman','fontsize',fontsize);%�������ڲü�figure�ġ���Ҫ��fig.m�ļ�����һ���ļ�����

ColorSet = [...
         0         0    1.0000
         0    0.5000         0
    1.0000         0         0
         0    0.7500    0.7500
    0.7500         0    0.7500
    0.7500    0.7500         0
   0.2500    0.2500     0.2500
];%��ɫ���ϣ�����Ĭ�ϵİ�����ɫ����ɫ���������Ը���
set(gcf, 'DefaultAxesColorOrder', ColorSet);%����ѭ��ʹ�õ���ɫ����

%������������������Ҫ������Ϊplot
P1 = semilogy(LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3)); 
P1.LineStyle = "-";
P1.LineWidth=2;
P1.Color = "b";
P1.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P1.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P1.MarkerSize=8;
hold on;


P2 = semilogy(LDPC5GFreeRideExtra1BitPayloadBerFer(:,1), LDPC5GFreeRideExtra1BitPayloadBerFer(:,3)); 
P2.LineStyle = "-";
P2.LineWidth=2;
P2.Color = "r";
P2.Marker = "diamond";
P2.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������
 

h_legend = legend('Extra data,${\ell}$=1',...
                  'Payload data,${\ell}$=1');  %ͼ����������������Ⱥ��Ӧ
set(h_legend,'FontName','Times New Roman','FontSize',14,'FontWeight','normal');
set(h_legend,'Interpreter','latex');


xlabel('SNR(dB)','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%��������
ylabel('BER','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%��������


set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');
set(gcf,'color','white');  % ���ñ����ǰ�ɫ�� ԭ���ǻ�ɫ�� �������治�ÿ�
%set(get(gca,'Children'),'linewidth',linewidth);   %����ͼ���߿�
set(gca, 'XTick', 0:0.5:11);  % ����x������Ŀ̶�
%set(gca, 'YTick',(0:2:32))   % ����y������Ŀ̶�
set(gca,'linewidth',1);       % �����������ϸ
set(gca, 'FontSize',16)        % ��������������ִ�С������legend���ִ�С.
% set(get(gca,'Children'), 'markersize', markersize);  %���ñ�Ǵ�С
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% ���ñ����ɫ,ͳһ��ɫ��
axis([0 2.5 1e-6 1]);         % �������귶Χ


print(figure(1), '-depsc', '/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.eps');%����Ϊeps��ʽ��ͼƬcolor
exportgraphics(figure(1),'/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.pdf','ContentType','vector')
% saveas(figure(1), '/home/jack/������/MATLAB/ComLetter20230303/WER1.pdf','pdf');

 
 

