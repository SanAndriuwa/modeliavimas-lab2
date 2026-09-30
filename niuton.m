function [n,DD] = niuton(x,y)
%Input : x = [x0 x1 ... xN]
% y = [y0 y1 ... yN]
%Output: n = Newton polynomial coefficients of degree N
N = length(x)-1;
DD = zeros(N + 1,N + 1);
DD(1:N + 1,1) = y';
for k = 2:N + 1
    for m = 1: N + 2 - k %Divided Difference Table
        DD(m,k) = (DD(m + 1,k - 1) - DD(m,k - 1))/(x(m + k - 1)- x(m));
    end
end
a = DD(1,:); %Eq.(3.2.6)
n = a(N+1); %Begin with Eq.(3.2.7)
for k = N:-1:1 %Eq.(3.2.7)
    n = [n a(k)] - [0 n*x(k)]; %n(x)*(x - x(k - 1))+a_k - 1
end

