function [ result_figure ] = show_gpha( beam, title_name, colormap_name )

    if nargin < 3
        colormap_name = 'yarg';
    end
    if nargin < 2
        title_name = ['Gradient phase',...
            '[', num2str(length(beam.x)), 'x', num2str(length(beam.y)), ']'];
    end

    X = beam.x;
    Y = beam.y;
    Z = abs(get_Phase(beam)');

    result_figure = show_main(X, Y, Z, title_name, colormap_name);
    
    %colorbar;
    
end

