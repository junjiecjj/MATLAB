%%  Asynchronous SCMA Encoding
%输入：
%   source_symbols - 每一列是一组用户发送码字的下标
%   CB - 码本
%   h - 信道系数，三维，第三维表示帧数，前两维为d_v*d_f
%   row_valid - 每一行表示占用该资源节点的用户
%   MF - 匹配滤波器
%   offset - 各用户时延（从基带波形点数表示）
function coded = AsynchronousSCMA_Encoder(source_symbols, CB, h, row_valid, col_valid, MF, offset)
[K, ~, ~] = size(CB);
frame_length = size(source_symbols,2);
sample_length = length(MF);%基带波形点数
d_f = size(row_valid,2);
%逐资源块编码，将该资源块上的所有用户的符号整理好，然后这些用户符号直接相加即可
offset_length = offset(end);%因为不同步，额外多出的长度（波形的离散点角度）；根据最后一个用户的偏移点数即可得到
coded = zeros(K,frame_length*sample_length+offset_length);
for k = 1:K
    temp = zeros(d_f,frame_length*sample_length+offset_length);%存储当前第k个资源块上各用户的信号
    for df = 1:d_f
        for i = 1:frame_length
            temp(df,offset(row_valid(k,df))+(i-1)*sample_length+1:offset(row_valid(k,df))+i*sample_length) = ...
                CB(k,source_symbols(row_valid(k,df),i),row_valid(k,df)).*h(col_valid(:,row_valid(k,df))==k,row_valid(k,df),i).*MF;
        end
    end
    coded(k,:) = sum(temp,1);
end
end
