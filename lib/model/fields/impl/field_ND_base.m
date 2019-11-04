classdef field_ND_base < field_base

    properties (Access = protected)
        dimension
    end
    
    methods
        function obj = field_ND_base(dimension, resolution, scale, center)
                                   
            if nargin < 2
                resolution = 3;
            end
            
            if nargin < 3
                scale = 1;
            end
            
            if nargin < 4
                center = 0;
            end
            
            if length(resolution) == 1
                resolution = resolution * ones(1, dimension);
            end
            
            if length(resolution) ~= dimension
                error(['Length of resolution must be equals ' num2str(dimension)]);
            end
            
            if length(scale) == 1
                scale = scale * ones(1, dimension);
            end
            
            if length(scale) ~= dimension
                error(['Length of scale must be equals ' num2str(dimension)]);
            end
            
            if length(center) == 1
                center = center * ones(1, dimension);
            end
            
            if length(center) ~= dimension
                error(['Length of center must be equals ' num2str(dimension)]);
            end
            
            obj = obj@field_base(resolution, scale, center);
            obj.dimension = dimension;
            obj.name = ['field ' num2str(dimension) 'D'];
        end
        
        function dim = getDimension(obj)
            dim = obj.dimension;
        end
        
        function [res, mes] = checkEquals(obj, field)
            
            res = false;
            
            left_dim = obj.getDimension;
            right_dim = field.getDimension;
            
            if left_dim ~= right_dim
                mes = 'Dimensions of beams are not match';
                return;
            end
            
            left_res = obj.getResolution;
            right_res = field.getResolution;
            
            if sum(left_res ~= right_res)
                mes = 'Sizes of resolution of beams are not match';
                return;
            end
            
            left_sca = obj.getScale;
            right_sca = field.getScale;
            
            if sum(left_sca ~= right_sca)
                mes = 'Sizes of scale of beams are not match';
                return;
            end
            
            left_cen = obj.getCenter;
            right_cen = field.getCenter;
            
            if sum(left_cen~=right_cen)
                mes = 'Sizes of center of beams are not match';
                return;
            end
            
            res = true;
            mes = 'Good';
            
        end
    end
end

