classdef field_1D < field_ND_base
    
    methods (Access = public)
        function obj = field_1D(resolution, scale, center)
            
            if nargin < 1
                resolution = 3;
            end 
            
            if nargin < 2
                scale = 1;
            end 
            
            if nargin < 3
                center = 0;
            end 
            
            obj = obj@field_ND_base(1, resolution, scale, center);     
            obj.axes_title = {'t'};
            obj.name = '1D';
        end

        function axis = getAxis(obj)
            axis = obj.getAxes{1};
        end
    end
end

