function A = orthDiag(M)
rows = size(M,1);
e = eig(M);
A = zeros(rows);
for i = 1:rows
    A(:,i) = eigvec(M,e(i));
end
% D_tr = A'*M*A
% D_inv = A^(-1)*M*A
end
