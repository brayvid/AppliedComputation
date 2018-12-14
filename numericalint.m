function [ leftriemann,rightriemann,midriemann ] = numericalint( f,a,b,n )
dx = (b-a)/n; 
leftriemann = 0; 
rightriemann = 0;
midriemann = 0;
for i = 1:n
    leftriemann = vpa(leftriemann + f(a+(i-1)*dx)*dx,16);
    rightriemann = vpa(rightriemann + f(a+i*dx)*dx,16);
    midriemann = vpa(midriemann + f(a+(1/2)*dx + (i-1)*dx)*dx,16);
end
end

