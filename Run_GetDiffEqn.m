% Display the difference equation of a PDE in matrix index format
clear
clc

% X,T step size
dx = 0.2;
dt = 0.1;

syms M(I,J)

% Input a partial differential equation in terms of Ux, Ut, Uxx, Utt
% so each is a function of M, I, J and either dx or dt.
eqn = Ut(M,I,J,dt) == Uxx(M,I,J,dx) + 2.*Ux(M,I,J,dx);


% Display difference equation
% The output assumes the top left corner of the domain, at min X and max T,
% is I = 1 and J = 1, following matlab matrix indexing.
fprintf('Difference equation with matrix indexing:\n\n')
% I = I+1; % substitute so (I,J) is the point being solved for.
% eqn = subs(eqn);
disp(simplify(eqn))








