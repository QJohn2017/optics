classdef function_2D_XY_edge < function_base

    properties (Access = protected)
        values
        input_func
        input_field
    end

    methods (Access = public)

        function obj = function_2D_XY_edge(input_func, input_field)
            
            values = input_func.getValuesOn(input_field);
            
            obj = obj@function_base;
            
            obj.input_func = input_func;
            obj.input_field = input_field;
            
            obj.values = obj.egde(values);
            obj.func = @(x) obj.calculate(x);
            
            obj.name = 'edge';
        end

    end
    
    methods (Access = public)
        function val = calculate(obj, point)
            coord = obj.input_field.findPoint(point);
            val = obj.values(coord(1),coord(2));
        end
    end
    
    methods (Access = protected)

        function res = egde(obj, values)

            [n, m] = size(values);
            
            for i = 1:n
                for j = 1:m
                    if i == 1
                        res(i,j) = values(i,j);
                    elseif j == 1
                        res(i,j) = values(i,j);
                    elseif i == n
                        res(i,j) = values(i,j);
                    elseif j == m
                        res(i,j) = values(i,j);
                    else
                        sq = values(i-1:i+1,j-1:j+1);
                        val = abs(max(max(sq))-min(min(sq)));
                        res(i,j) = val;
                    end
                end
            end

        end

    end

end