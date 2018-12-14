function uxx = Uxx(M,I,J,dx)
uxx = (M(I,J+1) - 2*M(I,J) + M(I,J-1))/(dx^2);
end
