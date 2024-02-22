%% Currently feasibility of UD layups 
%Add sub folders to path so that MATLAB can find the funcs in subfolders
addpath(strcat(pwd, '\classical_laminate_theory'))
clear

%% Layup input files
layup = 'test_layup_1';
material_xlsx_file = "\classical_laminate_theory\CLT_input_ply_mat_data\gurit_data_sheets.xlsx";

layup_xlsx_file = strcat("\classical_laminate_theory\CLT_input_layup_data\", layup, ".xlsx");

%% Determine ABD matrix with CLT
[ABD, t] = clt_func(layup_xlsx_file, material_xlsx_file);
abd = inv(ABD);

%% Laminate engineering constants
% The engineering constants of the laminate can be determined from the
% abd-matrix as:

E_x = -1 * (1/(abd(1,1)*t));   %% Do not foget you added a * -1 here!!
G_xy= -1 * (1/(abd(6,6)*t));


