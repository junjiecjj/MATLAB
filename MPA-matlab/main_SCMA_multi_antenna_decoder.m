%% SCMA
clc;clear;
addpath('SCMA_detector/');
addpath('SCMA_tools/');
addpath('..\load_H_matrix');
addpath('..\My_LDPC/');
addpath('..\5G_polar_construction/');
addpath('..\Decoders/');
addpath('..\Tools/OLD');
addpath('..\Tools');
addpath('..\eBCH/');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Parameter settings %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 编码方案
%****************************LDPC****************************
encoding_scheme = 'LDPC';
% 获得H矩阵，并处理
% H = CCSDS_ldpc_n128_k64_H();
H = CCSDS_ldpc_n256_k128_H();
% H = CCSDS_ldpc_n512_k256_H();
% H = Gallager_n8000_k4000_dv3dc6_H();
% H = CMMB_LDPC_n9216_k4608();
% H = IEEE80211ad_n672_k336_H();
% H = N999M111();
% H = N1998M222();
% H = N273M82();
% H = N96M48();
% H = N504M252();
% H = N1008M504();
% H = N1057M244();
% H = N2048M1030();
% H = N16383M2131();
% H = EG255();
% H = EG1023();
% H = EG4095();
% H = PG273();
% H = PG1057();
% H = IEEE80211n(648, 5/6);% N takes values in {648, 1296, 1944}. R takes values in {1/2, 2/3, 3/4, 5/6}.
% H = IEEE80216e(576, '1/2');%N takes values in {576   672   768   864   960  1056  1152  1248  1344  1440  1536  1632  1728  1824  1920  2016  2112  2208  2304}.%R takes values in {'1/2', '2/3A', '2/3B', '3/4A', '3/4B', '5/6'}.
% H = LDPC_GF256();
[H_column_permuted, m1, n, k1, vn_degree, cn_degree, P, H_row_one_absolute_index, H_column_one_relative_index, vn_distribution, cn_distribution] = H_matrix_process(H);
G = [eye(k1) P'];
R = k1/n;



%****************************5G polar码****************************
% encoding_scheme = '5G polar';
% n = 64;    %实际码长
% k = 16;        %实际信息比特长度
% crc_length = 11; %crc校验位长度
% R = k/n;            %码率
% %crc generator matrix and parity check matrix
% poly = get_crc_poly(crc_length);
% [G_crc,~,~] = make_CRC_GH(k, poly);
% %5G Construction
% [N, rate_matching_mode, rate_matching_pattern, frozen_pattern] = Para_5GConstruction(k, E, crc_length);
% frozen_pattern_after_rate_matching = frozen_pattern(rate_matching_pattern);%速率兼容后的冻结模式
% %Polar生成矩阵
% G_polar_full = G_matrix(N);
% G_polar = G_polar_full(frozen_pattern==0,rate_matching_pattern);
% G_AA = G_polar_full(frozen_pattern==0,frozen_pattern==0);
% crc+polar生成矩阵
%----------高斯消元系统编码方法-------------
%G = mod(G_crc*G_polar,2);
%[G,perm_index] = my_Gauss_Elimination(G);

%****************************eBCH码****************************
% encoding_scheme = 'eBCH';
% H = eBCH_n8_k4_dmin4_H();
% H = eBCH_n16_k7_dmin6_H();
% H = eBCH_n32_k11_dmin12_H();
% H = eBCH_n64_k16_dmin24_H();
% H = eBCH_n64_k24_dmin16_H();
% H = eBCH_n64_k30_dmin14_H();
% H = eBCH_n64_k36_dmin12_H();
% H = eBCH_n128_k64_H();
% n = size(H,2);
% k = n-size(H,1);
% R = k/n;
% [H_sys,perm_index] = my_Gauss_Elimination(H);
% G = [eye(k) H_sys(:,n-k+1:n)'];



% CB = CodeBook();%获取码本
%--------------下述码本功率没有归一化-----------------
% CB = CodeBook_test();%获取码本
CB = CodeBook_HuaWei();
% load('GAM_M4','CB')    % Load the codebook
% load('LPCB_A42','CB')
% load('LPCB_A43','CB')
% load('StarQAM','CB')
% load('HUAWEI_M4F5x10','CB')
% load('DE_rayleigh','CB');%来自文献2020_ICCC_Design of SCMA Codebooks Using Differential Evolution
%下面三个码本来自文献2024_TWC_Enhancing Signal Space Diversity for SCMA Over Rayleigh Fading Channels
% load('PCB1','CB')
% load('PCB2','CB')
% load('AMICB_1','CB')
%--------------上述码本功率没有归一化-----------------
[K, M, J] = size(CB);   %J个用户，K个资源节点，每个用户码本中M个码字
%---------------功率归一化，保证每个正交资源上叠加符号平均功率为1-------------
power = zeros(1,K);
for k = 1:K
    power(k) = sum(sum(abs(CB(k,:,:)).^2))/M;
    CB(k,:,:) = CB(k,:,:)/sqrt(power(k));
end
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算
d_v = sum(CB(:,1,1)~=0);      %VN节点度数，以第一个用户码本中的第一个码字为例计算
bits_num = log(M)/log(2);%SCMA码字对应的比特数
%以每个用户码本中第一个码字为例分析每个用户占用资源节点下标
temp = CB(:,1,:);%每个用户第一个码字
temp2 = reshape(temp,size(temp,1),size(temp,3));%转换为2维矩阵
[row2,~,~] = find(temp2);%寻找非零元素行下标
col_valid = reshape(row2,d_v,J);%每列对应一个用户占用的资源节点下标
temp3 = temp2';
[row3,~,~] = find(temp3);%寻找非零元素行下标
row_valid = reshape(row3,d_f,K)';%每行对应一个资源上的用户下标
%Com = Combination(J, M);%所有可能的码字下标组合，ML detector用
frame_length = n/bits_num;%符号长度
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
mset_double = zeros(M^(d_f-1),d_f-1);
for t = 0:M^(d_f-1)-1
    for i = 1:d_f-1
        mset_double(t+1,i) = base2dec(mset_char(t+1,i),M);
    end
end

Nr = 2;%接收端天线数
iter_all = 3;  %最大迭代次数，Number of iterations in decoding
iter_detector = 3;
iter_LDPC = 3;
vec = 5:0.5:18;%信噪比，SNR
%--------信噪比类型------
SNR = 'Eb/N0';
% SNR = 'SNR';
%SNR = 'Es/N0';
%-------信道类型--------
% channel = 'AWGN';
% channel = 'quasi-static rician';
channel = 'fast fading rician';
K_ric = 0;%Rician信道因子线性;0-Rayleigh信道

order = 2;
D = 2;
max_test_num = 4526;%k=16,6阶，14893；k=30,3阶，4526,k=24,4阶，12951
max_runs = 1e12;    %最大仿真帧数
max_err = 50;      %最大错误帧数
display_interval = 1;%显示间隔

%检测器类型
%detector = 'MLdetector';
detector = 'MPAdetector';
%detector = 'LogMPAdetector';
%detector = 'maxLogMPAdetector';

%译码器选择,只是将相应译码器名称写入文件
%软入软出OSD
Decoder = 'Joint_estimation_SISO_OSD_decoder';%
%Decoder = 'Independent_estimation_SISO_OSD_decoder';%
%Decoder = 'SISO_OSD_decoder';
%Decoder = 'SISO_OLDn_decoder';
%Decoder = 'SISO_PB_OSD_decoder';



%% 存储结果
num_runs = zeros(1,length(vec));
error_symbols = zeros(1,length(vec));
ser = zeros(1,length(vec));
error_bits = zeros(1,length(vec));
ber = zeros(1,length(vec));
error_blocks = zeros(1,length(vec));
bler = zeros(1,length(vec));
total_test_num = zeros(1,length(vec));
test_num = zeros(1,J);
ave_test_num = zeros(1,length(vec));
c_esti = zeros(J,n);%存储每个用户当前译码结果
c_esti_temp = zeros(J,n,iter_all);%存储每个用户每次迭代译码结果
source_symbols = zeros(J,frame_length);%编码后的符号

y = zeros(K,frame_length,Nr);%存储接收结果
H = zeros(d_v,J,frame_length,Nr);%存储信道矩阵

name = ['../Results\ SCMA_'  detector Decoder encoding_scheme '_n' num2str(n) '.txt'];
filename = fopen(name,'a+');
fprintf(filename,'\n\n');
fprintf(filename,'程序开始时间：%s \n',datetime('now'));
fprintf(filename,'n = %d  ',n);
fprintf(filename,'encoding_scheme = %s  ', encoding_scheme);
fprintf(filename,'Decoder = %s  ', Decoder);fprintf(filename,'\n');
fprintf(filename,'K = %d  ',K);
fprintf(filename,'J = %d  ',J);
fprintf(filename,'M = %d  ',M);
fprintf(filename,'iter_all = %d  ',iter_all);
fprintf(filename,'iter_detector = %d  ',iter_detector);fprintf(filename,'\n');
fprintf(filename,'max_runs = %1.2e  ',max_runs);
fprintf(filename,'max_err = %d  ',max_err);
fprintf(filename,'display_interval = %d  ',display_interval);fprintf(filename,'\n');
fprintf(filename, [SNR  '        BER          BLER           ave_test_num         total_blocks']);fprintf(filename,'\n');
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
            sigma = sigma/sqrt(2);
        case 'Es/N0'
            sigma = 1/sqrt(2*J/K) * 10^(-vec(i_vec)/20);%E_s/N_0，单路噪声功率
    end
    for i_run = 1 : max_runs
        %inteleaver_matrix = Interleaver(J,n);%交织序列
        inteleaver_matrix = repmat(1:n,J,1);%无交织序列
        %生成数据，编码
        info = rand(J, k1) > 0.5;%信源比特，每行是一个用户的
        coded_bits = mod(info*G,2);%编码比特，每行是一个用户的
        for j = 1:J
            coded_bits(j,:) = coded_bits(j,inteleaver_matrix(j,:));%交织
        end
        for i_frame = 1:frame_length%获得SCMA码字下标
            source_symbols(:,i_frame) = coded_bits(:,(i_frame-1)*bits_num+1:i_frame*bits_num)*bit_weight+1;
        end
        for nr = 1:Nr
        %选择信道
        switch channel
            %----------AWGN------------
            case 'AWGN'
                h = ones(d_v,J,frame_length);%全1系数
            %--------准静态衰落---------
            case 'quasi-static rician'
                temp = sqrt(K_ric/(K_ric+1))+sqrt(1/(K_ric+1))*(randn(d_v,J)+1i*randn(d_v,J))/sqrt(2);%同一个用户同一资源块上的符号有相同的信道系数
                h = repmat(temp,1,1,frame_length);%复制
            %--------快衰落---------
            case 'fast fading rician'
                h = sqrt(K_ric/(K_ric+1))+sqrt(1/(K_ric+1))*(randn(d_v,J,frame_length)+1i*randn(d_v,J,frame_length))/sqrt(2);%瑞利衰落系数，SCMA码字中每个复数信号有单独的系数 
        end
        symbols = SCMA_Encoder(source_symbols, CB, h, col_valid);%编码，每列是一组待发送复数信号
        noise = randn(K, frame_length) + randn(K, frame_length) * 1j;%AWGN噪声，每个资源块加独立噪声，复数
        y(:,:,nr) = symbols + sigma*noise;
        H(:,:,:,nr) = h;
        end
        %**********************************************JDD/EPA/MPA*********************************************
        %JDD/MPA
        %c_esti = JDD_MPA_for_multi_antenna(CB, y, H, Nr, sigma, iter_all, col_valid, row_valid, mset_double, bits, inteleaver_matrix, H_row_one_absolute_index, H_column_one_relative_index, n, m1, vn_degree, cn_degree);
        %JDD/EPA
        %c_esti = JDD_EPA_for_multi_antenna(CB, y, H, Nr, sigma, iter_all, col_valid, row_valid, inteleaver_matrix, H_row_one_absolute_index, H_column_one_relative_index, n, m1, vn_degree, cn_degree);
        %JDD/EPA，没有门限
        %c_esti = JDD_EPA_for_multi_antenna_without_Threshold(CB, y, H, Nr, sigma, iter_all, col_valid, row_valid, inteleaver_matrix, H_row_one_absolute_index, H_column_one_relative_index, n, m1, vn_degree, cn_degree);
        %**********************************************JDD/EPA/MPA*********************************************
        prior_detector = ones(J,d_v,M,frame_length)/M;
        for i_iter = 1:iter_all
            %****************************detector******************************
            %### [llr_detector_output, ~] = SCMA_multi_antenna_MPAdetector_forIter(CB, y, H, sigma, iter_detector, col_valid, row_valid, bits, mset_double, Nr, prior_detector);
            % [llr_detector_output, ~] = SCMA_multi_antenna_MPAdetector_forIter1(CB, y, H, sigma, iter_detector, col_valid, row_valid, bits, mset_double, Nr, prior_detector);
            [llr_detector_output, ~] = SCMA_multi_antenna_EPAdetector_forIter(CB, y, H, sigma, iter_detector, col_valid, row_valid, bits, prior_detector, Nr);
            %****************************detector******************************
            
            %对每个用户分别译码
            prior_detector = ones(J,d_v,M,frame_length);
            for j = 1:J
                llr_decoder_input = llr_detector_output(j,:);
                llr_decoder_input(inteleaver_matrix(j,:)) = llr_decoder_input;%解交织
                
                %****************************decoder******************************
                %软入软出OSD，联合估计
                %[llr_decoder_output, test_num(j), c_esti(j,:)] = Joint_estimation_SISO_OSD_decoder(llr_decoder_input, G, order);
                %proposed，多段拟合，确保每个位置都能获得软信息，
                %[llr_decoder_output, test_num(j), c_esti(j,:)] = SISO_OLDn_decoder(llr_decoder_input, G, D);
                %BP
                [llr_decoder_output, c_esti(j,:)] = my_LDPC_Flooding_BP_decoder_forIter(llr_decoder_input, H_row_one_absolute_index, H_column_one_relative_index, n, m1, vn_degree, cn_degree, iter_LDPC);
                llr_decoder_output = llr_decoder_output - llr_decoder_input ;%获取外信息
                %总测试TEPs次数加
                total_test_num(i_vec) = total_test_num(i_vec) + test_num(j);
                llr_decoder_output = llr_decoder_output(inteleaver_matrix(j,:));%交织
                %****************************decoder******************************
                for d = 1:frame_length
                    temp = llr_decoder_output((d-1)*bits_num+1:d*bits_num);
                    p1 = 0.5-0.5*tanh(temp/2);
                    p0 = 1-p1;
                    p = [p0;p1];
                    for m = 1:M
                        temp1 = bits(m,:);%将码字下标转为二进制比特
                        for b = 1:bits_num
                            prior_detector(j,:,m,d) = p(temp1(b)+1,b)*prior_detector(j,:,m,d); 
                        end
                    end
                    for i_dv = 1:d_v
                        prior_detector(j,i_dv,:,d) = prior_detector(j,i_dv,:,d)/sum(prior_detector(j,i_dv,:,d));%概率归一化
                    end
                end
            end
        end

        for j = 1:J
            temp = c_esti(j,:);
            info_esti = temp(1:k1);%得到信息比特
            if any(info_esti ~= info(j,:))
                %误帧数加一
                error_blocks(i_vec) = error_blocks(i_vec) + 1;
                %误比特数
                error_bits(i_vec)=sum(mod((info_esti+info(j,:)), 2)) + error_bits(i_vec);
            end

        end


        %总仿真帧数加N_u
        num_runs(i_vec) = num_runs(i_vec) + J;
        %BER
        ber(i_vec) = error_bits(i_vec)/(num_runs(i_vec)*k1);
        %BLER
        bler(i_vec) = error_blocks(i_vec)/num_runs(i_vec);
       
        %平均测试TEPs次数
        ave_test_num(i_vec) = total_test_num(i_vec)/num_runs(i_vec);
        
        
        %若达到最大仿真帧数则跳出
        if error_blocks(i_vec) >= max_err*J
            break;
        end
        
        
        if mod(i_run, display_interval) == 0
            disp(' ');            disp(['Sim iteration running = ' num2str(i_run)]);
            disp(['encoding_scheme = ' encoding_scheme '  n = ' num2str(n)         '  k = '  num2str(k) '  Decoder = ' Decoder]);
            disp( ['K = ' num2str(K)         '  J = '  num2str(J)  '  M = '  num2str(M)  '  iter_all = '  num2str(iter_all) '  iter_detector = '  num2str(iter_detector)]);
            disp( [SNR '       BER          BLER       ave_test_num   error_blocks']);
            disp(num2str([vec(1:i_vec)', ber(1:i_vec)', bler(1:i_vec)',ave_test_num(1:i_vec)', error_blocks(1:i_vec)']));
            disp(' ');
        end
    end
    fprintf(filename,'%f    %1.9f       %1.9f      %f    %d\n',vec(i_vec), ber(i_vec), bler(i_vec), ave_test_num(i_vec), num_runs(i_vec));
end
toc
disp('程序结束时间：');
disp(datetime('now'));
fprintf(filename,'程序运行时间：%s \n',num2str(toc));
fprintf(filename,'程序结束时间：%s \n',datetime('now'));
fclose(filename);