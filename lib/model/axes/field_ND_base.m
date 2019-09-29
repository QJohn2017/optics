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
            obj.name = 'field ND base';
        end
        
        function dim = getDimension(obj)
            dim = obj.dimension;
        end
    end
end

