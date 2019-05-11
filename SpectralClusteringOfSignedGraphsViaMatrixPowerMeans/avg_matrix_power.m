function M = avg_matrix_power(matrix_cell, p)
% M = average_matrix_power(matrix_cell, p, tol)
% This function approximates the average or power matrices, i.e.
%            x = (1/k)*[(A_1)^p + ... +(A_k)^p]
% INPUT: matrix_cell : cell array (k,1) in each entry it contains a
%                      symmetric positive semidefinite matrix A_i
%        p           : scalar [power parameter]
% 
% Important: this method performs the spectral decomposition in each
% matrix. We do this as we want to pay special attention to the case of
% negative powers for positive semi definite matrices, by taking the pseudo
% inverse when necessary.

if p == 0
    % compute log euclidean mean
    M = get_matrix_exp_log_mean(matrix_cell);
    
else

    % compute average matrix power
    numberOfMatrices = length(matrix_cell);    % number of matrices in cell
    n                = size(matrix_cell{1},1); % size of matrices
    M                = zeros(n,n);
    for i = 1:numberOfMatrices
        A = matrix_cell{i};
        M = M + power_of_a_matrix(full(A),p);
    end
    M = 0.5*(M+M');                            % enforcing symmetry
    M = M/numberOfMatrices;
    
end

function M = get_matrix_exp_log_mean(matrix_cell)
% M = get_matrix_exp_log_mean(matrix_cell)
% This function approximates the log euclidean mean, i.e.
%            x = exp( (1/k)*[log(A_1) + ... +log(A_k)] )
% INPUT: matrix_cell : cell array (k,1) in each entry it contains a
%                      symmetric positive definite matrix A_i
% 

numberOfMatrices = length(matrix_cell);    % number of matrices in cell
n                = size(matrix_cell{1},1); % size of matrices
M                = zeros(n,n);
for i = 1:numberOfMatrices
    A     = matrix_cell{i};
    logmA = logm(full(A));
    logmA = 0.5*(logmA+logmA');            % enforcing symmetry
    M     = M + logmA;
end
M = M/numberOfMatrices;
M = expm(M);
M = 0.5*(M+M');
