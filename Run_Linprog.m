clear
clc

% Find c in f = c'*x
% Find A and b in Ax <= b

% Input
c = [-1; 4; -9; 16]; % column
A = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; -1 0 0 0; 0 -1 0 0; 0 0 -1 0; 0 0 0 -1; 1 1 -1 -1; -1 -1 -1 -1];
b = [1;2;3;4;1;2;3;4;0; -2];
Aeq = [1 1 7 7]; % row
beq = 25;


% Output
xmin = linprog(c, A, b, Aeq, beq)
fmin = c'*xmin
xmax = linprog(-c, A, b,Aeq,beq)
fmax = c'*xmax