function [ result ] = filter_noise_random( beam, percent_noise )
% It returns noised beam

    if nargin < 2
        percent_noise = 0.2;
    end

    if percent_noise < 0
        percent_noise = 0;
    end
    
    result = beam;
   
    if percent_noise ~= 0 

        result.name = ['[' result.name ']*rand(' num2str(percent_noise) ')'];

        maxMag = get_MaxMag(result);

        if maxMag == 0
            maxMag = 1;
        end

        rangeMag = percent_noise*maxMag;

        r = get_Magnitude(result);
        
        dr = rand(length(result.x),length(result.y))*rangeMag;
        dphi = zeros(size(result.values));
        for i = 1:length(result.x)
            for j = 1:length(result.y)
                if r(i,j) > dr(i,j)
                    dphi_max = asin(dr(i,j)/r(i,j));
                    dphi(i,j) = 2*dphi_max*function_Random;
                else
                    dphi(i,j) = 2*pi*function_Random;
                end       
            end
        end

        result.values = result.values + dr.*exp(1j*dphi);

        result = set_Energy(result, beam);
    end
end