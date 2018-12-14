% Perform numerical integration with Riemann sums (numericalint)
clear
clc

f = @(x) sqrt(x^3+x^2+x+1);
a = 0; b = 1;
n = 200;

[left, right, mid] = numericalint(f,a,b,n)

syms x
exact = vpa(real(int(f(x),a,b)),16)