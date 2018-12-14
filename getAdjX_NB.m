% Get the vector positions of any adjacent points to (i,j) in inner matrix
function INT_ADJ_IN_X = getAdjX_NB(i,j,mat)
u = [i-1, j];
r = [i, j+1];
d = [i+1, j];
l = [i, j-1];

internal = [];

% add any adjacent internal points to the list
if u(1) >= 1
    internal = [internal; u];
end
if r(2) <= size(mat,2)
    internal = [internal; r];
end
if d(1) <= size(mat,1)
    internal = [internal; d];
end
if l(2) >= 1
    internal = [internal; l];
end

for q = 1:size(internal,1)
    INT_ADJ_IN_X(q) = getPosX(internal(q,1),internal(q,2),mat);
end

end
