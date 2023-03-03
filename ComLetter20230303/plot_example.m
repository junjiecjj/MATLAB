clear;%���workspace�ı�������ֹͬ����������
clc;%���workspace��������ʾ��

width = 7;%����ͼ��������ø�
height = 7*0.75;%����ͼ�ߣ�������ø�
fontsize = 18;%����ͼ�������С
linewidth = 2;%�����߿�һ���СΪ2���ÿ�Щ��1��Ĭ�ϴ�С
markersize = 10;%��ǵĴ�С�����ո���ϲ�����á�




%����������

%��0������
LDPC5GNoExtraBerFer = [...

];

LDPC5GNoExtraBerFer = [...

];

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
semilogy(LDPC5GFreeRideExtra1BitExtraBerFer(:,1), LDPC5GFreeRideExtra1BitExtraBerFer(:,3), 'm--o', ...
         LDPC5GFreeRideExtra1BitPayloadBerFer(:,1), LDPC5GFreeRideExtra1BitPayloadBerFer(:,3), 'k-d');


hold on;
grid on; % ��ʾ����

h_legend = legend('Payload data,${\ell}$=1',...
                  'Extra data,${\ell}$=1');  %ͼ����������������Ⱥ��Ӧ
set(h_legend,'Interpreter','latex');

xlabel('SNR(dB)');%��������
ylabel('BER');%��������



set(gcf,'color','white'); % ���ñ����ǰ�ɫ�� ԭ���ǻ�ɫ�� �������治�ÿ�
set(get(gca,'Children'),'linewidth',linewidth);%����ͼ���߿�
set(gca, 'XTick', 0:0.5:11);  % ���ú�����̶�ֵ
set(gca,'linewidth',2);       % �����������ϸ
set(gca, 'FontSize',18)        % ���������������� 8
set(get(gca,'Children'), 'markersize', markersize);  %���ñ�Ǵ�С
% set(get(gca,'Children'), 'MarkerEdgeColor','b', 'MarkerFaceColor','b');% ���ñ����ɫ,ͳһ��ɫ��
% axis([0 2.5 1e-6 1]);         % �������귶Χ

print(figure(1), '-depsc', '/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.eps');%����Ϊeps��ʽ��ͼƬcolor
exportgraphics(figure(1),'/home/jack/�ĵ�/��ɽ��ѧ/SemanticFreeRide/Figures/WER.pdf','ContentType','vector')
% saveas(figure(1), '/home/jack/������/MATLAB/ComLetter20230303/WER1.pdf','pdf');

 

