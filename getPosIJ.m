% get the (i,j) position in inner matrix from a vector position
function IJ = getPosIJ(pos, mat)
IJ = zeros(1,2);

grplen = size(mat,1);
place = pos / grplen;

int_part = fix(place);
frac_part = place - fix(place);
if frac_part == 0
    colU = int_part;
    rowU = grplen;
else
    colU = int_part + 1;
    rowU = frac_part*grplen;
end
IJ = round([rowU, colU]);
end