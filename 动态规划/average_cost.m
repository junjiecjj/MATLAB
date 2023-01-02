clear;  
clc;  

% 值迭代部分：
p = 0.8;
n = 10;
c = 1;
K = 5;
k = 1;
h = zeros(1, n+1);
lamdas(1, 1) = 0;
H(1, :) = h;
% 使用while循环来不断进行迭代
while 1
    % 利用h(n)=0来求出此次迭代的lamda的值
    x1 = K + (1-p)*H(k, 1) + p*H(k, 2);
    lamda = x1;
    lamdas(k, 1) = lamda;
    for i = 0:n-1
        x2 = c*i + (1-p)*H(k, i+1) + p*H(k, i+2);
        % h(i)取二者最小值，并且每一次迭代的h(i)都会被储存到一个矩阵中
        H(k+1, i+1) = min(x1, x2) - lamda;
    end
    % n状态下h的取值是固定的，u(n)必定为1，其实可以看出h(n)=0;
    H(k+1, n+1) = x1 - lamda;
    % 如果这次迭代的h与上次迭代中的h近似相等时，停止迭代，跳出while循环
    if pdist(H(k:k+1, :)) < 1.0000e-6
        break;
    end
    k = k + 1;
end
% 利用单调性来求解threshold
for m = 1:n-1
    m1 = c*(m-1) + (1-p)*H(k, m) + p*H(k, m+1);
    m2 = c*m + (1-p)*H(k, m+1) + p*H(k, m+2);
    if m1 <= x1 && x1 <= m2
        break;
    end
end
threshold1 = m;

% 策略迭代部分：
k = 1;
% 初始化起始策略
policy = zeros(1, n+1);
policy(1, n+1) = 1;
P(1, :) = policy;
H_p(1, :) = zeros(1, n+1);
lamdas_p(k, 1) = 0;
while 1
    % 每次迭代求解线性方程之前都要初始化A和b
    A = zeros(n+2);
    B = zeros(n+2, 1);
    for i = 1:n
        if P(k, i) == 0
            A(i, i) = p;
            A(i, i+1) = -p;
            % lamda项的系数放入A的第n+2列
            A(i, n+2) = 1;
            B(i, 1) = c*(i-1);
        else
            A(i, 1) = p - 1;
            A(i, 2) = -p;
            A(i, i) = A(i, i) + 1;
            % lamda项的系数放入A的第n+2列
            A(i, n+2) = 1;
            B(i, 1) = K;
        end
    end
    A(n+1, 1) = p - 1;
    A(n+1, 2) = -p;
    A(n+1, n+1) = 1;
    A(n+1, n+2) = 1;
    B(n+1, 1) = K;
    % h(n) = 0
    A(n+2, n+1) = 1;
    % 求解线性方程组Ax=b得到hk(i)和lamda_k，并储存起来
    x=linsolve(A, B);
    x = x';
    H_p(k, :) = x(1, 1:n+1);
    lamdas_p(k, 1) = x(1, n+2);
    % 求解下一次迭代的uk+1
    u1 = K + (1-p)*H_p(k, 1) + p*H_p(k, 2);
    for i = 0:n-1
        u0 = c*i + (1-p)*H_p(k, i+1) + p*H_p(k, i+2);
        if u1 < u0
            policy(1, i+1) = 1;
        else
            policy(1, i+1) = 0;
        end
    end
    policy(1, n+1) = 1;
    P(k+1, :) = policy;
    % 如果这次迭代的h_p与上次h_p近似相等且uk和uk+1近似相等时，停止迭代，跳出while循环
    if k > 1 && pdist(H_p(k-1:k, :)) < 1.0000e-6 && pdist(P(k:k+1, :)) < 1.0000e-6
        break;
    end
    k = k + 1;
end

% 利用平稳分布pi来求解threshold
f = zeros(1, n);
for m = 1:n
    PT = zeros(m+1);
    % 初始化概率转移矩阵PT
    for i = 1:m
        PT(i, i+1) = p;
        PT(i, i) = 1-p;
    end
    PT(m+1, 1) = 1-p;
    PT(m+1, 2) = p;
    k = 1;
    % 初始化向量v=(1,0,...,0)
    v = zeros(1, m+1);
    v(1, 1) = 1;
    % 循环乘上概率转移矩阵PT使其收敛
    while 1
        if  pdist([v; v*PT]) < 1.0000e-6
            break;
        end
        v = v * PT;
    end
    for i = 0:m-1
        % 计算每个m对应的f(m)
        f(1, m) = f(1, m) + c*i*v(1, i+1);
    end
    f(1, m) = f(1, m) + K*v(1,m+1);
end
% 找到使得f(m)最小的threshold
[value, threshold2] = min(f);
