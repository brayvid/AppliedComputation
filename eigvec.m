% Calculates a single eigenvector
function x = eigvec(A,c)
S = size(A);
n = S(1);
I = eye(n);
ONE = ones(1,n);
M = [A - c*I; ONE];
ZERO = zeros(n,1);
b = [ZERO; 1];
[x min] = least2norm(M,b);
x = [x; min];
x = x./norm(x);
end
