function  [f,t]=gggfconv(f1,f2,t1,t2)    
    d=input('请输入采样时间间隔: ');
    f=conv(f1,f2);     %计算序列f1和f2的卷积和
    f=f*d; 
    ts=t1(1)+t2(1)   %计算序列f非零值的起始位置
    l=length(t1)+length(t2)-2; %计算序列f非零值的宽带
    t=ts:d:(ts+l*d)      %计算序列f非零值的时间向量
    subplot(2,2,1);plot(t1,f1) 
    subplot(2,2,2);plot(t2,f2)