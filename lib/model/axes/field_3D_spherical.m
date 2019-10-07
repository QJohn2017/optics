classdef field_3D_spherical < field_ND_base
    methods
        function obj = field_3D_spherical(resolution, radius)

            if nargin < 1
                resolution = 3;
            end

            if nargin < 2
                radius = 1;
            end

            scale = [radius pi 2*pi];
            center = [radius/2 0 pi];

            obj = obj@field_ND_base(3, resolution, scale, center);
            obj.axes_title = {'r' 'teta' 'phi'};
            obj.name = '3D spherical';
        end

        function r = getR(obj)
            r = obj.getAxes{1};
        end

        function teta = getTeta(obj)
            teta = obj.getAxes{2};
        end
    
        function phi = getPhi(obj)
            phi = obj.getAxes{3};
        end
    end
end

