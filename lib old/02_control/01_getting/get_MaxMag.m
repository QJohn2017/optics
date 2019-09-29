function [ res ] = get_MaxMag( beam )
% It returns value of maximum of absolute values

    res = max(max(get_Magnitude(beam)));
    
end

