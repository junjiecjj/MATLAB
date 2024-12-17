%% SCMA
clc;clear;
addpath('Results/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Parameter settings %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 获取码本
%--------------下述码本功率没有归一化（不同用户的码本以及同一用户的码本中的码字功率都可能是不同的）-----------------
%下面码本来自文献2024_TWC_Enhancing Signal Space Diversity for SCMA Over Rayleigh Fading Channels
% load('PCB1','CB')%K4 M=4 J=6
% load('PCB2','CB')%K4 M=4 J=6
% load('PCB3','CB')%K4 M=8 J=6
% load('PCB4','CB')%K4 M=8 J=6
% load('AMICB1','CB')%K4 M=4 J=6
% load('AMICB2','CB')%K4 M=8 J=6
%上面码本来自文献2024_TWC_Enhancing Signal Space Diversity for SCMA Over Rayleigh Fading Channels
% CB = CodeBook_IDD();
%-----------K=4,M=4,J=6---------------
% CB = CodeBook_HuaWei();
% load('GAM_M4','CB')    % Load the codebook
% load('LPCB_A42','CB')
% load('LPCB_A43','CB')
load('StarQAM','CB')
% load('HUAWEI_M4F5x10','CB')
% CB = DE_AWGN();%来自文献2020_ICCC_Design of SCMA Codebooks Using Differential Evolution
% load('DE_rayleigh','CB');%来自文献2020_ICCC_Design of SCMA Codebooks Using Differential Evolution

%--------------上述码本功率没有归一化-----------------
[K, M, J] = size(CB);   %J个用户，K个资源节点，每个用户码本中M个码字
%功率归一化，保证每个正交资源上叠加符号平均功率为1
% power = zeros(1,K);
% for k = 1:K
%     power(k) = sum(sum(abs(CB(k,:,:)).^2))/M;
%     CB(k,:,:) = CB(k,:,:)/sqrt(power(k));
% end
CB(:,:,:) = CB(:,:,:)/sqrt(sum(sum(sum(abs(CB(:,:,:)).^2)))/(M*K));

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
Com = Combination(J, M);%所有可能的码字下标组合，ML detector用



frame_length = 1000; %h和noise蒙特卡洛次数

R = 1;%码率
vec = 0:5:30;%信噪比
%--------信噪比类型------
% SNR = 'Eb/N0';
SNR = 'SNR';
% SNR = 'Es/N0';
%-------信道类型--------
channel = 'AWGN';
% channel = 'quasi-static rician';
% channel = 'fast fading rician';
K_ric = 0;%Rician信道因子线性;0-Rayleigh信道

%% 存储结果
CB_temp = zeros(K,M,J,frame_length);
sum_rate = zeros(1, length(vec));
name = ['Results\SCMA_'  'sum_rate'  '.txt'];
filename = fopen(name,'a+');
fprintf(filename,'\n\n');
fprintf(filename,'程序开始时间：%s \n',datetime('now'));fprintf(filename,'\n');
fprintf(filename,'K = %d  ',K);
fprintf(filename,'J = %d  ',J);
fprintf(filename,'M = %d  ',M);fprintf(filename,'\n');
fprintf(filename, [SNR          'sum_rate ']);fprintf(filename,'\n');
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

    temp_MJ = 0;
    for c = 1:M^J
        source_symbols = Com(c,:)';%当前所有用户码字下标组合
        %每帧分别处理
        sum_nh = 0;
        for i = 1:frame_length
            %选择信道
            switch channel
                %----------AWGN------------
                case 'AWGN'
                    h = ones(K,J);%全1系数
                    %--------准静态衰落---------
                case 'quasi-static rician'
                    h = sqrt(K_ric/(K_ric+1))+sqrt(1/(K_ric+1))*(randn(K,J)+1i*randn(K,J))/sqrt(2);%同一个用户同一资源块上的符号有相同的信道系数
                    %--------快衰落---------
                case 'fast fading rician'
                    h = sqrt(K_ric/(K_ric+1))+sqrt(1/(K_ric+1))*(randn(K,J)+1i*randn(K,J))/sqrt(2);%瑞利衰落系数，SCMA码字中每个复数信号有单独的系数
            end
            symbols = SCMA_Encoder(source_symbols, CB, h, col_valid);%编码，每列是一组待发送复数信号
            noise = randn(K, 1) + randn(K,1) * 1j;%AWGN噪声，每个资源块加独立噪声，复数
            y = symbols + sigma*noise;
            
            %将所有码本符号乘上相应的系数
            for j = 1:J
                for m = 1:M
                    CB_temp(col_valid(:,j),m,j) = CB(col_valid(:,j),m,j).*h(col_valid(:,j),j);
                end
            end
            %分子部分
            temp_up = 0;
            for t = 1:M^J
                temp_index = Com(t,:);
                temp_sum = zeros(K,1);
                for j = 1:J%获得当前码字组合的叠加结果
                    temp_sum = temp_sum+CB_temp(:,temp_index(j),j);
                end
                temp_k = 0;
                for k = 1:K%获得所有资源上概率连乘后指数的分子部分（和）
                    temp_k = temp_k+abs(y(k)-temp_sum(k)).^2;
                end
                temp_up = temp_up+exp(-temp_k/(2*sigma^2));
            end

            %分母部分
            temp_sum = zeros(K,1);
            for j = 1:J
                temp_sum = temp_sum+CB_temp(:,source_symbols(j),j);
            end
            temp_k = 0;
            for k = 1:K
                temp_k = temp_k+abs(y(k)-temp_sum(k)).^2;
            end
            temp_down = exp(-temp_k/(2*sigma^2));
            %当前n和h下结果
            temp_nh = sum(log2(temp_up./temp_down));%
            sum_nh = sum_nh+temp_nh;
        end
        temp_MJ = temp_MJ+sum_nh/frame_length;
    end
    sum_MJ = temp_MJ/M^J;
    %和速率
    sum_rate(i_vec) = (J*log2(M)-sum_MJ);
    disp(' ');
    disp( [SNR '    sum_rate  ']);
    disp(num2str([vec(1:i_vec)', sum_rate(1:i_vec)']));
    disp(' ');
    fprintf(filename,'%f    %1.9f   \n',vec(i_vec), sum_rate(i_vec));
end
plot(vec,sum_rate);
toc
disp('程序结束时间：');
disp(datetime('now'));
fprintf(filename,'程序运行时间：%s \n',num2str(toc));
fprintf(filename,'程序结束时间：%s \n',datetime('now'));
fclose(filename);