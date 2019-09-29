function [ result_figure ] = show_surface( surface_data, percent_values, percent_transp, title_name , dimension )
% 01 - surface_data
%   01.01 - surface_data.x
%   01.02 - surface_data.y
%   01.03 - surface_data.z
%   01.04 - surface_data.values
%   01.05 - surface_data.resolution
%   01.06 - surface_data.size
%   01.07 - surface_data.name
% 02 - percent_values
% 03 - percent_transp
% 04 - title_name
% 05 - dimension

    if nargin < 5
        dimension = 'mm';
    end
    if nargin < 4
        title_name = surface_data.name;
    end
    if nargin < 3
        if nargin < 2
            percent_values = [0.2 0.4 0.6 0.8];
        end
        percent_transp = ones(1,length(percent_values))/length(percent_values);
    end

    axes_x = surface_data.x;
    axes_y = surface_data.y;
    axes_z = surface_data.z;
    values = abs(surface_data.values).^2;

    result_figure = figure;
    axesMain = axes('Parent',result_figure);

    %colormap(jet);

    % Create light
    light('Parent',axesMain,...
        'Position',[17.375982876645 -100.556150614945 83.9711431702997],...
        'Style','local');

    % Create zlabel
    zlabel(['z, ' dimension]);

    % Create ylabel
    ylabel(['y, ' dimension]);

    % Create xlabel
    xlabel(['x, ' dimension]);

    % Create title
    title(title_name);

    xlim(axesMain,[min(axes_x) max(axes_x)]);
    ylim(axesMain,[min(axes_y) max(axes_y)]);
    zlim(axesMain,[min(axes_z) max(axes_z)]);

    range_x = max(axes_x)-min(axes_x);
    range_y = max(axes_y)-min(axes_y);
    range_z = max(axes_z)-min(axes_z);
    range_axes = [range_x range_y range_z];
    range_min = min(range_axes);
    range_max = max(range_axes);

    dataAspectRatio = range_axes/range_min;
    n_aspect_ratio_max = 2;
    for i = 1:length(dataAspectRatio)
        if dataAspectRatio(i) > n_aspect_ratio_max
            dataAspectRatio(i) = dataAspectRatio(i)/n_aspect_ratio_max;
        else
            dataAspectRatio(i) = 1;
        end
    end

    view(axesMain,[135.00 25.00]);

    box(axesMain,'on');
    grid(axesMain,'on');

    min_value = min(min(min(values)));
    max_value = max(max(max(values)));

    %legend(axesMain,'show');

    % Set the remaining axes properties
    set(axesMain,   'XTick',min(axes_x):(max(axes_x)-min(axes_x))/8:max(axes_x),...
        'YTick',min(axes_y):(max(axes_y)-min(axes_y))/8:max(axes_y),...
        'ZTick',min(axes_z):(max(axes_z)-min(axes_z))/8:max(axes_z),...
        'CLim', [min_value max_value],...
        'DataAspectRatio', dataAspectRatio);


    %colorbar('peer',axesMain,'Limits',[min_value max_value]);

    colors = jet;

    values_byColor = min_value:(max_value-min_value)/(length(colors)-1):max_value;
    values_byPercent = min_value + (max_value-min_value)*percent_values;
    values = permute(values, [2 1 3]);

    for i = 1:length(values_byPercent)
        patched_surface = patch(isosurface(axes_x,axes_y,axes_z,values,values_byPercent(i)));
        isonormals(axes_x,axes_y,axes_z,values,patched_surface);
        patched_surface.FaceAlpha = percent_transp(i);
        diff_val = abs(values_byColor - values_byPercent(i));
        ind = find(diff_val == min(diff_val));
        color = colors(ind(1), :);
        patched_surface.FaceColor = color;
        patched_surface.EdgeColor = 'none';
        patched_surface.DisplayName = ['val = ' num2str(round(values_byPercent(i),3)) ' (' num2str(round(100*percent_values(i),1)) '%)'];
    end

    lighting gouraud

    camlight('headlight');

end