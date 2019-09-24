function [ res, x, y ] = get_Phase( beam )
% Angles of beam

    res = angle(beam.values);
    x = beam.x;
    y = beam.y;
    
end

