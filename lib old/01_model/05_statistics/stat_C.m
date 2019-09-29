function [ result ] = stat_C( X, Y, P )
    
    if nargin < 3
        P = ones(size(X))/numel(X);
    end
    
    if nargin < 2
        Y = X;
    end

    result = stat_M( (X-stat_M(X,P)).*(Y-stat_M(Y,P)), P);
    
end

