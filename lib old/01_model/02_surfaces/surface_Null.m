function [ result ] = surface_Null( resolution_surface, size_mm, wavelength_mm )

    if nargin < 3
        wavelength_mm = 0.0005;
    end
    if nargin < 2
        size_mm = 0.002*[1 1 1];
    end
    if nargin < 1
        resolution_surface = [31 31 31];
    end
    result.resolution = resolution_surface;
    result.size = size_mm;
    result.wavelength = wavelength_mm;
    result.name = 'null';
    
    dx = result.size(1)/(result.resolution(1)-1);
    dy = result.size(2)/(result.resolution(2)-1);
    dz = result.size(3)/(result.resolution(3)-1);
    result.x = -result.size(1)/2:dx:result.size(1)/2;
    result.y = -result.size(2)/2:dy:result.size(2)/2;
    result.z = -result.size(3)/2:dz:result.size(3)/2;
    
    result.values = zeros(result.resolution);

end

