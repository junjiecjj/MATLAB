function [TotalDigCentAxis,TotalAngCentAxis] = diff_sub_array_axis_extract(AllArrayAxis,AllDigSubArrNum)
%==========================================================================
%��ȡ��������
%==========================================================================
TotalDigCentAxis=[];  %��������ƽ������
TotalAngCentAxis=[];  %ģ������ƽ������

for knum=1:AllDigSubArrNum
    if(AllArrayAxis(knum).DigSubValid)
        DigCentAxis     = AllArrayAxis(knum).fDigArrayAxis ;%������������ 
        TotalDigCentAxis=[TotalDigCentAxis;DigCentAxis];    %��������ƽ������

        AngArrayAxis = AllArrayAxis(knum).fAngArrayAxis;   %ģ����������
        TotalAngCentAxis=[TotalAngCentAxis;AngArrayAxis];  %ģ������ƽ������
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