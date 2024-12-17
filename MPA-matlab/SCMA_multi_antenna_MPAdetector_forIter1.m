%MPA检测
%输入：
%   CB - 码本
%   y - 输入数据，每列是一组
%   H - 信道系数
%   sigma - 单路噪声功率
%   iterNum - 迭代次数
%   col_valid - 每一列是该用户占用资源下标
%   row_valid - 每一行是占用该资源的用户下标
%   mset_double - 除当前用户外的用户码本组合下标
%   Nr - 接收天线数
%输出：
%   decoded_symbols - 输出符号
%   iter_num - 总迭代次数
function [llr_output, decoded_symbols] = SCMA_multi_antenna_MPAdetector_forIter1(CB, y, h, sigma, iterNum, col_valid, row_valid, bits, mset_double, Nr, prior)
[K, M, J] = size(CB);  %J个用户，K个资源节点，M个码字
CB_temp = zeros(K,M,J,Nr);
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算
d_v = sum(CB(:,1,1)~=0);   %VN节点度数，以第一个用户码本中的第一个码字为例计算
decision = zeros(J,1);
frame_length = size(y,2);
decoded_symbols = zeros(J, frame_length);
bits_num = log(M)/log(2);%SCMA码字对应的比特数
llr_output = zeros(J, frame_length*bits_num);

for d = 1:frame_length
    temp = prior(:,:,:,d);%码本中所有非零符号都有一个概率
    V = repmat(temp,1,1,1,Nr);
    pro_bit = zeros(2,bits_num,J);%存储每个用户所有码字比特0/1的概率
    %将所有码本符号乘上相应的系数
    for nr = 1:Nr
        for j = 1:J
            for m = 1:M
                CB_temp(col_valid(:,j),m,j,nr) = CB(col_valid(:,j),m,j).*h(:,j,d,nr);
            end
        end
    end

    for iter = 1:iterNum
        U = zeros(K,d_f,M,Nr);%资源节点往用户节点传递信息（每个资源上可能的非零符号都返回一个概率，固定某个正交资源上某个用户某个码字的非零元素，遍历在该资源上的其他用户的非零元素的组合）
        for nr = 1:Nr
            for k = 1:K %遍历资源节点，逐资源处理返回信息
                for idf = 1:d_f %遍历与当前资源节点相连的所有层节点，逐用户处理返回信息
                    iUser = row_valid(k,idf);%当前计算层节点
                    layer = row_valid(k,[1:idf-1 idf+1:d_f]); %除当前层节点外其余df-1个层节点序号
                    for m = 1:M  %遍历当前层节点的所有码字
                        for n = 0:M^(d_f-1)-1 %除当前用户外，其它用户码字的组合共有M^(d_f-1)种，用四进制表示 15-33 从000到M-1 M-1 M-1。。。
                            tmp = y(k,d,nr)-CB_temp(k,m,iUser,nr); %y_k-x_kjm
                            for c=1:d_f-1
                                tmp = tmp-CB_temp(k,mset_double(n+1,c)+1,layer(c),nr); %y_k-x_kjm-c_i
                            end
                            tmp = exp(-(real(tmp)^2+imag(tmp)^2)/(2*sigma^2));%去掉常数项/(2*pi*sigma^2)
                            for c = 1:d_f-1 %乘上V
                                tmp = tmp*V(layer(c),col_valid(:,layer(c))==k,mset_double(n+1,c)+1,nr);
                            end
                            U(k,idf,m,nr) = U(k,idf,m,nr)+tmp;
                        end
                    end
                end
            end
        end
        %计算V
        temp = prior(:,:,:,d);%码本中所有非零符号都有一个概率
        V = repmat(temp,1,1,1,Nr);
        for nr = 1:Nr
            nr_remain = [1:nr-1  nr+1:Nr];%其余天线
            %计算当前接收天线信号的外信息
            for j = 1:J %遍历所有层节点
                for v = 1:d_v %遍历所有有效的资源节点
                    resource = col_valid([1:v-1 v+1:d_v],j);
                    %考虑当前天线接收信号反馈的信息
                    for m = 1:M
                        for vm = 1:d_v-1
                            V(j,v,m,nr) = V(j,v,m,nr)*U(resource(vm),row_valid(resource(vm),:)==j,m,nr);
                        end
                    end
                    %考虑其余天线提供的信息
                    for nr1 = 1:Nr-1
                        for m = 1:M
                            for v1 = 1:d_v
                                V(j,v,m,nr) = V(j,v,m,nr)*U(col_valid(v1,j),row_valid(col_valid(v1,j),:)==j,m,nr_remain(nr1));
                            end
                        end
                        V(j,v,:,nr) = V(j,v,:,nr)/sum(V(j,v,:,nr));
                    end
                end
            end 
        end
    end

    temp = prior(:,1,:,d);
    result = reshape(temp,J,M);
    result1 = ones(size(result));
    for j = 1:J
        for m = 1:M
            for nr = 1:Nr
                for v = 1:d_v
                    result(j,m)=result(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m,nr);
                end
            end
            for nr = 1:Nr
                for v = 1:d_v
                    result1(j,m)=result1(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m,nr);
                end
            end
        end
        result1(j,:) = result1(j,:)/sum(result1(j,:));%概率归一化
        [~,ind] = max(result(j,:));
        decision(j) = ind;
    end
    for j = 1:J
        for m = 1:M
            %获得当前用户当前码字的比特概率
            temp = bits(m,:);
            for b = 1:bits_num
                pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+result1(j,m);
            end
        end
    end

    %获得比特LLR
    temp = log(pro_bit(1,:,:)./pro_bit(2,:,:));
    llr_temp = reshape(temp,size(temp,2),size(temp,3));%转换为2维矩阵，每列是一个用户每个比特的LLR

    for j = 1:J
        for i = 1:bits_num
            if isinf(llr_temp(i,j))
                llr_temp(i,j) = sign(llr_temp(i,j))*0.5/sigma^2;
            end
            if isnan(llr_temp(i,j))
                llr_temp(i,j) = inf;%2/sigma^2; %sign(llr_temp(i,j))*
            end
        end
    end
    llr_output(:,(d-1)*bits_num+1:d*bits_num) = llr_temp';
    %获得输出符号
    decoded_symbols(:,d) = decision;
end
end