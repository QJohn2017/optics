classdef function_custom < function_base
   
    properties (Access = protected)
        values
        field
    end
    
    methods (Access = public)
        
        function obj = function_custom(values, field)
            obj = obj@function_base;
            obj.name = 'custom function';
            
            size_values = size(values);
            
            axes = field.getAxes;
            
            size_field(length(axes)) = 0;
            for i = 1:length(axes)
                size_field(i) = length(axes{i});
            end

            if sum(size_values ~= size_field)
                error("Size of values and size of field is not match");
            end
            
            obj.values = values;
            obj.field = field;
        end

    end
    
    methods (Access = public)

        function value = calculate(obj, point)

            local_values = obj.values;
            local_field = obj.field;
            
            coord = local_field.findPoint(point);
            
            value = obj.getValue(local_values, coord);
            
        end
        
        function field = getField(obj)
            field = obj.field;
        end

        function obj = setField(obj, field)
            local_field = obj.field;
            
            local_res = local_field.getResolution;
            field_res = field.getResolution;
            
            if length(local_res) ~= length(field_res)
                warning("Resolution of new field is not valid. Setting did not happen");
                return;
            end
            
            if sum(local_res ~= field_res)
                warning("Resolution of new field is not valid. Setting did not happen");
                return;
            end
            
            obj.field = field;
        end
        
    end
    
    methods (Access = protected)

        function value = getValue(obj, values, coord)
            
            size_values = size(values);
            
            if length(coord) > 1
                
                if length(coord) == 2
                    values = values(coord(1),:);
                else
                    values = reshape(values(coord(1),:), size_values(2:end));
                end
                
                value = obj.getValue(values, coord(2:end));
            else
                
                value = values(coord);

            end

        end

    end
end

