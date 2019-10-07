classdef field_2D_polar < field_ND_base
    
    methods (Access = public)
        function obj = field_2D_polar(resolution, radius)
            
            if nargin < 1
                resolution = 3;
            end

            if nargin < 2
                radius = 1;
            end

            scale = [radius 2*pi];
            center = scale/2;

            obj = obj@field_ND_base(2, resolution, scale, center);
            obj.axes_title = {'r' 'phi'};
            obj.name = '2D polar';
        end

        function r = getR(obj)
            r = obj.getAxes{1};
        end

        function phi = getPhi(obj)
            phi = obj.getAxes{2};
        end
        
        function field = getField_2D_XY(obj)
            local_resolution = obj.resolution;
            local_scale = obj.scale;
            
            resolution = fix(sqrt(prod(local_resolution)));
            scale = 2 * local_scale(1);
            center = 0;
            
            field = field_2D_XY(resolution, scale, center);
        end
    end
end

