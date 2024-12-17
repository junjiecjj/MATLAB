
%max-Log-MPA检测
%输入：
%   CB - 码本
%   y - 输入数据，每列是一组
%   h - 信道系数
%   sigma - 单路噪声功率
%   iterNum - 迭代次数
%   col_valid - 每一列是该用户占用资源下标
%   row_valid - 每一行是占用该资源的用户下标
%   bits - 各码字对应的比特
%   mset_double - 除当前用户外的用户码本组合下标
%   prior - decoder反馈的先验信息
%输出：
%   llr_output - 比特LLR
%   decoded_symbols - 输出符号

function [llr_output, decoded_symbols] = SCMA_maxLogMPAdetector_forIter(CB, y, h, sigma, iterNum, col_valid, row_valid, bits, mset_double, prior)
[K, M, J] = size(CB);%J个用户，K个资源节点，M个码字
CB_temp = zeros(size(CB));
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算，Each FN is connected to 3 VNs
d_v = sum(CB(:,1,1)~=0);   %VN节点度数，以第一个用户码本中的第一个码字为例计算，Each VN is connected to 2 FNs
decision = ones(J,1);
F2V = zeros(M^(d_f-1),1);%存储资源节点向用户节点传递信息的中间值
bits_num = log(M)/log(2);%SCMA码字对应的比特数

llr_output = zeros(J, size(y,2)*log(M)/log(2));
decoded_symbols = zeros(J, size(y,2));

for d = 1:size(y,2)
    V = log(prior(:,:,:,d));%码本中所有非零符号都有一个概率
    pro_bit = zeros(2,bits_num,J);%存储每个用户所有码字比特0/1的概率
    %将所有码本符号乘上相应的系数
    for j = 1:J
        for m = 1:M
            CB_temp(col_valid(:,j),m,j) = CB(col_valid(:,j),m,j).*h(:,j,d);
        end
    end
    for iter = 1:iterNum
        U = zeros(K,d_f,M);%资源节点往用户节点传递信息，
        for k = 1:K %遍历资源节点
            for idf = 1:d_f %遍历与当前资源节点相连的所有层节点
                iUser = row_valid(k,idf);%当前计算层节点
                layer = row_valid(k,[1:idf-1 idf+1:d_f]); %除当前层节点外其余df-1个层节点序号
                for m = 1:M  %遍历当前层节点的所有码字
                    for n = 0:M^(d_f-1)-1 %除当前用户外，其它用户码字的组合共有M^(d_f-1)种，用四进制表示 15-33 从000到M-1 M-1 M-1。。。
                        tmp = y(k,d)-CB_temp(k,m,iUser); %y_k-x_kjm
                        for c=1:d_f-1
                            tmp = tmp-CB_temp(k,mset_double(n+1,c)+1,layer(c)); %y_k-x_kjm-c_i
                        end
                        tmp = -(real(tmp)^2+imag(tmp)^2)/(2*sigma^2);
                        for c = 1:d_f-1 %加上V
                            tmp = tmp+V(layer(c),col_valid(:,layer(c))==k,mset_double(n+1,c)+1);
                        end
                        F2V(n+1) = tmp;
                    end
                    U(k,idf,m) = max(F2V);%max操作
                end
            end
        end
        
        %计算V
        V = log(prior(:,:,:,d));
        for j = 1:J %遍历所有层节点
            for v = 1:d_v %遍历所有资源节点
                resource = col_valid([1:v-1 v+1:d_v],j);
                for m = 1:M
                    for vm = 1:d_v-1
                        V(j,v,m) = V(j,v,m)+U(resource(vm),row_valid(resource(vm),:)==j,m);
                    end
                end
            end
        end
    end
    %进行判决
    temp = prior(:,1,:,d);
    temp = reshape(temp,J,M);
    result1 = temp;
    result = log(temp);
    for j = 1:J
        for m = 1:M
            for v = 1:d_v
                result(j,m)=result(j,m)+U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m);
            end
            temp = bits(m,:);%将码字下标转为二进制比特
            for b = 1:log(M)/log(2)
                if result1(j,m)>0
                    pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+exp(result(j,m))/result1(j,m);
                else
                    pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+exp(result(j,m));  
                end
            end
        end
        [~,ind] = max(result(j,:));
        decision(j) = ind;
    end
    %获得比特LLR
    temp = log(pro_bit(1,:,:)./pro_bit(2,:,:));
    llr_temp = reshape(temp,size(temp,2),size(temp,3));%转换为2维矩阵，每列是一个用户每个比特的LLR
    
    for j = 1:J
        for i = 1:bits_num
            if isinf(llr_temp(i,j))
                llr_temp(i,j) = sign(llr_temp(i,j))*2/sigma^2;
            end
        end
    end
    
    llr_output(:,(d-1)*bits_num+1:d*bits_num) = llr_temp';
    %获得输出符号
    decoded_symbols(:,d) = decision;
end
end