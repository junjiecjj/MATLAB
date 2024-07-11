
function [v, lower_bound] = SDR_solving(hr, G, hd, N)
    L = 1000; % 高斯随机化过程次数
    Phi = diag(hr)*G;
    R = [Phi*Phi' Phi*hd'; hd*Phi' 0];
    cvx_begin sdp quiet
        variable V(N+1,N+1) hermitian
        maximize(real(trace(R*V))+norm(hd)^2);
        subject to
            diag(V) == 1;
            V ==  hermitian_semidefinite(N+1);
    cvx_end
    
    lower_bound = cvx_optval;
    % 高斯随机化过程
    %% method 1
    max_F = 0;
    max_v = 0;
    [U, Sigma] = eig(V);
    for l = 1 : L
        r = sqrt(2) / 2 * (randn(N+1, 1) + 1j * randn(N+1, 1));
        v = U * Sigma^(0.5) * r;
        if v' * R * v > max_F
            max_v = v;
            max_F = v' * R * v;
        end
    end
    
    v = exp(1j * angle(max_v / max_v(end)));
    v = v(1 : N);
end
