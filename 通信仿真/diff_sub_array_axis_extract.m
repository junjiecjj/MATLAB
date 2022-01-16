function [TotalDigCentAxis,TotalAngCentAxis] = diff_sub_array_axis_extract(AllArrayAxis,AllDigSubArrNum)
%==========================================================================
%获取阵列坐标
%==========================================================================
TotalDigCentAxis=[];  %数字阵列平均坐标
TotalAngCentAxis=[];  %模拟阵列平均坐标

for knum=1:AllDigSubArrNum
    if(AllArrayAxis(knum).DigSubValid)
        DigCentAxis     = AllArrayAxis(knum).fDigArrayAxis ;%数字中心坐标 
        TotalDigCentAxis=[TotalDigCentAxis;DigCentAxis];    %数字阵列平均坐标

        AngArrayAxis = AllArrayAxis(knum).fAngArrayAxis;   %模拟阵列坐标
        TotalAngCentAxis=[TotalAngCentAxis;AngArrayAxis];  %模拟阵列平均坐标
    end
    knum;
end

% figure
% hold on;
% plot(TotalAngCentAxis(:,1),TotalAngCentAxis(:,2),'.k');
% plot(TotalDigCentAxis(:,1),TotalDigCentAxis(:,2),'.r');
% hold off;
% xlabel('X(m)');
% ylabel('Z(m)'); axis square;