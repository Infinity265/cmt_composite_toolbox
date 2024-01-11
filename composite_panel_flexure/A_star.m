function A_star = A_star(ABD)
    %Returns the In-Plane stiffness matrix [A*] of a laminate with
    %restrained curvature
    %
    % Arguments:
    %   ABD  :  Laminate ABD matrix
    %
    % Returns
    %   A_star  :  In-plane stiffness matrix with restrained curvature
    A = zeros(3,3);
    for i = 1:3
        for j = 1:3
            A(i,j) = ABD(i,j);
        end
    end
    A_star = inv(A);
end