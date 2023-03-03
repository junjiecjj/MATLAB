

%%Polar N64 K32 CRC6 L8 
%---------------------------------
 SC=[
1.000000   0.1180433509  0.2929115407
1.500000   0.0662543403  0.1736111111
2.000000   0.0353225047  0.0941619586
2.500000   0.0143457953  0.0383641525
3.000000   0.0045861724  0.0119958734
3.500000   0.0012190436  0.0034158839
4.000000   0.0002674692  0.0007742911
4.500000   0.0000422019  0.0001277879

 ];

SC_Ber_Snr  = SC(:,1)';
SC_Ber   = SC(:,2)';
SC_Fer_Snr  = SC(:,1)';
SC_Fer   = SC(:,3)';
 
%---------------------------------
%%Polar N64 K32 CRC6 L16 
%---------------------------------
 OA_SC=[
1.000000   0.0948201064  0.2313743637
1.500000   0.0516035649  0.1301066875
2.000000   0.0256987729  0.0649266329
2.500000   0.0089325042  0.0231824926
3.000000   0.0026404579  0.0068717188
3.500000   0.0007092486  0.0019797589
4.000000   0.0001307090  0.0003705427
4.500000   0.0000224205  0.0000687085

 ];
 
OA_SC_Ber_Snr  = OA_SC(:,1)';
 OA_SC_Ber      = OA_SC(:,2)';
 OA_SC_Fer_Snr  = OA_SC(:,1)';
 OA_SC_Fer      = OA_SC(:,3)';

%---------------------------------
%Polar N64 K32 CRC6 L32
%---------------------------------
 SCFT2=[

1.000000   0.0786244829  0.1880406168
1.500000   0.0425163450  0.1037775010
2.000000   0.0188133226  0.0473440015
2.500000   0.0064851517  0.0159831218
3.000000   0.0018706628  0.0048596532
3.500000   0.0004835794  0.0013381650
4.000000   0.0000980205  0.0002806099

 ];
 
SCFT2_Ber_Snr  =SCFT2(:,1)';
 SCFT2_Ber     = SCFT2(:,2)';
 SCFT2_Fer_Snr  =SCFT2(:,1)';
 SCFT2_Fer     = SCFT2(:,3)';

 
%---------------------------------
%Polar N64 K32 CRC6 L64
%---------------------------------
 SCFT4=[
1.000000   0.0692418033  0.1639344262
1.500000   0.0362321950  0.0858074481
2.000000   0.0147080480  0.0368161402
2.500000   0.0053054239  0.0131648236
3.000000   0.0015834426  0.0041215358
3.500000   0.0004263380  0.0011830399
4.000000   0.0000872947  0.0002553410
 ];
 
SCFT4_Ber_Snr  =SCFT4(:,1)';
 SCFT4_Ber     = SCFT4(:,2)';
 SCFT4_Fer_Snr  =SCFT4(:,1)';
 SCFT4_Fer     = SCFT4(:,3)';



%---------------------------------

%---------------------------------
%Polar N64 K32 CRC6 L128
%---------------------------------
 SCFT8=[
1.000000   0.0641798048  0.1501501502
1.500000   0.0345792119  0.0810766986
2.000000   0.0139313961  0.0343878955
2.500000   0.0048468045  0.0119637260
3.000000   0.0014758921  0.0038718270
3.500000   0.0004220393  0.0011484062


];
 
SCFT8_Ber_Snr  =SCFT8(:,1)';
 SCFT8_Ber     = SCFT8(:,2)';
 SCFT8_Fer_Snr  =SCFT8(:,1)';
 SCFT8_Fer     = SCFT8(:,3)';


 

%---------------------------------


%%Polar N64 K32 CRC6 L8 GA
%---------------------------------
 SCGA=[
1.000000   0.1151929145  0.2868617326
1.500000   0.0635053897  0.1658374793
2.000000   0.0338910820  0.0897182846
2.500000   0.0135192959  0.0360334390
3.000000   0.0039958009  0.0104585007
3.500000   0.0010908353  0.0029358057
4.000000   0.0002057429  0.0005942032
4.500000   0.0000276407  0.0000811173


 ];

SCGA_Ber_Snr  = SCGA(:,1)';
SCGA_Ber   = SCGA(:,2)';
SCGA_Fer_Snr  = SCGA(:,1)';
SCGA_Fer   = SCGA(:,3)';
 
%---------------------------------
%%Polar N64 K32 CRC6 L16  GA
%---------------------------------
 OA_SCGA=[

1.000000   0.0902823285  0.2184359983
1.500000   0.0463087444  0.1169043722
2.000000   0.0227752424  0.0570450656
2.500000   0.0074628802  0.0188665006
3.000000   0.0020590163  0.0052863064
3.500000   0.0004541925  0.0011944577
4.000000   0.0000723696  0.0001895112

 ];
 
OA_SCGA_Ber_Snr  = OA_SCGA(:,1)';
 OA_SCGA_Ber      = OA_SCGA(:,2)';
 OA_SCGA_Fer_Snr  = OA_SCGA(:,1)';
 OA_SCGA_Fer      = OA_SCGA(:,3)';

%---------------------------------
%Polar N64 K32 CRC6 L32  GA
%---------------------------------
 SCFT2GA=[

1.000000   0.0678805934  0.1621271077
1.500000   0.0329762388  0.0812347685
2.000000   0.0135697899  0.0332491023
2.500000   0.0042704015  0.0102623045
3.000000   0.0011033741  0.0027775309
3.500000   0.0002023675  0.0005103041

 ];
 
SCFT2GA_Ber_Snr  =SCFT2GA(:,1)';
 SCFT2GA_Ber     = SCFT2GA(:,2)';
 SCFT2GA_Fer_Snr  =SCFT2GA(:,1)';
 SCFT2GA_Fer     = SCFT2GA(:,3)';

 
%---------------------------------
%Polar N64 K32 CRC6 L64  GA
%---------------------------------
 SCFT4GA=[

1.000000   0.0518605711  0.1215066829
1.500000   0.0237718187  0.0563063063
2.000000   0.0087091858  0.0206654267
2.500000   0.0022893412  0.0054289995
3.000000   0.0005386426  0.0013173773
3.500000   0.0000871788  0.0002070140

 ];
 
SCFT4GA_Ber_Snr  =SCFT4GA(:,1)';
 SCFT4GA_Ber     = SCFT4GA(:,2)';
 SCFT4GA_Fer_Snr  =SCFT4GA(:,1)';
 SCFT4GA_Fer     = SCFT4GA(:,3)';



%---------------------------------

%---------------------------------
%Polar N64 K32 CRC6 L128  GA
%---------------------------------
 SCFT8GA=[

1.000000   0.0373472968  0.0866400970
1.500000   0.0157030402  0.0361925443
2.000000   0.0053871507  0.0124847062
2.500000   0.0012968394  0.0031267979
3.000000   0.0002786988  0.0006534555

];
 
SCFT8GA_Ber_Snr  =SCFT8GA(:,1)';
 SCFT8GA_Ber     = SCFT8GA(:,2)';
 SCFT8GA_Fer_Snr  =SCFT8GA(:,1)';
 SCFT8GA_Fer     = SCFT8GA(:,3)';
%---------------------------------







%2-------------------------Draw_the_Figure-------------------------------------


%---------------------------------
figure(1)
%------------

%------------
h_SC_FERSNR=semilogy(SC_Fer_Snr,SC_Fer);
set(h_SC_FERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','+',...
                    'MarkerSize',8); 
hold on
grid on  
% ------------

% ------------
h_OA_SC_FERSNR=semilogy(OA_SC_Fer_Snr,OA_SC_Fer);
set(h_OA_SC_FERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','o',...
                    'MarkerSize',8); 
% ------------

% ------------
h_SCFT2_FERSNR=semilogy(SCFT2_Fer_Snr,SCFT2_Fer);
set(h_SCFT2_FERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','^',...
                    'MarkerSize',8); 
% ------------



% ------------
h_SCFT4_FERSNR=semilogy(SCFT4_Fer_Snr,SCFT4_Fer);
set(h_SCFT4_FERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','*',...
                    'MarkerSize',8); 
% ------------
% ------------
h_SCFT8_FERSNR=semilogy(SCFT8_Fer_Snr,SCFT8_Fer);
set(h_SCFT8_FERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','s',...
                    'MarkerSize',8); 
% ------------

%------------
h_SCGA_FERSNR=semilogy(SCGA_Fer_Snr,SCGA_Fer);
set(h_SCGA_FERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','+',...
                    'MarkerSize',6); 
hold on
grid on  
% ------------

% ------------
h_OA_SCGA_FERSNR=semilogy(OA_SCGA_Fer_Snr,OA_SCGA_Fer);
set(h_OA_SCGA_FERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','o',...
                    'MarkerSize',6); 
% ------------

% ------------
h_SCFT2GA_FERSNR=semilogy(SCFT2GA_Fer_Snr,SCFT2GA_Fer);
set(h_SCFT2GA_FERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','^',...
                    'MarkerSize',6); 
% ------------



% ------------
h_SCFT4GA_FERSNR=semilogy(SCFT4GA_Fer_Snr,SCFT4GA_Fer);
set(h_SCFT4GA_FERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','*',...
                    'MarkerSize',6); 
% ------------
% ------------
h_SCFT8GA_FERSNR=semilogy(SCFT8GA_Fer_Snr,SCFT8GA_Fer);
set(h_SCFT8GA_FERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','s',...
                    'MarkerSize',6); 
% ------------




% ------------





figure(2)

%------------
h_SC_BERSNR=semilogy(SC_Ber_Snr,SC_Ber);
set(h_SC_BERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','+',...
                    'MarkerSize',8); 
hold on
grid on  
% ------------

% ------------
h_OA_SC_BERSNR=semilogy(OA_SC_Ber_Snr,OA_SC_Ber);
set(h_OA_SC_BERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','o',...
                    'MarkerSize',8); 
% ------------

% ------------
h_SCFT2_BERSNR=semilogy(SCFT2_Ber_Snr,SCFT2_Ber);
set(h_SCFT2_BERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','s',...
                    'MarkerSize',8); 
% ------------



% ------------
h_SCFT4_BERSNR=semilogy(SCFT4_Ber_Snr,SCFT4_Ber);
set(h_SCFT4_BERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','^',...
                    'MarkerSize',8); 
% ------------

% ------------
h_SCFT8_BERSNR=semilogy(SCFT8_Ber_Snr,SCFT8_Ber);
set(h_SCFT8_BERSNR,'Color',[0 0 0],... 
                    'LineStyle','-',...
                    'LineWidth',2,...
                    'Marker','*',...
                    'MarkerSize',8); 
% ------------
%------------
h_SCGA_BERSNR=semilogy(SCGA_Ber_Snr,SCGA_Ber);
set(h_SCGA_BERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','+',...
                    'MarkerSize',6); 
hold on
grid on  
% ------------

% ------------
h_OA_SCGA_BERSNR=semilogy(OA_SCGA_Ber_Snr,OA_SCGA_Ber);
set(h_OA_SCGA_BERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','o',...
                    'MarkerSize',6); 
% ------------

% ------------
h_SCFT2GA_BERSNR=semilogy(SCFT2GA_Ber_Snr,SCFT2GA_Ber);
set(h_SCFT2GA_BERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','s',...
                    'MarkerSize',6); 
% ------------



% ------------
h_SCFT4GA_BERSNR=semilogy(SCFT4GA_Ber_Snr,SCFT4GA_Ber);
set(h_SCFT4GA_BERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','^',...
                    'MarkerSize',6); 
% ------------

% ------------
h_SCFT8GA_BERSNR=semilogy(SCFT8GA_Ber_Snr,SCFT8GA_Ber);
set(h_SCFT8GA_BERSNR,'Color',[1 0 0],... 
                    'LineStyle','--',...
                    'LineWidth',2,...
                    'Marker','*',...
                    'MarkerSize',6); 
% ------------



%------------



%-------------------------set axis; set legend----------------------------------%
figure(1)
%axis([-2,2,1e-7, 1e-1]);
xlabel('E_b/N_0(dB)');
ylabel('FER');
legend('CA-SCL L=8',...
'CA-SCL L=16',...
'CA-SCL L=32',...
'CA-SCL L=64',...
'CA-SCL L=128',...
'GA L=8',...
'GA L=16',...
'GA L=32',...
'GA L=64',...
'GA L=128');
title(' N=64 K=32 CRC=6 ');


figure(2)
%axis([-2,2,1e-7, 1e-1]);
xlabel('E_b/N_0(dB)');
ylabel('BER');
legend('CA-SCL L=8',...
'CA-SCL L=16',...
'CA-SCL L=32',...
'CA-SCL L=64',...
'CA-SCL L=128',...
'GA L=8',...
'GA L=16',...
'GA L=32',...
'GA L=64',...
'GA L=128');
title(' N=64 K=32 CRC=6 ');

% axis([1, 5,0, 10]);


