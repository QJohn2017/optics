function [ result ] = convert_SummaSurfaces( surfaces , array_C )

    if nargin < 2
        array_C = ones(1,length(surfaces));
    end
  
    result = surface_Null(surfaces(1).resolution, surfaces(1).size, surfaces(1).wavelength);
    result.name = '';
    
    for i = 1:length(surfaces)
        result.values = result.values + array_C(i) * surfaces(i).values;
        if array_C(i) == 1
            add_name = surfaces(i).name;
        elseif array_C(i) == -1
            add_name = ['-(' surfaces(i).name ')'];
        elseif array_C(i) == 0
            add_name = '0';
        else
            add_name = [num2str(array_C(i)) '(' surfaces(i).name ')'];
        end
        if isempty(result.name)
            result.name = add_name;
        else
            result.name = [result.name ' + ' add_name];
        end
    end
    
end