function [ result ] = stat_M( X, P )
    
    if nargin < 2
        P = ones(size(X))/numel(X);
    end

    if abs(round(sum(P(:)),6) - 1) > eps
        error('Summa of P is not equal by 1');
    end
    
    X = X.*P;
    
    result = sum(X(:));

end