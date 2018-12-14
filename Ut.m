function ut = Ut(M,I,J,dt)

ut = (M(I-1,J) - M(I,J))/dt;
end