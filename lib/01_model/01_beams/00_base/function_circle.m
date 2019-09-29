classdef function_circle < function_base
       
    properties (Access = private)
        radius_circ_default = 1;
        center_circ_default = 0;
    end
    
    properties (Access = public)
        radius_circ
        center_circ
    end

    methods (Access = public)

        function obj = function_circle(radius_circ, center_circ)
            if nargin < 1
                radius_circ = obj.radius_circ_default;
            end
            
            if nargin < 2
                center_circ = obj.center_circ_default;
            end
            
            if length(radius_circ)~=length(center_circ)
                error("Size of scale and size of center is not match!");
            end
            
            obj.radius_circ = radius_circ;
            obj.center_circ = center_circ;
        end

    end

    methods (Access = public)

        function value = calculate(obj, point)

            local_radius_circ = obj.radius_circ;
            local_center_circ = obj.center_circ;
            
            if length(local_center_circ) == 1
                local_center_circ = local_center_circ * ones(size(point));
            elseif sum(size(local_center_circ) ~= size(point))
                error("Size of center circle and size of point is not match!");
            end
            point = point - local_center_circ;
            if sum(point.*point)<=local_radius_circ
                value = 1;
            else
                value = 0;
            end

        end

    end

end