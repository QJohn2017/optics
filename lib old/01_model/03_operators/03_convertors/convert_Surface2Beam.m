function [ result ] = convert_Surface2Beam( surface_data, axes, value )
    
    if nargin < 3
        value = 0;
    end
    if nargin < 2
        axes = 'y';
    end

    result.wavelength = surface_data.wavelength;
    
    switch axes
        case 'x'
            result.resolution = [surface_data.resolution(2) surface_data.resolution(3)];
            result.size = [surface_data.size(2) surface_data.size(3)];
            result.x = surface_data.y;
            result.y = surface_data.z;
            [temp index] = min(abs(surface_data.x-value));
            result.values = permute(surface_data.values(index,:,:), [2 3 1]);
            result.name = [surface_data.name ' x=' num2str(value)];
        case 'y'
            result.resolution = [surface_data.resolution(1) surface_data.resolution(3)];
            result.size = [surface_data.size(1) surface_data.size(3)];
            result.x = surface_data.x;
            result.y = surface_data.z;
            [temp index] = min(abs(surface_data.y-value));
            result.values = permute(surface_data.values(:,index,:), [1 3 2]);
            result.name = [surface_data.name ' y=' num2str(value)];
        case 'z'
            result.resolution = [surface_data.resolution(1) surface_data.resolution(2)];
            result.size = [surface_data.size(1) surface_data.size(2)];
            result.x = surface_data.x;
            result.y = surface_data.y;
            [temp index] = min(abs(surface_data.y-value));
            result.values = permute(surface_data.values(:,:,index), [1 2 3]);
            result.name = [surface_data.name ' z=' num2str(value)];
    end
    
end