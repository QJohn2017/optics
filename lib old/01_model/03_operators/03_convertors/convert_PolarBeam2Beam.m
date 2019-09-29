function [ result ] = convert_PolarBeam2Beam( beam )
    result.x = -beam.r(end):(beam.r(end)/(round(sqrt(length(beam.r)*length(beam.phi)))-1)):beam.r(end);
    result.y = result.x;

    result.resolution = [length(result.x) length(result.y)];
    result.size = [max(result.x)-min(result.x) max(result.y)-min(result.y)];
    result.wavelength = beam.wavelength;
    result.name = beam.name;
    
    for i = 1:length(result.x)
        for j = 1:length(result.y)
            r = sqrt(result.x(i)^2+result.y(j)^2);
            value = 0;
            if r <= beam.r(end)
                I = []; J = [];
                phi = angle(result.x(i)+1j*result.y(j));
                if phi < 0 
                    phi = phi + 2*pi;
                end
                I = function_Find(beam.r, r);
                J = function_Find(beam.phi, phi);

                if ~isempty(I) && ~isempty(J)
                    value = beam.values(I, J);
                end
            end
            result.values(i,j) = value;
        end
    end
end