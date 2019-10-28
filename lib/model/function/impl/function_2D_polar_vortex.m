classdef function_2D_polar_vortex < function_base
    properties (Access = public)
        deg
    end
    
    methods (Access = public)
        function obj = function_2D_polar_vortex(deg)
            if nargin < 1
                deg = 1;
            end
            
            obj = obj@function_base;
            
            obj.deg = deg;
            
            obj.func = @(r) obj.vortex(r);
        end

    end
    
    methods (Access = public)
        function deg = getDegree(obj)
            deg = obj.deg;
        end
    end
    
    methods (Access = protected)
                
        function value = vortex(obj, point)
            val = obj.deg;
            value = (point(1)^val)*exp(val*1j*point(2));
        end
    end
end

