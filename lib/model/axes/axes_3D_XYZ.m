classdef axes_3D_XYZ < axes_ND_base
    
    methods (Access = public)
        function obj = axes_3D_XYZ(resolution, scale, center)
            
            if nargin < 1
                resolution = 3;
            end 
            
            if nargin < 2
                scale = 1;
            end 
            
            if nargin < 3
                center = 0;
            end 
            
            obj = obj@axes_ND_base(3, resolution, scale, center);
            obj.axes_title = {'x' 'y', 'z'};
            obj.name = '3D cartesian';
        end

        function x = getX(obj)
            x = obj.getAxes{1};
        end

        function y = getY(obj)
            y = obj.getAxes{2};
        end

        function z = getZ(obj)
            z = obj.getAxes{3};
        end
    end
end

