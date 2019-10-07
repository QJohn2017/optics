function [ res ] = beam_LG_old( resolution, size_beam, N, M, sigma, wavelength )
    if nargin < 6
        wavelength = 0.0005;
    end
    if nargin < 5
        sigma = 0.5;
    end
    if nargin < 3
        N = 1;
        M = 0;
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
    res.name = ['LG' '(' num2str(N) ',' num2str(M) ')'];
    dx = size_beam(1)/(resolution(1)-1);
    dy = size_beam(2)/(resolution(2)-1); 
    for i = 1:resolution(1)
        res.x(i) = -size_beam(1)/2+dx*(i-1);
    end
    for j = 1:resolution(2)
        res.y(j) = -size_beam(2)/2+dy*(j-1);
    end
    res.values(resolution(1), resolution(2)) = 0;
    eNorm = 0;
    for i = 1:resolution(1)
        for j = 1:resolution(2)
            r = sqrt(res.x(i)^2+res.y(j)^2);
            phi = angle(res.x(i)+1j*res.y(j));

             L = function_Laguerre(N, abs(M), (r/sigma)^2);
             A = exp(-(r/sigma)^2);
             G = 1/sigma/sqrt(pi * factorial(abs(M)));
             E = exp(1j*M*phi);
             R = (r/sigma)^abs(M);
            
            value = L*A*G*E*R;
            res.values(i,j) = value;
            eNorm = eNorm + abs(value)^2;
        end
    end
    eNorm = eNorm*dx*dy;
    res.values = res.values / sqrt(eNorm);
end