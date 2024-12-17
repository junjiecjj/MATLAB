%×î´óËÆÈ»¼ì²â

function [err_sum,demodSignal] = scmaDeML(CB, PRE, data_source)
    DataLength = length(PRE);
    Yout = PRE;
 %% all possible received munber 
    m=1;   %count Y
    for i6=1:4
      for i5=1:4
        for i4=1:4
           for i3=1:4
             for i2=1:4
               for i1=1:4
            AllY(1,m)=CB(1,i2,2)+CB(1,i3,3)+CB(1,i5,5);
            AllY(2,m)=CB(2,i1,1)+CB(2,i3,3)+CB(2,i6,6);
            AllY(3,m)=CB(3,i2,2)+CB(3,i4,4)+CB(3,i6,6);
            AllY(4,m)=CB(4,i1,1)+CB(4,i4,4)+CB(4,i5,5);
            AllY(5,m)=i1;AllY(6,m)=i2;AllY(7,m)=i3;
            AllY(8,m)=i4;AllY(9,m)=i5;AllY(10,m)=i6;
            m = m+1;
%           AllY(1,m)=AllX(1,i1)+AllX(2,i2)+AllX(3,i3);
%           AllY(2,m)=AllX(1,i1)+AllX(4,i4)+AllX(5,i5);
%           AllY(3,m)=AllX(2,i2)+AllX(4,i4)+AllX(6,i6);
%           AllY(4,m)=AllX(3,i3)+AllX(5,i5)+AllX(6,i6);
%           AllY(5,m)=i1;AllY(6,m)=i2;AllY(7,m)=i3;
%           AllY(8,m)=i4;AllY(9,m)=i5;AllY(10,m)=i6;
%           m=m+1;
                end
              end
           end
         end
      end
    end
    
    % maxium likelyhood detect
    CompareY = zeros(1,4096);
    Location = zeros(1,DataLength);
    for i=1:DataLength
            for j=1:4096
               CompareY(1,j)=abs(real(AllY(1,j)-Yout(1,i)))+abs(imag(AllY(1,j)-Yout(1,i)))+abs(real(AllY(2,j)-Yout(2,i)))+abs(imag(AllY(2,j)-Yout(2,i)))+abs(real(AllY(3,j)-Yout(3,i)))+abs(imag(AllY(3,j)-Yout(3,i)))+abs(real(AllY(4,j)-Yout(4,i)))+abs(imag(AllY(4,j)-Yout(4,i)));
%                CompareY1(1,j)=abs(real(AllY(1,j)-Ydata(1,i)))+abs(imag(AllY(1,j)-Ydata(1,i)))+abs(real(AllY(2,j)-Ydata(2,i)))+abs(imag(AllY(2,j)-Ydata(2,i)))+abs(real(AllY(3,j)-Ydata(3,i)))+abs(imag(AllY(3,j)-Ydata(3,i)))+abs(real(AllY(4,j)-Ydata(4,i)))+abs(imag(AllY(4,j)-Ydata(4,i)));
            end
            SSS=find(CompareY == min(CompareY));
            Location(i) = SSS(1);
%             Location1(i) = find(CompareY1 == min(CompareY1));
    end
    %find the input
for i=1:DataLength
        switch (AllY(5,Location(i)))
            case 1
                Uout1(:,i)=1;
            case 2
                Uout1(:,i)=2;
            case 3
                Uout1(:,i)=3;
            case 4
                Uout1(:,i)=4;
        end
        switch (AllY(6,Location(i)))
            case 1
                Uout2(:,i)=1;
            case 2
                Uout2(:,i)=2;
            case 3
                Uout2(:,i)=3;
            case 4
                Uout2(:,i)=4;
        end
        switch (AllY(7,Location(i)))
            case 1
                Uout3(:,i)=1;
            case 2
                Uout3(:,i)=2;
            case 3
                Uout3(:,i)=3;
            case 4
                Uout3(:,i)=4;
        end
        switch (AllY(8,Location(i)))
            case 1
                Uout4(:,i)=1;
            case 2
                Uout4(:,i)=2;
            case 3
                Uout4(:,i)=3;
            case 4
                Uout4(:,i)=4;
        end
        switch (AllY(9,Location(i)))
            case 1
                Uout5(:,i)=1;
            case 2
                Uout5(:,i)=2;
            case 3
                Uout5(:,i)=3;
            case 4
                Uout5(:,i)=4;
        end
        switch (AllY(10,Location(i)))
            case 1
                Uout6(:,i)=1;
            case 2
                Uout6(:,i)=2;
            case 3
                Uout6(:,i)=3;
            case 4
                Uout6(:,i)=4;
        end
end
%     end
%     for i=1:DataLength
%         switch (AllY(5,Location(i)))
%             case 1
%                 Uout1(:,i)=[0;0];
%             case 2
%                 Uout1(:,i)=[0;1];
%             case 3
%                 Uout1(:,i)=[1;0];
%             case 4
%                 Uout1(:,i)=[1;1];
%         end
%         switch (AllY(6,Location(i)))
%             case 1
%                 Uout2(:,i)=[0;0];
%             case 2
%                 Uout2(:,i)=[0;1];
%             case 3
%                 Uout2(:,i)=[1;0];
%             case 4
%                 Uout2(:,i)=[1;1];
%         end
%         switch (AllY(7,Location(i)))
%             case 1
%                 Uout3(:,i)=[0;0];
%             case 2
%                 Uout3(:,i)=[0;1];
%             case 3
%                 Uout3(:,i)=[1;0];
%             case 4
%                 Uout3(:,i)=[1;1];
%         end
%         switch (AllY(8,Location(i)))
%             case 1
%                 Uout4(:,i)=[0;0];
%             case 2
%                 Uout4(:,i)=[0;1];
%             case 3
%                 Uout4(:,i)=[1;0];
%             case 4
%                 Uout4(:,i)=[1;1];
%         end
%         switch (AllY(9,Location(i)))
%             case 1
%                 Uout5(:,i)=[0;0];
%             case 2
%                 Uout5(:,i)=[0;1];
%             case 3
%                 Uout5(:,i)=[1;0];
%             case 4
%                 Uout5(:,i)=[1;1];
%         end
%         switch (AllY(10,Location(i)))
%             case 1
%                 Uout6(:,i)=[0;0];
%             case 2
%                 Uout6(:,i)=[0;1];
%             case 3
%                 Uout6(:,i)=[1;0];
%             case 4
%                 Uout6(:,i)=[1;1];
%         end
%     end
    demodSignal = [Uout1;Uout2;Uout3;Uout4;Uout5;Uout6;];
    err=demodSignal~=data_source;
    err_sum=sum(sum(err));
end
