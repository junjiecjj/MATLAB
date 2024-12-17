% MPA检测
% 输入：
%   CB - 码本
%   y - 输入数据，每列是一组
%   h - 信道系数
%   sigma - 单路噪声功率
%   iterNum - 迭代次数
%   col_valid - 每一列是该用户占用资源下标
%   row_valid - 每一行是占用该资源的用户下标
%   mset_double - 除当前用户外的用户码本组合下标
% 输出：
%   decoded_symbols - 输出符号
%   iter_num - 总迭代次数
function decoded_symbols = SCMA_MPAdetector(CB, y, h, sigma, iterNum, col_valid, row_valid, mset_double)
[K, M, J] = size(CB);  % J个用户，K个资源节点，M个码字
CB_temp = zeros(size(CB));
d_f = sum(CB(1,1,:)~=0);   % FN节点度数，所有用户的第一个正交资源为例计算
d_v = sum(CB(:,1,1)~=0);   % VN节点度数，以第一个用户码本中的第一个码字为例计算
decision = zeros(J,iterNum);
decoded_symbols = zeros(J, size(y,2));
for d = 1:size(y,2)
    V = ones(J,d_v,M)/M;
    % 将所有码本符号乘上相应的系数
    for j = 1:J
        for m = 1:M
            CB_temp(col_valid(:,j),m,j) = CB(col_valid(:,j),m,j).*h(:,j,d);
        end
    end
    for iter = 1:iterNum
        U = zeros(K,d_f,M);% 资源节点往用户节点传递信息（每个资源上可能的非零符号都返回一个概率，固定某个正交资源上某个用户某个码字的非零元素，遍历在该资源上的其他用户的非零元素的组合）
        % 更新资源节点
        for k = 1:K % 遍历资源节点，逐资源处理返回信息
            for idf = 1:d_f % 遍历与当前资源节点相连的所有层节点，逐用户处理返回信息
                iUser = row_valid(k,idf);% 当前计算层节点
                layer = row_valid(k,[1:idf-1 idf+1:d_f]); % 除当前层节点外其余df-1个层节点序号
                for m = 1:M  % 遍历当前层节点的所有码字
                    for n = 0:M^(d_f-1)-1 % 除当前用户外，其它用户码字的组合共有M^(d_f-1)种，用四进制表示 15-33 从000到M-1 M-1 M-1。。。
                        tmp = y(k,d) - CB_temp(k, m, iUser); % y_k-x_kjm
                        for c=1:d_f-1
                            tmp = tmp - CB_temp(k, mset_double(n+1, c)+1, layer(c)); % y_k-x_kjm-c_i
                        end
                        tmp = exp(-(real(tmp)^2+imag(tmp)^2)/(2*sigma^2));% 去掉常数项/(2*pi*sigma^2)
                        for c = 1:d_f-1 % 乘上V
                            tmp = tmp*V(layer(c), col_valid(:,layer(c))==k, mset_double(n+1,c)+1);
                        end
                        U(k, idf, m) = U(k, idf, m) + tmp;
                    end
                end
            end
        end
        % 更新用户节点
        V = ones(J, d_v, M)/M;
        for j = 1:J % 遍历所有层节点
            for v = 1:d_v % 遍历所有有效的资源节点
                resource = col_valid([1:v-1 v+1:d_v],j);
                for m = 1:M
                    for vm = 1:d_v-1
                        V(j, v, m) = V(j, v, m)*U(resource(vm),row_valid(resource(vm),:)==j,m);
                    end
                end
                V(j,v,:) = V(j,v,:)/sum(V(j,v,:));
            end
        end
    end
    % 进行判决
    result = ones(J,M)/M;
    for j = 1:J
        for m = 1:M
            for v = 1:d_v
                result(j,m)=result(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m);
            end
        end
        [~,ind] = max(result(j,:));
        decision(j,iter) = ind;
    end
    % 获得输出符号
    decoded_symbols(:,d) = decision(:,iter);
end
end
















