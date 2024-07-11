% ======================== 绘制时域波形图=======================
Fs = 1000;                                % 总的采样率
N = 1024;                                % 总的子载波数
T = N / Fs;                              % 信号绘制为一个周期的长度
x = 0 : 1/Fs : T-1/Fs;                   % 生成时间向量，用于绘制波形
Numscr = 4;                              % 绘制的子载波数量
s_data = 1;                              % 初始相位
y = zeros(Numscr, numel(x));             % 初始化存储每个子载波的复数值的矩阵
ini_phase = repmat(s_data, 1, numel(x));  % 生成与时间长度相匹配的初始相位向量
for k = 0 : Numscr-1                      % 循环遍历要绘制的子载波数量
    for n = 0 : numel(x)-1                % 循环遍历时间序列
        y(k+1, n+1) = ini_phase(n+1) * exp(1i * 2 * pi * k * n / N);  % 计算每个时间点上每个子载波的复数值
    end
end
figure(1);
plot(x, real(y));                         % 绘制时域波形
xlabel('时间/s');                          % 设置 X 轴标签为“时间”
ylabel('幅度/V');                          % 设置 Y 轴标签为“幅度”

%% ======================== 绘制频域波形图=======================
f = (-Fs/2 : Fs/numel(x) : Fs/2-Fs/numel(x));
y_fft = zeros(Numscr, numel(x));
for k = 1 : Numscr
    y_fft(k, :) = abs(fftshift(fft(y(k,:)))) / N;  % 计算每个子载波的频谱
end
figure(2)
plot(f, y_fft(1,:), f, y_fft(2,:), f, y_fft(3,:), f, y_fft(4,:));
grid on;
xlim([-10, 10]);                          % 将 x 轴范围限制在 -10 到 10 之间
xlabel('频率/Hz');
ylabel('幅度/V');

%%
figure(3)
a = 20;
y1 = zeros(Numscr, a * N);
y_combined = horzcat(y, y1);              % 水平拼接两个矩阵
f = (-Fs/2 : Fs/((a+1)*N) : (Fs/2-Fs/((a+1)*N)));
y_fft = zeros(Numscr, (a+1)*N);
for k = 1 : Numscr
    y_fft(k, :) = abs(fftshift(fft(y_combined(k,:)))) / N;  % 计算每个子载波的频谱
end
plot(f, y_fft(1,:), f, y_fft(2,:), f, y_fft(3,:), f, y_fft(4,:));
grid on;
xlim([-10, 10]);                          % 将 x 轴范围限制在 -10 到 10 之间
xlabel('频率/Hz');
ylabel('幅度/V');



%%
a = 20;
y1 = zeros(Numscr, a * N);
y_combined = horzcat(y, y1);              % 水平拼接两个矩阵
f = (-Fs/2 : Fs/((a+1)*N) : (Fs/2-Fs/((a+1)*N)));
y_fft = zeros(Numscr, (a+1)*N);
for k = 1 : Numscr
    y_fft(k, :) = real(fftshift(fft(y_combined(k,:)))) / N;  % 计算每个子载波的频谱
end

figure(4)
plot(f, y_fft(1,:), f, y_fft(2,:), f, y_fft(3,:), f, y_fft(4,:));
grid on;
xlim([-10, 10]);                          % 将 x 轴范围限制在 -10 到 10 之间
xlabel('频率/Hz');
ylabel('幅度/V');
