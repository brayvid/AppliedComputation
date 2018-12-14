function utt = Utt(M,I,J,dt)
utt = (M(I-1,J) - 2*M(I,J) + M(I+1,J))/(dt^2);
end
