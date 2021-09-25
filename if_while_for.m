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

%暂停2s
%pause(2)

%与或非
A = 1:9
TrueorFalse = ~(A>4)            %非
TrueorFalse = (A>2)&(A<6)       %与
TrueorFalse = (A>2)|(A<6)       %或

A = 1:9
B = 2:10

%异或运算，A与B相同时(都为假或者都为真)返回0，A与B不同时(一真一假)返回1
xor(A,B) 

%如果在一个向量中，有任何元素为非零，返回1，否则返回0;
%如果矩阵A中的每一列有非零元素，返回1，否则返回0；
any(A)


%如果在一个向量中，所有元素为非零，返回1，否则返回0;
%如果矩阵A中的每一列所有元素非零，返回1，否则返回0；
all(A)
