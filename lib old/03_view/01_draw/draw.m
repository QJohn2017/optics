function draw( figures_input, file_names )
    for i = length(figures_input):-1:1
        current_figure = figures_input(i);
        if iscell(file_names)
            current_file_name = file_names{i};
        else
            current_file_name = file_names;
        end
        draw_one(current_figure, current_file_name);
    end
end

function draw_one( figure_input, file_name )

    %saveas(figure_input,file_name,'png');
    print(figure_input, file_name, '-dpng');
    close(figure_input);
    
end