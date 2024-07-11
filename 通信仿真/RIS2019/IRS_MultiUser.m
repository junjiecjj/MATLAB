% 当给定AP的波束向量时，优化IRS的相位v，求解问题（P4'）
function v = IRS_MultiUser(W,Hr,Hd,G,N,Uk,gamma)
    L = 1000; % 高斯随机化过程次数
    b = Hd'*W;
    R = cell(Uk,Uk);
    for k=1:Uk
        for j=1:Uk
            a = diag(Hr(:,k)')*G*W(:,j);
            R{k,j} = [a*a' a*b(k,j)';a'*b(k,j) 0];
        end
    end
    cvx_begin quiet
        variable V(N+1,N+1) hermitian
        variable alpha1(Uk,1)
        expression RV(Uk,Uk)
        for k=1:Uk
            for j=1:Uk
                RV(k,j)=trace(R{k,j}*V);
            end
        end
        maximize(sum(alpha1))
        subject to
            for i=1:Uk
                trace(R{i,i}*V)+square_abs(b(i,i))>=gamma*sum(RV(i,[1:i-1 i+1:Uk]))+gamma*(b(i,[1:i-1 i+1:Uk])*b(i,[1:i-1 i+1:Uk])'+1) + alpha1(i);
                alpha1(i) >= 0;
            end
            diag(V) == 1;
            V ==  hermitian_semidefinite(N+1);
    cvx_end
    % 高斯随机化过程
    max_F = 0;
    max_v = 0;
    [U, Sigma] = eig(V);
    for l = 1 : L
        r = sqrt(2) / 2 * (randn(N+1, 1) + 1j * randn(N+1, 1));
        v = U * Sigma^(0.5) * r;
        s = 0;
        Vp = v*v';
        RVp = zeros(Uk,Uk);
        for k=1:Uk
            for j=1:Uk
                RVp(k,j)=trace(R{k,j}*Vp);
            end
        end
        for i=1:Uk
            s = s + real(v'*R{i,i}*v+b(i,i)'*b(i,i)-gamma*sum(RVp(i,[1:i-1 i+1:Uk]))-gamma*(b(i,[1:i-1 i+1:Uk])*b(i,[1:i-1 i+1:Uk])'+1));
        end
        if real(s)> max_F
            max_v = v;
            max_F = real(s);
        end
    end

    v = exp(1j * angle(max_v / max_v(end)));
    v = v(1 : N);
end
