classdef field_3D_cylindrical < field_ND_base

    methods
        function obj = field_3D_cylindrical(resolution, radius, distance)
            if nargin < 1
                resolution = 3;
            end
            if nargin < 2
                radius = 1;
            end
            if nargin < 3
                distance = 1;
            end
            
            scale = [radius 2*pi distance];
            center = [radius/2 pi 0];

            obj = obj@field_ND_base(3, resolution, scale, center);
            obj.axes_title = {'r' 'phi' 'z'};
            obj.name = '3D cylindrical';
        end

        function r = getR(obj)
            r = obj.getAxes{1};
        end
    
        function phi = getPhi(obj)
            phi = obj.getAxes{2};
        end

        function z = getZ(obj)
            z = obj.getAxes{3};
        end
    end
end

