function [ result ] = filter_smooth( beam, degree )

    if nargin < 2
        degree = 1;
    end
    
    result = beam;
    
    for k = 1:abs(degree)
        temp = result;
        for i = 1:length(temp.x)
            for j = 1:length(temp.y)
                current_area = get_area(i, j, result);
                temp.values(i,j) = get_smooth(current_area);
            end
        end
        result = set_Energy(temp, result);
    end
    
    result.name = ['[' result.name ']*smooth(' num2str(degree) ')'];
end

function [ result ] = get_area( i, j, beam )

    if 2 < i && i <= (length(beam.x)-2) && 2 < j && j <= (length(beam.y)-2)
        % start I ring
        result = beam.values((i-2):(i+2),(j-2):(j+2));
        % end I ring
    else 
        if 1 < i && i <= (length(beam.x)-1) && 1 < j && j <= (length(beam.y)-1)
            % start II ring
            result = beam.values((i-1):(i+1),(j-1):(j+1));
            if i == 2
                result = [zeros([1 3]); result; beam.values(i+2,(j-1):(j+1))];
            else
                result = [beam.values(i-2,(j-1):(j+1)); result; zeros([1 3])];
            end
            if j == 2
                result = [zeros([5 1]) result];
                if i == 2
                    result = [result [0; beam.values((i-1):(i+2),j+2)]];
                end
                if 2 < i && i <= (length(beam.x)-2)
                    result = [result beam.values((i-2):(i+2),j+2)];
                end
                if i == (length(beam.x)-1)
                    result = [result [beam.values((i-2):(i+1),j+2); 0]];
                end
            end
            if 2 < j && j <= (length(beam.y)-2)
                if i == 2
                    result = [[0; beam.values((i-1):(i+2),j-2)] result [0; beam.values((i-1):(i+2),j+2)]];
                end
                if i == (length(beam.x)-1)
                    result = [[beam.values((i-2):(i+1),j-2); 0] result [beam.values((i-2):(i+1),j+2); 0]];
                end
            end
            if j == (length(beam.y)-1)
                result = [result zeros([5 1])];
                if i == 2
                    result = [[0; beam.values((i-1):(i+2),j-2)] result];
                end
                if 2 < i && i <= (length(beam.x)-2)
                    result = [beam.values((i-2):(i+2),j-2) result];
                end
                if i == (length(beam.x)-1)
                    result = [[beam.values((i-2):(i+1),j-2); 0] result];
                end
            end
            % end II ring
        else 
            % start III ring
            if i == 1 && j == 1 % left up corner
                result = [zeros([2 5]); zeros([3 2]) beam.values(i:(i+2),j:(j+2))];
            end
            
            if i == 1 && j == length(beam.y) % right up corner
                result = [zeros([2 5]); beam.values(i:(i+2),(j-2):j) zeros([3 2])];
            end
            
            if i == length(beam.x) && j == 1 % left down corner
                result = [zeros([3 2]) beam.values((i-2):i,j:(j+2)); zeros([2 5])];
            end
            
            if i == length(beam.x) && j == length(beam.y) % right down corner
                result = [beam.values((i-2):i,(j-2):j) zeros([3 2]); zeros([2 5])];
            end
            
            if i == 1 && 2 < j && j <= (length(beam.y)-2) % up side
                result = [zeros([2 5]); beam.values(i:(i+2),(j-2):(j+2))];
            end
            
            if i == length(beam.x) && 2 < j && j <= (length(beam.y)-2) % down side
                result = [beam.values((i-2):i,(j-2):(j+2)); zeros([2 5])];
            end
            
            if 2 < i && i <= (length(beam.x)-2) && j == 1 % left side
                result = [zeros([5 2]) beam.values((i-2):(i+2),j:(j+2))];
            end
            
            if 2 < i && i <= (length(beam.x)-2) && j == length(beam.y) % right side
                result = [beam.values((i-2):(i+2),(j-2):j) zeros([5 2])];
            end
            switch i 
                case 2
                    switch j
                        case 1 % left up point
                            result = [zeros([5 2]) [zeros([1 3]); beam.values((i-1):(i+2),j:(j+2))]];
                        case length(beam.y) % right up point
                            result = [[zeros([1 3]); beam.values((i-1):(i+2),(j-2):j)] zeros([5 2])];
                    end
                case (length(beam.x)-1)
                    switch j
                        case 1 % left down point
                            result = [zeros([5 2]) [beam.values((i-2):(i+1),j:(j+2)); zeros([1 3])]];
                        case length(beam.y) % right down point
                            result = [[beam.values((i-2):(i+1),(j-2):j); zeros([1 3])] zeros([5 2])];
                    end
            end
            switch j
                case 2
                    switch i
                        case 1 % up left point
                            result = [zeros([2 5]); [zeros([3 1]) beam.values(i:(i+2),(j-1):(j+2))]];
                        case length(beam.x) % down left point
                            result = [[zeros([3 1]) beam.values((i-2):i,(j-1):(j+2))]; zeros([2 5])];
                    end
                case (length(beam.y)-1)
                    switch i
                        case 1 % up right point
                            result = [zeros([2 5]); [beam.values(i:(i+2),(j-2):(j+1)) zeros([3 1])]];
                        case length(beam.x)  % down right point
                            result = [[beam.values((i-2):i,(j-2):(j+1)) zeros([3 1])]; zeros([2 5])];
                    end
            end
            % end III ring
        end 
    end

end

function [ result ] = get_smooth( current_area )
    
    i_ring = current_area(3,3);
    ii_ring = sum(sum(current_area(2:4,2:4)))-i_ring;
    iii_ring = sum(sum(current_area))-ii_ring;
    
    result = i_ring*2/3 + ii_ring*3/10 + iii_ring*1/30;

end