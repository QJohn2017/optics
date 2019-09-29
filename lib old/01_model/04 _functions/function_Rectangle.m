function [ result ] = function_Rectangle( value, width )
    if nargin < 2
        width = 1;
    end
    if abs(value) <= width/2
        result = 1;
    else
        result = 0;
    end
end