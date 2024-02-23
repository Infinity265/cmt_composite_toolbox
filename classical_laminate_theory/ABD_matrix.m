function ABD = ABD_matrix(Q_bar, z)
    % ABD_matrix Returns ABD matrix.
    %
    % Arguments:
    %   Q_bar : Cell array of size n with stiffness matrices in ply CS.
    %   z   : Array of size n+1 with the locations of the ply edges.
    %
    % Returns:
    %   ABD : ABD matrix.

    %Note: I am making this specific section of calculation as per PAAC Eqn 4.8.
    % They do their Q_bar and z matrix calculations in order of the Nth ply
    % to the 1st ply. Code thus far has generated the flipped order
  
    % Flipping arrays 
    Q_bar_Nto1 = flip(Q_bar);

    


    %CLT calculations
    A = zeros(3,3);
    B = zeros(3,3);
    D = zeros(3,3);
    if length(z) - 1 == length(Q_bar_Nto1)
        
        k = length(Q_bar_Nto1);
        while k>=1
           
           %Determine layer k parameters
           zk = z(k+1);
           zk_minus1 = z(k);
           Qbar_k =  Q_bar_Nto1{k};

           %Sum to A, B or D matrix
           A = A + Qbar_k * (zk - zk_minus1);
           B = B + Qbar_k * (zk^2 - zk_minus1^2)/2;
           D = D + Qbar_k * (zk^3 - zk_minus1^3)/3;
           
           %Move to next ply
           k = k-1;
        end
    end
    ABD = [A, B; B, D];
end