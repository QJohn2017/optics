function [ out_beam ] = operator_SetEnergy( beam_to, beam_from )
% It sets energy of beamFrom to beamTo

    out_beam = set_EnergyValue(beam_to, get_Energy(beam_from));
    
end