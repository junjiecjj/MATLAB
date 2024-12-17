%MPA���
%���룺
%   CB - �뱾
%   y - �������ݣ�ÿ����һ��
%   H - �ŵ�ϵ��
%   sigma - ��·��������
%   iterNum - ��������
%   col_valid - ÿһ���Ǹ��û�ռ����Դ�±�
%   row_valid - ÿһ����ռ�ø���Դ���û��±�
%   mset_double - ����ǰ�û�����û��뱾����±�
%   Nr - ����������
%�����
%   decoded_symbols - �������
%   iter_num - �ܵ�������
function [llr_output, decoded_symbols] = SCMA_multi_antenna_MPAdetector_forIter1(CB, y, h, sigma, iterNum, col_valid, row_valid, bits, mset_double, Nr, prior)
[K, M, J] = size(CB);  %J���û���K����Դ�ڵ㣬M������
CB_temp = zeros(K,M,J,Nr);
d_f = sum(CB(1,1,:)~=0);   %FN�ڵ�����������û��ĵ�һ��������ԴΪ������
d_v = sum(CB(:,1,1)~=0);   %VN�ڵ�������Ե�һ���û��뱾�еĵ�һ������Ϊ������
decision = zeros(J,1);
frame_length = size(y,2);
decoded_symbols = zeros(J, frame_length);
bits_num = log(M)/log(2);%SCMA���ֶ�Ӧ�ı�����
llr_output = zeros(J, frame_length*bits_num);

for d = 1:frame_length
    temp = prior(:,:,:,d);%�뱾�����з�����Ŷ���һ������
    V = repmat(temp,1,1,1,Nr);
    pro_bit = zeros(2,bits_num,J);%�洢ÿ���û��������ֱ���0/1�ĸ���
    %�������뱾���ų�����Ӧ��ϵ��
    for nr = 1:Nr
        for j = 1:J
            for m = 1:M
                CB_temp(col_valid(:,j),m,j,nr) = CB(col_valid(:,j),m,j).*h(:,j,d,nr);
            end
        end
    end

    for iter = 1:iterNum
        U = zeros(K,d_f,M,Nr);%��Դ�ڵ����û��ڵ㴫����Ϣ��ÿ����Դ�Ͽ��ܵķ�����Ŷ�����һ�����ʣ��̶�ĳ��������Դ��ĳ���û�ĳ�����ֵķ���Ԫ�أ������ڸ���Դ�ϵ������û��ķ���Ԫ�ص���ϣ�
        for nr = 1:Nr
            for k = 1:K %������Դ�ڵ㣬����Դ��������Ϣ
                for idf = 1:d_f %�����뵱ǰ��Դ�ڵ����������в�ڵ㣬���û���������Ϣ
                    iUser = row_valid(k,idf);%��ǰ�����ڵ�
                    layer = row_valid(k,[1:idf-1 idf+1:d_f]); %����ǰ��ڵ�������df-1����ڵ����
                    for m = 1:M  %������ǰ��ڵ����������
                        for n = 0:M^(d_f-1)-1 %����ǰ�û��⣬�����û����ֵ���Ϲ���M^(d_f-1)�֣����Ľ��Ʊ�ʾ 15-33 ��000��M-1 M-1 M-1������
                            tmp = y(k,d,nr)-CB_temp(k,m,iUser,nr); %y_k-x_kjm
                            for c=1:d_f-1
                                tmp = tmp-CB_temp(k,mset_double(n+1,c)+1,layer(c),nr); %y_k-x_kjm-c_i
                            end
                            tmp = exp(-(real(tmp)^2+imag(tmp)^2)/(2*sigma^2));%ȥ��������/(2*pi*sigma^2)
                            for c = 1:d_f-1 %����V
                                tmp = tmp*V(layer(c),col_valid(:,layer(c))==k,mset_double(n+1,c)+1,nr);
                            end
                            U(k,idf,m,nr) = U(k,idf,m,nr)+tmp;
                        end
                    end
                end
            end
        end
        %����V
        temp = prior(:,:,:,d);%�뱾�����з�����Ŷ���һ������
        V = repmat(temp,1,1,1,Nr);
        for nr = 1:Nr
            nr_remain = [1:nr-1  nr+1:Nr];%��������
            %���㵱ǰ���������źŵ�����Ϣ
            for j = 1:J %�������в�ڵ�
                for v = 1:d_v %����������Ч����Դ�ڵ�
                    resource = col_valid([1:v-1 v+1:d_v],j);
                    %���ǵ�ǰ���߽����źŷ�������Ϣ
                    for m = 1:M
                        for vm = 1:d_v-1
                            V(j,v,m,nr) = V(j,v,m,nr)*U(resource(vm),row_valid(resource(vm),:)==j,m,nr);
                        end
                    end
                    %�������������ṩ����Ϣ
                    for nr1 = 1:Nr-1
                        for m = 1:M
                            for v1 = 1:d_v
                                V(j,v,m,nr) = V(j,v,m,nr)*U(col_valid(v1,j),row_valid(col_valid(v1,j),:)==j,m,nr_remain(nr1));
                            end
                        end
                        V(j,v,:,nr) = V(j,v,:,nr)/sum(V(j,v,:,nr));
                    end
                end
            end 
        end
    end

    temp = prior(:,1,:,d);
    result = reshape(temp,J,M);
    result1 = ones(size(result));
    for j = 1:J
        for m = 1:M
            for nr = 1:Nr
                for v = 1:d_v
                    result(j,m)=result(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m,nr);
                end
            end
            for nr = 1:Nr
                for v = 1:d_v
                    result1(j,m)=result1(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m,nr);
                end
            end
        end
        result1(j,:) = result1(j,:)/sum(result1(j,:));%���ʹ�һ��
        [~,ind] = max(result(j,:));
        decision(j) = ind;
    end
    for j = 1:J
        for m = 1:M
            %��õ�ǰ�û���ǰ���ֵı��ظ���
            temp = bits(m,:);
            for b = 1:bits_num
                pro_bit(temp(b)+1,b,j) = pro_bit(temp(b)+1,b,j)+result1(j,m);
            end
        end
    end

    %��ñ���LLR
    temp = log(pro_bit(1,:,:)./pro_bit(2,:,:));
    llr_temp = reshape(temp,size(temp,2),size(temp,3));%ת��Ϊ2ά����ÿ����һ���û�ÿ�����ص�LLR

    for j = 1:J
        for i = 1:bits_num
            if isinf(llr_temp(i,j))
                llr_temp(i,j) = sign(llr_temp(i,j))*0.5/sigma^2;
            end
            if isnan(llr_temp(i,j))
                llr_temp(i,j) = inf;%2/sigma^2; %sign(llr_temp(i,j))*
            end
        end
    end
    llr_output(:,(d-1)*bits_num+1:d*bits_num) = llr_temp';
    %����������
    decoded_symbols(:,d) = decision;
end
end