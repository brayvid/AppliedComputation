function ux = Ux(M,I,J,dx)
ux = (M(I,J+1) - M(I,J))/dx;
end