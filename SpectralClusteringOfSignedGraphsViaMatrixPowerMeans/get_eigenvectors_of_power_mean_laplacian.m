function [V,D] = get_eigenvectors_of_power_mean_laplacian(matrix_cell, p, k, method_str, krylovOpts)
% [V,D] = get_eigenvectors_of_power_mean_laplacian(matrix_cell, p, k, method_str, krylovOpts)
% This function computes the eigenvectores corresponding to the k smallest
% eigenvalues of the generalized matrix mean (0.5*(A^p + B^p))^(1/p)
% INPUT: matrix_cell (cell)  : cell array (k,1) in each entry it contains a
%                             symmetric positive semidefinite matrix A_i
%        p (scalar)          : p-th power of generalized matrix mean
%        k (scalar)          : number of eigenvectors to compute
%        method_str (string) : method to approximate (A^p)x:
%                              options(default: method_str='polynomial_krylov')
%                              - 'direct' : first computes the matrix power mean
%                                 Mp and then the corresponding eigenvectors
%                              - 'eigs' : first computes the matrix power mean
%                                 (Mp)^p (avoids the outer power '1/p')
%                                 and then the corresponding eigenvectors
%                              - 'polynomial_krylov': matrix-free computation of
%                                 eigenvectors of matrix power mean Mp
%                                 Warning: this option is holds only for p<0
%        krylovOpts (struct)  : parameters of polynomial krylov method
%                               krylovOpts.tol: approximation tolerance
%                               (default krylovOpts.tol = 1.e-10)
%                               krylov.maxIt:   maximum basis size for power approximation
%                               (default krylov.maxIt =  size(matrix_cell{1},1) )
% OUTPUT: V                   : eigenvectors of matrix power mean
%         D                   : vector with corresponding eigenvalues

% Methodology. Let M = 1/k*(A_1^p + ... +  A_k^p). 
% Observe that M and M^(1/p) share the same eigenvectors, 
% whereas the eigenvalues from M^(1/p) are (lambda(M))^(1/p).
% 
% Thus, if p > 0, then the ordering of eigenvalues do not change. 
% Therefore, our tasks reduces to find the smallest eigenvectors of M.
% 
% If p < 0, the ordering is inverted, and thus the smallest eigenvalues of
% M^(1/p) correspond to the largest eigenvalues of M.

opts.issym  = true;
opts.isreal = true;
opts.tol    = eps;

if strcmp(method_str, 'direct') 
    
    [V,D] = direct_method(matrix_cell, p, k, opts);
    
elseif strcmp(method_str, 'eigs')
    
    [V,D] = eigs_method(matrix_cell, p, k, opts);
        
elseif strcmp(method_str, 'polynomial_krylov')
 
    [V,D] = polynomial_krylov_method(matrix_cell, p, k, opts, krylovOpts);

end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
function [V,D] = direct_method(matrix_cell, p, k, opts)
% Computes eigenvectors corresponding to the k smallest eigenvalues of the
% matrix power mean Mp, by computing Mp

    M     = avg_matrix_power(matrix_cell, p);
    [V,D] = eig(full(M));
    D     = diag(D);
    D     = D.^(1/p);
    M     = V*diag(D)*V';
    [V,D] = eigs(M,k,'sm',opts);
    D     = diag(D);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
function [V,D] = eigs_method(matrix_cell, p, k, opts)
% Computes eigenvectors corresponding to the k smallest eigenvalues of the
% matrix power mean Mp, by computing Mp^p, i.e. avoids the outer power '1/p'

    M = avg_matrix_power(matrix_cell, p);
    
    if p == 0
        [V,D] = eigs(M,k,'sa',opts);
    else
    
        if p >= 0 
            [V,D] = eigs(M,k,'sa',opts);
        elseif p < 0
            [V,D] = eigs(M,k,'la',opts);
        end

        D        = diag(D);
        D        = D.^(1/p);
        D        = real(D);

        [D, idx] = sort(D, 'ascend');
        V        = V(:, idx);
        V        = real(V);        
    end
    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
function [V,D] = polynomial_krylov_method(matrix_cell, p, k, opts, krylovOpts)
% Computes eigenvectors corresponding to the k smallest eigenvalues of the
% matrix power mean Mp, without computing the matrix Mp, through the
% polynomial krylov approximation method

    assert(p<0, 'The Polynomial Krylov method is developed only for negative powers (i.e. p<0). ') 
    
    n            = size(matrix_cell{1},1);
    tol          = krylovOpts.tol;
    maxIt        = krylovOpts.maxIt;
    Afun         = @(x) average_matrix_power_times_a_vector(matrix_cell, x, p, tol, maxIt);

    [V,D]        = eigs(Afun,n,k,'lm',opts);
    D            = diag(D);
    D            = D.^(1/p);
    D            = real(D);

    [D, idx]     = sort(D, 'ascend');
    V            = V(:, idx);
    V            = real(V);
    
    
function v = average_matrix_power_times_a_vector(matrix_cell, x, p, tol, maxIt)   

    numberOfMatrices = length(matrix_cell);
    m                = maxIt;
    v                = zeros(size(matrix_cell{1},1),1);
    for i = 1:numberOfMatrices
        A = matrix_cell{i};
        v = v + gen_arnoldi_for_power_of_a_matrix_times_a_vector(A,m,x,p,tol);
    end
    v = v/numberOfMatrices;
    v = real(v);