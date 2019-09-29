classdef function_rectangle < function_base
       
    properties (Access = private)
        scale_rect_default = 1;
        center_rect_default = 0;
    end
    
    properties (Access = public)
        scale_rect
        center_rect
    end

    methods (Access = public)

        function obj = function_rectangle(scale_rect, center_rect)
            if nargin < 1
                scale_rect = obj.scale_rect_default;
            end
            
            if nargin < 2
                center_rect = obj.center_rect_default;
            end
            
            if length(scale_rect)~=length(center_rect)
                error("Size of scale and size of center is not match!");
            end
            
            obj.scale_rect = scale_rect;
            obj.center_rect = center_rect;
        end

    end

    methods (Access = public)

        function value = calculate(obj, point)

            local_scale_rect = obj.scale_rect;
            local_center_rect = obj.center_rect;

            if length(local_scale_rect) == 1
                local_scale_rect = local_scale_rect * ones(size(point));
            elseif sum(size(local_scale_rect) ~= size(point))
                error("Size of scale rect and size of point is not match!");
            end
            
            if length(local_center_rect) == 1
                local_center_rect = local_center_rect * ones(size(point));
            elseif sum(size(local_center_rect) ~= size(point))
                error("Size of center rect and size of point is not match!");
            end

            if prod(abs(point-local_center_rect) <= local_scale_rect / 2) 
                value = 1;
            else
                value = 0;
            end

        end

    end

end