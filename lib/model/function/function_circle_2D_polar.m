classdef function_circle_2D_polar < function_base

    properties (Access = public)
        radius_circ
    end

    methods (Access = public)

        function obj = function_circle_2D_polar(radius_circ)
            if nargin < 1
                radius_circ = 1;
            end
            
            obj = obj@function_base;
            
            obj.name = 'circle';
            obj.description = ['[' num2str(radius_circ) ']'];
            
            obj.radius_circ = radius_circ;
        end

    end

    methods (Access = public)

        function value = calculate(obj, point)

            local_radius_circ = obj.radius_circ;
            
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