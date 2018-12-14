
% Get position in solution vector of a point (i,j) in the inner matrix
function POS_IN_X = getPosX(i,j,mat)
POS_IN_X = (j-1)*size(mat,1) + i;
end
