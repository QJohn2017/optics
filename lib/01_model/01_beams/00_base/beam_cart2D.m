classdef beam_cart2D < beam_cart

    properties (Access = private, Constant)
        resolution_default = [31 31]
        scale_default = [1 1]
    end
    
    properties (Access = public)
        x_title = 'x';
        y_title = 'y';
    end
    
    methods (Access = public)
        
        function obj = beam_cart2D(resolution, scale)
                                    
            if nargin < 1
                resolution = [31 31];
            end
            
            if nargin < 2
                scale = [1 1];
            end
            
            if length(resolution) ~= 2
                error("Size of resolution is not equals two!");
            end
            
            obj = obj@beam_cart(resolution, scale);
            
        end
        
        function x = GetX(obj)
            x = obj.axes{1};
        end
        
        function y = GetY(obj)
            y = obj.axes{2};
        end
        
        function obj = SetX(obj, x)
            axes = obj.axes;
            axes{1} = x;
            obj = obj.SetAxes(axes);
        end
        
        function obj = SetY(obj, y)
            axes = obj.axes;
            axes{2} = y;
            obj = obj.SetAxes(axes);
        end
        
        function obj = SetAxes(obj, axes)
            if length(axes) ~= 2
                error("Size of axes is not equals two!");
            end
            obj = SetAxes@beam_base(obj, axes);
        end
        
    end
            
end

