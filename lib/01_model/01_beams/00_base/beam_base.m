classdef beam_base

    properties (Access = protected)
        default_axes = {[-0.5:0.01:0.5] [-0.5:0.025:0.5]};
    end

    properties 
        axes
        values
    end
    
    methods

        function obj = beam_base(axes)
            if nargin ~= 1
                axes = obj.default_axes;
            end

            for i = 1:length(axes)
                s(i)=length(axes{i});
            end
            
            obj.axes = axes;
            obj.values = zeros(s);
        end

    end

end

