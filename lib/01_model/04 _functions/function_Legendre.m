function [ result ] = function_Legendre( n, m, teta, phi, dteta )
    
    if nargin < 5
        dteta = 0.1;
    end
    result = (-1)^m * sqrt((2*n+1)*factorial(n-m)/(4*pi*factorial(n+m)))*P(n,m,cos(teta),dteta)*exp(1j*m*phi);

end

function result = P( n, m, x, dx )

    m_ = abs(m);
    if m_ > n
        result = 0;
    else
        result = (1-x^2)^(m_/2)*ddp(n, m_, x, dx);
    end

end

function result = ddp( n, m, x, dx )

    if m > 0
        result = (ddp_simple(n, m, m - 1, x + dx, dx) - ddp_simple(n, m, m - 1, x - dx, dx))/(2*dx);
    else
        result = P_simple(n, x);
    end

end

function result = ddp_simple( n, M, m, x, dx )

    if m > 0
        result = (ddp_simple(n, M, m - 1, x + dx, dx) - ddp_simple(n, M, m - 1, x - dx, dx))/(2*dx);
    else
        result = P_simple(n, x);
    end

end

function result = P_simple( n, x )

    if n == 0
        result = 1;
    end
    if n == 1
        result = x;
    end
    if n > 1
        result = ((2*n+1)*x*P_simple(n-1,x)-n*P_simple(n-2,x))/(n+1);
    end

end