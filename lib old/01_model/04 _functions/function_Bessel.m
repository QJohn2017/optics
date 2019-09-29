function [ result ] = function_Bessel( alpha, X, K )
    
    if nargin < 3
        K = 100;
    end
    
%     for i = 1:(K+1+alpha)
%         factorials(i) = factorial(i-1);
%     end
%     
%     for i = 1:length(X)
%         result(i) = 0;
%         x = X(i);
%         for k = 0:K
%             result(i) = result(i) + ((-1)^k)/(factorials(k+alpha+1)*factorials(k+1))*(x/2)^(2*k+alpha);
%         end
%     end
    
    result = besselj(alpha,X);

end