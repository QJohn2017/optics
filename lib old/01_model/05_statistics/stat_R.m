function [ result ] = stat_R( X, Y, P )

    if nargin < 3
        P = ones(size(X))/numel(X);
    end
    
    if nargin < 2
        Y = X;
    end
    
    result = stat_C(X,Y,P)/sqrt(stat_C(X,X,P)*stat_C(Y,Y,P));
    
end