% Quadratic programming
clear
clc

syms x1 x2 x3

% Enter function
func(x1,x2,x3) = (2.2*x1 + 1.8*x2 - 3.1*x3 + 1.7)^2 + ...
    (-2*x1 - 0.8*x2 - 1.5*x3 +2.6)^2 + ...
    (3.4*x1 + 1.4*x2 - 1.1*x3 -0.8)^2 + (2.2*x1 + 0.8*x2)^2;

func = expand(func)

%% 
% Enter coefficients of linear terms in order manually
f = [-209/25 -7/25 -829/50];

% Don't edit
H = double(hessian(func,[x1,x2,x3]));
xmin = vpa(quadprog(H,f),8)
fmin =  vpa(func(xmin(1),xmin(2),xmin(3)),8)
