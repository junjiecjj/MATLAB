%EPA检测
%输入：
%   CB - 码本
%   y - 输入数据，每列是一组
%   h - 信道系数
%   sigma - 单路噪声功率
%   iterNum - 迭代次数
%   col_valid - 每一列是该用户占用资源下标
%   row_valid - 每一行是占用该资源的用户下标
%   prior - decoder反馈的先验信息
%输出：
%   decoded_symbols - 输出符号
%   llr_output - 比特LLR，外信息
function [llr_output,decoded_symbols] = SCMA_multi_antenna_EPAdetector_forIter(CB, y, h, sigma, iterNum, col_valid, row_valid, bits, prior, Nr)
[K, M, J] = size(CB);  %J个用户，K个资源节点，M个码字
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算
d_v = sum(CB(:,1,1)~=0);   %VN节点度数，以第一个用户码本中的第一个码字为例计算
decision = zeros(J,iterNum);
bits_num = log(M)/log(2);%SCMA码字对应的比特数
decoded_symbols = zeros(J, size(y,2));

for d = 1:size(y,2)
    mean_K2J = complex(zeros(K,J,Nr));%资源节点向用户节点传递的信息，初始化为0（没有完全使用）
    variance_K2J = 1000*ones(K,J,Nr);%资源节点向用户节点传递的信息，初始化为max（一个较大的实数）
    pro_bit = zeros(2,bits_num,J);%存储每个用户所有码字比特0/1的概率
    for iter = 1:iterNum
        %% 用户节点更新
        %计算每个用户每个码字的后验概率（根据从资源节点返回的均值和方差计算）
        temp = prior(:,1,:,d);
        p_app = reshape(temp,J,M);
        for j = 1:J
            for m = 1:M
                for nr = 1:Nr
                for v = 1:d_v
                    p_app(j,m) = p_app(j,m)*exp(-(abs(CB(col_valid(v,j),m,j)-mean_K2J(col_valid(v,j),j,nr)))^2/variance_K2J(col_valid(v,j),j,nr));%每个用户每个码字的后验概率
                end
                end
            end
            p_app(j,:) = p_app(j,:)/sum(p_app(j,:));%概率归一化
            if isnan(p_app(j,:))%可能所有码字概率均为0，归一化后为nan，此时赋值等概率
                p_app(j,:) = 1/M;
            end
        end
        %计算后验均值和方差
        mean_app = complex(zeros(K,J));%该用户每个码字的概率乘以相应符号的累加
        %计算后验均值
        for j = 1:J
            for v = 1:d_v
                for m = 1:M
                    mean_app(col_valid(v,j),j) = mean_app(col_valid(v,j),j) + p_app(j,m)*CB(col_valid(v,j),m,j);%计算后验均值
                end
            end
        end
        variance_app = zeros(K,J);%累加
        %计算后验方差
        for j = 1:J
            for v = 1:d_v
                for m = 1:M
                    variance_app(col_valid(v,j),j) = variance_app(col_valid(v,j),j) + p_app(j,m)*(abs(CB(col_valid(v,j),m,j)-mean_app(col_valid(v,j),j)))^2;%计算后验方差
                end
            end
        end
        %计算用户节点到资源节点传递的均值和方差
        variance_J2K = zeros(K,J,Nr);%用户节点向资源节点传递的方差，初始化为0（开空间，没有完全使用）
        mean_J2K = zeros(K,J,Nr);%用户节点向资源节点传递的均值，初始化为0（开空间，没有完全使用）
        for nr = 1:Nr
        for j = 1:J
            for v = 1:d_v
                %variance_J2K(col_valid(v,j),j,nr) = ((1/variance_app(col_valid(v,j),j))-(1/variance_K2J(col_valid(v,j),j,nr)))^-1;%计算用户节点到资源节点传递的方差
                %mean_J2K(col_valid(v,j),j,nr) = variance_J2K(col_valid(v,j),j,nr)*(mean_app(col_valid(v,j),j)/variance_app(col_valid(v,j),j)-mean_K2J(col_valid(v,j),j,nr)/variance_K2J(col_valid(v,j),j,nr));%计算用户节点到资源节点传递的均值
                %简化为后验均值和方差
                variance_J2K(col_valid(v,j),j,nr) = variance_app(col_valid(v,j),j);%计算用户节点到资源节点传递的方差
                mean_J2K(col_valid(v,j),j,nr) = mean_app(col_valid(v,j),j);%计算用户节点到资源节点传递的均值
            end
        end
        end

        %% 资源节点更新
        %计算资源节点向用户节点传递的均值和方差
        for nr = 1:Nr
        for k = 1:K %遍历资源节点
            for idf = 1:d_f %遍历与当前资源节点相连的所有层节点
                iUser = row_valid(k,idf);%当前计算层节点
                layer = row_valid(k,[1:idf-1 idf+1:d_f]); %除当前层节点外其余df-1个层节点序号
                temp1 = 0;%均值计算中的累加项
                temp2 = 0;%方差计算中的累加项
                for c=1:d_f-1
                    temp1 = temp1 + h(col_valid(:,layer(c))==k,layer(c),d,nr)*mean_J2K(k,layer(c),nr);
                    temp2 = temp2 + (abs(h(col_valid(:,layer(c))==k,layer(c),d,nr)))^2*variance_J2K(k,layer(c),nr);
                end
                mean_K2J(k,iUser) = (y(k,d,nr)-temp1)/h(col_valid(:,iUser)==k,iUser,d,nr);
                variance_K2J(k,iUser) = (2*sigma^2+temp2)/(abs(h(col_valid(:,iUser)==k,iUser,d,nr)))^2;
            end
        end
        end
    end
    %% 进行判决
    %计算每个用户每个码字的后验概率（根据从资源节点返回的均值和方差计算）
    temp = prior(:,1,:,d);
    p_app = reshape(temp,J,M);
    p_prior = p_app;
    p = zeros(J,M);
    for j = 1:J
        for m = 1:M
            for nr = 1:Nr
            for v = 1:d_v
                p_app(j,m) = p_app(j,m)*exp(-abs(CB(col_valid(v,j),m,j)-mean_K2J(col_valid(v,j),j,nr))^2/variance_K2J(col_valid(v,j),j,nr));%每个用户每个码字的后验概率  
            end
            end
            if p_prior(j,m) > 0
                p(j,m) = p_app(j,m)/p_prior(j,m);
            else
                p(j,m) = p_app(j,m);
            end
        end
        p(j,:) = p(j,:)/sum(p(j,:));%概率归一化
        if isnan(p(j,:))%可能所有码字概率均为0，归一化后为nan，此时赋值等概率
            p(j,:) = 1/M;
        end
        [~,ind] = max(p_app(j,:));
        decision(j,iter) = ind;
    end

    for j = 1:J
        for m = 1:M
            %获得当前用户当前码字的比特概率
            temp = bits(m,:);
            for b = 1:bits_num
                 pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+p(j,m);
            end
        end 
    end
    %获得比特LLR
    temp = log(pro_bit(1,:,:)./pro_bit(2,:,:));
    llr_temp = reshape(temp,size(temp,2),size(temp,3));%转换为2维矩阵，每列是一个用户每个比特的LLR
    
    for j = 1:J
        for i = 1:bits_num
            if isinf(llr_temp(i,j))
                llr_temp(i,j) = sign(llr_temp(i,j))*2/sigma^2; 
            end
            if isnan(llr_temp(i,j))
                llr_temp(i,j) = 2/sigma^2; %sign(llr_temp(i,j))*
            end
        end
    end

    llr_output(:,(d-1)*bits_num+1:d*bits_num) = llr_temp';


    %获得输出符号
    decoded_symbols(:,d) = decision(:,iter);
end
end