function [H] = H_eBCH(N, k, dmin)
filename = (['eBCH_N' num2str(N) '_k' num2str(k) '_dmin' num2str(dmin) '.mat' ]);
H = importdata(filename);
end