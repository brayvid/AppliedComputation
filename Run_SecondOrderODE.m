% Plot solution to a second order ODE (ode45)
%  SECOND ORDER EQUATIONS ONLY
clear
clc

syms y(t)

% Inputs
eqn = diff(y, 2) + t.*diff(y) + sin(t).*y == cos(2.*t);    %% input SECOND ORDER equation in y(t)
interval = [pi 3*pi];
init = [0 1]; % first is function, second is derivative

% Output
[V] = odeToVectorField( eqn );
M = matlabFunction(V,'vars', {'t','Y'});
sol = ode45(M,interval, init);  %% Syntax ode45(func, domain, initialconds)
fplot(@(x)deval(sol,x,1), interval)
