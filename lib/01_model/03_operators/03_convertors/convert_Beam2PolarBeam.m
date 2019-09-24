function [ result ] = convert_Beam2PolarBeam( beam )
    
    result.r = 0:(max(abs(beam.x))/(round(sqrt(length(beam.x)*length(beam.y)))/2 - 1)):max(abs(beam.x));
    result.phi = 0:(2*pi/(2*round(sqrt(length(beam.x)*length(beam.y))) - 1)):(2*pi);
    result.wavelength = beam.wavelength;
    result.name = beam.name;
    
    for i = 1:length(result.r)
        r = result.r(i);
        for j = 1:length(result.phi)
            phi = result.phi(j);
            x = r*cos(phi);
            y = r*sin(phi);
            value = 0;
            if result.r(end)^2 >= x^2+y^2
                I = []; J = [];
                I = function_Find(beam.x, x);
                J = function_Find(beam.y, y);

                if ~isempty(I) && ~isempty(J)
                    value = beam.values(I, J);
                else
                    fprintf([num2str(x) ' : ' num2str(y) ' - ops\n']);
                end
            end
            result.values(i,j) = value;
        end
    end
end