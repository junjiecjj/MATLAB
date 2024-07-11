
% 线型	描述	表示的线条
% "-"	实线	
% 
% "--"	虚线	
% 
% ":"	点线	
% 
% "-."	点划线	
% 
% 标记	描述	生成的标记
% "o"	圆圈	
% 
% "+"	加号	
% 
% "*"	星号	
% 
% "."	点	
% 
% "x"	叉号	
% 
% "_"	水平线条	
% 
% "|"	垂直线条	
% 
% "square"	方形	
% 
% "diamond"	菱形	
% 
% "^"	上三角	
% 
% "v"	下三角	
% 
% ">"	右三角	
% 
% "<"	左三角	
% 
% "pentagram"	五角形	
% 
% "hexagram"	六角形	



% 颜色名称	短名称	RGB 三元组	外观
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




clear;%清楚workspace的变量，防止同名变量干扰
clc;%清楚workspace的命令显示。



%下面是数据
%第0组数据,没有额外比特
LDPC5GNoExtraBer  = [
0.000000 0.1600611772
0.250000 0.1306803995
0.500000 0.0865661982
0.750000 0.0389888584
1.000000 0.0115016044
1.250000 0.0015711885
1.500000 0.0001291701
1.750000 0.0000063439
2.000000 0.0000003201
];

LDPC5GNoExtraFer = [
0.000000 0.9920634921
0.250000 0.9363295880
0.500000 0.7396449704
0.750000 0.3663003663
1.000000 0.1166861144
1.250000 0.0169877349
1.500000 0.0014351897
1.750000 0.0000855838
2.000000 0.0000092097
];




%第一组数据，第一列是Eb/N0或SNR, 第二列是BER，第三列是WER，下同。
LDPC5GFreeRideExtra1BitExtraBerFer = [...
0.000000  0.0277023658  0.0277023658
0.250000  0.0096264921  0.0096264921
0.500000  0.0023673570  0.0023673570
0.750000  0.0003360000  0.0003360000
1.000000  0.0000250000  0.0000250000
% 1.250000  0.0000020000  0.0000020000
% 1.500000  0.0000000000  0.0000000000
% 1.750000  0.0000000000  0.0000000000
];


%The following results correspond to Setup_of_BPSK_AWGN0.txt
LDPC5GFreeRideExtra1BitPayloadBerFer = [...
0.000000 0.1695081791  0.9956230262
0.250000 0.1361787138  0.9467558722
0.500000 0.0902647746  0.7433074818
0.750000 0.0411093734  0.3859320000
1.000000 0.0111053406  0.1133065000
1.250000 0.0016376776  0.0175820000
1.500000 0.0001254078  0.0014485000
1.750000 0.0000051437  0.0000755000
2.000000 0.0000002755  0.0000090000
% 2.500000 0.0000000026  0.0000010000
];


%第二组数据
%The results correspond to .\Set_up\Setup_of_BlockCodeCRC_BPSK_AWGN0.txt
LDPC5GFreeRideExtra2BitExtraBerFer = [...
0.000000  0.0473476854  0.0703531729
0.250000  0.0179997841  0.0269861831
0.500000  0.0039655110  0.0060634724
0.750000  0.0006277281  0.0009383081
1.000000  0.0000550000  0.0000770000
1.250000  0.0000005000  0.0000010000
1.500000  0.0000000000  0.0000000000
];

LDPC5GFreeRideExtra2BitPayloadBerFer = [...
0.000000 0.1838549728  0.9952159842
0.250000 0.1418919170  0.9472420121
0.500000 0.0914873711  0.7425752780
0.750000 0.0412932836  0.3859083010
1.000000 0.0111733911  0.1136940000
1.250000 0.0016257687  0.0175260000
1.500000 0.0001304365  0.0014870000
1.750000 0.0000052276  0.0000810000
];

%第三组数据
LDPC5GFreeRideExtra4BitExtraBerFer = [...
0.000000  0.0835652443  0.1546072975
0.250000  0.0362813370  0.0696378830
0.500000  0.0097517411  0.0180420741
0.750000  0.0017736432  0.0032189532
1.000000  0.0001445000  0.0002700000
1.250000  0.0000045000  0.0000100000
];

LDPC5GFreeRideExtra4BitPayloadBerFer = [...
0.000000 0.2104775433  0.9959802103
0.250000 0.1559486711  0.9443593315
0.500000 0.0955580601  0.7428463176
0.750000 0.0423233868  0.3876038112
1.000000 0.0112560359  0.1136600000
1.250000 0.0016571208  0.0177480000
];


%第4组数据
LDPC5GFreeRideExtra6BitExtraBerFer = [...
0.000000  0.1498462130  0.2883506344
0.250000  0.0699818347  0.1362397820
0.500000  0.0209448138  0.0405383493
0.750000  0.0035813468  0.0068739861
1.000000  0.0003077068  0.0006158242
];

LDPC5GFreeRideExtra6BitPayloadBerFer = [...
0.000000 0.2551212274  0.9959630911
0.250000 0.1794964805  0.9467302452
0.500000 0.1042264185  0.7495540782
0.750000 0.0433801151  0.3847851192
1.000000 0.0113335026  0.1132457631
];

%第5组数据
LDPC5GFreeRideExtra10BitExtraBerFer = [...
0.000000  0.2763392857  0.5580357143
0.250000  0.1552850737  0.3203074952
0.500000  0.0580246914  0.1143118427
0.750000  0.0134757820  0.0266425108
];

LDPC5GFreeRideExtra10BitPayloadBerFer = [...
0.000000 0.3453578404  0.9966517857
0.250000 0.2440819854  0.9500320307
0.500000 0.1308471698  0.7445130316
0.750000 0.0510339514  0.3882879523
];

%=======================================
width = 7;%设置图宽，这个不用改
height = 7*0.75;%设置图高，这个不用改
fontsize = 18;%设置图中字体大小
linewidth = 2;%设置线宽，一般大小为2，好看些。1是默认大小
markersize = 10;%标记的大小，按照个人喜好设置。
%%========================================================================================
%    开始画图
%%========================================================================================

h = figure(1);
% fig(h, 'units','inches','width',width, 'height', height, 'font','Times New Roman','fontsize',fontsize);%这是用于裁剪figure的。需要把fig.m文件放在一个文件夹中



% ColorSet = [...
%          0         0    1.0000
%          0    0.5000         0
%     1.0000         0         0
%          0    0.7500    0.7500
%     0.7500         0    0.7500
%     0.7500    0.7500         0
%    0.2500    0.2500     0.2500
% ];%颜色集合，这是默认的八种颜色，颜色的数量可以更改
% set(gcf, 'DefaultAxesColorOrder', ColorSet);%设置循环使用的颜色集合

%------------------------------ 0: No Extra ---------------------------
% %纵坐标对数域，如果不需要对数改为plot
% P00 = semilogy(LDPC5GNoExtraBer(:,1), LDPC5GNoExtraBer(:,2)); 
% P00.LineStyle = "--";
% P00.LineWidth=2;
% P00.Color = "b";
% P00.Marker = "pentagram";
% %P00.MarkerEdgeColor="auto"; %标记轮廓颜色，指定为 "auto"、RGB 三元组、十六进制颜色代码、颜色名称或短名称。默认值 "auto" 使用与 Color 属性相同的颜色。
% %P00.MarkerFaceColor="auto"; %标记填充颜色，指定为 "auto"、RGB 三元组、十六进制颜色代码、颜色名称或短名称。"auto" 选项使用与父坐标区的 Color 属性相同的颜色。如果您指定 "auto"，并且坐标区图框不可见，则标记填充颜色为图窗的颜色。
% P00.MarkerSize=8;
% hold on;

%-------------------------------  0: No Extra -------------------------
P01 = semilogy(LDPC5GNoExtraFer(:,1), LDPC5GNoExtraFer(:,2)); 
P01.LineStyle = "--";
P01.LineWidth=linewidth;
P01.Color = "k";
P01.Marker = "*";
P01.MarkerSize=markersize;
hold on;


%-------------------------------1 Payload -------------------------
P12 = semilogy(LDPC5GFreeRideExtra1BitPayloadBerFer(:,1), LDPC5GFreeRideExtra1BitPayloadBerFer(:,3)); 
P12.LineStyle = "--";
P12.LineWidth=linewidth;
P12.Color = "r";
P12.Marker = "o";
P12.MarkerSize=markersize;
hold on;


%-------------------------------2 Payload -------------------------
P22 = semilogy(LDPC5GFreeRideExtra2BitPayloadBerFer(:,1), LDPC5GFreeRideExtra2BitPayloadBerFer(:,3)); 
P22.LineStyle = "--";
P22.LineWidth=linewidth;
P22.Color = "g";
P22.Marker = "diamond";
P22.MarkerSize=markersize;
hold on;




%-------------------------------4 Payload -------------------------
P42 = semilogy(LDPC5GFreeRideExtra4BitPayloadBerFer(:,1), LDPC5GFreeRideExtra4BitPayloadBerFer(:,3)); 
P42.LineStyle = "--";
P42.LineWidth=linewidth;
P42.Color = "#A2142F";
P42.Marker = "v";
P42.MarkerSize=markersize;
hold on;



%-------------------------------6 Payload -------------------------
P62 = semilogy(LDPC5GFreeRideExtra6BitPayloadBerFer(:,1), LDPC5GFreeRideExtra6BitPayloadBerFer(:,3)); 
P62.LineStyle = "--";
P62.LineWidth=linewidth;
P62.Color = "#0072BD";
P62.Marker = "^";
P62.MarkerSize=markersize;
hold on;


%-------------------------------10 Payload -------------------------
P102 = semilogy(LDPC5GFreeRideExtra10BitPayloadBerFer(:,1), LDPC5GFreeRideExtra10BitPayloadBerFer(:,3)); 
P102.LineStyle = "--";
P102.LineWidth=linewidth;
P102.Color = "#7E2F8E";
P102.Marker = "square";
P102.MarkerSize=markersize;
hold on;

%---------------------------------------------------------

hold on;
grid on; 
set(gca,'XMinorGrid','off'); % 关闭X轴的次网格
set(gca,'XGrid','off','LineWidth',0.01); % 关闭X轴的网格
set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');

% gca表示对axes的设置；  gcf表示对figure的设置
%---------------------------------------------------------
scalesize = 28;
% 设置坐标轴的数字大小，包括xlabel/ylabel文字(坐标轴标注)大小.同时影响图例、标题等,除非它们被单独设置。所以一开始就使用这行先设置刻度字体字号，然后在后面在单独设置坐标轴标注、图例、标题等的 字体字号。
set(gca, 'FontSize',fontsize,'FontName','Times New Roman');

h_legend = legend('Payload data,without extra data', ...
                  'Payload data, ${\ell}$=1', ...
                  'Payload data, ${\ell}$=2', ...
                  'Payload data, ${\ell}$=4',...
                  'Payload data, ${\ell}$=6',...
                  'Payload data, ${\ell}$=10'...
                  );  %图例，与上面的曲线先后对应
legendsize = 22;
set(h_legend,'FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Location','southwest');
set(h_legend,'Interpreter','latex');

labelsize = 28;
xlabel('SNR(dB)','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%横坐标标号,坐标轴label字体、字体大小
ylabel('WER','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%纵坐标标号，坐标轴label字体、字体大小
%set(get(gca,'XLabel'),'FontSize',14);%图上文字为8 point或小5号
%set(get(gca,'YLabel'),'FontSize',14);



set(gca, 'XTick', 0:0.5:11);  % 设置x坐标轴的刻度
%set(gca, 'YTick',(0:2:32))   % 设置y坐标轴的刻度
axis([0 2.5 1e-6 1]);         % 横纵坐标范围

%set(get(gca,'Children'),'linewidth',linewidth);   %设置图中线宽
set(gca,'linewidth',1);       % 设置坐标轴粗细

set(get(gca,'Children'), 'markersize', markersize);  %设置标记大小
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% 设置标记颜色,统一颜色。


set(gcf,'color','white');  % 设置背景是白色的 原先是灰色的 论文里面不好看


%print(figure(1), '-depsc', '/home/jack/文档/中山大学/SemanticFreeRide/figures/WER_payload.eps');%保存为eps格式的图片color
%exportgraphics(figure(1),'/home/jack/文档/中山大学/SemanticFreeRide/figures/WER_payload.pdf','ContentType','vector')
% saveas(figure(1), '/home/jack/公共的/MATLAB/ComLetter20230303/WER1.pdf','pdf');

 
 

