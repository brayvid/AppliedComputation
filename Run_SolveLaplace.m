% LAPLACE'S EQUATION Linear Algebra Method
clear
clc
hold off

%   %   %   %   %
%
%   Edit inputs
%

% X,T domain
xdom = [0 1];
tdom = xdom;

% X,T step size (must evenly divide the interval length)
dx = 0.2;
dt = dx;

% Boundary conditions as anonymous functions
% (all 4 required, must match at corners)
upperCondition = @(X) 1 + 0.*X;            % top edge u(x,tdom(2))
lowerCondition = @(X) X.^2 + (1-X).^2;            % bottom edge, u(x,tdom(1))
leftCondition = @(T) 1 + 0.*T;                  % left edge, u(xdom(1),t)
rightCondition = @(T)1 + 0.*T;                 % right edge, u(xdom(2),t)

% Optional evaluation point
% sampleXT = [0.5 0.5];

% Plot boundary curves yes/no
plotBoundaryCurves = 0;

%   %   %   %   %



%   %   %   %   %
%
%   Main Program
%


% Solution matrix dims
xn = (xdom(2)-xdom(1))/dx + 1;
tn = (tdom(2)-tdom(1))/dt + 1;

% Solution matrix (empty)
U = zeros(tn, xn);

% IJ domain
idom = [1 tn];
jdom = [1 xn];

% Generate boundary values of U
cond = [0 0 0 0]; % T B L R
% Top
if exist('upperCondition','var') == 1
    % fill in top
    for x = xdom(1):dx:xdom(2)
        i = IfromT(tdom(2), tdom(1),tdom(2),idom(1), idom(2));
        j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
        U(i,j) = upperCondition(x);
    end
    cond(1) = 1;
end
% Bottom
if exist('lowerCondition','var') == 1
    % fill in bottom
    for x = xdom(1):dx:xdom(2)
        i = IfromT(tdom(1), tdom(1),tdom(2),idom(1), idom(2));
        j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
        U(i,j) = lowerCondition(x);
    end
    cond(2) = 1;
end
% Left
if exist('leftCondition','var') == 1
    % fill in left
    for t = tdom(1):dt:tdom(2)
        i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
        j = JfromX(xdom(1), xdom(1), xdom(2), jdom(1), jdom(2));
        U(i,j) = leftCondition(t);
    end
    cond(3) = 1;
end
% Right
if exist('rightCondition','var') == 1
    % fill in right
    for t = tdom(1):dt:tdom(2)
        i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
        j = JfromX(xdom(2), xdom(1), xdom(2), jdom(1), jdom(2));
        U(i,j) = rightCondition(t);
    end
    cond(4) = 1;
end


if strcmp(char(cond),char([1 1 1 1])) ~= 1
    disp('Not enough boundary conditions.')
    return
end
% Solve for inner values of U with linear algebra methods

% inner elements of U
UIN = U(2:tn-1,2:xn-1);

% each row in A corresponds to a central point
A = zeros(numel(UIN)); % Laplacian matrix

% each element of b corresponds to an inner point and each is equal to
% minus the sum of any boundary points adjacent to that inner point or else
% zero
b = zeros(numel(UIN),1);

for k = 1:size(A,1)
    % k is the active inner element # in vector index format
    
    % Vector index format: Start at top left (first element) of UIN
    % and go down the first column. Then go down the second column.
    % Repeat for all columns. (Could have been set up differently)
    
    % for each row of A (each vector element) do the following:
    
    A(k,k) = -4; % set the active element coeff to -4
    
    pos_ij = getPosIJ(k, UIN); % get ij of active element
    
    % Get vector index of non-boundary elements adjacent to active one
    adj_x = getAdjX_NB(pos_ij(1),pos_ij(2), UIN);
    
    % For each element in this row, check if it is in the list of
    % adjacent elements. If yes, set that entry of A equal to 1
    total_inner_adj = 0;
    for j = 1:size(A,2)
        
        if ismember(j, adj_x)
            A(k,j) = 1;
            total_inner_adj = total_inner_adj + 1;
        end
    end
    
    
    % get b value for the current row in Ax=b
    b(k) = getBoundSum(pos_ij(1),pos_ij(2),U);
end

% Solve system for the inner values
X = A\b;

% Insert inner values back into U
U(2:size(U,1)-1,2:size(U,2)-1) = reshape(X,[size(UIN,1), size(UIN,2)]);

%   %   %   %   %



%   %   %   %   %
%
%   Output
%

% Plot U(x,t) surface with labels
surf(xdom(1):dx:xdom(2),tdom(1):dt:tdom(2),flip(U,1))
xlabel('x')
ylabel('t')
zlabel('U(x,t)')
title(strcat(['U(x,t) with ',num2str(idom(2)*jdom(2)),' mesh points']))
hold on

% Plot boundary curves
if plotBoundaryCurves == 1
    % Top boundary curve (function of x)
    topX = (xdom(1):dx:xdom(2))';
    topT = tdom(2)*ones(length(topX),1);
    topU = upperCondition(topX);
    plot3(topX,topT,topU,'Color','m','LineWidth',2)
    % Bottom boundary curve (function of x)
    bottomX = (xdom(1):dx:xdom(2))';
    bottomT = tdom(1)*ones(length(bottomX),1);
    bottomU = lowerCondition(bottomX);
    plot3(bottomX,bottomT,bottomU,'Color','m','LineWidth',2)
    % Right boundary curve (function of t)
    rightT = (tdom(1):dt:tdom(2))';
    rightX = xdom(2)*ones(length(rightT),1);
    rightU = rightCondition(rightT);
    plot3(rightX,rightT,rightU,'Color','m','LineWidth',2)
    % Left boundary curve (function of t)
    leftT = (tdom(1):dt:tdom(2))';
    leftX = xdom(1)*ones(length(leftT),1);
    leftU = leftCondition(leftT);
    plot3(leftX,leftT,leftU,'Color','m','LineWidth',2)
end

% Display results
% A
% b
% X
U

% Evaluate U at specified point, if entered
if exist('sampleXT','var')
    IJ = [IfromT(sampleXT(2), tdom(1),tdom(2),idom(1),idom(2)), JfromX(sampleXT(1), xdom(1), xdom(2), jdom(1), jdom(2))];
    fprintf(strcat('\nU(',num2str(sampleXT(1)), ',', num2str(sampleXT(2)), ') = \n\n'))
    pointval = U(IJ(1), IJ(2));
    disp(pointval)
    plot3(sampleXT(1),sampleXT(2),pointval,'r*','LineWidth',1)
end

%   %   %   %   %



















%   %   %   %   %
