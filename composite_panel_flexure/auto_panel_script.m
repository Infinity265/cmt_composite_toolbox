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

%% Various Math Operations


%% Output Files 