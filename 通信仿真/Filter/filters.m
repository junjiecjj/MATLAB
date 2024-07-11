


%%  https://ww2.mathworks.cn/help/matlab/ref/filter.html?lang=en
clear all;
clc;

t = linspace(-pi,pi,100);
rng default  %initialize random number generator
x = sin(t) + 0.25*rand(size(t));



windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

y = filter(b,a,x);

plot(t,x)
hold on
plot(t,y)
legend('Input Data','Filtered Data')





%% 
clear all;
clc;


b = 1;
a = [1 -0.2];
rng default  %initialize random number generator
x = rand(2,15);
t = 0:length(x)-1;  %index vector


y = filter(b,a,x,[],2);


plot(t,x(1,:))
hold on
plot(t,y(1,:))
legend('Input Data','Filtered Data')
title('First Row')


figure
plot(t,x(2,:))
hold on
plot(t,y(2,:))
legend('Input Data','Filtered Data')
title('Second Row')




 









