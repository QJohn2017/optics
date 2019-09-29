function [ result ] = get_SummaBeams( beams , array_C )

    if nargin < 2
        array_C = ones(1,length(beams));
    end
    
    if length(beams) == 1
        current_beam = beams;
        for i = 1:length(array_C)-1
            beams = [beams current_beam];
        end
    end
    
    result = beam_Null(beams(1).resolution, beams(1).size, beams(1).wavelength);

    for i = 1:length(beams)
        result.values = result.values + array_C(i) * beams(i).values;
    end
    
    names = {};
    
    for i=1:length(array_C)
        if array_C(i) ~= 0
            names{end+1} = beams(i).name;
        end
    end
    
%     result.name = [beams(1).name];
%     for i = 2:(length(beams))
%         result.name = [result.name '+' beams(i).name];
%     end
    if ~isempty(names)
        result.name = [names{1}];
        for i = 2:(length(names))
            result.name = [result.name '+' names{i}];
        end
    else
        result.name = 'empty';
    end

end

