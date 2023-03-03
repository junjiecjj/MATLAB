
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

width = 7;%设置图宽，这个不用改
height = 7*0.75;%设置图高，这个不用改
fontsize = 18;%设置图中字体大小
linewidth = 2;%设置线宽，一般大小为2，好看些。1是默认大小
markersize = 6;%标记的大小，按照个人喜好设置。


%下面是数据
%第一组数据，第一列是Eb/N0, 第二列是BER，下同。
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

%第二组数据
%The results correspond to .\Set_up\Setup_of_BlockCodeCRC_BPSK_AWGN0.txt
LDPC5GFreeRideExtra2BitExtraBerFer = [...

];

LDPC5GFreeRideExtra2BitPayloadBerFer = [...

];


%第三组数据
LDPC5GFreeRideExtra6BitExtraBerFer = [...

];

LDPC5GFreeRideExtra6BitPayloadBerFer = [...

];

%第四组数据
LDPC5GFreeRideExtra10BitExtraBerFer = [...

];

LDPC5GFreeRideExtra10BitPayloadBerFer = [...

];


%%========================================================================================
%    开始画图
%%========================================================================================

h = figure(1);
% fig(h, 'units','inches','width',width, 'height', height, 'font','Times New Roman','fontsize',fontsize);%这是用于裁剪figure的。需要把fig.m文件放在一个文件夹中

ColorSet = [...
         0         0    1.0000
         0    0.5000         0
    1.0000         0         0
         0    0.7500    0.7500
    0.7500         0    0.7500
    0.7500    0.7500         0
   0.2500    0.2500     0.2500
];%颜色集合，这是默认的八种颜色，颜色的数量可以更改
set(gcf, 'DefaultAxesColorOrder', ColorSet);%设置循环使用的颜色集合

%纵坐标对数域，如果不需要对数改为plot
P1 = semilogy(LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3)); 
P1.LineStyle = "-";
P1.LineWidth=2;
P1.Color = "b";
P1.Marker = "pentagram";
%P1.MarkerEdgeColor="auto"; %标记轮廓颜色，指定为 "auto"、RGB 三元组、十六进制颜色代码、颜色名称或短名称。默认值 "auto" 使用与 Color 属性相同的颜色。
%P1.MarkerFaceColor="auto"; %标记填充颜色，指定为 "auto"、RGB 三元组、十六进制颜色代码、颜色名称或短名称。"auto" 选项使用与父坐标区的 Color 属性相同的颜色。如果您指定 "auto"，并且坐标区图框不可见，则标记填充颜色为图窗的颜色。
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
set(gca,'XMinorGrid','off'); % 关闭X轴的次网格
set(gca,'XGrid','off','LineWidth',0.01); % 关闭X轴的网格
 

h_legend = legend('Extra data,${\ell}$=1',...
                  'Payload data,${\ell}$=1');  %图例，与上面的曲线先后对应
set(h_legend,'FontName','Times New Roman','FontSize',14,'FontWeight','normal');
set(h_legend,'Interpreter','latex');


xlabel('SNR(dB)','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%横坐标标号
ylabel('BER','FontName','Times New Roman','FontSize',16,'FontWeight','normal','Color','k','Interpreter','latex');%纵坐标标号


set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');
set(gcf,'color','white');  % 设置背景是白色的 原先是灰色的 论文里面不好看
%set(get(gca,'Children'),'linewidth',linewidth);   %设置图中线宽
set(gca, 'XTick', 0:0.5:11);  % 设置x坐标轴的刻度
%set(gca, 'YTick',(0:2:32))   % 设置y坐标轴的刻度
set(gca,'linewidth',1);       % 设置坐标轴粗细
set(gca, 'FontSize',16)        % 设置坐标轴的数字大小，包括legend文字大小.
% set(get(gca,'Children'), 'markersize', markersize);  %设置标记大小
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% 设置标记颜色,统一颜色。
axis([0 2.5 1e-6 1]);         % 横纵坐标范围


print(figure(1), '-depsc', '/home/jack/文档/中山大学/SemanticFreeRide/Figures/WER.eps');%保存为eps格式的图片color
exportgraphics(figure(1),'/home/jack/文档/中山大学/SemanticFreeRide/Figures/WER.pdf','ContentType','vector')
% saveas(figure(1), '/home/jack/公共的/MATLAB/ComLetter20230303/WER1.pdf','pdf');

 
 

