function [ result ] = function_ScalarProduct( beam1, beam2 )

    if nargin < 2
        beam2 = beam1;
    end

    dx = (beam1.x(length(beam1.x))-beam1.x(1))/(beam1.resolution(1)-1);
    dy = (beam1.y(length(beam1.y))-beam1.y(1))/(beam1.resolution(2)-1);
    
    for i = 1:length(beam1.x)
        for j = 1:length(beam1.y)
            
            temp(i,j) = beam1.values(i,j) * beam2.values(i,j)';
            
        end
    end
    
    result = sum(sum(temp))*dx*dy;
end