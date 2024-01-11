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
t_upper = 1.2e-3;
t_lower = 1.2e-3;
% g_core_mat = ##                   %Shear mod of pure ali
% core_foil_t = ##                  %Wall thickness of ali foil in core
t_core = 30e-3;
w = 275e-3;
L = 400e-3;                     %Span of flexure test supports 

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

% Bending Deflection

%% Output Files 