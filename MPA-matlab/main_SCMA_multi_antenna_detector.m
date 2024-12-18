%% SCMA
clc;clear;
addpath('SCMA_detector/');
addpath('SCMA_tools/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Parameter settings %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%不同码本的能量没有归一化
CB = CodeBook();%获取码本，该码本每个正交资源上的平均功率为1
%--------------下述码本功率没有归一化，慎用-----------------
% CB = CodeBook_test();%获取码本
% CB = CodeBook_HuaWei();%每个正交资源上的平均功率不是1，所以SNR等的定义是不对的
% load('GAM_M4','CB')    % Load the codebook
% load('LPCB_A42','CB')
% load('LPCB_A43','CB')
% load('StarQAM','CB')
% load('HUAWEI_M4F5x10','CB')
%--------------上述码本功率没有归一化，慎用-----------------

[K, M, J] = size(CB);   %J个用户，K个资源节点，每个用户码本中M个码字
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算，Each FN is connected to 3 VNs
d_v = sum(CB(:,1,1)~=0);   %VN节点度数，以第一个用户码本中的第一个码字为例计算，Each VN is connected to 2 FNs
bits_num = log(M)/log(2);   %SCMA码字对应的比特数
%以每个用户码本中第一个码字为例分析每个用户占用资源节点下标
temp = CB(:,1,:);%每个用户第一个码本
temp2 = reshape(temp,size(temp,1),size(temp,3));%转换为2维矩阵
[row2,col2,~] = find(temp2);%寻找非零元素行下标
col_valid = reshape(row2,d_v,J);%每列对应一个用户占用的资源节点下标
temp3 = temp2';
[row3,~,~] = find(temp3);%寻找非零元素行下标
row_valid = reshape(row3,d_f,K)';%每行对应一个资源上的用户下标
%Com = Combination(J, M);%所有可能的码字下标组合，ML detector用
bit_weight = 2.^(bits_num-1:-1:0)';%左边是高位
temp = dec2base(0:M-1,2,bits_num);
bits = zeros(M,bits_num);
for m = 1:M
    for i = 1:bits_num
        bits(m,i) = base2dec(temp(m,i),2);
    end
end
temp = 0:M^(d_f-1)-1;
mset_char = dec2base(temp,M,d_f-1);%十进制数n转为M进制，产生df-1长序列
mset_double = zeros(M^(d_f-1),d_f-1);%每个资源被df个用户占用，除去一个用户后，剩余用户码字组合的十进制表示为0:M^(d_f-1)-1，将其转换为M进制，长为df-1位，每一位对应一个码字下标
for t = 0:M^(d_f-1)-1
    for i = 1:d_f-1
        mset_double(t+1,i) = base2dec(mset_char(t+1,i),M);
    end
end

Nr = 8;%接收端天线数
n = 64;%信道编码码字长度
R = 1;%码率
frame_length = n/bits_num;%符号长度
iter_detector = 5;  %detector最大迭代次数，Number of iterations in decoding
vec = 10:2:20;%信噪比
%--------信噪比类型------
SNR = 'Eb/N0';
% SNR = 'SNR';
% SNR = 'Es/N0';
%-------信道类型--------
% channel = 'AWGN';
% channel = 'quasi-static rician';
channel = 'fast fading rician';
K_ric = 0;%Rician信道因子线性;0-Rayleigh信道


max_runs = 1e12;    %最大仿真帧数
max_err = 300;      %最大错误帧数
display_interval = 10;%显示间隔

%检测器类型
%detector = 'MLdetector';
detector = 'MPAdetector';
%detector = 'LogMPAdetector';
%detector = 'maxLogMPAdetector';
%% 存储结果
num_runs = zeros(1,length(vec));
error_symbols = zeros(1,length(vec));
ser = zeros(1,length(vec));
error_bits = zeros(1,length(vec));
ber = zeros(1,length(vec));
error_blocks = zeros(1,length(vec));
bler = zeros(1,length(vec));
source_symbols = zeros(J,frame_length);%编码后的符号
source_bits_esti = zeros(J,n);
num_total_iter = zeros(1, length(vec));
num_ave_iter = zeros(1, length(vec));

y = zeros(K,frame_length,Nr);%存储接收结果
H = zeros(d_v,J,frame_length,Nr);%存储信道矩阵

name = ['./Results\ SCMA_'  detector '_n' num2str(n) '.txt'];
filename = fopen(name,'a+');
fprintf(filename,'\n\n');
fprintf(filename,'程序开始时间：%s \n',datetime('now'));
fprintf(filename,'n = %d  ',n);fprintf(filename,'\n');
fprintf(filename,'K = %d  ',K);
fprintf(filename,'J = %d  ',J);
fprintf(filename,'M = %d  ',M);
fprintf(filename,'iter_detector = %d  ',iter_detector);fprintf(filename,'\n');
fprintf(filename,'max_runs = %1.2e  ',max_runs);
fprintf(filename,'max_err = %d  ',max_err);
fprintf(filename,'display_interval = %d  ',display_interval);fprintf(filename,'\n');
fprintf(filename, [SNR          'BER          SER            BLER         total_blocks']);fprintf(filename,'\n');
%% 遍历SNR
%程序运行时间
tic
for i_vec = 1 : length(vec)
    %根据不同信噪比形式获得单路噪声功率，为复数信道，因此加性噪声sigma为单路噪声
    switch SNR
        case 'Eb/N0'
            sigma = 1/sqrt(2*R*log2(M)*J/K) * 10^(-vec(i_vec)/20);%E_b/N_0，一个正交资源上单路噪声功率，J个用户在K个资源上共传输log2(M)*J编码比特，码率R，平均每个资源传输Rlog2(M)*J/K个信息比特
        case 'SNR'
            sigma = 1/10^(vec(i_vec)/20);%SNR
            sigma = sigma/sqrt(2);%为复数信道，则sigma应为单路噪声功率
        case 'Es/N0'
            sigma = 1/sqrt(2*J/K) * 10^(-vec(i_vec)/20);%E_s/N_0，单路噪声功率
    end
    for i_run = 1 : max_runs
        %生成数据，编码
        source_bits = rand(J, n) > 0.5;%信源比特，每行是一个用户的
        for i_frame = 1:frame_length%获得SCMA码字下标
            source_symbols(:,i_frame) = source_bits(:,(i_frame-1)*bits_num+1:i_frame*bits_num)*bit_weight+1;
        end

        for nr = 1:Nr
            %选择信道
            switch channel
                %----------AWGN------------
                case 'AWGN'
                    h = ones(d_v,J,frame_length);%全1系数
                    %--------准静态衰落---------
                case 'quasi-static rician'
                    temp = (randn(d_v,J)+1i*randn(d_v,J))/sqrt(2);%同一个用户同一资源块上的符号有相同的信道系数
                    h = repmat(temp,1,1,frame_length);%复制
                    %--------快衰落---------
                case 'fast fading rician'
                    h = (randn(d_v,J,frame_length)+1i*randn(d_v,J,frame_length))/sqrt(2);%瑞利衰落系数，SCMA码字中每个复数信号有单独的系数
            end
            symbols = SCMA_Encoder(source_symbols, CB, h, col_valid);%编码，每列是一组待发送复数信号
            noise = randn(K, frame_length) + randn(K, frame_length) * 1j;%AWGN噪声，每个资源块加独立噪声，复数
            y(:,:,nr) = symbols + sigma*noise;
            H(:,:,:,nr) = h;
        end

        %****************************detector******************************
       
        % source_symbols_esti = SCMA_multi_antenna_MPAdetector1(CB, y, H, sigma, iter_detector, col_valid, row_valid, mset_double, Nr);
        source_symbols_esti = SCMA_multi_antenna_EPAdetector(CB, y, H, sigma, iter_detector, col_valid, row_valid, Nr);
        
        %****************************detector******************************


        %转换为比特
        for i_frame = 1:frame_length
            source_bits_esti(:,(i_frame-1)*bits_num+1:i_frame*bits_num) = bits(source_symbols_esti(:,i_frame),:);
        end

        %误帧数
        temp = source_symbols ~= source_symbols_esti;
        temp = sum(temp,2);
        err_block_sum = sum(temp>0);
        %误符号数
        err_symbols_sum = sum(temp);
        %误比特数
        temp = source_bits ~= source_bits_esti;
        err_bits_sum = sum(sum(temp));


        if err_symbols_sum > 0
            %误帧数加一
            error_blocks(i_vec) = error_blocks(i_vec) + err_block_sum;
            %误符号数
            error_symbols(i_vec) = error_symbols(i_vec) + err_symbols_sum;
            %误比特数
            error_bits(i_vec) = error_bits(i_vec) + err_bits_sum;
        end

        %总仿真帧数加
        num_runs(i_vec) = num_runs(i_vec) + J;
        %BLER
        bler(i_vec) = error_blocks(i_vec)/(J*i_run);
        %误符号率
        ser(i_vec) = error_symbols(i_vec)/(J*i_run*frame_length);
        %误比特率
        ber(i_vec) = error_bits(i_vec)/(J*i_run*frame_length *bits_num);

        %若达到最大仿真帧数则跳出
        if error_blocks(i_vec) >= max_err*J
            break;
        end

        if mod(i_run, display_interval) == 0
            disp(' ');            disp(['Sim iteration running = ' num2str(i_run)]);
            disp( ['n = ' num2str(n)         '  frame_length = '  num2str(frame_length)]);
            disp( ['K = ' num2str(K)         '  J = '  num2str(J)  '  M = '  num2str(M)  '  iter_detector = '  num2str(iter_detector)]);
            disp( [SNR '    BER        SER        BLER      error_blocks']);
            disp(num2str([vec(1:i_vec)', ber(1:i_vec)', ser(1:i_vec)', bler(1:i_vec)', error_blocks(1:i_vec)']));
            disp(' ');
        end
    end
    fprintf(filename,'%f    %1.9f    %1.9f     %1.9f       %d\n',vec(i_vec), ber(i_vec), ser(i_vec), bler(i_vec), num_runs(i_vec));
end
toc
disp('程序结束时间：');
disp(datetime('now'));
fprintf(filename,'程序运行时间：%s \n',num2str(toc));
fprintf(filename,'程序结束时间：%s \n',datetime('now'));
fclose(filename);