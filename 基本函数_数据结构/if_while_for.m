close all;
clear all;
clc;

r = 5;
S = pi*r*r;
fprintf('Area = %f\n',S) 

%%%%%%%%%%%%%%%%%%%%%% if-else %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1 < r < 10
    fprintf('1 < r < 10\n')
elseif r < 1
    fprintf('r < 1\n')
else
    fprintf('r > 10\n')
end

%%%%%%%%%%%%%%%%%%%%%% switch-case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch r
    case 1
        fprintf('r == 1\n')
    case 2
        fprintf('r == 2\n')
    otherwise
        fprintf('r == no\n')
end


%%%%%%%%%%%%%%%%%%%%%% for %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum = 0;
for i = 0:2:10
    sum = sum + i;
end
sum


%%%%%%%%%%%%%%%%%%%%%% while %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1;
sum = 0;
while i < 101
    sum = sum + i;
    if sum >= 100
        break
    end
    i = i+1;

end
sum


%value = input('message','s');

%��ͣ2s
%pause(2)

%����
A = 1:9
TrueorFalse = ~(A>4)            %��
TrueorFalse = (A>2)&(A<6)       %��
TrueorFalse = (A>2)|(A<6)       %��

A = 1:9
B = 2:10

%������㣬A��B��ͬʱ(��Ϊ�ٻ��߶�Ϊ��)����0��A��B��ͬʱ(һ��һ��)����1
xor(A,B) 

%�����һ�������У����κ�Ԫ��Ϊ���㣬����1�����򷵻�0;
%�������A�е�ÿһ���з���Ԫ�أ�����1�����򷵻�0��
any(A)


%�����һ�������У�����Ԫ��Ϊ���㣬����1�����򷵻�0;
%�������A�е�ÿһ������Ԫ�ط��㣬����1�����򷵻�0��
all(A)
