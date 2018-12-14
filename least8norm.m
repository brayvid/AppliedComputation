% Least Inf-Norm

function [x, min] = least8norm(A,b)
sol = linprog(-[zeros(size(A,2), 1); 1], [A eye(size(A,1), 1); -A eye(size(A,1), 1)], [b; -b]); % [-c, M, b0]
if isequal(sol,[])
    x = NaN;
    min = NaN;
else
    x = sol(1:length(sol)-2);
    min = sol(length(sol)-1);
end
end
