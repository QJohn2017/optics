function [ result, all_surfaces ] = surface_W( resolution_surface, size_mm, matrix_cnm, wavelength_mm )

    if nargin < 4
        wavelength_mm = 0.0005;
    end
    if nargin < 3
        matrix_cnm = [1 0  0;...
                      1 1 -1;...
                      1 1  0;...
                      1 1  1];
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
    result.name = '';
    
    dx = result.size(1)/(result.resolution(1)-1);
    dy = result.size(2)/(result.resolution(2)-1);
    dz = result.size(3)/(result.resolution(3)-1);
    result.x = -result.size(1)/2:dx:result.size(1)/2;
    result.y = -result.size(2)/2:dy:result.size(2)/2;
    result.z = -result.size(3)/2:dz:result.size(3)/2;
    
    result.values = zeros(result.resolution);
    
    [count_rows size_m] = size(matrix_cnm);
    array_N = (1:count_rows)-1;
    array_M = (1:(2*count_rows-1))-count_rows;
    
    for i = 1:count_rows
        row_cnm = matrix_cnm(i,:);
        C = row_cnm(1);
        N = row_cnm(2);
        M = row_cnm(3);
        all_surfaces(i) = surface_Null(resolution_surface, size_mm, wavelength_mm);
        if abs(M) <= N && C ~= 0
            all_surfaces(i) = surface_J_nm(resolution_surface, size_mm, N, M, wavelength_mm);
            result.values = result.values + C*all_surfaces(i).values;
            if isempty(result.name)
                result.name = [all_surfaces(i).name];
            else
                result.name = [result.name ' + ' all_surfaces(i).name];
            end
        end
    end
end

