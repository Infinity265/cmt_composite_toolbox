%% Housekeeping
clear

%% Input Files
% Upper and lower skin layups
upper_laminate = "2023_SIS_layup";
lower_laminate = "2023_SIS_layup";

%% Read in files 
upper_laminate_file = strcat("../classical_laminate_theory/CLT_output_data/", upper_laminate, "_ABD_stiffness.xlsx");
ABD_upper = readmatrix(upper_laminate_file); % Read in layup configuration
lower_laminate_file = strcat("../classical_laminate_theory/CLT_output_data/", lower_laminate, "_ABD_stiffness.xlsx");
ABD_lower = readmatrix(lower_laminate_file); % Read in layup configuration

%% Required Parameters
w = 275e-3;
L = 400e-3;                     %Span of flexure test supports 

t_upper = 1.2e-3;
t_lower = 1.2e-3;
t_core = 30e-3;

t_core_foil = 0.0459e-3;           %Cell wall thickness, see Connie page, I have low confidence
s_core = 6.35e-3;               %Ali core cell diameteer
G_core_mat = 26e9;              %Shear mod of pure ali

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
Pb = 1e3; %Arbitrarily selected

db = bending_axial_defl(Pb, L, EI);  % Bending deflection due to transverse load
ds = shear_axial_defl(Pb, L, w, t_core, G_core_L); % Shear deflection due to transverse load
d = db + ds; %Total deflection

%% Output Files 