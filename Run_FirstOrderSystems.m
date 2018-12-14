% Plot solutions to systems of first order ODEs (ode45)
%  FIRST ORDER SYSTEMS AND EQUATIONS ONLY
clear
clc

% INPUT IN THIS FORM: y' = f(t,y)
dydt = @(t,y) sin(t+y); % can be a column vector [Dy(1) ; Dy(2)] 

interval = [0 1]; %  [t_min t_max]
init = 1;  %  Form: [y1'(t_min) y2'(t_min)] and must have #init = #eqns

[T, Y] = ode45(dydt, interval, init);  % ode45(function, interval, initialcondition)

plot(T,Y) % for solution plots
legend('y')

% plot(Y(:,1),Y(:,2)) % for phase plot
% legend('r')
