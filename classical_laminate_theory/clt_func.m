function [ABD, t_laminate] = clt_func(layup_file, material_file)
    % return ABD matrix for given layup with given material properties.
    %
    % Arugments:
    %   layup_file, : Relative path to layup file.
    %   material_file : Relative path to material file.
    %
    % Output:
    %   ABD   : Material ABD Matrix 
    %   t_laminate  :  Thickness of the laminate (mm)


%%% This throws a negative when it probably shouldn't.. something to look
%%% into 


%% Read input excel files

layup_input_data = readcell(strcat(pwd, layup_file)); % Read in layup configuration
material_input_data = readcell(strcat(pwd, material_file)); % Read used material data


%% Determining Rotated Stiffness Matrix (Q_bar) for each ply
size_layup_data = size(layup_input_data);
size_mat_data = size(material_input_data);
n_layers = size_layup_data(1,1) -1;
n_mats = size_mat_data(1,1) -1;

expanded_layup_data = cell(n_layers,8); 
Q_bar_array = cell(n_layers,1); %Init array for transformed stiffness matrices of 1-kth ply
t_array = cell(n_layers, 1);           %Init z array

for k=1:n_layers
    %det mat. id and geometry of kth ply
    mat_index = cell2mat(layup_input_data(k+1,2));
    angle_deg = cell2mat(layup_input_data(k+1,3));
    angle_rad = angle_deg*(pi/180);
    t_array{k} = cell2mat(layup_input_data(k+1,4));

   
    % Extract mat. properties given mat. index 
    for i=1:(n_mats)
        if mat_index == cell2mat(material_input_data(i+1,1))%check that this is the indexed material
            layer_mat_prop = material_input_data(i+1,:); %retrieve material properties
        end
    end

    E1 = cell2mat(layer_mat_prop(3));
    E2 = cell2mat(layer_mat_prop(4));
    v12 = cell2mat(layer_mat_prop(5));
    G12 = cell2mat(layer_mat_prop(6));
        
    %Det. Qbar for kth ply from mat. properties
    Q = stiffness_matrix(E1, E2, v12, G12);
    Q_bar = rotate_Q(Q, angle_rad);
    
    % Populate expanded_layup_data
    % TODO
        
    Q_bar_array{k} = Q_bar;
    
    
end

% Generate z stack
z = ply_edges_nonuniform(t_array);

%% ABD and abd matrix

ABD = ABD_matrix(Q_bar_array, z);
abd = inv(ABD);
t_laminate = sum([t_array{:}]);

end