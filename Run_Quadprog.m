clear
clc

syms x1 x2 x3 x4

% Enter function
f(x1,x2,x3,x4) = 6*x1^2 + 3*x2^2 + 3*x3^2 + 7*x4^2 + x1*x2 - 10*x1*x4 - x1 + 4*x2 - 9*x3 + 16*x4;

% Enter manually
c = [-1; 4; -9; 16];
A = [1 1 -1 -1; -1 -1 -1 -1];
b = [0; -2];

% Output
H = double(hessian(f,[x1,x2,x3,x4]));
xmin = quadprog(H,c,A,b)
fmin =  vpa(f(xmin(1),xmin(2),xmin(3),xmin(4)),5) 
% xmax = quadprog(-H,-c,A,b)
% fmax =  vpa(f(xmax(1),xmax(2),xmax(3),xmax(4)),5) 



