classdef function_rect < function_base
       
    properties (Access = private)
        scale_rect_default = 1;
    end
    
    properties (Access = public)
        scale_rect
    end

    methods (Access = public)

        function obj = function_rect(scale_rect)
            if nargin < 1
                scale_rect = obj.scale_rect_default;
            end
            
            obj.scale_rect = scale_rect;
        end

    end

    methods (Access = public)

        function value = Calculate(obj, point)

            local_scale_rect = obj.scale_rect;

            if length(local_scale_rect) == 1
                local_scale_rect = local_scale_rect * ones(size(point));
            elseif sum(size(local_scale_rect) ~= size(point))
                error("Size of scale rect and size of point is not match!");
            end

            if prod(abs(point) <= local_scale_rect / 2) 
                value = 1;
            else
                value = 0;
            end

        end

    end

end