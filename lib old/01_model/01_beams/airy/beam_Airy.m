function [ res ] = beam_Airy( resolution, size_beam, gamma, alpha, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 4
        alpha = [1/3 1/3];
    end
    if nargin < 3
        gamma = [3 3];
    end
    if nargin < 2
        size_beam = [4 4];
    end
    if nargin < 1
        resolution = [128 128];
    end
    
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = ['airy('...
                num2str(alpha(1)) ',' num2str(gamma(1)) ';'...
                num2str(alpha(2)) ',' num2str(gamma(2)) ')'];
    
    step(1) = size_beam(1)/(resolution(1)-1);
    step(2) = size_beam(2)/(resolution(2)-1);
      
    res.x = -size_beam(1)/2:step(1):size_beam(1)/2;
    res.y = -size_beam(2)/2:step(2):size_beam(2)/2;

    for i = 1:resolution(2)
        for j = 1:resolution(1)
            res.values(i,j) = exp(1i*(alpha(1)*res.x(i)^gamma(1)+alpha(2)*res.y(j)^gamma(2)));
        end
    end
    
    res.values = res.values';
    
    res = operator_Fourier(res, 1000, resolution, size_beam);
    
end