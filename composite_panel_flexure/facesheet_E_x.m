function E_x_f = panel_f_mod(t, A_star)
 % Returns elastic modulus (in x dir) of composite face sheet
    %
    % Arguments:
    %   t  :  Facesheet thickness 
    %   A_star  :  Facesheet stiffness matrix with restained curvature
    %
    % Returns
    %   E_x_f  :  Facesheet elastic modulus
    E_x_f = 1/(t * A_star(1,1));
end