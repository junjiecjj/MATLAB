function spir_len = function1(d, n, lcolor)
% d:����������
%   n:������Ȧ��
%      lcolor:��ͼ�ߵ���ɫ
%         spir_len:�������ܳ�
%
if nargin > 3
    error('�����������\n');
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
    error('�����������\n')
end
axis('square')