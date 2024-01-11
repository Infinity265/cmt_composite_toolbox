function G_core_L = core_effective_G(t_core_foil, s_core, G_core_mat)
    %Returns composite panel flexural modulus (EI)
    %
    % Arguments:
    %   t_core_foil  :  Cell wall thickness [m] see Connie page, I have low confidence
    %   s_core  :  Diameter of hexagonal cells [m]
    %   G_core_mat  :  Shear modulus of isotropic core material [Pa]
    %
    % Returns
    %   G_core_L  :  Effective shear modulus in the ribbon direction [Pa]
    
    G_core_L = (4/3)*(t_core_foil/s_core)*G_core_mat;
end