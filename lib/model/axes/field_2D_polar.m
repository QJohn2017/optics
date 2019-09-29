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
    end
end

