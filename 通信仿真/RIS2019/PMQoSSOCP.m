function W = PMQoSSOCP(H, gamma,M,Uk)
    cvx_begin quiet
    variable W(M,Uk) complex
    minimize(norm(W,"fro"))
    subject to
        for i=1:Uk
            imag(H(i,:)*W(:,i)) == 0; % 保证为只有实部
            real(H(i,:)*W(:,i)) >= sqrt(gamma)*norm([1 H(i,:)*W(:,[1:i-1 i+1:Uk])]); % 二次锥约束
        end
    cvx_end
end
