
% https://blog.csdn.net/weixin_52135976/article/details/118893267
close all;
clear;
clc;

Nt = 4;
Nr = 6;
N = 1000;
Loop_Num = 3;
SNR = 0:1:10;
M = 2;
Data_Length = Nt*M*N;

for idxSNR = 1:length(SNR)
    for idxLoop = 1:Loop_Num
        TData_bit = randi([0,3], Data_Length, 1);
        TData_symbol = pskmod(TData_bit, 4, pi/4);
        Tx_Data = reshape(TData_symbol, Nt, []);
        RData_bit_sir = [];
        for idxTx_Data  = 1:length(Tx_Data)
            SNR_Linear = 10^(SNR(idxSNR)/10);
            P_signal = 1;
            P_noise = P_signal/SNR_Linear;
            H = sqrt(1/2)*(randn(Nr, Nt) + 1j*randn(Nr, Nt));
            N = sqrt(P_noise/2)*(randn(Nr, 1) + 1j*randn(Nr, 1));
            Data = H*Tx_Data(:,idxTx_Data) + N;
            %% ZF
            G = pinv(H);
            Rx_Data_zf1 = G*Data;
            Rx_Data_zf(:,idxTx_Data) = Rx_Data_zf1;
            %% SIC
            save_frame = [];
            H_sir = H;
            Data_sir = Data;
            for idxNt = 1:Nt
                G_findmin = sum(abs(G).^2, 2);
                G_findmin(find(G_findmin < 10e-7)) = [];
                wuyong = min(G_findmin);
                G_column = sum(abs(G).^2, 2);
                [~, G_column_min] = min(abs(G_column - wuyong));
                Data_ki = G(G_column_min, :)*Data_sir;
                Data_aki_n = pskdemod(Data_ki, 4, pi/4);
                Data_aki = pskmod(Data_aki_n, 4, pi/4);
                save_frame(G_column_min) = Data_aki;
                Data2 = Data_sir - Data_aki*H_sir(:, G_column_min);
                H_sir(:, G_column_min) = 0;
                G = pinv(H_sir);
                Data_sir = Data2;
            end
            Rx_Data_sir(:, idxTx_Data) = reshape(save_frame, [], 1);
            %% MMSE
            G_MMSE = H'/(H*H' + P_noise*eye(Nr, Nr));
            Rx_Data_mmse1 = G_MMSE*Data;
            Rx_Data_mmse(:,idxTx_Data) = Rx_Data_mmse1;
        end
        RData_symbol_zf = reshape(Rx_Data_zf, [], 1);
        RData_bit_zf = pskdemod(RData_symbol_zf, 4, pi/4);
        RData_symbol_sir = reshape(Rx_Data_sir, [], 1);
        RData_bit_sir = pskdemod(RData_symbol_sir,4, pi/4);
        RData_symbol_mmse = reshape(Rx_Data_mmse, [], 1);
        RData_bit_mmse = pskdemod(RData_symbol_mmse, 4, pi/4);
        Eerror_zf(idxLoop) = biterr(RData_bit_zf, TData_bit);
        Eerror_sir(idxLoop) = biterr(RData_bit_sir, TData_bit);
        Eerror_mmse(idxLoop) = biterr(RData_bit_mmse, TData_bit);
    end
    Ber_zf(idxSNR) = sum(Eerror_zf)/(Loop_Num*Data_Length);
    Ber_sir(idxSNR) = sum(Eerror_sir)/(Loop_Num*Data_Length);
    Ber_mmse(idxSNR) = sum(Eerror_mmse)/(Loop_Num*Data_Length);
end
semilogy(SNR, Ber_zf, 'r-*', 'linewidth', 1);
hold on;
semilogy(SNR, Ber_sir, 'g-o', 'linewidth', 1);
hold on;
semilogy(SNR, Ber_mmse, 'k-+', 'linewidth', 1);
grid on;
xlabel("SNR(dB)");
ylabel("BER");
legend("ZF", "SIC","MMSE");

