function [Pb, d] = three_point_bend_func(ABD_upper, t_upper, t_core, ABD_lower, t_lower)
    % Predicts the tested performance of 3 point bend test sample as is
    % required by SES
    %
    % Arugments:
    %   upper_ABD : ABD matrix of the upper laminate skin
    %   upper_t : Thickness of upper laminate skin (mm)
    %   core : Thickness of aluminium honeycomb core (mm)
    %   lower_ABD : ABD matrix of the lower laminate skin
    %   lower_t: Thickness of lower laminate skin (mm)
    %
    % Output:
    %   Pb : Load at which failure occurs (kN)
    %   d : Deflection (vertical) at which failure occurs 
    % 
    % NOTE: Currently core material properties are currently hard coded as
    % is the test panel width (275mm)


    %%Ahh this is wrong 

    
%% Required Parameters
w = 275;
L = 400;                     %Span of flexure test supports 

t_core_foil = 0.0459;           %Cell wall thickness, see Connie page, I have low confidence
s_core = 6.35;               %Ali core cell diameteer
G_core_mat = 26e3;              %Shear mod of pure ali

G_core_L = core_effective_G(t_core_foil, s_core, G_core_mat);
G_core_W = (1/2.5)*G_core_L;

%% Det. Flexural Modulus EI

%Determine in-plane stiffness matrix of face sheets with curvature and
%twist restrained by core
A_star_upper = A_star(ABD_upper);
A_star_lower = A_star(ABD_lower);

% Det. elastic modulus of facesheet 
E_x_upper = facesheet_E_x(t_upper, A_star_upper);
E_x_lower = facesheet_E_x(t_lower, A_star_lower);

% Det. panel flexural modulus (EI)
EI = flexural_mod(E_x_upper, E_x_lower, t_upper, t_core, t_lower, w);

%% Det. Deflections 
% To determine deflections you need to assume an applied load. I selected a unit value of
% 1000N but this can be changed as required.
Pb = 1; %Arbitrarily selected

db = bending_axial_defl(Pb, L, EI);  % Bending deflection due to transverse load
ds = shear_axial_defl(Pb, L, w, t_core, G_core_L); % Shear deflection due to transverse load
d = db + ds; %Total deflection
