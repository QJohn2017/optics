function [ result ] = surface_sphere( resolution, size_surface, radius, wavelength )

    if nargin < 4
        wavelength = 0.0005;
    end
    if nargin < 3
        if nargin < 2
            size_surface = [2 2 2];
        end
        radius = 1;%sqrt(sum(size.^2)/2);
    end
    if nargin < 2
        resolution = [31 31 31];
    end
    
    result.resolution = resolution;
    result.size = size_surface;
    result.wavelength = wavelength;
    result.name = ['sphere R=' num2str(radius)];
    
    dx = size_surface(1)/(resolution(1)-1);
    dy = size_surface(2)/(resolution(2)-1);
    dz = size_surface(3)/(resolution(3)-1);
    
    result.x = -size_surface(1)/2:dx:size_surface(1)/2;
    result.y = -size_surface(2)/2:dy:size_surface(2)/2;
    result.z = -size_surface(3)/2:dz:size_surface(3)/2;
    
    [X Y Z] = meshgrid(result.x,result.y,result.z);
    
    result.values = permute(sqrt(X.^2+Y.^2+Z.^2), [2 1 3]);
    
    for k = 1:resolution(3)
        [rows columns] = find(result.values(:,:,k)>radius);
        indexes{k} = [rows columns];
    end
    
    for k = 1:resolution(3)
        inds = indexes{k};
        [n, m] = size(inds);
        for i = 1:n
            coord = inds(i,:);
            ix = coord(1); iy = coord(2);
            result.values(ix,iy,k) = 0;
        end
    end
end

