classdef model_base
    
    properties (Access = public)
        name
        description
    end
    
    methods (Access = public)

        function obj = model_base(name, description)

            if nargin < 1
                name = 'default model';
            end
            
            if nargin < 2
                description = '';
            end

            obj.name = name;
            obj.description = description;

        end
        
    end

end