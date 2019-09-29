function [ result ] = stat_D( X, P )

    if nargin < 2
        P = ones(size(X))/numel(X);
    end
    
    result = stat_C(X,X,P);
    
    if result < 0 
        result = 0;
    end
end