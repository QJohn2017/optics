function [ result_figure ] = show_graph( X, Y, title_name, y_name, x_name)
%CREATEFIGURE(X1, Y1)
%  X1:  vector of x data
%  Y1:  vector of y data

%  Auto-generated by MATLAB on 01-Feb-2019 14:17:26

% Create figure
result_figure = figure;

% Create axes
axes_main = axes('Parent',result_figure);
hold(axes_main,'on');

% Create plot
plot(X,Y,'ZDataSource','','DisplayName','data','LineWidth',2,...
    'Color',[0 0.447 0.741]);

% Create xlabel
xlabel(x_name);

% Create ylabel
ylabel(y_name);

%ylim(axes_main,[0 1]);

% Create title
title(title_name);

box(axes_main,'on');
% Set the remaining axes properties
set(axes_main,'XGrid','on','YGrid','on');
end