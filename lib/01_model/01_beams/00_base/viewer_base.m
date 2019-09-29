classdef viewer_base
    %VIEWER_BASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = public)
        name
    end
    
    methods (Access = public)
        function obj = viewer_base(name)
            if nargin < 1
                name = '';
            end
            obj.name = name;
        end
        
        function fig = show(obj, model)
            fig = figure('name', [obj.name ' - ' model.name]);
        end
    end
    
end

