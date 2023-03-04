clear;%清楚workspace的变量，防止同名变量干扰
clc;%清楚workspace的命令显示。

width = 7;%设置图宽，这个不用改
height = 7*0.75;%设置图高，这个不用改
fontsize = 18;%设置图中字体大小
linewidth = 2;%设置线宽，一般大小为2，好看些。1是默认大小
markersize = 10;%标记的大小，按照个人喜好设置。




%下面是数据

%第0组数据
LDPC5GNoExtraBerFer = [...

];

LDPC5GNoExtraBerFer = [...

];

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
fig(h, 'units','inches','width',width, 'height', height, 'font','Times New Roman','fontsize',fontsize);%这是用于裁剪figure的。需要把fig.m文件放在一个文件夹中

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
semilogy(LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3), 'm--o', ...
         LDPC5GFreeRideExtra1BitPayloadBerFer(:,1), LDPC5GFreeRideExtra1BitPayloadBerFer(:,3), 'k-d');


hold on;
grid on; % 显示网格

h_legend = legend('Payload data,${\ell}$=1',...
                  'Extra data,${\ell}$=1');  %图例，与上面的曲线先后对应
set(h_legend,'Interpreter','latex');

xlabel('SNR(dB)');%横坐标标号
ylabel('BER');%纵坐标标号



set(gcf,'color','white'); % 设置背景是白色的 原先是灰色的 论文里面不好看
set(get(gca,'Children'),'linewidth',linewidth);%设置图中线宽
set(gca, 'XTick', 0:0.5:11);  % 设置横坐标刻度值
set(gca,'linewidth',2);       % 设置坐标轴粗细
set(gca, 'FontSize',18)        % 设置坐标轴字体是 8
set(get(gca,'Children'), 'markersize', markersize);  %设置标记大小
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% 设置标记颜色,统一颜色。
% axis([0 2.5 1e-6 1]);         % 横纵坐标范围

% print(figure(1), '-depsc', '/home/jack/文档/中山大学/SemanticFreeRide/Figures/WER.eps');%保存为eps格式的图片color
% exportgraphics(figure(1),'/home/jack/文档/中山大学/SemanticFreeRide/Figures/WER.pdf','ContentType','vector')
% % saveas(figure(1), '/home/jack/公共的/MATLAB/ComLetter20230303/WER1.pdf','pdf');
% 
%  

