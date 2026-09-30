function c = taylor_coefficients(variant,x0,n)
% Exact Taylor coefficients for the six assignment functions.
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
        power = variant-2;
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
