function [ res ] = operator_Cut( beam, axis, area )
% It cuts beam for current axis along area

    res = beam;
    
    startValue = area(1);
    endValue = area(2);
    
    if axis == 'x'
        startIndex = Find(res.x,startValue);
        endIndex = Find(res.x,endValue);
        res.x = res.x(startIndex:endIndex);
        res.values = res.values(startIndex:endIndex, :);
    end

    if axis == 'y'
        startIndex = Find(res.y,startValue);
        endIndex = Find(res.y,endValue);
        res.y = res.y(startIndex:endIndex);
        res.values = res.values(:, startIndex:endIndex);
    end
    
end

function [ res ] = Find( array, value )

    res = find(abs(array-value)==min(abs(array-value)));
    
end 