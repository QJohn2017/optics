classdef function_2D_XY_vortex < function_base
    properties (Access = public)
        deg
    end
    
    methods (Access = public)
        function obj = function_2D_XY_vortex(deg)
            if nargin < 1
                deg = 1;
            end
            
            obj = obj@function_base;
            
            obj.deg = deg;
            
            obj.func = @(x) obj.vortex(x);
        end

    end
    
    methods (Access = public)
        function deg = getDegree(obj)
            deg = obj.deg;
        end
    end
    
    methods (Access = protected)
                
        function value = vortex(obj, point)
            value = (point(1)+point(2)*1j)^obj.deg;
        end
    end
end

