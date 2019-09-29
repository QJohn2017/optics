function [ result_indexes ] = function_Find( array, center, radius )

    if nargin < 3
        radius = 0;
    end 
    if nargin < 2
        center = (array(1)+array(end))/2;
    end
    
    index_root = find(abs(array-center)==min(abs(array-center)));
    result_indexes = index_root;
    
    for i = (index_root-1):-1:1
        if array(i) >= (center-radius)
            result_indexes = [i result_indexes];
        else
            break;
        end
    end

    for i = (index_root+1):length(array)
        if array(i) <= (center+radius)
            result_indexes = [result_indexes i];
        else
            break;
        end
    end
    
    if radius == 0 && length(result_indexes)>1
        result_indexes = result_indexes(1);
    end
    
end