% MPA���
% ���룺
%   CB - �뱾
%   y - �������ݣ�ÿ����һ��
%   h - �ŵ�ϵ��
%   sigma - ��·��������
%   iterNum - ��������
%   col_valid - ÿһ���Ǹ��û�ռ����Դ�±�
%   row_valid - ÿһ����ռ�ø���Դ���û��±�
%   mset_double - ����ǰ�û�����û��뱾����±�
% �����
%   decoded_symbols - �������
%   iter_num - �ܵ�������
function decoded_symbols = SCMA_MPAdetector(CB, y, h, sigma, iterNum, col_valid, row_valid, mset_double)
[K, M, J] = size(CB);  % J���û���K����Դ�ڵ㣬M������
CB_temp = zeros(size(CB));
d_f = sum(CB(1,1,:)~=0);   % FN�ڵ�����������û��ĵ�һ��������ԴΪ������
d_v = sum(CB(:,1,1)~=0);   % VN�ڵ�������Ե�һ���û��뱾�еĵ�һ������Ϊ������
decision = zeros(J,iterNum);
decoded_symbols = zeros(J, size(y,2));
for d = 1:size(y,2)
    V = ones(J,d_v,M)/M;
    % �������뱾���ų�����Ӧ��ϵ��
    for j = 1:J
        for m = 1:M
            CB_temp(col_valid(:,j),m,j) = CB(col_valid(:,j),m,j).*h(:,j,d);
        end
    end
    for iter = 1:iterNum
        U = zeros(K,d_f,M);% ��Դ�ڵ����û��ڵ㴫����Ϣ��ÿ����Դ�Ͽ��ܵķ�����Ŷ�����һ�����ʣ��̶�ĳ��������Դ��ĳ���û�ĳ�����ֵķ���Ԫ�أ������ڸ���Դ�ϵ������û��ķ���Ԫ�ص���ϣ�
        % ������Դ�ڵ�
        for k = 1:K % ������Դ�ڵ㣬����Դ��������Ϣ
            for idf = 1:d_f % �����뵱ǰ��Դ�ڵ����������в�ڵ㣬���û���������Ϣ
                iUser = row_valid(k,idf);% ��ǰ�����ڵ�
                layer = row_valid(k,[1:idf-1 idf+1:d_f]); % ����ǰ��ڵ�������df-1����ڵ����
                for m = 1:M  % ������ǰ��ڵ����������
                    for n = 0:M^(d_f-1)-1 % ����ǰ�û��⣬�����û����ֵ���Ϲ���M^(d_f-1)�֣����Ľ��Ʊ�ʾ 15-33 ��000��M-1 M-1 M-1������
                        tmp = y(k,d) - CB_temp(k, m, iUser); % y_k-x_kjm
                        for c=1:d_f-1
                            tmp = tmp - CB_temp(k, mset_double(n+1, c)+1, layer(c)); % y_k-x_kjm-c_i
                        end
                        tmp = exp(-(real(tmp)^2+imag(tmp)^2)/(2*sigma^2));% ȥ��������/(2*pi*sigma^2)
                        for c = 1:d_f-1 % ����V
                            tmp = tmp*V(layer(c), col_valid(:,layer(c))==k, mset_double(n+1,c)+1);
                        end
                        U(k, idf, m) = U(k, idf, m) + tmp;
                    end
                end
            end
        end
        % �����û��ڵ�
        V = ones(J, d_v, M)/M;
        for j = 1:J % �������в�ڵ�
            for v = 1:d_v % ����������Ч����Դ�ڵ�
                resource = col_valid([1:v-1 v+1:d_v],j);
                for m = 1:M
                    for vm = 1:d_v-1
                        V(j, v, m) = V(j, v, m)*U(resource(vm),row_valid(resource(vm),:)==j,m);
                    end
                end
                V(j,v,:) = V(j,v,:)/sum(V(j,v,:));
            end
        end
    end
    % �����о�
    result = ones(J,M)/M;
    for j = 1:J
        for m = 1:M
            for v = 1:d_v
                result(j,m)=result(j,m)*U(col_valid(v,j),row_valid(col_valid(v,j),:)==j,m);
            end
        end
        [~,ind] = max(result(j,:));
        decision(j,iter) = ind;
    end
    % ����������
    decoded_symbols(:,d) = decision(:,iter);
end
end
















