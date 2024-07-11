% AP-IRS MRT
function [v_aimrt, w_aimrt] = AIMRT(hd,hr,G)
    w_aimrt = G(1,:)'/norm(G(1,:));
    varphi0 = angle(hd*w_aimrt);
    v_aimrt = exp(1j*(varphi0 - angle(diag(hr)*G*w_aimrt)));
end