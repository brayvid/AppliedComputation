% Least 1-Norm

function [x, min] = least1norm(A,b)
[n, m] = size(A);
c = [zeros(m,1); ones(n,1)];
b0 = [b; -b];
I = eye(n);
M = [A -I; -A -I];
sol = linprog(c, M, b0);
if isequal(sol,[])
    x = NaN;
    min = NaN;
else
    x = sol(1:m-1,1);
    min =  sum(sol(m:n-1,1));
end
end