


%% SCMA Encoding
function coded = SCMA_Encoder(source_symbols,CB,h,col_valid)
[K, ~, J] = size(CB);
frame_length = size(source_symbols,2);
coded = zeros(K,frame_length);
for i = 1:frame_length
    for j = 1:J
        coded(col_valid(:,j),i) = coded(col_valid(:,j),i) + CB(col_valid(:,j),source_symbols(j,i),j).*h(:,j,i);
    end
end
end
