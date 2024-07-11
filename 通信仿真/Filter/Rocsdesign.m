%% https://www.cnblogs.com/fangying7/p/4049101.html

% b = rcosdesign(beta,span,sps,shape)
% 
% beta: 滚降系数（因子），取值0~1之间，决定频宽和陡峭程度。取值一般大于0.2。
% 
% span: 表示截断的符号范围，对滤波器取了几个Ts的长度。
% 
% sps: 单个符号范围的采样个数。
% 
% shape：可选参数。可选择'normal'或者'sqrt'，也可不加。
% 
% 当选择'sqrt'时，返回一个平方根升余弦滤波器。

% filter: order = 48, rolloff factor: alpha = 0.5, sps = 8
% b = firros(n,Fc,df,Fs) Fc:cutoff frequency,df: transmition bandwidth, Fs:oversampling frequency
% h = firrcos(48, 0.5, 0.5, 8); 
Fc = 1/2;
h = rcosdesign(0.5, 6, 8); % 也可以
figure(1);
plot(h);
grid on;
xlabel('Time');
ylabel('Amplitude');
title(' raised cosine rolloff filter');

tx_bits1x = randi([0, 1], 100, 1)*2 -1;
tx_bits8x = zeros(1,800);
tx_bits8x(1:8:end) = tx_bits1x;

tx_shaped = filter(h, 1, tx_bits8x);
tx_sampled = tx_shaped(1:8:end);

figure(2);
stem(tx_bits1x(1:40));
title('orginal bitstream');

figure(3);
plot(tx_shaped(1:100));
title('output waveform');
grid on;

figure(4);
stem(tx_sampled(1:40));
grid on;
title('sampled output');


%% https://blog.csdn.net/weixin_43870101/article/details/106794354
clear all;
clc;
h = rcosdesign(0.25,6,4);
fvtool(h,'Analysis','impulse')

clear all;
clc;

rf = 0.25;
span = 4;
sps = 3;

% 设计一个衰减为 0.25 的升余弦滤波器。指定此过滤器跨越 4 个符号，每个符号 3 个样本。
h1 = rcosdesign(rf,span,sps,'normal');
fvtool(h1,'impulse')


% 根升余弦滤波器
h2 = rcosdesign(rf,span,sps,'sqrt');
fvtool(h2,'impulse')

% 将根升余弦滤波器与自身进行卷积。在最大值处截断脉冲响应，使其长度与 h1 相同。使用最大值归一化响应。然后，将卷积后的根升余弦滤波器与升余弦滤波器进行比较。
h3 = conv(h2,h2);
p2 = ceil(length(h3)/2);
m2 = ceil(p2-length(h1)/2);
M2 = floor(p2+length(h1)/2);
ct = h3(m2:M2);

stem([h1/max(abs(h1));ct/max(abs(ct))]','filled')
xlabel('Samples')
ylabel('Normalized amplitude')
legend('h1','h2 * h2')





%%   https://zhuanlan.zhihu.com/p/687335782
clear all;
clc;

beta = 0.8;
sps = 2;

span = 1;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化

span = 4;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化


span = 8;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化


span = 10;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化



beta = 0.8;
span = 8;

sps = 4;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化

sps = 8;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化


sps = 16;
hn = rcosdesign(beta, span, sps, "sqrt");
fvtool(hn,'Analysis','impulse'); %将脉冲响应可视化






















