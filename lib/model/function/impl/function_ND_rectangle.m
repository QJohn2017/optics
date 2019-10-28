classdef function_ND_rectangle < function_base
       
    properties (Access = protected)
        scale_rect
        center_rect
    end

    methods

        function obj = function_ND_rectangle(scale_rect, center_rect)
            if nargin < 1
                scale_rect = 1;
            end
            
            if nargin < 2
                center_rect = 0;
            end
            
            if length(scale_rect)~=length(center_rect)
                error("Size of scale and size of center is not match!");
            end
            
            obj = obj@function_base;
            
            obj.name = 'rectangle';
            obj.description = ['[' num2str(scale_rect) '] x [' num2str(center_rect) ']'];
            
            obj.scale_rect = scale_rect;
            obj.center_rect = center_rect;
            
            obj.func = @(p) obj.rectangle(p);
        end
    end
    
    methods (Access = public)
        function scale = getScale(obj)
            scale = obj.scale_rect;
        end
        function center = getCenter(obj)
            center = obj.center_rect;
        end
    end
    
    methods (Access = protected)
        function value = rectangle(obj, point)
            
            scale = obj.scale_rect;
            center = obj.center_rect;
            
            if prod(abs(point-center) <= scale / 2) 
                value = 1;
            else
                value = 0;
            end
        end
    end

end