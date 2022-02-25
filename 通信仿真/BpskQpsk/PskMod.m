
%%==================================
% pskmod系统函数的用法
%===================================
clc;
close all;
clear;


%%==================================
% pskmod系统函数的用法案例1
%===================================
M = 4;

data = randi([0 M-1],1000,1);
txSig = pskmod(data,M,pi/M);
rxSig = awgn(txSig,20);
scatterplot(rxSig);

%%==================================
% pskmod系统函数的用法案例2
%===================================
M = 16;
data = randi([0 M-1],1000,1);
txSig = pskmod(data,M,pi/M);
rxSig = awgn(txSig,20);
scatterplot(rxSig);

%%==================================
% pskmod系统函数的用法案例3
%===================================
dataIn = randi([0 3],1000,1);
txSig = pskmod(dataIn,4,pi/4);
rxSig = awgn(txSig,10);

dataOut = pskdemod(rxSig,4,pi/4);
numErrs = symerr(dataIn,dataOut);

%%==================================
% pskmod系统函数的用法案例4
%===================================
M = 8;
data = (0:M-1);
phz = 0;

symgray = pskmod(data,M,phz,'gray');
mapgray = pskdemod(symgray,M,phz,'gray');

symbin = pskmod(data,M,phz,'bin');
mapbin = pskdemod(symbin,M,phz,'bin');

scatterplot(symgray,1,0,'b*');
for k = 1:M
    text(real(symgray(k))-0.2,imag(symgray(k))+.15,...
        dec2base(mapgray(k),2,4));
     text(real(symgray(k))-0.2,imag(symgray(k))+.3,...
         num2str(mapgray(k)));
    
    text(real(symbin(k))-0.2,imag(symbin(k))-.15,...
        dec2base(mapbin(k),2,4),'Color',[1 0 0]);
    text(real(symbin(k))-0.2,imag(symbin(k))-.3,...
        num2str(mapbin(k)),'Color',[1 0 0]);
end
axis([-2 2 -2 2]);



