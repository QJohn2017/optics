function [ result ] = filter_vortex( beam, degree, center )
    if nargin < 3
        center = [0 0];
    end
    if nargin < 2
        degree = 1;
    end
    
    result = beam;
    result.name = ['[' result.name ']*oam(' num2str(degree) ')'];
    if degree ~= 0
        for i = 1:result.resolution(1)
            for j = 1:result.resolution(2)
                r = sqrt(result.x(i)^2+result.y(j)^2);
                phi = angle(result.x(i)+1j*result.y(j));
                %res.values(i,j) = res.values(i,j)*((res.x(i)-center(1))+(res.y(j)-center(2))*1i)^degree;
                result.values(i,j) = r^(abs(degree)-1)*result.values(i,j)*exp(1j*degree*phi);
            end
        end
        result = set_Energy(result, beam);
    end
end

