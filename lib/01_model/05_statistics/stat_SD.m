function [ result ] = stat_SD( X, Y )

    result = sqrt( sum((X(:)-Y(:)).^2)/(length(X(:))-1) );

end

