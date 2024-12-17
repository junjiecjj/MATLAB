%Gallager 码
dv = 3;
dc = 6;
codeLength = 6000;


rowNum_subMatrix = ceil(codeLength/dc);%子矩阵行数
sum_matrix = zeros(rowNum_subMatrix,codeLength);

%构造子矩阵
for i = 1:rowNum_subMatrix
    sum_matrix(i,(i-1)*dc+1:i*dc) = ones(1,dc);
end
H = sum_matrix;
%构造矩阵
for j = 1:dv-1
    permute = randperm(codeLength);
    per_sum_matrix = sum_matrix(:,permute);
    H = [H; per_sum_matrix];
    [H_column_permuted,M, N, K, vn_degree, cn_degree, P, H_row_one_absolute_index, H_comlumn_one_relative_index, vn_distribution, cn_distribution] = H_matrix_process(H);
    %计算环长
    num_4_cycles = count_4_cycles(H_row_one_absolute_index, cn_degree);
    while num_4_cycles>=1
        H(end-rowNum_subMatrix+1:end,:) = [];
        permute = randperm(codeLength);
        per_sum_matrix = per_sum_matrix(:,permute);
        H = [H; per_sum_matrix];
        [H_column_permuted,M, N, K, vn_degree, cn_degree, P, H_row_one_absolute_index, H_comlumn_one_relative_index, vn_distribution, cn_distribution] = H_matrix_process(H);
        %计算环长
        num_4_cycles = count_4_cycles(H_row_one_absolute_index, cn_degree);
    end
end
% num_6_cycles = count_6_cycles(H_row_one_absolute_index, cn_degree);
% num_8_cycles = count_8_cycles(H_row_one_absolute_index, cn_degree);
% num_10_cycles = count_10_cycles(H_row_one_absolute_index, cn_degree);
