function [ output_args ] = make_gif( file_name, names_cell, delay_time )

    if nargin < 3
        delay_time = 1/8; % 1/8 s
    end

    if nargin < 2
        make_gif_beams(file_name);
    else

        mkdir(file_name);
        
        for i = 1:length(names_cell)
            nameFile = [names_cell{i} '.png'];
            image_cell{i} = rgb2gray( imread(nameFile) );
            movefile(nameFile, file_name);
        end

        timeSec = length(names_cell)*delay_time;
        full_file_name = [file_name '_' num2str(timeSec) 's.gif'];

        for k = 1:numel(image_cell)

            if k == 1
                %// For 1st image, start the 'LoopCount'.
                imwrite(image_cell{k},full_file_name,'LoopCount',Inf, 'DelayTime', delay_time);
            else
                imwrite(image_cell{k},full_file_name,'WriteMode','append', 'DelayTime', delay_time);
            end

        end
        output_args = ['"' full_file_name '" successfully created']
        
    end
end

