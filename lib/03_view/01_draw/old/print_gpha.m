function print_gpha( beam , file_name, title_name, colormap_name )

    if nargin < 4
        colormap_name = 'yarg';
    end
    if nargin < 3
        title_name = ['Gradient phase',...
            '[', num2str(length(beam.x)), 'x', num2str(length(beam.y)), ']'];
    end
    
    figure = show_gpha(beam, title_name, colormap_name);
    print(figure, [file_name], '-dpng');
    
end