function [ res ] = function_Laguerre( N, M, X )
    for i = 1:length(X)
        x = X(i);
        if N == 0
            value = 1 + M;
        else
            if N == 1
                value = 1 + M - x;
            else
                value = ((2*N+M-1-x)*function_Laguerre(N-1,M,x)-(N+M-1)*function_Laguerre(N-2,M,x))/N;
            end
        end
        res(i) = value;
    end
end