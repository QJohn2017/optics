classdef field_2D_XY < field_ND_base
    
    methods (Access = public)
        function obj = field_2D_XY(resolution, scale, center)
            
            if nargin < 1
                resolution = 3;
            end 
            
            if nargin < 2
                scale = 1;
            end 
            
            if nargin < 3
                center = 0;
            end 
            
            obj = obj@field_ND_base(2, resolution, scale, center);
            obj.axes_title = {'x' 'y'};
            obj.name = '2D cartesian';
        end

        function x = getX(obj)
            x = obj.getAxes{1};
        end

        function y = getY(obj)
            y = obj.getAxes{2};
        end
    end
end

