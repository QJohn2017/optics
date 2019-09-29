function [ result_figure ] = show_polar_int( beam_polar )
    X = beam_polar.r;
    Y = round(beam_polar.phi/2/pi*360,1);
    Z = abs(beam_polar.values').^2;
    result_figure = show_main(X,Y,Z,beam_polar.name,'yarg',{'r, mm' 'phi, degree'});
end