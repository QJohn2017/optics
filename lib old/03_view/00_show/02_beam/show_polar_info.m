function [ result_figure ] = show_polar_info( beam, title_name, colormap_name )
    
    if nargin < 3
        colormap_name = 'yarg';
    end
    if nargin < 2
        title_name = beam.name;
    end
    
    R = beam.r;
    PHI = beam.phi;
    Z_1 = abs(beam.values').^2;
    Z_2 = angle(beam.values');
    
    dim = {'r, mm' 'phi, degree'};
    
    result_figure = figure;
    axes_main = subplot(1,2,1);
    show_main(R, PHI, Z_1, ['Intensity - ' title_name], colormap_name, dim, result_figure, axes_main);
    
    axes_main = subplot(1,2,2);
    show_main(R, PHI, Z_2, ['Phase - ' title_name], colormap_name, dim, result_figure, axes_main);
    
    result_figure.Position = result_figure.Position.*[1 1 2 1];
    
end

