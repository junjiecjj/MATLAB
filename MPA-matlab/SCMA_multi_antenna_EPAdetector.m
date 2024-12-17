%EPA���
%���룺
%   CB - �뱾
%   y - �������ݣ�ÿ����һ��
%   h - �ŵ�ϵ��
%   sigma - ��·��������
%   iterNum - ��������
%   col_valid - ÿһ���Ǹ��û�ռ����Դ�±�
%   row_valid - ÿһ����ռ�ø���Դ���û��±�
%   Nr - ����������
%�����
%   llr - ����LLR
%   decoded_symbols - �������
%   iter_num - �ܵ�������
function decoded_symbols = SCMA_multi_antenna_EPAdetector(CB, y, h, sigma, iterNum, col_valid, row_valid, Nr)
[K, M, J] = size(CB);  %J���û���K����Դ�ڵ㣬M������
d_f = sum(CB(1,1,:)~=0);   %FN�ڵ�����������û��ĵ�һ��������ԴΪ������
d_v = sum(CB(:,1,1)~=0);   %VN�ڵ�������Ե�һ���û��뱾�еĵ�һ������Ϊ������
decision = zeros(J,iterNum);
frame_length = size(y,2);
decoded_symbols = zeros(J, frame_length);

for d = 1:frame_length
    mean_K2J = complex(zeros(K,J,Nr));%��Դ�ڵ����û��ڵ㴫�ݵ���Ϣ����ʼ��Ϊ0��û����ȫʹ�ã�
    variance_K2J = 1000*ones(K,J,Nr);%��Դ�ڵ����û��ڵ㴫�ݵ���Ϣ����ʼ��Ϊmax��һ���ϴ��ʵ����
    for iter = 1:iterNum
        %% �û��ڵ����
        %����ÿ���û�ÿ�����ֵĺ�����ʣ����ݴ���Դ�ڵ㷵�صľ�ֵ�ͷ�����㣩
        p_app = ones(J,M)/M;%ÿ���û�ÿ�����ֵĺ�����ʣ���ʼ��Ϊȫ1/M���൱����������Ϣ
        for j = 1:J
            for m = 1:M
                for nr = 1:Nr
                    for v = 1:d_v
                        p_app(j,m) = p_app(j,m)*exp(-(abs(CB(col_valid(v,j),m,j)-mean_K2J(col_valid(v,j),j,nr)))^2/variance_K2J(col_valid(v,j),j,nr));%ÿ���û�ÿ�����ֵĺ������
                    end
                end
            end
            p_app(j,:) = p_app(j,:)/sum(p_app(j,:));%���ʹ�һ��
            if isnan(p_app(j,:))%�����������ָ��ʾ�Ϊ0����һ����Ϊnan����ʱ��ֵ�ȸ���
                p_app(j,:) = 1/M;
            end
        end
        %��������ֵ�ͷ���
        mean_app = complex(zeros(K,J));%���û�ÿ�����ֵĸ��ʳ�����Ӧ���ŵ��ۼ�
        %��������ֵ
        for j = 1:J
            for v = 1:d_v
                for m = 1:M
                    mean_app(col_valid(v,j),j) = mean_app(col_valid(v,j),j) + p_app(j,m)*CB(col_valid(v,j),m,j);%��������ֵ
                end
            end
        end
        variance_app = zeros(K,J);%�ۼ�
        %������鷽��
        for j = 1:J
            for v = 1:d_v
                for m = 1:M
                    variance_app(col_valid(v,j),j) = variance_app(col_valid(v,j),j) + p_app(j,m)*(abs(CB(col_valid(v,j),m,j)-mean_app(col_valid(v,j),j)))^2;%������鷽��
                end
            end
        end
        %�����û��ڵ㵽��Դ�ڵ㴫�ݵľ�ֵ�ͷ���
        variance_J2K = zeros(K,J,Nr);%�û��ڵ�����Դ�ڵ㴫�ݵķ����ʼ��Ϊ0�����ռ䣬û����ȫʹ�ã�
        mean_J2K = zeros(K,J,Nr);%�û��ڵ�����Դ�ڵ㴫�ݵľ�ֵ����ʼ��Ϊ0�����ռ䣬û����ȫʹ�ã�
        for nr = 1:Nr
            for j = 1:J
                for v = 1:d_v
                    variance_J2K(col_valid(v,j),j,nr) = abs(((1/variance_app(col_valid(v,j),j))-(1/variance_K2J(col_valid(v,j),j,nr)))^-1);%�����û��ڵ㵽��Դ�ڵ㴫�ݵķ���
                    mean_J2K(col_valid(v,j),j,nr) = variance_J2K(col_valid(v,j),j,nr)*(mean_app(col_valid(v,j),j)/variance_app(col_valid(v,j),j)-mean_K2J(col_valid(v,j),j,nr)/variance_K2J(col_valid(v,j),j,nr));%�����û��ڵ㵽��Դ�ڵ㴫�ݵľ�ֵ
                    %��Ϊ�����ֵ�ͷ���
                    %variance_J2K(col_valid(v,j),j,nr) = variance_app(col_valid(v,j),j);%�����û��ڵ㵽��Դ�ڵ㴫�ݵķ���
                    %mean_J2K(col_valid(v,j),j,nr) = mean_app(col_valid(v,j),j);%�����û��ڵ㵽��Դ�ڵ㴫�ݵľ�ֵ
                end
            end
        end
        %% ��Դ�ڵ����
        %������Դ�ڵ����û��ڵ㴫�ݵľ�ֵ�ͷ���
        for nr = 1:Nr
            for k = 1:K %������Դ�ڵ�
                for idf = 1:d_f %�����뵱ǰ��Դ�ڵ����������в�ڵ�
                    iUser = row_valid(k,idf);%��ǰ�����ڵ�
                    layer = row_valid(k,[1:idf-1 idf+1:d_f]); %����ǰ��ڵ�������df-1����ڵ����
                    temp1 = 0;%��ֵ�����е��ۼ���
                    temp2 = 0;%��������е��ۼ���
                    for c=1:d_f-1
                        temp1 = temp1 + h(col_valid(:,layer(c))==k,layer(c),d,nr)*mean_J2K(k,layer(c),nr);
                        temp2 = temp2 + (abs(h(col_valid(:,layer(c))==k,layer(c),d,nr)))^2*variance_J2K(k,layer(c),nr);
                    end
                    mean_K2J(k,iUser,nr) = (y(k,d,nr)-temp1)/h(col_valid(:,iUser)==k,iUser,d,nr);     %(8)
                    variance_K2J(k,iUser,nr) = (2*sigma^2+temp2)/(abs(h(col_valid(:,iUser)==k,iUser,d,nr)))^2; %(9)
                end
            end
        end
    end
    %% �����о�
    %����ÿ���û�ÿ�����ֵĺ�����ʣ����ݴ���Դ�ڵ㷵�صľ�ֵ�ͷ�����㣩
    p_app = ones(J,M)/M;%ÿ���û�ÿ�����ֵĺ�����ʣ���ʼ��Ϊȫ1/M���൱����������Ϣ
    for j = 1:J
        for m = 1:M
            for nr = 1:Nr
                for v = 1:d_v
                    p_app(j,m) = p_app(j,m)*exp(-(abs(CB(col_valid(v,j),m,j)-mean_K2J(col_valid(v,j),j,nr)))^2/variance_K2J(col_valid(v,j),j,nr));%ÿ���û�ÿ�����ֵĺ������
                end
            end
        end
        p_app(j,:) = p_app(j,:)/sum(p_app(j,:));%���ʹ�һ��
        if isnan(p_app(j,:))%�����������ָ��ʾ�Ϊ0����һ����Ϊnan����ʱ��ֵ�ȸ���
            p_app(j,:) = 1/M;
        end
        [~,ind] = max(p_app(j,:));
        decision(j,iter) = ind;
    end
    %����������
    decoded_symbols(:,d) = decision(:,iter);
end
end
















