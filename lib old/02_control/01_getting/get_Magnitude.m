function [ res , x , y ] = get_Magnitude( beam )
% Magnitude of beam
    res = abs(beam.values);
    x = beam.x;
    y = beam.y;
    
end

