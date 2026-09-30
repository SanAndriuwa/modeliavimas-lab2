function [c,x,y] = cheby(f,N,a,b)
%Input : f = function name on [a,b]
%Output: c = Newton polynomial coefficients of degree N
% (x,y) = Chebyshev nodes
if nargin == 2, a = -1; b = 1; end
k = 0:N;
theta = (2*N + 1 - 2*k)*pi/(2*N + 2);
xn = cos(theta); %Eq.(3.3.1a)
x = (b - a)/2*xn +(a + b)/2; %Eq.(3.3.1b)
y = feval(f,x);
d = zeros(1,N+1);
d(1) = y*ones(N + 1,1)/(N+1);
for m = 2: N + 1
    cos_mth = cos((m-1)*theta);
    d(m) = y*cos_mth'*2/(N + 1); %Eq.(3.3.6b)
end
xn = [2 -(a + b)]/(b - a); %the inverse of (3.3.1b)
T_0 = 1; T_1 = xn; %Eq.(3.3.3b)
c = d(1)*[0 T_0] +d(2)*T_1; %Eq.(3.3.5)
for m = 3: N + 1
    tmp = T_1;
    T_1 = 2*conv(xn,T_1) -[0 0 T_0]; %Eq.(3.3.3a)
    T_0 = tmp;
    c = [0 c] + d(m)*T_1; %Eq.(3.3.5)
end





