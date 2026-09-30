function [num,den,t,M,N] = padeap(f,xo,M,N,xmin,xmax,coefficients)
% Adapted from pade.m: same Taylor matching system, descending outputs.
% Optional exact Taylor coefficients avoid unstable high-order differences.
if xo < xmin || xo > xmax
    error('The Taylor center must be inside the approximation interval.');
end
if nargin < 7
    a = zeros(1,M+N+1);
    a(1) = feval(f,xo);
    h = 0.01; scale = 1;
    for i = 1:M+N
        scale = scale*i*h;
        a(i+1) = difapx(i,[-i i])*feval(f,xo+(-i:i)*h)'/scale;
    end
else
    a = coefficients;
end
total = M+N;
while N > 0
    A = zeros(N); b = zeros(N,1);
    for m = 1:N
        for n = 1:N
            index = M+1+m-n;
            if index >= 1
                A(m,n) = a(index);
            end
        end
        b(m) = -a(M+1+m);
    end
    if rcond(A) > 1e-12
        break;
    end
    N = N-1; M = total-N;
end
if N == 0
    d = zeros(0,1);
else
    d = A\b;
end
q = zeros(1,M+1);
for m = 1:M+1
    mm = min(m-1,N);
    q(m) = a(m:-1:m-mm)*[1; d(1:mm)];
end
% Q(0)=1; the supplied division by d(N) fails when d(N)=0.
num = fliplr(q);
den = [flipud(d)' 1];
t = fliplr(a);
end
