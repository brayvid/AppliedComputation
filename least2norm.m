% Least 2-Norm
function [x, min] = least2norm(A,b) % A is (n x m) and b is (m x 1)
sol = ((A'*A)^-1)*(A'*b);
if isequal(sol,[])
    x = NaN;
    min = NaN;
else
    x = sol(1:length(sol)-1);
    min = sol(end);
end
end