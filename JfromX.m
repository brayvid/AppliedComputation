% Maps X to J
function j = JfromX(x, a, b, c, d)
j=round((x-a)/(b-a)*(d-c)+c);
end