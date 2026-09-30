% Function approximation: all six PDF variants.
clear; clc; close all;
variants = 1:6; % use, for example, [1 4] to run selected variants
for variant = variants
fprintf('\nFUNCTION VARIANT %d\n',variant);
switch variant
    case 1
        f = @(x) (1+x)./log(1+x); a = 1; b = 5;
    case 2
        f = @(x) 1./(1+exp(x)); a = -10; b = 10;
    case 3
        f = @(x) x./(1+x.^2); a = -10; b = 10;
    case 4
        f = @(x) x./(1+x.^2); a = 0; b = 2;
    case 5
        f = @(x) 1./(1+x.^3); a = 0; b = 2;
    case 6
        f = @(x) 1./(1+x.^4); a = -2; b = 2;
    otherwise
        error('variant must be from 1 to 6.');
end
orders = [2 3 5 7 9];
x = linspace(a,b,1001);
y = f(x);
x0 = (a+b)/2;
methods = {'Lagrange','Newton','Chebyshev','Pade','Spline'};
mse = zeros(length(orders),5);
maxError = mse;
nodeDifference = zeros(length(orders),1);
padeDegrees = zeros(length(orders),2);

for i = 1:length(orders)
    n = orders(i);
    nodes = linspace(a,b,n+1);
    values = f(nodes);
    pL = lagran(nodes,values);
    pN = niuton(nodes,values);
    [pC,chebNodes,chebValues] = cheby(f,n,a,b);

    % Known power series avoid unstable high-order numerical derivatives.
    c = taylor_coefficients(variant,x0,n);
    % For order n, the Pade degrees add up to n.
    M = floor(n/2); N = n-M;
    [num,den,M,N] = pade_coefficients(c,M,N);
    padeDegrees(i,:) = [M N];
    shiftedX = x-x0;
    yTaylor = polyval(fliplr(c),shiftedX);
    denominator = polyval(fliplr(den),shiftedX);
    % Detect poles between grid points as well as at grid points.
    denRoots = roots(fliplr(den));
    realPoles = real(denRoots(abs(imag(denRoots)) < 1e-8))+x0;
    realPoles = realPoles(realPoles >= a & realPoles <= b);
    if ~isempty(realPoles)
        fprintf('Pade [%d/%d] has poles in the interval at x = ',M,N);
        fprintf('%g ',realPoles); fprintf('\n');
    end
    approx = [polyval(pL,x); polyval(pN,x); polyval(pC,x); ...
        polyval(fliplr(num),shiftedX)./denominator; spline(nodes,values,x)];
    for j = 1:5
        mse(i,j) = mean((y-approx(j,:)).^2);
        maxError(i,j) = max(abs(y-approx(j,:)));
    end
    if ~isempty(realPoles)
        maxError(i,4) = Inf; % the continuous maximum is unbounded
    end
    nodeDifference(i) = max(abs(approx(1,:)-approx(2,:)));

    % Break plot lines across poles instead of joining both branches.
    plotApprox = approx;
    for pole = realPoles'
        [~,nearest] = min(abs(x-pole));
        plotApprox(4,max(1,nearest-1):min(length(x),nearest+1)) = NaN;
    end
    figure('Name',sprintf('Order %d',n));
    subplot(2,1,1);
    plot(x,y,'k-',x,plotApprox,'LineWidth',1.1); hold on;
    plot(nodes,values,'ko',chebNodes,chebValues,'ms');
    legend([{'Function'},methods,{'Uniform nodes','Chebyshev nodes'}], ...
        'Location','best');
    xlabel('x'); ylabel('y'); grid on;
    title(sprintf('Variant %d, degree %d, %d nodes',variant,n,n+1));
    subplot(2,1,2);
    plot(x,y,'k-',x,yTaylor,'b--',x,plotApprox(4,:),'r-','LineWidth',1.1);
    legend('Function','Taylor','Pade','Location','best');
    xlabel('x'); ylabel('y'); grid on;
    title(sprintf('Taylor about x0 = %g; Pade [%d/%d]',x0,M,N));
end

disp('Mean squared errors:');
disp(array2table([orders' mse],'VariableNames',[{'Degree'},methods]));
disp('Maximum absolute errors:');
disp(array2table([orders' maxError],'VariableNames',[{'Degree'},methods]));
disp('Difference between Lagrange and Newton on the same grid:');
disp(table(orders',nodeDifference,'VariableNames',{'Degree','Difference'}));
figure('Name','Approximation errors');
subplot(2,1,1);
semilogy(orders,max(mse,eps),'-o');
legend(methods,'Location','best'); xlabel('Degree'); ylabel('MSE'); grid on;
subplot(2,1,2);
semilogy(orders,max(maxError,eps),'-o');
legend(methods,'Location','best'); xlabel('Degree'); ylabel('Maximum error'); grid on;
end

% Keep plots readable when MATLAB uses a dark theme.
set(findall(groot,'Type','figure'),'Color','w');
set(findall(groot,'Type','axes'),'Color','w','XColor','k','YColor','k');
set(findall(groot,'Type','legend'),'Color','w','TextColor','k');
set(findall(groot,'Type','text'),'Color','k');

function c = taylor_coefficients(variant,x0,n)
% Expand numerator and denominator in ascending powers of s = x-x0.
p = zeros(1,n+1); q = p;
switch variant
    case 1
        p(1:2) = [1+x0 1]; q(1) = log(1+x0);
        for j = 1:n
            q(j+1) = (-1)^(j+1)/(j*(1+x0)^j);
        end
    case 2
        p(1) = 1; q(1) = 1+exp(x0);
        for j = 1:n
            q(j+1) = exp(x0)/factorial(j);
        end
    case {3,4}
        p(1:2) = [x0 1]; q(1:3) = [1+x0^2 2*x0 1];
    case {5,6}
        power = variant-2; % 3 for variant 5, 4 for variant 6
        p(1) = 1; q(1) = 1+x0^power;
        for j = 1:min(n,power)
            q(j+1) = nchoosek(power,j)*x0^(power-j);
        end
end
% Coefficient matching in q(s)*c(s) = p(s).
c = zeros(1,n+1);
for j = 0:n
    value = p(j+1);
    for r = 1:j
        value = value-q(r+1)*c(j-r+1);
    end
    c(j+1) = value/q(1);
end
end

function [num,den,M,N] = pade_coefficients(c,M,N)
% Coefficients are stored in ascending powers of (x-x0).
% Exact rational functions can give a singular full-size Pade system.
% Reduce the denominator degree until the system is nonsingular.
total = M+N;
while N > 0
    A = zeros(N); rhs = zeros(N,1);
    for row = 1:N
        power = M+row;
        rhs(row) = -c(power+1);
        for col = 1:N
            if power-col >= 0
                A(row,col) = c(power-col+1);
            end
        end
    end
    if rcond(A) > 1e-12
        break;
    end
    N = N-1; M = total-N;
end
if N == 0
    den = 1;
else
    den = [1; A\rhs]';
end
num = conv(c,den);
num = num(1:M+1);
end
