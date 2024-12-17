%%  synchronous SCMA Encoding，考虑基带波形
%输入：
%   source_symbols - 每一列是一组用户发送码字的下标
%   CB - 码本
%   h - 信道系数，三维，第三维表示帧数，前两维为d_v*d_f
%   col_valid - 每一列表示该用户占用的资源节点下标
%   MF - 匹配滤波器
%输出：
%   coded - 编码后的波形
function coded = synchronousSCMA_Encoder(source_symbols, CB, h, col_valid, MF)
[K, ~, J] = size(CB);
frame_length = size(source_symbols,2);
coded = zeros(K,length(MF),frame_length);
for i = 1:frame_length
    for j = 1:J
        coded(col_valid(:,j),:,i) = coded(col_valid(:,j),:,i)+CB(col_valid(:,j),source_symbols(j,i),j).*h(:,j,i).*MF;
    end
end
end
