function  make_gif_beams( beams, file_name )
    
    if nargin < 2
        file_name = 'file';
    end
    for i=1:length(beams)
        figures(i) = show_info(beams(i));
        names_cell{i} = ['shot_' num2str(i)];
    end
    draw(figures, names_cell);
    close all
    make_gif(file_name, names_cell);
end

