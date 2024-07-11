clear;%清楚workspace的变量，防止同名变量干扰
clc;%清楚workspace的命令显示。



%下面是数据
%第0组数据,没有额外比特
LDPC5GNoExtraBer  = [
0.00  0.1611011601  0.9957145817  0.7335102881   12.8167432369 
0.25  0.1332193808  0.9479554520  0.6414109840   13.6252593044 
0.50  0.0893510414  0.7430479150  0.4524114524   15.3443613781
0.75  0.0409456574  0.3859088319  0.2144924839   18.7258204968
1.00  0.0111369205  0.1137451437  0.0593508375   24.3765885268
1.25  0.0016388128  0.0176109816  0.0087791875   32.7401940722
1.50  0.0001286017  0.0014731935  0.0006898617   44.4931611384
1.75  0.0000053473  0.0000787361  0.0000285274  271.4102207797
2.00  0.0000003599  0.0000088060  0.0000019559  338.3438282795 
2.25  0.0000000086  0.0000020720  0.0000000691  345.8511636695 
2.50  0.0000000000  0.0000000000  0.0000000000  348.1308036087 
];

LDPC5GWithExtraFer = [
0.00  0.1819643988  0.9999886069  0.7481717519      12.3198641553 
0.25  0.1414259893  0.9973122734  0.6477140044      13.3807097245 
0.50  0.0914532879  0.9339730709  0.4541789583      15.2504190341 
0.75  0.0413094775  0.6229880891  0.2149349594      18.6881758723 
1.00  0.0111212304  0.2138011393  0.0591450919      24.3843110888 
1.25  0.0016320915  0.0347436561  0.0087411826      32.7553098848 
1.50  0.0001223886  0.0029155878  0.0006591106      44.5811851447 
1.75  0.0000055336  0.0001626100  0.0000305741     269.6388754169 
2.00  0.0000002643  0.0000269291  0.0000017746     333.3337478270 
2.25  0.0000000070  0.0000020715  0.0000000561     347.0169745793 
2.50  0.0000000383  0.0000020715  0.0000002504     346.9677972167 
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
% semilogy(LDPC5GNoExtraBer(:,1), LDPC5GNoExtraBer(:,5), 'b-s', ...
%          LDPC5GWithExtraFer(:,1), LDPC5GWithExtraFer(:,5), 'r--d');


semilogy(LDPC5GNoExtraBer(:,1), LDPC5GNoExtraBer(:,5), 'b-*','LineWidth',2, 'markersize',10)
hold on;

semilogy(LDPC5GWithExtraFer(:,1), LDPC5GWithExtraFer(:,5), 'r--o', 'LineWidth', 2, 'markersize',12)
hold on;


%---------------------------------------------------------
hold on;
grid on;
set(gca,'XMinorGrid','off'); % 关闭X轴的次网格
set(gca,'XGrid','on','LineWidth',0.01); % 关闭X轴的网格
set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');

% gca表示对axes的设置；  gcf表示对figure的设置
%-------------------------------------------------------------------
scalesize = 28;
% 设置坐标轴的数字大小，包括xlabel/ylabel文字(坐标轴标注)大小.同时影响图例、标题等,除非它们被单独设置。所以一开始就使用这行先设置刻度字体字号，然后在后面在单独设置坐标轴标注、图例、标题等的 字体字号。
set(gca, 'FontSize',fontsize,'FontName','Times New Roman');


h_legend = legend('without extra data', ...
                  'with extra data, ${\ell}$=2'...
                  );  %图例，与上面的曲线先后对应
legendsize = 18;
set(h_legend,'FontName','Times New Roman','FontSize',legendsize,'FontWeight','normal','LineWidth',1,'Location','northwest');
set(h_legend,'Interpreter','latex')

labelsize = 28;
xlabel('SNR(dB)','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%横坐标标号,坐标轴label字体、字体大小
ylabel('PSNR(dB)','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%纵坐标标号，坐标轴label字体、字体大小
%set(get(gca,'XLabel'),'FontSize',14);%图上文字为8 point或小5号
%set(get(gca,'YLabel'),'FontSize',14);



set(gca, 'XTick', 0:0.25:11);  % 设置x坐标轴的刻度
%yticks([10 20 30 50 100 200 300 350])
%set(gca, 'YTick',(0:2:32))   % 设置y坐标轴的刻度
axis([0 2.5 10 1000]);         % 横纵坐标范围

% set(get(gca,'Children'),'linewidth',linewidth);   %设置图中线宽
set(gca,'linewidth',1.5);       % 设置坐标轴粗细

% set(get(gca,'Children'), 'markersize', markersize);  %设置标记大小
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% 设置标记颜色,统一颜色。


set(gcf,'color','white');  % 设置背景是白色的 原先是灰色的 论文里面不好看


% 
% print(figure(1), '-depsc', '/home/jack/文档/中山大学/SemanticFreeRide_GlobeCom/Figures/PSNR.eps');%保存为eps格式的图片color
exportgraphics(figure(1),'/home/jack/文档/中山大学/00 我的论文/2023/FreeRide_semantic_WCNC/SemanticFreeRide_WCNC_submit/Figures/Fig8.eps','ContentType','vector')
% % saveas(figure(1), '/home/jack/公共的/MATLAB/ComLetter20230303/WER1.pdf','pdf');
% 


