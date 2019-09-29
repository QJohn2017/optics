function [ res ] = get_Energy( beams )
% It returns value of energy of beams

    [n, m]=size(beams);
    for i=1:n
        for j = 1:m
            beam = beams(i,j);
            res(i,j) = function_ScalarProduct( beam );
            %dx = (beam.x(length(beam.x))-beam.x(1))/(beam.resolution(1)-1);
            %dy = (beam.y(length(beam.y))-beam.y(1))/(beam.resolution(2)-1);
            %res(i,j) = sum(sum(get_Intensity(beam))) * dx * dy;
        end
    end
    
end