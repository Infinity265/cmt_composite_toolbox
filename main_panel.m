%% Housekeeping 
%IMPORTANT this script only uses engineering units (MPa, mm, N)
clear

%Add sub folders to path so that MATLAB can find the funcs in subfolders
addpath(strcat(pwd, '\classical_laminate_theory'))
addpath(strcat(pwd, '\composite_panel_flexure'))


% Layup input files
upper_skin_layup = 'test_layup_1';
lower_skin_layup =  'test_layup_1';


%Read layup from excel files 
material_xlsx_file = "\classical_laminate_theory\CLT_input_ply_mat_data\gurit_data_sheets.xlsx";
upper_skin_layup_xlsx_file = strcat("\classical_laminate_theory\CLT_input_layup_data\", upper_skin_layup, ".xlsx");
lower_skin_layup_xlsx_file = strcat("\classical_laminate_theory\CLT_input_layup_data\", lower_skin_layup, ".xlsx");

% Determine ABD matrix with CLT
[ABD_upper, t_upper] = clt_func(upper_skin_layup_xlsx_file, material_xlsx_file);
[ABD_lower, t_lower] = clt_func(lower_skin_layup_xlsx_file, material_xlsx_file);

% Core
t_core = 25;
% Material properties of core are currently hard coded in three point bend
% function. Maybe look to chante in the future

% Determine panel performance in 3 point bending
[Pb, d] = three_point_bend_test(ABD_upper, t_upper, t_core, ABD_lower, t_lower)

