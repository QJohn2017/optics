function [ res ] = beam_HG( resolution, size_beam, N, M, wavelength )
    if nargin < 5
        wavelength = 0.0005;
    end
    if nargin < 3
        N = 1;
        M = 1;
    end
    if nargin < 2
        size_beam = [8 8];
    end
    if nargin < 1
        resolution = [128 128];
    end
    res.resolution = resolution;
    res.size = size_beam;
    res.wavelength = wavelength;
    res.name = ['HG(' num2str(N) ',' num2str(M) ')'];
    
    dx = size_beam(1)/(resolution(1)-1);
    dy = size_beam(2)/(resolution(2)-1);
        
    for i = 1:resolution(1)
        res.x(i) = -size_beam(1)/2+dx*(i-1);
    end
    for j = 1:resolution(2)
        res.y(j) = -size_beam(2)/2+dy*(j-1);
    end
    
    res.values(resolution(1), resolution(2)) = 0;
    for i=1:resolution(1)
        for j=1:resolution(2)
            res.values(i,j) = exp(-((res.x(i))^2+(res.y(j))^2))*H(N, sqrt(2)*res.x(i))*H(M, sqrt(2)*res.y(j));
        end
    end
    
    res = edit_Norming(res);
end

function [ res ] = H(n, t)
    res = ((-1)^n)*exp(t^2)*diffExp(n, t, 0.001);
end

function [ res ] = diffExp(n, t, step)
    if n == 0
        res = exp(-t^2);
    else
        res = (diffExp(n-1, t+step, step) - diffExp(n-1, t-step, step))/(2*step);
    end
end
