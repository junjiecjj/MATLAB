%功能：恢复速率适配
function llr_recover = nrLDPC_rate_recover(llr, k, N_pun_inf, N_shor, N_pun_pc)
llr = [zeros(1, N_pun_inf) llr];%恢复前2Z列凿孔
llr = [llr  zeros(1, N_pun_pc)];%恢复校验比特凿孔
llr = [llr(1:k)  500*ones(1, N_shor) llr(k+1:end)];%恢复缩短
llr_recover = llr;      
end

