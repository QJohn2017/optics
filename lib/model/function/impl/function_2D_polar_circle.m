classdef function_2D_polar_circle < function_base

    properties (Access = protected)
        radius_circ
    end

    methods (Access = public)

        function obj = function_2D_polar_circle(radius_circ)
            if nargin < 1
                radius_circ = 1;
            end
            
            obj = obj@function_base;
            
            obj.name = 'circle';
            obj.description = ['[' num2str(radius_circ) ']'];
            
            obj.radius_circ = radius_circ;
            
            obj.func = @(x) obj.circle(x, obj.radius_circ);
        end

    end
    
    methods (Access = public)
        function radius = getRadius(obj)
            radius = obj.radius_circ;
        end
    end
    
    methods (Access = protected)

        function value = circle(obj, point, local_radius_circ)

            r = point(1);
            phi = point(2);
            
            if r <= local_radius_circ
                value = 1;
            else
                value = 0;
            end

        end

    end

end