function [ res ] = operator_Norming( beam )
% It norming Energy by 1

    res = beam;
    res.values = res.values / sqrt(get_Energy(res));
    
end

