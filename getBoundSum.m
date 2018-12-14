% get the b value corresponding to any row of A (any inner i,j)
function ADJ_BOUND_B = getBoundSum(i,j,mat)

% Convert indices of UIN to indices of U
i_IN_U = round(i + 1);
j_IN_U = round(j + 1);

% get I or J coordinate (in U) of adjacent elements
ui = round(i_IN_U - 1);
di = round(i_IN_U + 1);
rj = round(j_IN_U + 1);
lj = round(j_IN_U - 1);

external_sum = 0;

% Check if adjacent elements are on the boundary
% If so, return the negative of the sum of their values
if ui == 1 % top
    external_sum = external_sum + mat(ui,j_IN_U);
end
if di == size(mat,1)  % bottom
    external_sum = external_sum + mat(di,j_IN_U);
end
if rj == size(mat,2) % right
    external_sum = external_sum +  mat(i_IN_U,rj);
end
if lj == 1 % left
    external_sum = external_sum +  mat(i_IN_U,lj);
end

ADJ_BOUND_B = -external_sum;
end