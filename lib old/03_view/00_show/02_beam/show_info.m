function [ result_figure ] = show_info( beam, title_name, colormap_name )
    
    if nargin < 3
        colormap_name = 'yarg';
    end
    if nargin < 2
        title_name = beam.name;
    end
    
    X = beam.x;
    Y = beam.y;
    Z_1 = get_Intensity(beam)';
    Z_2 = get_Phase(beam)';
    
    dim = {'x, mm' 'y, mm'};
    
    result_figure = figure;
    axes_main = subplot(1,2,1);
    show_main(X, Y, Z_1, ['Intensity - ' title_name], colormap_name, dim, result_figure, axes_main);
    
    axes_main = subplot(1,2,2);
    show_main(X, Y, Z_2, ['Phase - ' title_name], colormap_name, dim, result_figure, axes_main);
    
    result_figure.Position = result_figure.Position.*[1 1 2 1];
    
end

