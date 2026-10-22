% Interpoliacija ir funkciju aproksimacija.
clear; clc; close all;
studento_nr = 20194658;
variantas = mod(studento_nr,5); % Pagal uzduoti: 0-4.

switch variantas
    case 0
        f = @(x) (1+x)./log(1+x); a = 1; b = 5;
    case 1
        f = @(x) 1./(1+exp(x)); a = -10; b = 10;
    case 2
        f = @(x) x./(1+x.^2); a = -10; b = 10;
    case 3
        f = @(x) x./(1+x.^2); a = 0; b = 2;
    case 4
        f = @(x) 1./(1+x.^3); a = 0; b = 2;
    case 5 % PDF yra ir 5 variantas, bet mod(nr,5) jo neparenka.
        f = @(x) 1./(1+x.^4); a = -2; b = 2;
end
fprintf('Variantas: %d\n',variantas);
eiles = [2 3 5 7 9];
x = linspace(a,b,1001);
y = f(x);
NMSE = zeros(5,4);
metodai = {'Lagrange uniform','Lagrange Chebyshev', ...
    'Spline uniform','Spline Chebyshev'};

for i = 1:length(eiles)
    n = eiles(i);
    xu = linspace(a,b,n+1);
    % Cebysevo mazgai turi buti surikiuoti spline funkcijai.
    xc = sort((a+b)/2+(b-a)/2*cos((2*(0:n)+1)*pi/(2*(n+1))));
    yu = f(xu); yc = f(xc);
    p1 = lagran(xu,yu);
    p2 = lagran(xc,yc);
    Y = [polyval(p1,x); polyval(p2,x); ...
        spline(xu,yu,x); spline(xc,yc,x)];
    for j = 1:4
        % NMSE: paklaidos energija / funkcijos energija.
        NMSE(i,j) = sum((y-Y(j,:)).^2)/sum(y.^2);
    end
    figure('Theme','light');
    plot(x,y,'k-',x,Y,'LineWidth',1.2); hold on;
    plot(xu,yu,'ko',xc,yc,'ms');
    legend([{'Function'},metodai,{'Uniform nodes','Chebyshev nodes'}], ...
        'Location','best');
    title(sprintf('Variant %d, degree %d',variantas,n));
    xlabel('x'); ylabel('y'); grid on;
end
disp(array2table([eiles' NMSE],'VariableNames', ...
    {'Degree','LagrangeUniform','LagrangeChebyshev','SplineUniform','SplineChebyshev'}));
figure('Theme','light');
semilogy(eiles,NMSE,'-o'); grid on;
legend(metodai,'Location','best');
xlabel('Degree'); ylabel('NMSE');
