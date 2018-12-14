% Maps T to I
% (c and d coordinates reversed on input to flip up-down)
function i = IfromT(t, a, b, d, c)
i=round((t-a)/(b-a)*(d-c)+c);
end