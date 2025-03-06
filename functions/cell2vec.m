function vec = cell2vec(cell)
%CELL2VEC converts avrage colour cell into indexed vector 

vec = zeros(4,size(cell,1));

for k=1:size(cell,1)
    vec(:,k) = [cell{k,1}(1); cell{k,1}(2); cell{k,1}(3); k];
end

end

