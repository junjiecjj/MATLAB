%max-Log-MPA检测
%输入：
%   CB - 码本
%   y - 输入数据，每列是一组
%   h - 信道系数
%   sigma - 单路噪声功率
%   iterNum - 迭代次数
%   col_valid - 每一列是该用户占用资源下标
%   row_valid - 每一行是占用该资源的用户下标
%   mset_double - 除当前用户外的用户码本下标（从0开始）组合，每一行是一种组合
%输出：
%   decoded_symbols - 输出符号

function decoded_symbols = SCMA_maxLogMPAdetector(CB, y, h, sigma, iterNum, col_valid, row_valid, mset_double)
[K, M, J] = size(CB);%J个用户，K个资源节点，M个码字
frame_length = size(y,2);%符号长度
CB_temp = zeros(size(CB));
d_f = sum(CB(1,1,:)~=0);   %FN节点度数，所有用户的第一个正交资源为例计算，Each FN is connected to 3 VNs
d_v = sum(CB(:,1,1)~=0);   %VN节点度数，以第一个用户码本中的第一个码字为例计算，Each VN is connected to 2 FNs
decision = zeros(J,1);
F2V = zeros(M^(d_f-1),1);%存储资源节点向用户节点传递信息的中间值

decoded_symbols = zeros(J, frame_length);
for d = 1:frame_length
    V = log(ones(J,d_v,M)/M);%码本中所有非零符号都有一个概率
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
        V = log(ones(J,d_v,M)/M);
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
    result = log(ones(J,M)/M);
    for j = 1:J
        for m = 1:M
            for v = 1:d_v
                result(j,m)=result(j,m)+U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m);
            end
        end
        [~,ind] = max(result(j,:));
        decision(j,1) = ind;
    end
    %获得输出符号
    decoded_symbols(:,d) = decision;
end
end







