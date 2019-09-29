function [ result ] = get_Code( X )

    value_control = max(X)/2;
    result = zeros(size(X));
    result(find((X - value_control)>0)) = 1;
end