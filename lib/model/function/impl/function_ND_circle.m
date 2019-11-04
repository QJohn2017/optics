classdef function_ND_circle < function_base

    properties (Access = protected)
        radius_circ
        center_circ
    end

    methods (Access = public)

        function obj = function_ND_circle(radius_circ, center_circ)
            if nargin < 1
                radius_circ = 1;
            end
            
            if nargin < 2
                center_circ = 0;
            end
            
            if length(radius_circ) ~= length(center_circ)
                error("Size of scale and size of center is not match!");
            end
            
            obj = obj@function_base;
            
            obj.name = 'circle';
            obj.description = ['[' num2str(radius_circ) '] x [' num2str(center_circ) ']'];
            
            obj.radius_circ = radius_circ;
            obj.center_circ = center_circ;
            
            obj.func = @(v) obj.circle(v, obj.radius_circ, obj.center_circ);
        end

    end

    methods (Access = public)
        function radius = getRadius(obj)
            radius = obj.radius_circ;
        end
        function center = getCenter(obj)
            center = obj.center_circ;
        end
    end
    
    methods (Access = protected)

        function value = circle(obj, point, radius, center)

            if length(center) == 1
                center = center * ones(size(point));
            elseif sum(size(center) ~= size(point))
                error("Size of center circle and size of point is not match!");
            end
            point = point - center;
            if sum(point.*point) <= radius
                value = 1;
            else
                value = 0;
            end

        end

    end

end