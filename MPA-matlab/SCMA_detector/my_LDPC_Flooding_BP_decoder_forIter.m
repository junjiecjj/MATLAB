function  [llr_output, c_hat] = my_LDPC_Flooding_BP_decoder_forIter(llr, H_row_one_absolute_index, H_column_one_relative_index, N, M, vn_degree, cn_degree, max_iter)
VN_array = zeros(max(vn_degree), N);
for v = 1 : N
    for v_neighbor = 1 : vn_degree(v)
        VN_array(v_neighbor, v) = llr(v);%Belief Propagation Rule. The initial 2/sigma^2*y is automatically incorporateed here.
    end
end

for t = 1 : max_iter

    %*********************************************法一：tanh（适应LLR为0的情况）*****************************************
    for c = 1 : M
        %精准计算
        product = ones(max(cn_degree),1);
        for c_neighbor = 1 : cn_degree(c)%针对每个变量节点
            for i = 1:cn_degree(c)
                if(i~=c_neighbor)%剔除该变量节点
                    %5G移动通信中的信道编码 公式（3.38）
                    CN_tanh_tmp = 1 - 2/(1 + exp(VN_array(H_column_one_relative_index(c, i), H_row_one_absolute_index(c, i))));%Exact decoding.
                    product(c_neighbor) = product(c_neighbor) * CN_tanh_tmp;
                end
            end
        end
        for c_neighbor = 1 : cn_degree(c)
            x = product(c_neighbor);
            x = sign(x) * min(abs(x), 1 - 1e-15);%Numerical Stability.
            VN_array(H_column_one_relative_index(c, c_neighbor), H_row_one_absolute_index(c, c_neighbor)) = log((1 + x)/(1 - x));%Exact decoding.
        end
    end
    
    %VN update
    sum_VN = sum(VN_array);
    for v = 1 : N
        for v_neighbor = 1 : vn_degree(v)
            VN_array(v_neighbor, v) = sum_VN(v) - VN_array(v_neighbor, v) + llr(v);%Belief Propagation Rule. The initial 2/sigma^2*y is automatically incorporateed here.
        end
    end
    llr_output = (sum_VN + llr);
    c_hat = (sum_VN + llr) < 0;%Belief propagation Decision.
    
%     parity_check = zeros(M, 1);
%     for m = 1 : M
%         for k = 1 : 1 : cn_degree(m)
%             parity_check(m) = parity_check(m) + c_hat(H_row_one_absolute_index(m, k));
%         end
%     end
%     if ~sum(mod(parity_check, 2))%early stop, to see whether Hx = 0.
%         iter_this_time = t;
%         check_flag = 1;
%         break;
%     end
end
