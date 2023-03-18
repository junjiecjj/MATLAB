clear;%清楚workspace的变量，防止同名变量干扰
clc;%清楚workspace的命令显示。



%下面是数据
%第0组数据,没有额外比特
LDPC5GWithExtraPixelErr  = [
0.00  0.1784594854  1.0000000000  0.7447141012
0.25  0.1437590917  1.0000000000  0.6539459229
0.50  0.0905845960  1.0000000000  0.4500694275
0.75  0.0408406258  1.0000000000  0.2119026184
1.00  0.0112059911  1.0000000000  0.0597610474
1.25  0.0020823479  1.0000000000  0.0110448201
1.50  0.0000529289  1.0000000000  0.0003077189
1.75  0.0000000000  0.0000000000  0.0000000000
2.00  0.0000000000  0.0000000000  0.0000000000
2.25  0.0000000000  0.0000000000  0.0000000000
2.50  0.0000000000  0.0000000000  0.0000000000
];


%===========================================
width = 7;%设置图宽，这个不用改
height = 7*0.75;%设置图高，这个不用改
fontsize = 18;%设置图中字体大小
linewidth = 2;%设置线宽，一般大小为2，好看些。1是默认大小
markersize = 10;%标记的大小，按照个人喜好设置。
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
semilogy(LDPC5GNoExtraFer(:,1), LDPC5GNoExtraFer(:,2), 'k-*');


%---------------------------------------------------------
hold on;
grid on; 
set(gca,'XMinorGrid','off'); % 关闭X轴的次网格
set(gca,'XGrid','off','LineWidth',0.01); % 关闭X轴的网格
set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');

% gca表示对axes的设置；  gcf表示对figure的设置
%-------------------------------------------------------------------
scalesize = 28;
% 设置坐标轴的数字大小，包括xlabel/ylabel文字(坐标轴标注)大小.同时影响图例、标题等,除非它们被单独设置。所以一开始就使用这行先设置刻度字体字号，然后在后面在单独设置坐标轴标注、图例、标题等的 字体字号。
set(gca, 'FontSize',fontsize,'FontName','Times New Roman');


h_legend = legend('Payload data,without extra data', ...
                   'Payload data, ${\ell}$=10',...
                  'Extra data, ${\ell}$=1',...
                  'Extra data, ${\ell}$=2',...
                  'Extra data, ${\ell}$=4',...
                  'Extra data, ${\ell}$=6',...
                  'Extra data, ${\ell}$=10'...
                  );  %图例，与上面的曲线先后对应
legendsize = 12;
set(h_legend,'FontName','Times New Roman','FontSize',legendsize,'FontWeight','normal','LineWidth',1,'Location','NorthEast');
set(h_legend,'Interpreter','latex');

labelsize = 28;
xlabel('SNR(dB)','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%横坐标标号,坐标轴label字体、字体大小
ylabel('WER','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%纵坐标标号，坐标轴label字体、字体大小
%set(get(gca,'XLabel'),'FontSize',14);%图上文字为8 point或小5号
%set(get(gca,'YLabel'),'FontSize',14);



set(gca, 'XTick', 0:0.5:11);  % 设置x坐标轴的刻度
%set(gca, 'YTick',(0:2:32))   % 设置y坐标轴的刻度
axis([0 2.5 1e-6 1]);         % 横纵坐标范围

set(get(gca,'Children'),'linewidth',linewidth);   %设置图中线宽
set(gca,'linewidth',1);       % 设置坐标轴粗细

set(get(gca,'Children'), 'markersize', markersize);  %设置标记大小
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% 设置标记颜色,统一颜色。


set(gcf,'color','white');  % 设置背景是白色的 原先是灰色的 论文里面不好看


% 
% print(figure(1), '-depsc', '/home/jack/文档/中山大学/SemanticFreeRide/figures/WER_extra.eps');%保存为eps格式的图片color
% exportgraphics(figure(1),'/home/jack/文档/中山大学/SemanticFreeRide/figures/WER_extra.pdf','ContentType','vector')
% % saveas(figure(1), '/home/jack/公共的/MATLAB/ComLetter20230303/WER1.pdf','pdf');
% 
%  

