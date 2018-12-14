% Difference Equation Method for PDEs
clear
clc
hold off

% Edit X,T domain
xdom = [0 2];
tdom = [0 1];

% Edit X,T step size (must evenly divide the interval length)
dx = 0.2;
dt = 0.1;


%   Note about Difference Equations and Boundary Conditions:
%   
%   If an edge is omitted, the difference equation cannot reference
%   that direction.
%   Eg: If no upper condition is specified, the diff eqn cannot use the
%   point M(i-1,j) because eventually i-1 = 0 which is out of bounds.
%
% Edit difference equation after @(M,i,j)
% (Top left of domain is i=1, j=1)
difference = @(M,i,j) (1/3)*(M(i+1,j-1) + M(i+1,j) + M(i+1,j+1));

% Edit boundary conditions after @(*)
% upperCondition = @(X) ;            % top edge u(x,tdom(2))
lowerCondition = @(X) X.^2;            % bottom edge, u(x,tdom(1))
leftCondition = @(T) 0.*T;                  % left edge, u(xdom(1),t)
rightCondition = @(T) T + 4;                 % right edge, u(xdom(2),t)


% Edit evaluation point
sampleXT = [1, 1/2];


% Plot boundary curves yes/no
plotBoundaryCurves = 0;


% Max error for steady state
allowed_err = 10^-10;



% Calculations



% Solution matrix dimensions
xn = (xdom(2)-xdom(1))/dx + 1;
tn = (tdom(2)-tdom(1))/dt + 1;

% Solution (empty)
U = zeros(tn, xn);

% IJ domain
idom = [1 tn];
jdom = [1 xn];

% Slightly different procedure for filling in each boundary

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


current_err = 9999999999;
prevU = U;

% Compute difference equation starting at known borders
switch char(cond)
    case char([0 1 1 1]) % Top unknown, fill from bottom
        while current_err > allowed_err
            % Relax system
            for t = tdom(1)+dt:dt:tdom(2)
                for x = xdom(1)+dx:dx:xdom(2)-dx
                    i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
                    j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
                    if idom(1) <= i <= idom(2) && jdom(1) <= j <= jdom(2)
                        U(i,j) = difference(U,i,j);
                    else
                        disp('index out of bounds')
                    end
                end
            end
            current_err = abs(norm(U,2) - norm(prevU,2));
            prevU = U;
        end
    case char([1 0 1 1])  % Bottom unknown, fill from top
        while current_err > allowed_err
            for t = tdom(2)-dt:-dt:tdom(1)
                for x = xdom(1)+dx:dx:xdom(2)-dx
                    i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
                    j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
                    if idom(1) <= i <= idom(2) && jdom(1) <= j <= jdom(2)
                        U(i,j) = difference(U,i,j);
                    else
                        disp('index out of bounds')
                    end
                end
            end
            current_err = abs(norm(U,2) - norm(prevU,2));
            prevU = U;
        end
    case char([1 1 0 1]) % Left unknown, fill from right
        while current_err > allowed_err
            for x = xdom(2)-dx:-dx:xdom(1)
                for t = tdom(1)+dt:dt:tdom(2)-dt
                    i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
                    j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
                    if idom(1) <= i <= idom(2) && jdom(1) <= j <= jdom(2)
                        U(i,j) = difference(U,i,j);
                    else
                        disp('index out of bounds')
                    end
                end
            end
            current_err = abs(norm(U,2) - norm(prevU,2));
            prevU = U;
        end
    case char([1 1 1 0]) % Right unknown, fill from left
        while current_err > allowed_err
            for x = xdom(1)+dx:dx:xdom(2)
                for t = tdom(1)+dt:dt:tdom(2)-dt
                    i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
                    j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
                    if idom(1) <= i <= idom(2) && jdom(1) <= j <= jdom(2)
                        U(i,j) = difference(U,i,j);
                    else
                        disp('index out of bounds')
                    end
                end
            end
            current_err = abs(norm(U,2) - norm(prevU,2));
            prevU = U;
        end
    case char([1 1 1 1])
        % All borders known, fill inner grid by relaxation method
        while current_err > allowed_err
            for t = tdom(1)+dt:dt:tdom(2)-dt
                for x = xdom(1)+dx:dx:xdom(2)-dx
                    i = IfromT(t, tdom(1),tdom(2),idom(1), idom(2));
                    j = JfromX(x, xdom(1), xdom(2), jdom(1), jdom(2));
                    if idom(1) <= i <= idom(2) && jdom(1) <= j <= jdom(2)
                        U(i,j) = difference(U,i,j);
                    else
                        disp('index out of bounds')
                    end
                end
            end
            current_err = abs(norm(U,2) - norm(prevU,2));
            prevU = U;
        end
    otherwise
        fprintf('\nIncorrect boundary conditions.\n\n')
        return
end



% Output

U


% Plot U(x,t) surface
surf(xdom(1):dx:xdom(2),tdom(1):dt:tdom(2),flip(U,1))
hold on
% plot3( [xdom(1) xdom(2) xdom(2) xdom(1) xdom(1)], [tdom(1) tdom(1) tdom(2)  tdom(2) tdom(1)], [0 0 0 0 0],'Color','r','LineWidth',2 )
% figure labels
xlabel('x')
ylabel('t')
zlabel('U(x,t)')
title(strcat(['U(x,t) with ',num2str(idom(2)*jdom(2)),' mesh points']))

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
if exist('sampleXT', 'var')
    IJ = [IfromT(sampleXT(2), tdom(1),tdom(2),idom(1),idom(2)), JfromX(sampleXT(1), xdom(1), xdom(2), jdom(1), jdom(2))];
    fprintf(strcat('U(',num2str(sampleXT(1)),',',num2str(sampleXT(2)),') = \n\n'))
    pointval = U(IJ(1), IJ(2));
    disp(vpa(pointval,10))
    plot3(sampleXT(1),sampleXT(2),pointval,'r*','LineWidth',1) 
end

