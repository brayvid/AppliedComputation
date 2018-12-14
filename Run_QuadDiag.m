%% Quadratic programming - step 1
clear
clc

syms x1 x2 x3 real

% Enter function
Q(x1,x2,x3) = 2*x1*x2 - 3*x1*x3 + 5*x2*x3;

Q = expand(Q)

%% Step 2
% Enter coefficients of linear terms in order manually
f = [0 0 0];

% Calculate the Hessian matrix of Q
H = double(hessian(Q,[x1,x2,x3]))

% Orthogonally diagonalize H
A = vpa(orthDiag(H),8)

% Get diagonal matrix D
D = A'*H*A;

% Ensure off-diagonal elements are exactly equal to zero
D0 = zeros(3);
for i = 1:3
   D0(i,i) = D(i,i); 
end

% Get transformation that eliminates cross terms
syms y1 y2 y3 real
Y = [y1; y2; y3];
for i = 1:size(Y,1)
   X(i,1) = A(i,:)*Y;   
end

X = vpa(X,4)

R(y1,y2,y3) = (1/2)*Y'*D0*Y;

R = vpa(expand(R),8)



