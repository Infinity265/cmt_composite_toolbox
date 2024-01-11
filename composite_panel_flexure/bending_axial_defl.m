function db = bending_axial_defl(Pb, L, EI)
 % Returns deflection in the transverse (z) direction due bending
 % deformation cause by a transverse load
    %
    % Arguments:
    %   Pb  :  Applied Transverse Load [N]
    %   L  :  Span of supports [m]
    %   EI  :  Flexural modulus of panel [IDK]
    %
    % Returns
    %   db  :  Bending z displacement [m]
    
    kb = (1/48); %kb : bending deflection coefficient kb -> 1/48 for simply support beams in 3PB. Reference -> PAAC table 18.1
    db = kb*(Pb * L^3/ EI);
end