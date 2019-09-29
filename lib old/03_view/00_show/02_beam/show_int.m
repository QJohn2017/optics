function [ result_figure ] = show_int( beam, title_name, colormap_name )

    if nargin < 3
        colormap_name = 'yarg';
    end
    if nargin < 2
        title_name = beam.name;
    end
    
    X = beam.x;
    Y = beam.y;
    Z = get_Intensity(beam)';

    result_figure = show_main(X, Y, Z, title_name, colormap_name);

end