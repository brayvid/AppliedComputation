% Interface

function mb = bestline(X, Y, norm)
data = array2table([X', Y'],'VariableNames',{'X','Y'});
[slope, intercept] = bestline128(X, Y, norm);
switch norm
    case 8
        rowname = {'InfNorm'};
    case 2
        rowname = {'TwoNorm'};
    case 1
        rowname = {'OneNorm'};
end
mb = array2table([slope, intercept],'VariableNames',{'Slope','Intercept'},'RowNames',rowname);
end
