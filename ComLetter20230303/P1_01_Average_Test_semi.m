%LDPC DBICM PEG 0.5 16QAM
%码长8064
clear all;
clc;


width = 8;%设置图宽，这个不用改
height = 8 * 0.75;%设置图高，这个不用改
fontsize = 6;%设置图中字体大小
linewidth = 2;%设置线宽，一般大小为2，好看些。1是默认大小


%%%%%%%%%%%%%%%%%%%%% LDPC-BPSK %%%%%%%%%%%%%%%%%%%%%%%%%%%

P1_01_GA_UU = [

-2.000000 3508.1292693472
-1.500000 2176.7732254697
-1.000000 1238.0353766829
-0.500000 583.5137093615
0.000000 274.6775102307
0.500000 103.7749669827
1.000000 32.0138056140
1.500000 9.2087392094
2.000000 2.8372196249
2.500000 1.3737137000
3.000000 1.0748033000
3.500000 1.0164463000



];
%%%%%%%%%%%%%%%%%%%%%% Unusing symmetry  %%%%%%%%%%%%%%%%%%%%%%

P1_01_UnknownP1_Travers_Type_NoOrder = [
-2.000000 72741.6194444444
-1.500000 68806.0928074246
-1.000000 64074.7361769352
-0.500000 55971.6528354080
0.000000 51966.0465484484
0.500000 47885.3198413506
1.000000 44656.8651901781

];


P1_01_UnknownP1_Travers_Type_Order = [
-2.000000 70715.4428571429
-1.500000 58209.2295774648
-1.000000 47125.6838939021
-0.500000 37697.4666754827
0.000000 30261.0524686145
0.500000 24282.5370754500
1.000000 19687.2551845319
1.500000 15891.7553978917
2.000000 13181.4243060000
2.500000 11311.1816140000
3        9667



];

P1_01_UnknownP1_Travers_Type_Order_parallel = [
-2.000000 14824.5333333333
-1.500000 10498.8084303240
-1.000000 5705.8666192424
-0.500000 2812.7639097744
0.000000 1375.1339722593
0.500000 547.1091454551
1.000000 189.2132689563
1.500000 57.7011401101
2.000000 20.2543680000
2.500000 10.9919120000
3.000000 8.5668400000

%2.500000 10.7339200000

];


% P1_01_KnownP1_Travers_Type_Order = [
% -2.000000 56494.1111111111
% -1.500000 52003.9396751740
% -1.000000 43135.5086887836
% -0.500000 33142.0281014393
% 0.000000 28232.2789158525
% 0.500000 23067.9249681653
% 1.000000 19461.4055012810
% 1.5      17223
% 
% ];





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot(P1_01_UnknownP1_Travers_Type_NoOrder(:,1), P1_01_UnknownP1_Travers_Type_NoOrder(:,2),'b-+','LineWidth',1.5, 'markersize',7)
% hold on;

% plot(P1_01_UnknownP1_Travers_Type_Order(:,1), P1_01_UnknownP1_Travers_Type_Order(:,2),'b-o','LineWidth',1.5, 'markersize',7)
% hold on;
% 
% plot(P1_01_UnknownP1_Travers_Type_Order_parallel(:,1), P1_01_UnknownP1_Travers_Type_Order_parallel(:,2),'b-p','LineWidth',1.5, 'markersize',7)
% hold on;
% 
% plot(P1_01_GA_UU(:,1), P1_01_GA_UU(:,2),'k--+','LineWidth',1.5, 'markersize',11)
% hold on;


semilogy(P1_01_UnknownP1_Travers_Type_Order(:,1), P1_01_UnknownP1_Travers_Type_Order(:,2),'r-o','LineWidth',1.5, 'markersize',7)
hold on;

semilogy(P1_01_UnknownP1_Travers_Type_Order_parallel(:,1), P1_01_UnknownP1_Travers_Type_Order_parallel(:,2),'b-p','LineWidth',1.5, 'markersize',7)
hold on;


semilogy(P1_01_GA_UU(:,1), P1_01_GA_UU(:,2),'k--+','LineWidth',1.5, 'markersize',11)
hold on;







axis([-2 3 1 100000])
set(gca, 'FontName', 'Times New Roman');
%t = title('Type-aware + random code, $n = 128, ~k= 64, ~p_1 = 0.1$');
%set(t,'Interpreter','latex');
x=xlabel('SNR');%横坐标标号
set(x,'Interpreter','latex');
set(gca,'xtick',-2:0.5:3);
%set(gca,'ytick',0:1000:100000);
ylabel('Average number of tests');
grid on

h=legend(...
    'Serial decoding',...
    'Parallel decoding',...
    'GA type decoding');
set(h,'Interpreter','latex', 'fontsize', 12)


hold off;
%print(gcf, '-depsc', 'BER_BMST_LDPC_ID_DBICM_ID_16QAM_PEG1_2.eps')

