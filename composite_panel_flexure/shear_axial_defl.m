function ds = shear_axial_defl(Pb, L, w, t_core, Gc)
 % Returns deflection in the transverse (z) direction due bending
 % deformation cause by a transverse load
    %
    % Arguments:
    %   Pb  :  Applied Transverse Load [N]
    %   L  :  Span of supports [m]
    %   w  :  Panel width [m]
    %   t_core  :  Core thickness [m]
    %   Gc  :  Shear modulus of core (not core material!) [Pa]
    %
    % Returns
    %   db  :  Bending z displacement [m]
    
    ks = (1/4); %kb : shear deflection coefficient ks -> 1/4 for simply support beams in 3PB. Reference -> PAAC table 18.1
    ds = ks*(Pb * L/ w * t_core * Gc);
end