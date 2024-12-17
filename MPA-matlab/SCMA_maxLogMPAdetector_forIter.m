
%max-Log-MPA���
%���룺
%   CB - �뱾
%   y - �������ݣ�ÿ����һ��
%   h - �ŵ�ϵ��
%   sigma - ��·��������
%   iterNum - ��������
%   col_valid - ÿһ���Ǹ��û�ռ����Դ�±�
%   row_valid - ÿһ����ռ�ø���Դ���û��±�
%   bits - �����ֶ�Ӧ�ı���
%   mset_double - ����ǰ�û�����û��뱾����±�
%   prior - decoder������������Ϣ
%�����
%   llr_output - ����LLR
%   decoded_symbols - �������

function [llr_output, decoded_symbols] = SCMA_maxLogMPAdetector_forIter(CB, y, h, sigma, iterNum, col_valid, row_valid, bits, mset_double, prior)
[K, M, J] = size(CB);%J���û���K����Դ�ڵ㣬M������
CB_temp = zeros(size(CB));
d_f = sum(CB(1,1,:)~=0);   %FN�ڵ�����������û��ĵ�һ��������ԴΪ�����㣬Each FN is connected to 3 VNs
d_v = sum(CB(:,1,1)~=0);   %VN�ڵ�������Ե�һ���û��뱾�еĵ�һ������Ϊ�����㣬Each VN is connected to 2 FNs
decision = ones(J,1);
F2V = zeros(M^(d_f-1),1);%�洢��Դ�ڵ����û��ڵ㴫����Ϣ���м�ֵ
bits_num = log(M)/log(2);%SCMA���ֶ�Ӧ�ı�����

llr_output = zeros(J, size(y,2)*log(M)/log(2));
decoded_symbols = zeros(J, size(y,2));

for d = 1:size(y,2)
    V = log(prior(:,:,:,d));%�뱾�����з�����Ŷ���һ������
    pro_bit = zeros(2,bits_num,J);%�洢ÿ���û��������ֱ���0/1�ĸ���
    %�������뱾���ų�����Ӧ��ϵ��
    for j = 1:J
        for m = 1:M
            CB_temp(col_valid(:,j),m,j) = CB(col_valid(:,j),m,j).*h(:,j,d);
        end
    end
    for iter = 1:iterNum
        U = zeros(K,d_f,M);%��Դ�ڵ����û��ڵ㴫����Ϣ��
        for k = 1:K %������Դ�ڵ�
            for idf = 1:d_f %�����뵱ǰ��Դ�ڵ����������в�ڵ�
                iUser = row_valid(k,idf);%��ǰ�����ڵ�
                layer = row_valid(k,[1:idf-1 idf+1:d_f]); %����ǰ��ڵ�������df-1����ڵ����
                for m = 1:M  %������ǰ��ڵ����������
                    for n = 0:M^(d_f-1)-1 %����ǰ�û��⣬�����û����ֵ���Ϲ���M^(d_f-1)�֣����Ľ��Ʊ�ʾ 15-33 ��000��M-1 M-1 M-1������
                        tmp = y(k,d)-CB_temp(k,m,iUser); %y_k-x_kjm
                        for c=1:d_f-1
                            tmp = tmp-CB_temp(k,mset_double(n+1,c)+1,layer(c)); %y_k-x_kjm-c_i
                        end
                        tmp = -(real(tmp)^2+imag(tmp)^2)/(2*sigma^2);
                        for c = 1:d_f-1 %����V
                            tmp = tmp+V(layer(c),col_valid(:,layer(c))==k,mset_double(n+1,c)+1);
                        end
                        F2V(n+1) = tmp;
                    end
                    U(k,idf,m) = max(F2V);%max����
                end
            end
        end
        
        %����V
        V = log(prior(:,:,:,d));
        for j = 1:J %�������в�ڵ�
            for v = 1:d_v %����������Դ�ڵ�
                resource = col_valid([1:v-1 v+1:d_v],j);
                for m = 1:M
                    for vm = 1:d_v-1
                        V(j,v,m) = V(j,v,m)+U(resource(vm),row_valid(resource(vm),:)==j,m);
                    end
                end
            end
        end
    end
    %�����о�
    temp = prior(:,1,:,d);
    temp = reshape(temp,J,M);
    result1 = temp;
    result = log(temp);
    for j = 1:J
        for m = 1:M
            for v = 1:d_v
                result(j,m)=result(j,m)+U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m);
            end
            temp = bits(m,:);%�������±�תΪ�����Ʊ���
            for b = 1:log(M)/log(2)
                if result1(j,m)>0
                    pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+exp(result(j,m))/result1(j,m);
                else
                    pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+exp(result(j,m));  
                end
            end
        end
        [~,ind] = max(result(j,:));
        decision(j) = ind;
    end
    %��ñ���LLR
    temp = log(pro_bit(1,:,:)./pro_bit(2,:,:));
    llr_temp = reshape(temp,size(temp,2),size(temp,3));%ת��Ϊ2ά����ÿ����һ���û�ÿ�����ص�LLR
    
    for j = 1:J
        for i = 1:bits_num
            if isinf(llr_temp(i,j))
                llr_temp(i,j) = sign(llr_temp(i,j))*2/sigma^2;
            end
        end
    end
    
    llr_output(:,(d-1)*bits_num+1:d*bits_num) = llr_temp';
    %����������
    decoded_symbols(:,d) = decision;
end
end