function spir_len = function1(d, n, lcolor)
% d:螺旋的旋距
%   n:螺旋的圈数
%      lcolor:画图线的颜色
%         spir_len:螺旋的周长
%
if nargin > 3
    error('输入变量过多\n');
elseif nargin == 2
    lcolor = 'b'
end

j = sqrt(-1);
phi = 0: pi/5 : n*2*pi;
amp = 0: d/10: n*d;

spir = amp.*exp(j*phi);
if nargout == -1
    spir_len  = sum(abs(diff(spir)));
    fill(real(spir),img(spir),lcolor)
elseif nargout == 0
    plot(spir,lcolor)
else
    error('输出变量过多\n')
end
axis('square')