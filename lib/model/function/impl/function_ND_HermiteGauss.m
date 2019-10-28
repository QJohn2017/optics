classdef function_ND_HermiteGauss < function_base
   
    properties (Access = protected)
        coef
        epsilon
    end
    
    methods (Access = public)

        function obj = function_ND_HermiteGauss(coef, epsilon)
            
            if nargin < 2
                epsilon = 0.001;
            end
            
            obj = obj@function_base;
            
            obj.name = 'Hermite Gauss (cartesian)';
            obj.description = ['[' num2str(coef) ']'];
            
            obj.coef = coef;
            obj.epsilon = epsilon;
            
            obj.func = @(p) obj.hermiteGauss(p, obj.coef, obj.epsilon);
        end

    end

    methods (Access = public)
        function coef = getCoef(obj)
            coef = obj.coef;
        end
        function eps = getEpsilon(obj)
            eps = obj.epsilon;
        end
    end
    
    methods (Access = protected)

        function value = hermiteGauss(obj, params, local_coef, local_epsilon)
            
            if length(local_coef) == 1
                local_coef = local_coef * ones(size(params));
            end
            
            if length(params)~=length(local_coef)
                error("Length of point and length of coef is not match")
            end
            
            value = 1;
            for i = 1:length(local_coef)
                value = value * obj.H(local_coef(i),sqrt(2)*params(i),local_epsilon);
            end
            value = value * exp(-sum(params.*params));
        end

    end

    methods (Access = private)
        function res = H(obj, k, t, epsilon)
            if nargin < 3
                epsilon = 0.001;
            end
            res = ((-1)^k)*exp(t^2)*obj.diffExp(k, t, epsilon);
        end
        
        function res = diffExp(obj, n, t, epsilon)
            if n == 0
                res = exp(-t^2);
            else
                res = (obj.diffExp(n-1, t+epsilon, epsilon) - obj.diffExp(n-1, t-epsilon, epsilon))/(2*epsilon);
            end
        end
    end
    
end