%功能：信息位缩短，信息比特位置和校验比特位置凿孔
function codeword_match = nrLDPC_rate_match(codeword, k, N_pun_pc, N_shor, N_pun_inf)
codeword(end-N_pun_pc+1:end) = [];%校验比特凿孔
codeword(k+1:k+N_shor) = [];%信息比特缩短（将补的零去掉）
codeword(1:N_pun_inf) = [];%信息比特凿孔，因为固定凿前面2*Z列
codeword_match = codeword;
end

