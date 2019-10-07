function print_mag( beam , file_name, title_name, colormap_name )

    if nargin < 4
        colormap_name = 'yarg';
    end
    if nargin < 3
        beam.name;
    end
    
    figure = show_mag(beam, title_name, colormap_name);
    print(figure, [file_name], '-dpng');
    
end