function [ res ] = get_MaxInt( beam )
% It returns value of maximum of absolute values

    res = max(max(get_Intensity(beam)));
    
end

