function [ res ] = operator_FrenelCareful( beam, distance, resolution, size )
% It returns careful Frenel of beam

    if nargin < 4
        size = beam.size;
    end
    if nargin < 3
        resolution = beam.resolution;
    end
    if nargin < 2
        distance = 1000;
    end
    
    res.resolution = resolution;
    res.size = size;
    res.wavelength = beam.wavelength; 
    
    k = 2*pi/beam.wavelength;
    dx = size(1)/(resolution(1)-1);
    dy = size(2)/(resolution(2)-1);
    
    res.x = (-size(1)/2):dx:(size(1)/2);
    res.y = (-size(2)/2):dy:(size(2)/2);

    for i = 1:resolution(1)
        x = res.x(i);
        for j = 1:resolution(2)
            y = res.y(j);
            value = 0;
            for ii = 1:beam.resolution(1)
                u = beam.x(ii);
                for jj=1:beam.resolution(2)
                    v = beam.y(jj);
                    const = exp(1j*k*(u^2+v^2-2*(x*u+y*v))/(2*distance));
                    value = value + beam.function(ii,jj) * const; 
                end
            end
            e = exp(1i * k * (x^2+y^2)/(2 * distance));
            res.function(i,j) = e * value * dx * dy;
        end
    end
    res.function = -1i * k * exp(1j * k * distance) * res.function / (2 * pi * distance);
end

