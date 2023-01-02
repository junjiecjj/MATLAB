clear;
clc;


% 值迭代部分：
% 对相关初始变量进行赋值
p = 0.5;
n = 10;
c = 1;
K = 7;
alpha = 0.9;
k = 1;
% 初始化J
j = zeros(1, n+1);
J(1, :) = j;
% 使用while循环来不断进行迭代
while 1
    % 策略u(i) = 1时J的可能取值
    x1 = K + alpha*(1-p)*J(k, 1) + alpha*p*J(k, 2);
    for i = 0:n-1
        % 策略u(i) = 0时J的可能取值
        x2 = c*i + alpha*(1-p)*J(k, i+1) + alpha*p*J(k, i+2);
        % J(i)取二者最小值，并且每一次迭代的J(i)都会被储存到一个矩阵中
        J(k+1, i+1) = min(x1, x2);
    end
    % n状态下J的取值是固定的，u(n)必定为1
    J(k+1, n+1) = x1;
    % 如果这次迭代的J与上次迭代中的J近似相等时，停止迭代，跳出while循环
    if pdist(J(k:k+1, :)) < 1.0000e-6
        break;
    end
    k = k + 1;
end
% 利用单调性来求解threshold
for m = 1:n-1
    m1 = c*(m-1) + alpha*(1-p)*J(k, m) + alpha*p*J(k, m+1);
    m2 = c*m + alpha*(1-p)*J(k, m+1) + alpha*p*J(k, m+2);
    if m1 <= x1 && x1 <= m2
        break;
    end
end

%  策略迭代部分：
k = 1;
% policy = zeros(1, n+1);
% policy(1, n+1) = 1;
% 初始化起始策略
policy = ones(1, n+1);
P(1, :) = policy;
J_p(1, :) = zeros(1, n+1);
while 1
    % 每次迭代求解线性方程之前都要初始化A和b
    A = zeros(n+1);
    B = zeros(n+1, 1);
    for i = 1:n
        if P(k, i) == 0
            A(i, i) = 1 - alpha + alpha*p;
            A(i, i+1) = -alpha*p;
            B(i, 1) = c*(i-1);
        else
            A(i, 1) = alpha*p - alpha;
            A(i, 2) = -alpha*p;
            A(i, i) = A(i, i) + 1;
            B(i, 1) = K;
        end
    end
    A(n+1, 1) = alpha*p - alpha;
    A(n+1, 2) = -alpha*p;
    A(n+1, n+1) = 1;
    B(n+1, 1) = K;
    % 求解线性方程组Ax=b得到Jk(i)，并储存起来
    x=linsolve(A, B);
    J_p(k, :) = x';
    % 求解下一次迭代的uk+1
    u1 = K + alpha*(1-p)*J_p(k, 1) + alpha*p*J_p(k, 2);
    for i = 0:n-1
        u0 = c*i + alpha*(1-p)*J_p(k, i+1) + alpha*p*J_p(k, i+2);
        if u1 < u0
            policy(1, i+1) = 1;
        else
            policy(1, i+1) = 0;
        end
    end
    policy(1, n+1) = 1;
    P(k+1, :) = policy;
    % 如果这次迭代的J_p与上次迭代中的J_p近似相等时，停止迭代，跳出while循环
    if k > 1 && pdist(J_p(k-1:k, :)) < 1.0000e-6
        break;
    end
    k = k + 1;
end