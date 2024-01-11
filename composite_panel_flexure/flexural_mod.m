function EI = flexural_mod(E_x_upper, E_x_lower, t_upper, t_core, t_lower, w)
    %Returns composite panel flexural modulus (EI)
    %
    % Arguments:
    %   E_x_upper  :  Upper facesheet Exx
    %   E_x_lower  :  Lower facesheet Exx
    %   t_upper  :  Thickness of upper facesheet
    %   t_core  :  Thickness of core
    %   t_lower  :  Thickness of lower facesheet
    %   w  :  Panel width
    %
    % Returns
    %   EI  :  Flexural modulus

    d = 0.5*t_upper + t_core + 0.5*t_lower; %distance between laminate midsurfaces
    EI = (w*d^2)/((1/E_x_lower*t_lower)+(1/E_x_upper*t_upper));
end