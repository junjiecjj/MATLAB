
clear;
clc;
close all;


Nt = 4;
Nr = 4;


H = (randn(Nr,Nt)+1j*randn(Nr,Nt)).*sqrt(1/2);
data = randi([0 1], Nt*4, 1);
x = qammod(data, 16, 'UnitAveragePower', true, 'InputType','bit');
n = randn(Nr,1);
y = H*x + n;
sigma2 = 1;

OSIC_type = 2;


if OSIC_type==1  % 1基于SINR排序
  Order=[];  % detection order
  index_array=[1:Nt] % yet to be detected signal index
  % V-BLAST
  for stage = 1:Nt
     Wmmse = inv(H'*H+sigma2*eye(Nt+1-stage))*H';  % MMSE filter
     WmmseH = Wmmse*H;
     SINR=[];
     for i = 1:Nt-(stage-1)
        tmp = norm(WmmseH(i,[1:i-1 i+1:Nt-(stage-1)]))^2 + sigma2*norm(Wmmse(i,:))^2;
        SINR(i) = abs(WmmseH(i,i))^2/tmp; % SINR calculation
     end
     [val_max,index_temp] = max(SINR);    % ordering using SINR
     Order = [Order index_array(index_temp)]; 
     index_array = index_array([1:index_temp-1 index_temp+1:end]);
     x_temp(stage) = Wmmse(index_temp,:)*y;     % MMSE filtering
     X_hat(stage) = QAM16_slicer(x_temp(stage),1); % slicing
     y_tilde = y - H(:,index_temp)*X_hat(stage); % interference subtraction
     H_tilde = H(:,[1:index_temp-1 index_temp+1:Nt-(stage-1)]); % new H
     H = H_tilde;   y = y_tilde;
  end
  X_hat(Order) = X_hat;
elseif OSIC_type==2 % 3基于列范数的排序
  %X_hat=zeros(nT,1);
  G = inv(H);           % inverse of H
  for i=1:Nt            % column_norm calculation
     norm_array(i) = norm(H(:,i));
  end
  [sorted_norm_array,Order_temp] = sort(norm_array); 
  Order = wrev(Order_temp);
  % V-BLAST
  for stage=1:Nt
      x_temp=G(Order(stage),:)*y;    % Tx signal estimation
      X_hat(Order(stage))=QAM16_slicer(x_temp,1); % slicing
      y_tilde = y-H(:,Order(stage))*X_hat(Order(stage)); 
  end
else % 2基于SNR排序
  Order=[];
  index_array=[1:Nt]; % set of indices of signals to be detected
  % V-BLAST
  for stage=1:Nt
     G = inv(H'*H)*H'; 
     norm_array=[];
     for i=1:Nt-(stage-1) % detection ordering
        norm_array(i) = norm(G(i,:));
     end
     [val_min,index_min]=min(norm_array); % ordering in SNR
     Order=[Order index_array(index_min)];
     index_array = index_array([1:index_min-1 index_min+1:end]); 
     x_temp(stage) = G(index_min,:)*y;  % Tx signal estimation
     X_hat(stage) = QAM16_slicer(x_temp(stage),1);  % slicing
     y_tilde = y-H(:,index_min)*X_hat(stage); % interference subtraction
     H_tilde = H(:,[1:index_min-1 index_min+1:Nt-(stage-1)]); % new H
     H = H_tilde;   y = y_tilde;
  end
  X_hat(Order) = X_hat;
end











