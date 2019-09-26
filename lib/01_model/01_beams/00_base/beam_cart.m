classdef beam_cart < beam_base

    
    properties (Access = protected)
        resolution
        scale
    end
    
    methods (Access = public)
        
        function obj = beam_cart(resolution, scale)
            
            obj = obj@beam_base(function_base, {[]});
            
            axes = obj.CalculateAxes(resolution, scale);
            
            obj = obj.SetAxes(axes);
            
            obj.resolution = resolution;
            obj.scale = scale;
            
        end
        
        function resolution = GetResolution(obj)
            resolution = obj.resolution;
        end
        
        function scale = GetScale(obj)
            scale = obj.scale;
        end
        
        function obj = SetResolution(obj, resolution)
            obj.resolution = resolution;
            axes = obj.CalculateAxes(resolution, obj.scale);
            obj = obj.SetAxes(axes);
        end
        
        function obj = SetScale(obj, scale)
            obj.scale = scale;
            axes = obj.CalculateAxes(obj.resolution, scale);
            obj = obj.SetAxes(axes);
        end
        
    end
    
    methods (Access = protected)
        
        function axes = CalculateAxes(obj, resolution, scale)
            if length(resolution) ~= length(scale)
                error("Length of resolution and length of scale is not match!");
            end
            
            count = length(resolution);
            
            axes{count} = [];
            
            for i = 1:count
                step = scale(i)/(resolution(i)-1);
                axes{i} = (-scale(i)/2):step:(scale(i)/2);
            end
        end
        
    end
    
end

