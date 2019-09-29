function [ res , x , y ] = get_Intensity( beam )
% Intensity of beam
    magFunction = get_Magnitude(beam);
    res = magFunction.*magFunction;
    x = beam.x;
    y = beam.y;

end

