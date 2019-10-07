function [ result ] = convert_Beams2Surface( beams , z )

    if nargin < 2
        z = 1:length(beams);
    end

    axes_x = beams(1).x;
    axes_y = beams(1).y;
    axes_z = z;
    
    values = zeros(length(axes_x),length(axes_y),length(axes_z));
    
    for k = 1:length(beams)
        values(:,:,k) = get_Intensity(beams(k));
    end

    result.x = axes_x;
    result.y = axes_y;
    result.z = axes_z;
    result.values = values;
    
    for i = 1:length(beams(1).resolution)
        res(1,i) = beams(1).resolution(i);
    end
    
    result.resolution = [res length(z)];
    
    for i = 1:length(beams(1).size)
        size(1,i) = beams(1).size(i);
    end
    result.size = [size (z(end)-z(1))];
    result.wavelength = beams(1).wavelength;
    result.name = ['z = ' num2str(z(1)) '-' num2str(z(end))];
end

