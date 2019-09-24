function [ result ] = convert_Func2PolarBeam( func, resolution, R,name, wavelength )
    
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        name = 'unnamed';
    end
    if nargin < 3
        R = 1;
    end
    if nargin < 2
        resolution = [63 255];
    end

    dr = R/(resolution(1)-1);
    dphi = 2*pi/(resolution(2)-1);

    result.r = 0:dr:R;
    result.phi = 0:dphi:(2*pi);
    result.wavelength = wavelength;
    result.name = name;
    
    for i = 1:length(result.r)
        r = result.r(i);
        for j = 1:length(result.phi)
            phi = result.phi(j);
            result.values(i,j) = func(r,phi);
        end
    end
end