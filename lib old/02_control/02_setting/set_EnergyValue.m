function [ out_beam ] = operator_SetEnergyValue( beam_to, value )
% It sets value energy to beamTo

    out_beam = beam_to;
    A = sqrt(value / get_Energy(beam_to));
    out_beam.values = A * out_beam.values;

end