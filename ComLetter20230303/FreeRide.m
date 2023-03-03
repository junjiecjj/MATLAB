
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

%��0������,û�ж������
LDPC5GNoExtraBer  = [
0.000000 0.1600611772
0.250000 0.1306803995
0.500000 0.0865661982
0.750000 0.0389888584
1.000000 0.0115016044
1.250000 0.0015711885
1.500000 0.0001291701
];

LDPC5GNoExtraFer = [
0.000000 0.9920634921
0.250000 0.9363295880
0.500000 0.7396449704
0.750000 0.3663003663
1.000000 0.1166861144
1.250000 0.0169877349
1.500000 0.0014351897
];


%��һ�����ݣ���һ����Eb/N0��SNR, �ڶ�����BER����������WER����ͬ��
LDPC5GFreeRideExtra1BitExtraBerFer = [...
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
0.000000  0.0473476854  0.0703531729
0.250000  0.0179997841  0.0269861831
0.500000  0.0039655110  0.0060634724
];

LDPC5GFreeRideExtra2BitPayloadBerFer = [...
0.000000 0.1838549728  0.9952159842
0.250000 0.1418919170  0.9472420121
0.500000 0.0914873711  0.7425752780
];

%����������
LDPC5GFreeRideExtra4BitExtraBerFer = [...
0.000000  0.0835652443  0.1546072975
0.250000  0.0362813370  0.0696378830
0.500000  0.0097517411  0.0180420741
];

LDPC5GFreeRideExtra4BitPayloadBerFer = [...
0.000000 0.2104775433  0.9959802103
0.250000 0.1559486711  0.9443593315
0.500000 0.0955580601  0.7428463176
];


%��4������
LDPC5GFreeRideExtra6BitExtraBerFer = [...
0.000000  0.1498462130  0.2883506344
0.250000  0.0699818347  0.1362397820
0.500000  0.0209448138  0.0405383493
];

LDPC5GFreeRideExtra6BitPayloadBerFer = [...
0.000000 0.2551212274  0.9959630911
0.250000 0.1794964805  0.9467302452
0.500000 0.1042264185  0.7495540782
];

%��5������
LDPC5GFreeRideExtra10BitExtraBerFer = [...
0.000000  0.2763392857  0.5580357143
0.250000  0.1552850737  0.3203074952

];

LDPC5GFreeRideExtra10BitPayloadBerFer = [...
0.000000 0.3453578404  0.9966517857
0.250000 0.2440819854  0.9500320307
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

%------------------------------ 0: No Extra ---------------------------
% %������������������Ҫ������Ϊplot
% P00 = semilogy(LDPC5GNoExtraBer(:,1), LDPC5GNoExtraBer(:,2)); 
% P00.LineStyle = "--";
% P00.LineWidth=2;
% P00.Color = "b";
% P00.Marker = "pentagram";
% %P00.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
% %P00.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
% P00.MarkerSize=8;
% hold on;

%-------------------------------  0: No Extra -------------------------
P01 = semilogy(LDPC5GNoExtraFer(:,1), LDPC5GNoExtraFer(:,2)); 
P01.LineStyle = "-";
P01.LineWidth=2;
P01.Color = "r";
P01.Marker = "diamond";
P01.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������


%------------------------------1---------------------------
%������������������Ҫ������Ϊplot
P11 = semilogy(LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3)); 
P11.LineStyle = "-";
P11.LineWidth=2;
P11.Color = "b";
P11.Marker = "pentagram";
%P11.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P11.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P11.MarkerSize=8;
hold on;

%-------------------------------1-------------------------
P12 = semilogy(LDPC5GFreeRideExtra1BitPayloadBerFer(:,1), LDPC5GFreeRideExtra1BitPayloadBerFer(:,3)); 
P12.LineStyle = "--";
P12.LineWidth=2;
P12.Color = "r";
P12.Marker = "diamond";
P12.MarkerSize=7;
hold on;

hold on;
grid on; 

%-------------------------------2--------------------------
%������������������Ҫ������Ϊplot
P21 = semilogy(LDPC5GFreeRideExtra2BitExtraBerFer(:,1), LDPC5GFreeRideExtra2BitExtraBerFer(:,3)); 
P21.LineStyle = "-";
P21.LineWidth=2;
P21.Color = "b";
P21.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P1.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P21.MarkerSize=8;
hold on;

%-------------------------------2-------------------------
P22 = semilogy(LDPC5GFreeRideExtra2BitPayloadBerFer(:,1), LDPC5GFreeRideExtra2BitPayloadBerFer(:,3)); 
P22.LineStyle = "-";
P22.LineWidth=2;
P22.Color = "r";
P22.Marker = "diamond";
P22.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������

%-------------------------------4--------------------------
%������������������Ҫ������Ϊplot
P41 = semilogy(LDPC5GFreeRideExtra4BitExtraBerFer(:,1), LDPC5GFreeRideExtra4BitExtraBerFer(:,3)); 
P41.LineStyle = "-";
P41.LineWidth=2;
P41.Color = "b";
P41.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P1.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P41.MarkerSize=8;
hold on;

%-------------------------------4-------------------------
P42 = semilogy(LDPC5GFreeRideExtra4BitPayloadBerFer(:,1), LDPC5GFreeRideExtra4BitPayloadBerFer(:,3)); 
P42.LineStyle = "-";
P42.LineWidth=2;
P42.Color = "r";
P42.Marker = "diamond";
P42.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������



%-------------------------------6--------------------------
%������������������Ҫ������Ϊplot
P61 = semilogy(LDPC5GFreeRideExtra6BitExtraBerFer(:,1), LDPC5GFreeRideExtra6BitExtraBerFer(:,3)); 
P61.LineStyle = "-";
P61.LineWidth=2;
P61.Color = "b";
P61.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P1.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P61.MarkerSize=8;
hold on;

%-------------------------------6-------------------------
P62 = semilogy(LDPC5GFreeRideExtra6BitPayloadBerFer(:,1), LDPC5GFreeRideExtra6BitPayloadBerFer(:,3)); 
P62.LineStyle = "-";
P62.LineWidth=2;
P62.Color = "r";
P62.Marker = "diamond";
P62.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������


%-------------------------------10 --------------------------
%������������������Ҫ������Ϊplot
P101 = semilogy(LDPC5GFreeRideExtra10BitExtraBerFer(:,1), LDPC5GFreeRideExtra10BitExtraBerFer(:,3)); 
P101.LineStyle = "-";
P101.LineWidth=2;
P101.Color = "b";
P101.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %���������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�Ĭ��ֵ "auto" ʹ���� Color ������ͬ����ɫ��
%P1.MarkerFaceColor="auto"; %��������ɫ��ָ��Ϊ "auto"��RGB ��Ԫ�顢ʮ��������ɫ���롢��ɫ���ƻ�����ơ�"auto" ѡ��ʹ���븸�������� Color ������ͬ����ɫ�������ָ�� "auto"������������ͼ�򲻿ɼ������������ɫΪͼ������ɫ��
P101.MarkerSize=8;
hold on;

%-------------------------------10 -------------------------
P102 = semilogy(LDPC5GFreeRideExtra10BitPayloadBerFer(:,1), LDPC5GFreeRideExtra10BitPayloadBerFer(:,3)); 
P102.LineStyle = "-";
P102.LineWidth=2;
P102.Color = "r";
P102.Marker = "diamond";
P102.MarkerSize=7;
hold on;

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������


%---------------------------------------------------------
h_legend = legend('Payload data,${\ell}$=0', ...
                  'Extra data,${\ell}$=1',...
                  'Payload data,${\ell}$=1', ...
                  'Extra data,${\ell}$=2',...
                  'Payload data,${\ell}$=2', ...
                  'Extra data,${\ell}$=4',...
                  'Payload data,${\ell}$=4',...
                  'Extra data,${\ell}$=6',...
                  'Payload data,${\ell}$=6',...
                  'Extra data,${\ell}$=10',...
                  'Payload data,${\ell}$=10'...
                  );  %ͼ����������������Ⱥ��Ӧ
set(h_legend,'FontName','Times New Roman','FontSize',14,'FontWeight','normal');
set(h_legend,'Interpreter','latex');


xlabel('SNR(dB)','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%��������
ylabel('WER','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%��������

set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������


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


% print(figure(1), '-depsc', '/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.eps');%����Ϊeps��ʽ��ͼƬcolor
% exportgraphics(figure(1),'/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.pdf','ContentType','vector')
% % saveas(figure(1), '/home/jack/������/MATLAB/ComLetter20230303/WER1.pdf','pdf');
% 
%  
 

