% Selector

function [m, b] = bestline128(X, Y, norm)
A = [X' ones(length(X),1)];
b = Y';
switch norm
    case 1
    [m, b] = least1norm(A,b);
    case 2
    [m, b] = least2norm(A,b);
    case 8
    [m, b] = least8norm(A,b);
end
end