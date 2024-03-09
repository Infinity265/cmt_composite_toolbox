%% Currently feasibility of UD layups 

%IMPORTANT this script only uses engineering units (MPa, mm, N)

%Add sub folders to path so that MATLAB can find the funcs in subfolders
addpath(strcat(pwd, '\classical_laminate_theory'))
clear

%% Layup input files
layup = '2023_SIS_cfg10';
material_xlsx_file = "\classical_laminate_theory\CLT_input_ply_mat_data\gurit_data_sheets.xlsx";
layup_xlsx_file = strcat("\classical_laminate_theory\CLT_input_layup_data\", layup, ".xlsx");

%% Determine ABD matrix with CLT
[ABD, t, Q_bar_array, z] = clt_func(layup_xlsx_file, material_xlsx_file);
abd = inv(ABD);

%% Laminate engineering constants
% The engineering constants of the laminate can be determined from the
% abd-matrix as:

E_x = (1/(abd(1,1)*t));
G_xy = (1/(abd(3,3)*t)); 

%% Specify abbitrary loading of the laminate
% Loading matrix
N = [0; 0; 0;  % Nx, Ny, Nxy (in N/m) TODO: Double check the units used on this
       1e5; 0; 0]; % Mx, My, Mxy (in Nm/m)

%% Plot strain of the laminate
strain = abd * N; %Determine strains of the laminate TODO: Implement for general case 

%% Plot stress of the matrix 
[stress_r, z_int] = ply_stress(strain, Q_bar_array, z); % ply CS
plot_stress(stress_r, z_int, 1);

%% Apply failure criteria 
%stress = rotate_stress_to_matCS(stress_r, layup); % material CS