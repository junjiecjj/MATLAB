clear;%���workspace�ı�������ֹͬ����������
clc;%���workspace��������ʾ��



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


%��һ�����ݣ���һ����Eb/N0��SNR, �ڶ�����BER����������WER����ͬ��
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

%�ڶ�������
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

%����������
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


%��4������
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

%��5������
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



%===========================================
width = 7;%����ͼ��������ø�
height = 7*0.75;%����ͼ�ߣ�������ø�
fontsize = 18;%����ͼ�������С
linewidth = 2;%�����߿�һ���СΪ2���ÿ�Щ��1��Ĭ�ϴ�С
markersize = 10;%��ǵĴ�С�����ո���ϲ�����á�
%%========================================================================================
%    ��ʼ��ͼ
%%========================================================================================

h = figure(1);
fig(h, 'units','inches','width',width, 'height', height, 'font','Times New Roman','fontsize',fontsize);%�������ڲü�figure�ġ���Ҫ��fig.m�ļ�����һ���ļ�����



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
semilogy(LDPC5GNoExtraFer(:,1), LDPC5GNoExtraFer(:,2), 'k-*', ...
         LDPC5GFreeRideExtra10BitPayloadBerFer(:,1), LDPC5GFreeRideExtra10BitPayloadBerFer(:,3), 'r--s', ...
         LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3), 'b-x', ...
         LDPC5GFreeRideExtra2BitExtraBerFer(:,1), LDPC5GFreeRideExtra2BitExtraBerFer(:,3), 'b-^', ...
         LDPC5GFreeRideExtra4BitExtraBerFer(:,1), LDPC5GFreeRideExtra4BitExtraBerFer(:,3), 'b-h', ...
         LDPC5GFreeRideExtra6BitExtraBerFer(:,1), LDPC5GFreeRideExtra6BitExtraBerFer(:,3), 'b-p', ...
         LDPC5GFreeRideExtra10BitExtraBerFer(:,1), LDPC5GFreeRideExtra10BitExtraBerFer(:,3), 'b-s');


%---------------------------------------------------------
hold on;
grid on; 
set(gca,'XMinorGrid','off'); % �ر�X��Ĵ�����
set(gca,'XGrid','off','LineWidth',0.01); % �ر�X�������
set(gca,'gridlinestyle','--','Gridalpha',0.2,'LineWidth',0.01,'Layer','bottom');

% gca��ʾ��axes�����ã� �0�2gcf��ʾ��figure������
%-------------------------------------------------------------------
scalesize = 28;
% ��������������ִ�С������xlabel/ylabel����(�������ע)��С.ͬʱӰ��ͼ���������,�������Ǳ��������á�����һ��ʼ��ʹ�����������ÿ̶������ֺţ�Ȼ���ں����ڵ��������������ע��ͼ��������ȵ� �����ֺš�
set(gca, 'FontSize',fontsize,'FontName','Times New Roman');


h_legend = legend('Payload data,without extra data', ...
                   'Payload data, ${\ell}$=10',...
                  'Extra data, ${\ell}$=1',...
                  'Extra data, ${\ell}$=2',...
                  'Extra data, ${\ell}$=4',...
                  'Extra data, ${\ell}$=6',...
                  'Extra data, ${\ell}$=10'...
                  );  %ͼ����������������Ⱥ��Ӧ
legendsize = 12;
set(h_legend,'FontName','Times New Roman','FontSize',legendsize,'FontWeight','normal','LineWidth',1,'Location','NorthEast');
set(h_legend,'Interpreter','latex');

labelsize = 28;
xlabel('SNR(dB)','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%��������,������label���塢�����С
ylabel('WER','FontName','Times New Roman','FontSize',fontsize,'FontWeight','normal','Color','k','Interpreter','latex');%�������ţ�������label���塢�����С
%set(get(gca,'XLabel'),'FontSize',14);%ͼ������Ϊ8 point��С5��
%set(get(gca,'YLabel'),'FontSize',14);



set(gca, 'XTick', 0:0.5:11);  % ����x������Ŀ̶�
%set(gca, 'YTick',(0:2:32))   % ����y������Ŀ̶�
axis([0 2.5 1e-6 1]);         % �������귶Χ

set(get(gca,'Children'),'linewidth',linewidth);   %����ͼ���߿�
set(gca,'linewidth',1);       % �����������ϸ

set(get(gca,'Children'), 'markersize', markersize);  %���ñ�Ǵ�С
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% ���ñ����ɫ,ͳһ��ɫ��


set(gcf,'color','white');  % ���ñ����ǰ�ɫ�� ԭ���ǻ�ɫ�� �������治�ÿ�



print(figure(1), '-depsc', '/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/figures/WER_extra.eps');%����Ϊeps��ʽ��ͼƬcolor
exportgraphics(figure(1),'/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/figures/WER_extra.pdf','ContentType','vector')
% saveas(figure(1), '/home/jack/������/MATLAB/ComLetter20230303/WER1.pdf','pdf');

 

