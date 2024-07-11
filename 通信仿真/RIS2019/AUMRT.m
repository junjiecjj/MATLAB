% AP-User MRT
function [v_aumrt, w_aumrt] = AUMRT(hd,hr,G)
    w_aumrt = hd'/norm(hd);
    varphi0 = angle(hd*w_aumrt);
    v_aumrt = exp(1j*(varphi0 - angle(diag(hr)*G*w_aumrt)));
end















