

close all;
clear all;
clc;



%========================================================
% 检测增益文件：原始代码
%========================================================

load('sin_detect_gain.txt');
detect_gain = sin_detect_gain;

%======================================================
% 多项式拟合
%======================================================

FitNum = 1;  %拟合阶数
PolyCoe = polyfit(detect_gain(:,1), detect_gain(:,2), FitNum);  %多项式拟合系数



figure
plot(detect_gain(:,1),detect_gain(:,2))


%=====================================================
% 计算多项式
%=====================================================
DetGain = 110:200;    %检测增益文件：原始代码
ySnr = polyval(PolyCoe, DetGain);
FitErr = polyval(PolyCoe, detect_gain(:,1)) - detect_gain(:,2);
mse = std(FitErr);


figure
plot(detect_gain(:,1), detect_gain(:,2), 'r', DetGain, ySnr, 'b')
