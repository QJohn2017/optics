function [ result ] = filter_noise_normal( beams, percents )
% It returns normal noised beam

    if nargin < 2
        percents = 0.1*ones(length(beams));
    end
    
    if length(percents)~=length(beams)
        if length(percents) == 1 && length(beams) >= 1
            percents = percents*ones(length(beams));
        else
            if length(percents) > 1 && length(beams) == 1
                first_beam = beams;
                for i = 1:length(percents)-1
                    beams = [beams first_beam];
                end
            else
                error('Size is not match');
            end
        end
    end
    
    for index_beam = 1:length(beams)
        beam = beams(index_beam);
        percent = percents(index_beam);
        current_beam = beam;
        sigma_r = get_MaxMag(current_beam)*percent;
        current_beam.name = ['[' current_beam.name ']*norm(' num2str(round(sigma_r^2, 3)) ')'];

        r = get_Magnitude(current_beam);
        phi = get_Phase(current_beam);

        dr = abs(function_Normal(0, sigma_r^2, size(current_beam.values)));
        dphi = zeros(size(current_beam.values));
        for i = 1:length(current_beam.x)
            for j = 1:length(current_beam.y)
                if r(i,j) > dr(i,j)
                    dphi_max = asin(dr(i,j)/r(i,j));
                    sigma_phi = dphi_max / 3;
                    dphi(i,j) = 2*pi*function_Random;
                    %dphi(i,j) = function_Normal(0, sigma_phi^2);
                else
                    dphi(i,j) = 2*pi*function_Random;
                    %dphi(i,j) = function_Normal(0,pi^2);
                end       
            end
        end

        current_beam.values = r.*exp(1j*phi)+dr.*exp(1j*dphi);

        current_beam = set_Energy( current_beam, beam );
        
        result(index_beam) = current_beam;
        clear current_beam
    end

end